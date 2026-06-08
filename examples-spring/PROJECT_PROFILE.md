# Project Profile — orders-service (example)

Worked example: a Spring Boot REST service, showing how the template gets filled for a Java
project. This is fictional — your real values will differ. Compare it with the blank template at
`project-template/.claude/PROJECT_PROFILE.md`.

---

## §1. Architecture & entry points
- Entry point(s): `src/main/java/com/acme/orders/OrdersApplication.java` (`@SpringBootApplication`).
- Architecture doc: `ARCHITECTURE.md`.
- Key modules / shared state: REST controllers (`web/`), service layer (`service/`), JPA
  repositories (`repo/`) over PostgreSQL; config in `application.yml`. Shared singletons worth
  knowing: an injected `Clock` bean and a Caffeine cache.

## §2. Build / test / run commands
- Install / build: `./mvnw -q install -DskipTests`
- **Test command (agents run this):** `./mvnw test`
- Lint / format / typecheck: `./mvnw -q spotless:check checkstyle:check`
- Run the app: `./mvnw spring-boot:run` (needs a local Postgres; see `docker-compose.yml`)

## §3. Testing setup (read before writing tests)
- Testing guide doc: `docs/testing.md`.
- Shared fixtures / helpers: `AbstractIntegrationTest` (boots a Testcontainers Postgres);
  `TestDataFactory` builders under `src/test/java/.../support`.
- Available fixtures (REUSE; don't reinvent): `AbstractIntegrationTest` (full-context IT),
  `@WebMvcTest` slices for controllers, `OrderFixtures.anOrder()` builder.
- **Test-isolation hazards (CRITICAL):** use `@MockBean` to replace the `PaymentClient` bean so
  tests never call the real gateway; prefer `@WebMvcTest` / `@DataJpaTest` slices over a full
  `@SpringBootTest` to keep tests fast and isolated; reset the Caffeine cache and the injected
  `Clock` between tests (singletons — stale state leaks across tests).
- **Never touch in tests (real-data paths):** the real Postgres from `application.yml`
  (`jdbc:postgresql://prod-db…`) and the live `PaymentClient` base URL — always use Testcontainers
  and `@MockBean`.
- Platform/language test gotchas: classpath resources load differently from a built jar vs the IDE;
  default time zone affects `LocalDate` assertions — pin with `@TestPropertySource` or `-Duser.timezone=UTC`.

## §4. Git & PR conventions
- Branch / commit / PR rules doc: `docs/contributing.md`.
- **Issue/ticket code in PR title?** Yes — Jira `ORD-<n>`.
  - Look it up in: the Jira board, or the branch name (`feature/ORD-123-...`).
  - Title format: `<type>: <short summary> [ORD-123]`.
- PR body order: summary first, then a `## Context` / testing-notes section, then the trailer.
- Merge to main human-gated? Yes — requires 1 approval + green CI.
- Branch archival: GitHub deletes the branch after squash-merge; no manual archival.

## §5. Load-bearing mechanisms / change-gates
- **Flyway migrations** under `src/main/resources/db/migration` are append-only — never edit an
  already-released migration; add a new versioned one. Editing an applied migration corrupts prod
  schema history. (Spec: `docs/db-migrations.md`.)

## §6. Known gotchas
- Lombok is used — annotation processing must be enabled or builds/IDE look broken.
- `@Transactional` on a private or self-invoked method is a no-op (Spring proxy boundary).

## §7. Task / improvement tracking
- Work tracked in Jira (`ORD-<n>`); the PR-title convention is in §4.
