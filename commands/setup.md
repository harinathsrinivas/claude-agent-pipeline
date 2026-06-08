---
description: Apply the recommended global Claude Code settings for the agent pipeline (model=opus, effortLevel=xhigh) to ~/.claude/settings.json. Run once per machine after installing the plugin.
disable-model-invocation: true
---

Configure this machine's **global** Claude Code settings for the agent pipeline, non-destructively.

Recommended keys (these make the main orchestration session strong; each agent's own model is fixed
in its frontmatter regardless):
- `"model": "opus"`
- `"effortLevel": "xhigh"`

Steps:
1. Read `~/.claude/settings.json` if it exists; back it up to `~/.claude/settings.json.bak-<timestamp>` first.
2. **Merge** the two keys above into the existing JSON **without removing any other keys**. If the file
   doesn't exist, create it with just those keys. Write valid JSON (2-space indent).
3. Report which keys you added/changed and their new values. Remind the user: these are global (apply to
   every project); they can change the model anytime with `/model`, or lower `effortLevel` for
   cheaper/faster sessions.
4. Have the user run `/agents` and confirm the pipeline agents appear: `planner`, `orchestrator`,
   `architect`, `judge`, `executor-opus`, `executor-sonnet`, `executor-haiku`, `git-agent`. These are
   installed automatically by the plugin — this command does **not** install them.

Do not modify anything else. If you can't write `~/.claude/settings.json`, report the reason and stop.
