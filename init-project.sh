#!/usr/bin/env bash
# Part B: seed a project with the generic CLAUDE.md + .claude/PROJECT_PROFILE.md template.
# Never overwrites existing files (cp -n). Usage: ./init-project.sh /path/to/project
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:?usage: ./init-project.sh /path/to/project}"

mkdir -p "${TARGET}/.claude"
cp -n "${HERE}/project-template/CLAUDE.md"                              "${TARGET}/CLAUDE.md"
cp -n "${HERE}/project-template/.claude/PROJECT_PROFILE.md"            "${TARGET}/.claude/PROJECT_PROFILE.md"
cp -n "${HERE}/project-template/.claude/settings.local.starter.json"   "${TARGET}/.claude/settings.local.json"
cp -n "${HERE}/project-template/.claude/env.template"                  "${TARGET}/.claude/.env"

echo "Seeded ${TARGET}. Now edit (use examples-spring/ as a model):"
echo "  1) ${TARGET}/.claude/PROJECT_PROFILE.md   (fill every TODO; delete sections you don't need)"
echo "  2) ${TARGET}/CLAUDE.md                     (project name + resolve TODOs)"
echo "  3) ${TARGET}/.claude/.env                  (real tokens; keep git-ignored)"
