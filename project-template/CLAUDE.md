# <TODO: PROJECT NAME> — Project Instructions

Project-specific guidance for Claude Code. Loaded into every session and subagent. Merges with
the global `~/.claude/CLAUDE.md` (the karpathy behavioral guidelines).

> **All project-specific facts live in [`.claude/PROJECT_PROFILE.md`](.claude/PROJECT_PROFILE.md)**
> (entry points, build/test commands, fixtures, PR conventions, change-gates). Edit that file, not
> this one, for per-project details. This file holds only the workflow *rules* that are the same
> across projects. Every `TODO:` below is something to confirm or delete for this project.

## Git & pull requests
Follow the conventions recorded in `.claude/PROJECT_PROFILE.md` §4. Easy-to-forget rules (keep the
ones that apply, per §4):

1. **PR title** — use the issue/ticket code convention from §4 if your project has one.
2. **PR body order** — auto-generated summary FIRST, then `## Original task prompt` with the
   **complete verbatim** initial prompt, then the `🤖 Generated with Claude Code` trailer.
3. **Checkpoint 1 — merging into the default branch is human-gated.** Never merge/push to `main`
   without explicit user confirmation. Create the PR, then STOP and ask. <TODO: keep or relax>
4. **Checkpoint 2 — archiving a merged branch is human-gated.** On approval, create an annotated
   `archive/<branch>` tag (merge info + revive steps), push it, then delete the branch. <TODO: keep or relax>

## Agentic workflow
Non-trivial changes go through the multi-agent pipeline from the `claude-agent-pipeline` plugin
(planner → orchestrator → executors, with git-agent and judge). Effort tiers (Opus 4.8):
planner/orchestrator/architect/judge = opus/high · executor-opus = opus/max ·
executor-sonnet = sonnet/medium · executor-haiku & git-agent = haiku/low.
See `AGENT_WORKFLOW_NOTES.md`. <TODO: if you keep an ARCHITECTURE.md, reference its agent section here.>

**Execution model — top-level orchestration.** A Claude Code sub-agent cannot spawn sub-agents
(nesting depth = 1), and `orchestrator` is otherwise a sub-agent. So the pipeline runs in the
**main (top-level) session**: it reads `PLAN.md`, follows the `orchestrator` agent's definition as a
*playbook*, and spawns the executor / candidate / judge / git sub-agents **itself** (depth-1 from
the main session works), committing between steps and pausing at the human gates. **Do NOT launch
the `orchestrator` agent via `Task` to execute a plan** — it would hit the depth limit and silently
fall back to running everything inline.

## Surface fundamental contradictions — no silent handling
If any agent — or the main session — hits a **fundamental capability gap or contradiction** with the
task/plan (a required tool is unavailable, e.g. nested `Task`; a planned approach is impossible; an
instruction conflicts with a hard runtime limit), **STOP and surface it to the user as an explicit
decision** — state what was expected, what differs, and the options — rather than silently working
around it. This applies to every agent (this file loads into every session and sub-agent).

## Project-specific change-gates (load-bearing code)
If `.claude/PROJECT_PROFILE.md` §5 lists any load-bearing mechanism, treat it as a **change-gate**:
before implementing ANY change that would alter its documented behavior, STOP, state EXACTLY what
differs, and ask the user as an explicit decision. <TODO: keep if §5 is non-empty; delete otherwise.>

## Task / improvement tracking
Work tracking (if any) is described in `.claude/PROJECT_PROFILE.md` §7. <TODO: keep or delete.>
