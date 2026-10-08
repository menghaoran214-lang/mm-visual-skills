#!/usr/bin/env python3
"""Validate PNG reference assets before allowing style-guided image generation.

Stdlib-only preflight; it proves file decodability, NOT that the model has seen the
image. An image model must separately receive/view the actual verified images.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import struct
import sys
import zlib

PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"
REFERENCES = (
    "assets/preview.png",
    "assets/examples/example-old-vs-new.png",
    "assets/examples/example-x402-bazaar.png",
)
# Frozen master-reference hashes from the authenticated, original plugin asset archive.
# A valid but substituted PNG must NOT silently pass style reference preflight.
EXPECTED_SHA256 = {
    "assets/preview.png": "6ebfd1af04d21678bbfbd4df50b2068d5c9b95a920c1048f5b99d20e223fecf4",
    "assets/examples/example-old-vs-new.png": "dc1b6a0de0e3ac07020cca52eb169e26656badfa9aab1ec9df77313e3353d5cc",
    "assets/examples/example-x402-bazaar.png": "9636e0b03e2770addbea3c64284c9ba9eaf5f1307970907c9f8bd88efd62d2b7"
}
MAX_BYTES = 25 * 1024 * 1024


class InvalidReference(ValueError):
    """An image is absent, truncated, mislabeled, or corrupt."""


def validate_png(path: Path, expected_sha256: str | None = None) -> tuple[int, int]:
    if not path.is_file():
        raise InvalidReference("missing file")
    size = path.stat().st_size
    if size > MAX_BYTES:
        raise InvalidReference("reference exceeds 25 MiB")
    data = path.read_bytes()
    if not data.startswith(PNG_SIGNATURE):
        raise InvalidReference("invalid PNG signature (not a PNG file)")
    if expected_sha256 is not None and hashlib.sha256(data).hexdigest() != expected_sha256:
        raise InvalidReference("PNG content differs from frozen master reference (SHA-256 mismatch)")
    offset = len(PNG_SIGNATURE)
    seen_ihdr = False
    seen_iend = False
    idat = bytearray()
    width = height = 0
    while offset < len(data):
        if offset + 12 > len(data):
            raise InvalidReference("truncated PNG chunk header")
        length = struct.unpack_from(">I", data, offset)[0]
        ctype = data[offset + 4 : offset + 8]
        end = offset + 12 + length
        if end > len(data):
            raise InvalidReference("truncated PNG chunk payload")
        payload = data[offset + 8 : offset + 8 + length]
        actual_crc = struct.unpack_from(">I", data, offset + 8 + length)[0]
        wanted_crc = zlib.crc32(ctype + payload) & 0xFFFFFFFF
        if actual_crc != wanted_crc:
            raise InvalidReference("PNG chunk checksum mismatch")
        if not seen_ihdr:
            if ctype != b"IHDR" or length != 13:
                raise InvalidReference("missing/invalid first IHDR chunk")
            width, height = struct.unpack_from(">II", payload)
            if not width or not height or width > 16384 or height > 16384:
                raise InvalidReference("invalid or excessive image dimensions")
            seen_ihdr = True
        if ctype == b"IDAT":
            idat.extend(payload)
            if len(idat) > MAX_BYTES:
                raise InvalidReference("compressed IDAT exceeds 25 MiB")
        if ctype == b"IEND":
            if length:
                raise InvalidReference("nonempty IEND chunk")
            seen_iend = True
            if end != len(data):
                raise InvalidReference("trailing bytes after IEND")
            break
        offset = end
    if not seen_ihdr or not seen_iend or not idat:
        raise InvalidReference("missing IHDR, IDAT, or IEND")
    try:
        decoder = zlib.decompressobj()
        expanded = decoder.decompress(idat, MAX_BYTES + 1)
        if len(expanded) > MAX_BYTES or not decoder.eof or decoder.unused_data:
            raise InvalidReference("incomplete or excessive IDAT image data")
    except zlib.error as exc:
        raise InvalidReference("invalid compressed IDAT") from exc
    return width, height


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--json", action="store_true", help="Machine-readable results")
    args = parser.parse_args(argv)
    results = []
    for name in REFERENCES:
        try:
            width, height = validate_png(args.root / name, EXPECTED_SHA256[name])
            results.append({"asset": name, "ok": True, "width": width, "height": height})
        except (InvalidReference, OSError) as exc:
            results.append({"asset": name, "ok": False, "error": str(exc)})
    if args.json:
        print(json.dumps(results, ensure_ascii=False, indent=2))
    else:
        for result in results:
            mark = "PASS" if result["ok"] else "FAIL"
            details = (f'{result["width"]}x{result["height"]}' if result["ok"] else result["error"])
            print(f'{mark}: {result["asset"]} - {details}')
    if not all(x["ok"] for x in results):
        print("BLOCKED: visual references are unusable. Do not generate substitute images.", file=sys.stderr)
        return 2
    print("PASS: reference files decode AND SHA-256 matches frozen originals; actual visual viewing and model input are still required.", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
