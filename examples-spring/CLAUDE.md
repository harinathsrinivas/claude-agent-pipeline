# orders-service — Project Instructions

Example filled-in project `CLAUDE.md` (Spring Boot). Loaded into every session and subagent.
Merges with the global `~/.claude/CLAUDE.md` (karpathy behavioral guidelines).

> All project-specific facts live in [`.claude/PROJECT_PROFILE.md`](.claude/PROJECT_PROFILE.md)
> (entry points, build/test commands, fixtures, PR conventions, change-gates). Edit that file for
> per-project details; this file holds only the workflow rules.

## Git & pull requests
Follow the conventions in `.claude/PROJECT_PROFILE.md` §4:
1. **PR title** — include the Jira code: `<type>: <short summary> [ORD-123]`.
2. **PR body** — summary first, then a `## Context` / testing-notes section, then the trailer.
3. **Checkpoint 1 — merging into `main` is human-gated** (1 approval + green CI). Create the PR,
   then STOP and ask.
4. Branch archival — GitHub deletes the branch after squash-merge; no manual step.

## Agentic workflow
Non-trivial changes go through the multi-agent pipeline from the `claude-agent-pipeline` plugin
(planner → orchestrator → executors, with judge and git-agent). Effort tiers:
planner/orchestrator/architect/judge = opus/high · executor-opus = opus/max ·
executor-sonnet = sonnet/medium · executor-haiku & git-agent = haiku/low.

**Execution model — top-level orchestration.** A Claude Code sub-agent cannot spawn sub-agents
(nesting depth = 1). Run the pipeline from the **main session**, following
the `orchestrator` agent's definition as a playbook and spawning the executor / judge / git
sub-agents yourself. **Do NOT launch `orchestrator` via `Task`** — it would hit the depth limit
and silently fall back to running everything inline.

## Surface fundamental contradictions — no silent handling
If any agent hits a fundamental capability gap or contradiction (a required tool is unavailable; a
planned approach is impossible; an instruction conflicts with a hard runtime limit), STOP and
surface it to the user as an explicit decision rather than silently working around it.

## Project-specific change-gates (load-bearing code)
Per `.claude/PROJECT_PROFILE.md` §5: Flyway migrations under `db/migration` are append-only.
Before any change that edits an already-released migration, STOP, state exactly what differs, and
ask the user.

## Task / improvement tracking
Work is tracked in Jira (`ORD-<n>`); see `.claude/PROJECT_PROFILE.md` §7.
