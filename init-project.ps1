# Part B: seed a project with the generic CLAUDE.md + .claude/PROJECT_PROFILE.md template.
# Never overwrites existing files. Usage: ./init-project.ps1 C:\path\to\project
param([Parameter(Mandatory=$true)][string]$Target)
$ErrorActionPreference = "Stop"
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

New-Item -ItemType Directory -Force (Join-Path $Target ".claude") | Out-Null

function Copy-IfMissing($src, $dst) {
  if (Test-Path $dst) { Write-Host "  . exists, skipped: $dst" }
  else { Copy-Item $src $dst; Write-Host "  + $dst" }
}

Copy-IfMissing (Join-Path $Here "project-template/CLAUDE.md")                            (Join-Path $Target "CLAUDE.md")
Copy-IfMissing (Join-Path $Here "project-template/.claude/PROJECT_PROFILE.md")           (Join-Path $Target ".claude/PROJECT_PROFILE.md")
Copy-IfMissing (Join-Path $Here "project-template/.claude/settings.local.starter.json")  (Join-Path $Target ".claude/settings.local.json")
Copy-IfMissing (Join-Path $Here "project-template/.claude/env.template")                 (Join-Path $Target ".claude/.env")

Write-Host ""
Write-Host "Seeded $Target. Now edit (use examples-spring/ as a model):"
Write-Host "  1) $Target\.claude\PROJECT_PROFILE.md   (fill every TODO; delete sections you don't need)"
Write-Host "  2) $Target\CLAUDE.md                     (project name + resolve TODOs)"
Write-Host "  3) $Target\.claude\.env                  (real tokens; keep git-ignored)"
