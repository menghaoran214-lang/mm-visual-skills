param(
    [string]$TargetDir = (Join-Path $HOME ".codex\skills"),
    [string]$SourceDir = (Join-Path $HOME ".mm-visual-skills-source")
)

$ErrorActionPreference = "Stop"
$RepoUrl = "https://github.com/menghaoran214-lang/mm-visual-skills.git"

function Require-Command($Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command not found: $Name"
    }
}

Require-Command "git"

Write-Host "MM Visual Skills"
Write-Host "Source: $SourceDir"
Write-Host "Target: $TargetDir"

if (Test-Path (Join-Path $SourceDir ".git")) {
    Write-Host "Updating source repository..."
    git -C $SourceDir pull --ff-only
} elseif (Test-Path $SourceDir) {
    throw "SourceDir exists but is not a Git repository: $SourceDir"
} else {
    Write-Host "Cloning source repository..."
    git clone $RepoUrl $SourceDir
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

$Skills = @(
    @{ Source = "mm-visual"; Destination = "mm-visual" },
    @{ Source = "article-illustration"; Destination = "mm-article-illustration" }
)

foreach ($Skill in $Skills) {
    $SourcePath = Join-Path $SourceDir $Skill.Source
    $DestinationPath = Join-Path $TargetDir $Skill.Destination

    if (-not (Test-Path $SourcePath)) {
        throw "Skill source not found: $SourcePath"
    }

    if (Test-Path $DestinationPath) {
        Write-Host "Replacing managed Skill: $($Skill.Destination)"
        Remove-Item -Recurse -Force $DestinationPath
    }

    Copy-Item -Recurse -Force $SourcePath $DestinationPath
}

$VersionFile = Join-Path $SourceDir "VERSION"
$Version = if (Test-Path $VersionFile) { (Get-Content $VersionFile -Raw).Trim() } else { "unknown" }
$InstalledVersionFile = Join-Path $TargetDir ".mm-visual-skills-version"
Set-Content -Path $InstalledVersionFile -Value $Version -NoNewline

Write-Host ""
Write-Host "Installed/updated MM Visual Skills v$Version"
Write-Host "Installed Skills:"
Write-Host "  - $(Join-Path $TargetDir 'mm-visual')"
Write-Host "  - $(Join-Path $TargetDir 'mm-article-illustration')"
Write-Host "Version marker:"
Write-Host "  - $InstalledVersionFile"
Write-Host ""
Write-Host "Restart or reload your AI/Agent Skills if it does not detect changes automatically."
