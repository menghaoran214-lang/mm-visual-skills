$ErrorActionPreference = "Stop"
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$Installer = Join-Path $RepoRoot "scripts\install-or-update.ps1"
$Tmp = Join-Path ([IO.Path]::GetTempPath()) ("mm-visual-test-" + [guid]::NewGuid().ToString("N"))
$Remote = Join-Path $Tmp "upstream.git"
$Source = Join-Path $Tmp "source"
$Target = Join-Path $Tmp "skills"
New-Item -ItemType Directory -Path $Tmp | Out-Null
function Assert([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw "ASSERT FAIL: $Message" }
}
function Save-Skill([string]$Dir, [string]$Name) {
    New-Item -ItemType Directory -Path $Dir -Force | Out-Null
    @("---", "name: $Name", "metadata:", '  source: "https://github.com/menghaoran214-lang/mm-visual-skills"', "---") |
        Set-Content -Path (Join-Path $Dir "SKILL.md")
}
try {
    & git init --bare -q $Remote
    & git --git-dir=$Remote symbolic-ref HEAD refs/heads/main
    & git clone -q $Remote $Source
    & git -C $Source config user.email test@example.invalid
    & git -C $Source config user.name "MM Tests"
    Save-Skill (Join-Path $Source "visual") "mm-visual"
    Save-Skill (Join-Path $Source "cover") "mm-cover"
    Set-Content -Path (Join-Path $Source "VERSION") -Value "0.10.3"
    & git -C $Source add .
    & git -C $Source commit -qm initial
    & git -C $Source push -q -u origin main
    & $Installer -TargetDir $Target -SourceDir $Source -DryRun
    Assert (-not (Test-Path $Target)) "DryRun must not change target"
    & $Installer -TargetDir $Target -SourceDir $Source
    Assert (Test-Path (Join-Path $Target "mm-visual\.mm-visual-skills-managed")) "first install marker"
    Assert ((Get-Content (Join-Path $Target ".mm-visual-skills-version") -Raw).Trim() -eq "0.10.3") "first version"
    Add-Content -Path (Join-Path $Target "mm-cover\SKILL.md") -Value "LOCAL_CHANGE"
    Set-Content -Path (Join-Path $Source "VERSION") -Value "0.10.4"
    & git -C $Source add VERSION
    & git -C $Source commit -qm bump
    & git -C $Source push -q
    & $Installer -TargetDir $Target -SourceDir $Source
    Assert ((Get-Content (Join-Path $Target ".mm-visual-skills-version") -Raw).Trim() -eq "0.10.4") "upgrade version"
    $Backed = Get-ChildItem -Path (Join-Path $Target ".mm-visual-skills-backups") -Recurse -Filter "SKILL.md"
    Assert ([bool]($Backed | Select-String -Pattern "LOCAL_CHANGE" -Quiet)) "previous install backed up"
    Save-Skill (Join-Path $Source "other") "mm-other"
    & git -C $Source add .
    & git -C $Source commit -qm add-other
    & git -C $Source push -q
    $Foreign = Join-Path $Target "mm-other"
    New-Item -ItemType Directory -Path $Foreign | Out-Null
    Set-Content -Path (Join-Path $Foreign "keep.txt") -Value "MY FILE"
    $Failed = $false
    try { & $Installer -TargetDir $Target -SourceDir $Source } catch { $Failed = $true }
    Assert $Failed "foreign Skill collision rejected"
    Assert ((Get-Content (Join-Path $Foreign "keep.txt") -Raw).Trim() -eq "MY FILE") "foreign file unchanged"
    Remove-Item -LiteralPath $Foreign -Recurse -Force
    Remove-Item -LiteralPath (Join-Path $Target "mm-visual\.mm-visual-skills-managed")
    & $Installer -TargetDir $Target -SourceDir $Source
    Assert (Test-Path (Join-Path $Target "mm-visual\.mm-visual-skills-managed")) "legacy installs migrated"
    Write-Host "PASS: PowerShell dry-run, install, update, backup, conflict and legacy"
} finally {
    if (Test-Path -LiteralPath $Tmp) { Remove-Item -LiteralPath $Tmp -Recurse -Force }
}
