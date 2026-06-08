# claude-agent-pipeline

A **Claude Code plugin** that adds a generic, language-agnostic multi-agent coding pipeline
(planner → orchestrator → executors → judge → git-agent → architect) plus two helper commands.
Installs the karpathy way — entirely inside Claude Code, no shell scripts. The agents carry no
project- or language-specific content; everything that varies per project lives in one file you
fill in (`.claude/PROJECT_PROFILE.md`). Examples lead with Java/Spring.

## Install (inside Claude Code — no scripts)

In any Claude Code session:

```text
/plugin marketplace add harinathsrinivas/claude-agent-pipeline
/plugin install agent-pipeline@claude-agent-pipeline
/agent-pipeline:setup          ← optional: applies recommended global settings (Opus / xhigh)
```

The 8 agents are now available **globally, in every project** — run `/agents` to confirm
(`planner`, `orchestrator`, `architect`, `judge`, `executor-opus`, `executor-sonnet`,
`executor-haiku`, `git-agent`).

### …or just tell Claude
> "Add the marketplace `harinathsrinivas/claude-agent-pipeline`, install the `agent-pipeline` plugin, then run `/agent-pipeline:setup`."

Claude Code runs the `/plugin` steps and the setup for you. After installing, run `/reload-plugins`
(or restart) if the agents/commands don't appear immediately.

## Per project

Open the project in Claude Code and run:

```text
/agent-pipeline:init-project        (optionally: /agent-pipeline:init-project a short description)
```

This seeds `CLAUDE.md` + `.claude/PROJECT_PROFILE.md` (never overwriting existing files), auto-detects
your build/test command and entry point, and helps you fill the `TODO:`s. After that you only ever
edit **one file** — `.claude/PROJECT_PROFILE.md` — and the agents read everything project-specific
from it by section number. `examples-spring/` is a filled-in Spring Boot reference.

## What's in the plugin
```
.claude-plugin/
  marketplace.json     # marketplace manifest (this single-plugin repo)
  plugin.json          # plugin manifest
agents/                # 8 generic, language-neutral agents (auto-installed globally)
commands/
  setup.md             # /agent-pipeline:setup        — recommended global settings
  init-project.md      # /agent-pipeline:init-project  — seed + fill a project's templates
project-template/      # the templates the init command copies into a project
  CLAUDE.md
  .claude/PROJECT_PROFILE.md   # the ONE per-project knobs file (Java/Spring-first examples)
  .claude/env.template, settings.local.starter.json
examples-spring/       # a filled-in example (Spring Boot orders-service)
AGENT_WORKFLOW_NOTES.md  # effort tiers + the depth-1 orchestration rule
```

## What each agent reads from PROJECT_PROFILE.md
| Agent | Reads |
| :---- | :---- |
| architect | §1 entry points |
| planner | §2 test command, §3 testing setup |
| executor-opus / -sonnet / -haiku | §3 fixtures + isolation hazards + real-data guards, §2 test command |
| git-agent / orchestrator | §4 PR/issue-code convention, merge/archive gates |
| judge | nothing project-specific |

## Notes
- **Why a `/setup` command?** A plugin can ship agents and commands automatically, but Claude Code does
  **not** let a plugin set your `model` / `effortLevel`. `/agent-pipeline:setup` applies those
  (non-destructively) so "install everything" is still one or two commands.
- **Behavioral guidelines (karpathy):** kept separate on purpose. If you want them too:
  `/plugin marketplace add multica-ai/andrej-karpathy-skills` then
  `/plugin install andrej-karpathy-skills@karpathy-skills`.
- **Updating:** push changes here; on your machine run `/plugin update agent-pipeline` (or
  `/reload-plugins` during local testing).

## Design in one line
Agents = generic + installed globally + never edited. Per-project knobs = one `PROJECT_PROFILE.md`
the agents read by section number. Effort tiers and the depth-1 orchestration rule are in
`AGENT_WORKFLOW_NOTES.md`.
