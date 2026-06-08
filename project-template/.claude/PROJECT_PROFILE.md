# Project Profile — <TODO: PROJECT NAME>

**Single source of project-specific context for the agent pipeline.** The agents in the
`claude-agent-pipeline` plugin are generic; they read THIS file (by section number) for anything
that differs between projects. On a new project you edit ONLY this file and `CLAUDE.md`.

How to use: fill every `TODO:` below. Delete any section that doesn't apply (the agents treat
a missing section as "not defined" and fall back to sensible generic behavior). Keep the
section numbers/headings stable — the agents reference them as "§1 … §7".

---

## §1. Architecture & entry points
- Entry point(s): <TODO: e.g. the `@SpringBootApplication` main class `src/main/java/.../Application.java`; or `main.py` / `cmd/server/main.go`>
- Architecture doc (if any): <TODO: e.g. `ARCHITECTURE.md`, or "none">
- Key modules / shared state to know about: <TODO: e.g. Spring beans/components, config singletons, global/DB state, env vars>

## §2. Build / test / run commands
- Install / build: <TODO: e.g. `./mvnw -q install -DskipTests` or `./gradlew build -x test`; or `pip install -r requirements.txt` / `npm ci`>
- **Test command (agents run this):** <TODO: e.g. `./mvnw test` or `./gradlew test`; or `pytest -q` / `npm test`>
- Lint / format / typecheck: <TODO: e.g. `./mvnw -q checkstyle:check` / `./gradlew check` / Spotless; or `ruff check .`>
- Run the app: <TODO: e.g. `./mvnw spring-boot:run` or `./gradlew bootRun`; or `python main.py`>

## §3. Testing setup (read before writing tests)
- Testing guide doc (if any): <TODO: e.g. `docs/testing-strategy.md`, or "none">
- Shared fixtures / helpers: <TODO: e.g. JUnit base test classes / `@TestConfiguration` / fixtures under `src/test/java`; or `tests/conftest.py`>
- Available fixtures (REUSE these; don't reinvent): <TODO: list names + 1-line purpose, or "none yet">
- **Test-isolation hazards** (CRITICAL — getting these wrong lets tests hit real data):
  <TODO: e.g. (Java/Spring) "which bean a `@MockBean` replaces; prefer slice tests (`@WebMvcTest`,
  `@DataJpaTest`) over a full `@SpringBootTest`; reset shared singletons/static state between tests";
  (Python) "patch BOTH `pkg.X` and `main.X`". Write "none known" if not applicable.>
- **Never touch in tests (real-data paths):** <TODO: e.g. real user data dir, prod config/state files,
  real/prod DB (use Testcontainers or H2). List concrete paths/URLs. Agents never write or assert against these.>
- Platform/language test gotchas (if any): <TODO: e.g. (Java) classpath resource loading differs in jar
  vs IDE; flaky default time-zone/locale; H2-vs-prod SQL dialect drift. (Windows) path separators /
  case-insensitive FS. Delete if n/a.>

## §4. Git & PR conventions
- Branch / commit / PR rules doc (if any): <TODO: e.g. `docs/git-pr-conventions.md`, or "none">
- **Issue/ticket code in PR title?** <TODO: e.g. `IMP-<XN>` (custom), `JIRA-123`, GitHub `#123`, or "none">
  - If yes, where to look it up: <TODO: e.g. `improvements_tier*.md`, Jira board, issue link>
  - Title format: <TODO: e.g. `<type>: <short summary> — <CODE>`>
- PR body order: <TODO: e.g. "auto-summary first, then `## Original task prompt` (verbatim), then trailer">
- Merge to main human-gated? <TODO: yes / no — if yes, agents STOP and ask before merging>
- Branch archival method: <TODO: e.g. annotated `archive/<branch>` tag then delete; or just delete; or "none">

## §5. Load-bearing mechanisms / change-gates (optional)
<TODO: list any subsystem that must NOT be changed without explicit human sign-off, and what
"changing it" means. Example: a rollback journal / migration runner / billing path. For each,
say where the spec lives. DELETE this whole section if the project has none.>

## §6. Known gotchas (optional)
<TODO: language/platform/codebase traps an executor could trip on. DELETE if none.>

## §7. Task / improvement tracking (optional)
<TODO: how work is tracked, e.g. `IMP-<XN>` tasks in `improvements_tier*.md`, or a Jira/Linear
board, or GitHub issues. The planner/git-agent use this for PR titles (see §4). DELETE if none.>
