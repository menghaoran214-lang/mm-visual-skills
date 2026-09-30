param(
    [string]$TargetDir = (Join-Path $HOME ".codex\skills"),
    [string]$SourceDir = (Join-Path $HOME ".mm-visual-skills-source")
)

$ErrorActionPreference = "Stop"
$InstallerUrl = "https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/install-or-update.ps1"

try {
    $TempFile = Join-Path ([System.IO.Path]::GetTempPath()) ("mm-visual-install-" + [guid]::NewGuid().ToString() + ".ps1")
    Write-Host "Downloading MM Visual Skills installer..."
    Invoke-WebRequest -Uri $InstallerUrl -OutFile $TempFile -UseBasicParsing

    if (-not (Test-Path $TempFile)) {
        throw "Installer download failed."
    }

    & powershell -NoProfile -ExecutionPolicy Bypass -File $TempFile -TargetDir $TargetDir -SourceDir $SourceDir
    if ($LASTEXITCODE -ne 0) {
        throw "Installer exited with code $LASTEXITCODE"
    }
}
catch {
    Write-Error "MM Visual Skills install/update failed: $($_.Exception.Message)"
    exit 1
}
finally {
    if ($TempFile -and (Test-Path $TempFile)) {
        Remove-Item -Force $TempFile -ErrorAction SilentlyContinue
    }
}
