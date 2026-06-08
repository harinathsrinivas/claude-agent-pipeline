# claude-agent-pipeline

A portable, **language-agnostic Claude Code setup**: a multi-agent pipeline
(planner → orchestrator → executors → judge → git-agent) plus global config, packaged so a
**new machine is ready in one command**. The agents carry no project- or language-specific
content — everything that varies per project lives in a single file you fill in
(`.claude/PROJECT_PROFILE.md`). Examples lead with Java/Spring.

## Quick start (new machine)

```bash
git clone https://github.com/harinathsrinivas/claude-agent-pipeline.git
cd claude-agent-pipeline
./install.sh            # macOS / Linux / Git-Bash
#   …or on Windows PowerShell:
./install.ps1
```
Installs the 8 agents + global `settings.json` (Opus / xhigh) + the karpathy `CLAUDE.md` into
`~/.claude/`. Existing `settings.json` / `CLAUDE.md` are backed up or left untouched.

### …or just ask Claude to do it
Open Claude Code in the cloned folder and say:
> "Read README.md and run the global install (`install.sh`, or `install.ps1` on Windows), then tell me the verification steps."

## Per project

```bash
./init-project.sh /path/to/your/project        # (init-project.ps1 on Windows)
```
Drops a generic `CLAUDE.md` + `.claude/PROJECT_PROFILE.md` (+ `.env`, permission starter) into the
project — never overwriting existing files. Then edit **two files** (use `examples-spring/` as a
model):
1. `.claude/PROJECT_PROFILE.md` — fill the `TODO:`s (entry point, build/test command, fixtures, PR
   convention). Delete sections (§5/§6/§7) you don't need.
2. `CLAUDE.md` — set the project name; resolve its `TODO:`s.

The agents never change — they read everything project-specific from `PROJECT_PROFILE.md` by
section number.

## What each agent reads from PROJECT_PROFILE.md
| Agent | Reads |
| :---- | :---- |
| architect | §1 entry points |
| planner | §2 test command, §3 testing setup (model assignment for test steps) |
| executor-opus / -sonnet / -haiku | §3 fixtures + isolation hazards + real-data guards, §2 test command |
| git-agent / orchestrator | §4 PR/issue-code convention, merge/archive gates |
| judge | nothing project-specific (generic `path/to/File.ext:line` refs) |

## Layout
```
global/                 → installed to ~/.claude/ by install.sh
  agents/ (8)           generic, language-neutral agent definitions
  settings.json         model=opus, effort=xhigh, notifications
  CLAUDE.md             karpathy behavioral guidelines (global)
project-template/       → seeded into each project by init-project.sh
  CLAUDE.md             generic project instructions
  .claude/PROJECT_PROFILE.md   the ONE per-project knobs file (Java/Spring-first examples)
  .claude/env.template, settings.local.starter.json
examples-spring/        → a filled-in example (Spring Boot orders-service), for reference
install.sh / install.ps1            global install (Part A)
init-project.sh / init-project.ps1  per-project seed (Part B)
AGENT_WORKFLOW_NOTES.md  effort tiers + the depth-1 orchestration rule
```

## Verify after install
- `~/.claude/agents/` has 8 files; frontmatter intact (`name/description/model/effort/tools`).
- `~/.claude/settings.json` → opus / xhigh / notifications.
- In Claude Code: `/agents` lists all 8; `/model` shows Opus / xhigh.
- (optional) karpathy plugin: `/plugin marketplace add multica-ai/andrej-karpathy-skills` then
  `/plugin install andrej-karpathy-skills`. The guidelines are already in `~/.claude/CLAUDE.md`, so
  this is optional.
- Smoke test in a seeded project: ask the planner to plan a trivial task; confirm it reads
  `.claude/PROJECT_PROFILE.md`.

## Design in one line
Agents = generic + global + never edited. Per-project knobs = one `PROJECT_PROFILE.md` the agents
read by section number. Effort tiers and the depth-1 orchestration rule are in
`AGENT_WORKFLOW_NOTES.md`.
