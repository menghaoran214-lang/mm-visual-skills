param(
    [string]$TargetDir = (Join-Path $HOME ".codex\skills"),
    [string]$SourceDir = (Join-Path $HOME ".mm-visual-skills-source"),
    [switch]$Yes,
    [switch]$CheckOnly
)

$ErrorActionPreference = "Stop"
$RemoteVersionUrl = "https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/VERSION"
$LocalVersionFile = Join-Path $TargetDir ".mm-visual-skills-version"
$Installer = Join-Path $PSScriptRoot "install-or-update.ps1"

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

& $Installer -TargetDir $TargetDir -SourceDir $SourceDir
