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

function Get-SkillName($SkillDir) {
    $SkillFile = Join-Path $SkillDir "SKILL.md"
    $Head = Get-Content $SkillFile -TotalCount 40
    foreach ($Line in $Head) {
        if ($Line -match '^name:\s*["'']?([^"'']+)["'']?\s*$') {
            return $Matches[1].Trim()
        }
    }
    throw "Could not read skill name from: $SkillFile"
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

$SkillDirs = Get-ChildItem -Path $SourceDir -Directory | Where-Object {
    Test-Path (Join-Path $_.FullName "SKILL.md")
}

if (-not $SkillDirs -or $SkillDirs.Count -eq 0) {
    throw "No installable Skills found in repository root."
}

$Installed = @()

foreach ($SkillDir in $SkillDirs) {
    $SkillName = Get-SkillName $SkillDir.FullName
    $DestinationPath = Join-Path $TargetDir $SkillName

    if (Test-Path $DestinationPath) {
        Write-Host "Replacing managed Skill: $SkillName"
        Remove-Item -Recurse -Force $DestinationPath
    } else {
        Write-Host "Installing Skill: $SkillName"
    }

    Copy-Item -Recurse -Force $SkillDir.FullName $DestinationPath
    $Installed += $SkillName
}

$VersionFile = Join-Path $SourceDir "VERSION"
$Version = if (Test-Path $VersionFile) { (Get-Content $VersionFile -Raw).Trim() } else { "unknown" }
$InstalledVersionFile = Join-Path $TargetDir ".mm-visual-skills-version"
Set-Content -Path $InstalledVersionFile -Value $Version -NoNewline

Write-Host ""
Write-Host "Installed/updated MM Visual Skills v$Version"
Write-Host "Installed Skills:"
foreach ($SkillName in $Installed) {
    Write-Host "  - $(Join-Path $TargetDir $SkillName)"
}
Write-Host "Version marker:"
Write-Host "  - $InstalledVersionFile"
Write-Host ""
Write-Host "Future root-level directories containing SKILL.md will be installed automatically."
Write-Host "Restart or reload your AI/Agent Skills if it does not detect changes automatically."
