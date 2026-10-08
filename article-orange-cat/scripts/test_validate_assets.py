"""Offline regression tests for the visual reference validator."""
import hashlib
import struct
import tempfile
import unittest
from pathlib import Path
import zlib

from validate_assets import InvalidReference, validate_png


def chunk(ctype: bytes, content: bytes) -> bytes:
    payload = ctype + content
    return struct.pack(">I", len(content)) + payload + struct.pack(">I", zlib.crc32(payload) & 0xffffffff)


def tiny_png() -> bytes:
    return (b"\x89PNG\r\n\x1a\n"
            + chunk(b"IHDR", struct.pack(">IIBBBBB", 1, 1, 8, 2, 0, 0, 0))
            + chunk(b"IDAT", zlib.compress(b"\x00\xff\x00\x00"))
            + chunk(b"IEND", b""))


class ReferenceTests(unittest.TestCase):
    def test_valid_png(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d, "preview.png")
            p.write_bytes(tiny_png())
            self.assertEqual(validate_png(p), (1, 1))

    def test_matching_hash_passes(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d, "preview.png")
            data = tiny_png()
            p.write_bytes(data)
            self.assertEqual(validate_png(p, hashlib.sha256(data).hexdigest()), (1, 1))

    def test_substituted_valid_png_is_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d, "preview.png")
            p.write_bytes(tiny_png())
            with self.assertRaisesRegex(InvalidReference, "SHA-256 mismatch"):
                validate_png(p, "0" * 64)

    def test_random_bytes_with_png_extension_are_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d, "preview.png")
            p.write_bytes(b"random bytes pretending to be PNG")
            with self.assertRaisesRegex(InvalidReference, "signature"):
                validate_png(p)

    def test_corrupted_chunk_crc_is_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d, "preview.png")
            img = bytearray(tiny_png())
            img[24] ^= 1
            p.write_bytes(img)
            with self.assertRaisesRegex(InvalidReference, "checksum"):
                validate_png(p)

    def test_missing_reference_is_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            with self.assertRaisesRegex(InvalidReference, "missing"):
                validate_png(Path(d, "preview.png"))


if __name__ == "__main__":
    unittest.main()
