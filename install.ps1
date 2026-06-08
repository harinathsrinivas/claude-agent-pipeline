# Global install (Part A): copies the generic agent pipeline + global config into ~/.claude/.
# Safe to re-run; existing settings.json / CLAUDE.md are backed up or left untouched.
$ErrorActionPreference = "Stop"
$Here      = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = Join-Path $HOME ".claude"
$ts        = Get-Date -Format "yyyyMMdd-HHmmss"

Write-Host "Installing global Claude config into $ClaudeDir ..."
New-Item -ItemType Directory -Force (Join-Path $ClaudeDir "agents") | Out-Null

# 1) Agents (generic, language-neutral)
Copy-Item (Join-Path $Here "global/agents/*.md") (Join-Path $ClaudeDir "agents") -Force
Write-Host "  + agents -> $ClaudeDir\agents\ (8 files)"

# 2) Global settings (model=opus / effort=xhigh / notifs) — back up any existing
$settings = Join-Path $ClaudeDir "settings.json"
if (Test-Path $settings) {
  Copy-Item $settings "$settings.bak-$ts" -Force
  Write-Host "  ! existing settings.json backed up -> settings.json.bak-$ts"
}
Copy-Item (Join-Path $Here "global/settings.json") $settings -Force
Write-Host "  + settings.json"

# 3) Behavioral guidelines (karpathy). Only install if you don't already have one.
$claudemd = Join-Path $ClaudeDir "CLAUDE.md"
if (Test-Path $claudemd) {
  Write-Host "  . ~/.claude/CLAUDE.md already exists — left untouched (compare with global/CLAUDE.md to merge)"
} else {
  Copy-Item (Join-Path $Here "global/CLAUDE.md") $claudemd -Force
  Write-Host "  + CLAUDE.md (karpathy guidelines)"
}

Write-Host ""
Write-Host "Global install done. Next:"
Write-Host "  1) (optional) karpathy skills plugin — in Claude Code run:"
Write-Host "       /plugin marketplace add multica-ai/andrej-karpathy-skills"
Write-Host "       /plugin install andrej-karpathy-skills"
Write-Host "     (The guidelines are already in ~/.claude/CLAUDE.md, so this is optional.)"
Write-Host "  2) Per project, seed the template:"
Write-Host "       ./init-project.ps1 C:\path\to\your\project"
Write-Host "     then edit CLAUDE.md and .claude/PROJECT_PROFILE.md in that project."
Write-Host "  3) Verify: launch Claude Code -> /agents (8 agents load), /model (Opus / xhigh)."
