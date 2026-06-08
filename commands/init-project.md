---
description: Seed the CURRENT project with the agent-pipeline templates (CLAUDE.md + .claude/PROJECT_PROFILE.md) and help fill them in. Run once per project.
argument-hint: "[optional one-line description of this project]"
disable-model-invocation: true
---

Seed THIS project (root: `${CLAUDE_PROJECT_DIR}`) with the agent-pipeline templates. **Never overwrite a
file that already exists** — skip it and say so.

1. Ensure `${CLAUDE_PROJECT_DIR}/.claude/` exists.
2. If `${CLAUDE_PROJECT_DIR}/CLAUDE.md` does not exist, copy `${CLAUDE_PLUGIN_ROOT}/project-template/CLAUDE.md` into it.
3. If `${CLAUDE_PROJECT_DIR}/.claude/PROJECT_PROFILE.md` does not exist, copy `${CLAUDE_PLUGIN_ROOT}/project-template/.claude/PROJECT_PROFILE.md` into it.
4. If `${CLAUDE_PROJECT_DIR}/.claude/settings.local.json` does not exist, copy `${CLAUDE_PLUGIN_ROOT}/project-template/.claude/settings.local.starter.json` into it.
5. Point the user to `${CLAUDE_PLUGIN_ROOT}/project-template/.claude/env.template` for tokens — do **not**
   create a `.env` automatically.

Then help fill in the templates:
6. Inspect this repo to auto-detect what you can: build tool + test command (Maven `./mvnw test`, Gradle
   `./gradlew test`, npm, pytest, go), the entry point, and existing test fixtures/conventions. Use
   "$ARGUMENTS" as the project description if provided.
7. Propose concrete values for the `TODO:` markers in `.claude/PROJECT_PROFILE.md` (§1 entry point, §2
   commands, §3 testing) and in `CLAUDE.md` (project name); apply them after the user confirms. Use
   `${CLAUDE_PLUGIN_ROOT}/examples-spring/` as a model. Do **not** invent project facts you can't verify — ask.

Finish by listing the files you seeded and the `TODO:`s that still need the user's input.
