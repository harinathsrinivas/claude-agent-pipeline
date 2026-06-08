#!/usr/bin/env bash
# Global install (Part A): copies the generic agent pipeline + global config into ~/.claude/.
# Safe to re-run; existing settings.json / CLAUDE.md are backed up or left untouched.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
ts="$(date +%Y%m%d-%H%M%S)"

echo "Installing global Claude config into ${CLAUDE_DIR} ..."
mkdir -p "${CLAUDE_DIR}/agents"

# 1) Agents (generic, language-neutral)
cp "${HERE}/global/agents/"*.md "${CLAUDE_DIR}/agents/"
echo "  + agents -> ${CLAUDE_DIR}/agents/ ($(ls "${HERE}/global/agents/"*.md | wc -l | tr -d ' ') files)"

# 2) Global settings (model=opus / effort=xhigh / notifs) — back up any existing
if [ -f "${CLAUDE_DIR}/settings.json" ]; then
  cp "${CLAUDE_DIR}/settings.json" "${CLAUDE_DIR}/settings.json.bak-${ts}"
  echo "  ! existing settings.json backed up -> settings.json.bak-${ts}"
fi
cp "${HERE}/global/settings.json" "${CLAUDE_DIR}/settings.json"
echo "  + settings.json"

# 3) Behavioral guidelines (karpathy). Only install if you don't already have one.
if [ -f "${CLAUDE_DIR}/CLAUDE.md" ]; then
  echo "  . ~/.claude/CLAUDE.md already exists — left untouched (compare with global/CLAUDE.md to merge)"
else
  cp "${HERE}/global/CLAUDE.md" "${CLAUDE_DIR}/CLAUDE.md"
  echo "  + CLAUDE.md (karpathy guidelines)"
fi

cat <<'EOF'

Global install done. Next:
  1) (optional) karpathy skills plugin — in Claude Code run:
       /plugin marketplace add multica-ai/andrej-karpathy-skills
       /plugin install andrej-karpathy-skills
     (The guidelines are already in ~/.claude/CLAUDE.md, so this is optional.)
  2) Per project, seed the template:
       ./init-project.sh /path/to/your/project
     then edit CLAUDE.md and .claude/PROJECT_PROFILE.md in that project.
  3) Verify: launch Claude Code -> /agents (8 agents load), /model (Opus / xhigh).
EOF
