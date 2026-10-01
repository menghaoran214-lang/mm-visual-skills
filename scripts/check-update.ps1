param(
    [string]$TargetDir = (Join-Path $HOME ".codex\skills"),
    [string]$SourceDir = (Join-Path $HOME ".mm-visual-skills-source"),
    [switch]$Yes,
    [switch]$CheckOnly
)

$ErrorActionPreference = "Stop"
$RemoteVersionUrl = "https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/VERSION"
$InstallerUrl = "https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/install-or-update.ps1"
$LocalVersionFile = Join-Path $TargetDir ".mm-visual-skills-version"

try {
    $RemoteVersion = (Invoke-RestMethod -Uri $RemoteVersionUrl -UseBasicParsing).Trim()
} catch {
    throw "Could not check latest version from GitHub: $($_.Exception.Message)"
}

$LocalVersion = if (Test-Path $LocalVersionFile) {
    (Get-Content $LocalVersionFile -Raw).Trim()
} else {
    "not-installed"
}

Write-Host "Installed version: $LocalVersion"
Write-Host "Latest version:    $RemoteVersion"

if ([string]::IsNullOrWhiteSpace($RemoteVersion)) {
    throw "GitHub returned an empty VERSION value."
}

if ($LocalVersion -eq $RemoteVersion) {
    Write-Host "MM Visual Skills is up to date."
    exit 0
}

if ($LocalVersion -eq "not-installed") {
    Write-Host "MM Visual Skills is not installed in: $TargetDir"
} else {
    Write-Host "A newer/different version is available."
}

if ($CheckOnly) {
    exit 2
}

$DoUpdate = $Yes
if (-not $Yes) {
    $Answer = Read-Host "Install/update now? [Y/n]"
    $DoUpdate = ([string]::IsNullOrWhiteSpace($Answer) -or $Answer -match '^[Yy]')
}

if (-not $DoUpdate) {
    Write-Host "Skipped."
    exit 0
}

$TempFile = $null
try {
    # This is self-contained when the checker is launched directly from GitHub.
    $TempFile = Join-Path ([System.IO.Path]::GetTempPath()) ("mm-visual-install-" + [guid]::NewGuid().ToString() + ".ps1")
    Write-Host "Downloading the current MM Visual Skills installer..."
    Invoke-WebRequest -Uri $InstallerUrl -OutFile $TempFile -UseBasicParsing

    if (-not (Test-Path $TempFile) -or (Get-Item $TempFile).Length -eq 0) {
        throw "Installer download failed."
    }

    & powershell -NoProfile -ExecutionPolicy Bypass -File $TempFile -TargetDir $TargetDir -SourceDir $SourceDir
    if ($LASTEXITCODE -ne 0) {
        throw "Installer exited with code $LASTEXITCODE"
    }
}
finally {
    if ($TempFile -and (Test-Path $TempFile)) {
        Remove-Item -Force $TempFile -ErrorAction SilentlyContinue
    }
}
