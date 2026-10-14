param(
    [string]$TargetDir = (Join-Path $HOME ".codex\skills"),
    [string]$SourceDir = (Join-Path $HOME ".mm-visual-skills-source"),
    [switch]$DryRun
)
$ErrorActionPreference = "Stop"
$RepoUrl = "https://github.com/menghaoran214-lang/mm-visual-skills.git"
$Marker = ".mm-visual-skills-managed"
$VersionMarker = ".mm-visual-skills-version"
$SourceSignature = 'source: "https://github.com/menghaoran214-lang/mm-visual-skills"'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "git is required" }
Write-Host "MM Visual Skills | source: $SourceDir | target: $TargetDir"
if ($DryRun) {
    if (-not (Test-Path -LiteralPath (Join-Path $SourceDir ".git"))) {
        throw "Dry-run needs an existing source clone; it never downloads files: $SourceDir"
    }
} elseif (Test-Path -LiteralPath (Join-Path $SourceDir ".git")) {
    & git -C $SourceDir pull --ff-only
    if ($LASTEXITCODE -ne 0) { throw "git pull failed" }
} elseif (Test-Path -LiteralPath $SourceDir) {
    throw "Source exists but is not a Git repository: $SourceDir"
} else {
    & git clone $RepoUrl $SourceDir
    if ($LASTEXITCODE -ne 0) { throw "git clone failed" }
}

$Plan = @()
$Seen = @{}
foreach ($SkillDir in (Get-ChildItem -LiteralPath $SourceDir -Directory)) {
    $SkillFile = Join-Path $SkillDir.FullName "SKILL.md"
    if (-not (Test-Path -LiteralPath $SkillFile)) { continue }
    $Name = $null
    foreach ($Line in (Get-Content -LiteralPath $SkillFile -TotalCount 40)) {
        if ($Line -match '^name:\s*["'']?([^"'']+)["'']?\s*$') {
            $Name = $Matches[1].Trim()
            break
        }
    }
    if ($Name -notmatch '^[a-z0-9][a-z0-9-]*$' -or $Seen.ContainsKey($Name)) {
        throw "Invalid or duplicate Skill name in $SkillFile"
    }
    $Seen[$Name] = $true
    $Dest = Join-Path $TargetDir $Name
    if (Test-Path -LiteralPath $Dest) {
        $Item = Get-Item -LiteralPath $Dest -Force
        if (($Item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
            throw "CONFLICT: refusing to replace symlink $Dest"
        }
        $OwnerFile = Join-Path $Dest $Marker
        $ExistingSkill = Join-Path $Dest "SKILL.md"
        $IsOwned = (Test-Path -LiteralPath $OwnerFile) -and ((Get-Content -LiteralPath $OwnerFile -Raw).Trim() -eq "mm-visual-skills")
        $IsLegacy = (Test-Path -LiteralPath $ExistingSkill) -and ((Get-Content -LiteralPath $ExistingSkill -Raw).Contains($SourceSignature))
        if (-not $IsOwned -and -not $IsLegacy) {
            throw "CONFLICT: $Dest is not managed by MM Visual Skills; unchanged."
        }
        if ($IsLegacy -and -not $IsOwned) { Write-Host "Recognized legacy installation: $Name" }
    }
    Write-Host "PLAN: $Name -> $Dest"
    $Plan += [pscustomobject]@{Name = $Name; Source = $SkillDir.FullName; Dest = $Dest}
}
if ($Plan.Count -eq 0) { throw "No installable Skills found." }
if ($DryRun) { Write-Host "DRY RUN: no source or target files changed."; return }

$BackupRoot = Join-Path $TargetDir ".mm-visual-skills-backups"
New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null
$Backup = Join-Path $BackupRoot ("backup." + [guid]::NewGuid().ToString("N"))
$Stage = Join-Path $TargetDir (".mm-visual-stage." + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $Backup, $Stage -Force | Out-Null
$Installed = New-Object System.Collections.ArrayList
$BackedUp = New-Object System.Collections.ArrayList
$DestVersion = Join-Path $TargetDir $VersionMarker
try {
    if (Test-Path -LiteralPath $DestVersion) {
        Copy-Item -LiteralPath $DestVersion -Destination (Join-Path $Backup $VersionMarker)
    }
    foreach ($Entry in $Plan) {
        $Staged = Join-Path $Stage $Entry.Name
        Copy-Item -LiteralPath $Entry.Source -Destination $Staged -Recurse
        Set-Content -LiteralPath (Join-Path $Staged $Marker) -Value "mm-visual-skills"
    }
    foreach ($Entry in $Plan) {
        if (Test-Path -LiteralPath $Entry.Dest) {
            Move-Item -LiteralPath $Entry.Dest -Destination (Join-Path $Backup $Entry.Name)
            [void]$BackedUp.Add($Entry)
        }
        Move-Item -LiteralPath (Join-Path $Stage $Entry.Name) -Destination $Entry.Dest
        [void]$Installed.Add($Entry)
    }
    $Version = "unknown"
    $SourceVersion = Join-Path $SourceDir "VERSION"
    if (Test-Path -LiteralPath $SourceVersion) { $Version = (Get-Content -LiteralPath $SourceVersion -Raw).Trim() }
    $TempVersion = Join-Path $Stage $VersionMarker
    Set-Content -LiteralPath $TempVersion -Value $Version -NoNewline
    Move-Item -LiteralPath $TempVersion -Destination $DestVersion -Force
    Write-Host "Installed/updated $($Plan.Count) Skills (v$Version)."
    Write-Host "Previous version backup: $Backup"
    Write-Host "To roll back, restore the backed-up Skill folders and version marker to this target."
    Write-Host "Reload your AI client."
} catch {
    Write-Warning "Install failed; restoring previous managed Skills..."
    foreach ($Entry in $Installed) {
        if (Test-Path -LiteralPath $Entry.Dest) { Remove-Item -LiteralPath $Entry.Dest -Recurse -Force }
    }
    foreach ($Entry in $BackedUp) {
        Move-Item -LiteralPath (Join-Path $Backup $Entry.Name) -Destination $Entry.Dest
    }
    $PreviousVersion = Join-Path $Backup $VersionMarker
    if (Test-Path -LiteralPath $PreviousVersion) {
        Copy-Item -LiteralPath $PreviousVersion -Destination $DestVersion -Force
    } elseif (Test-Path -LiteralPath $DestVersion) {
        Remove-Item -LiteralPath $DestVersion -Force
    }
    throw
} finally {
    if (Test-Path -LiteralPath $Stage) { Remove-Item -LiteralPath $Stage -Recurse -Force }
}
