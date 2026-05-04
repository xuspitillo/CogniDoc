# TaskFlow API -- Cognitive Memory System

This project uses CogniDoc for structured LLM-assisted development.
Any LLM operating in this repository MUST follow this protocol.

---

## Semantic Beacon System (SBS) [*(API.W1.DEF>S1)*]

### Domains

| Code | Domain | Coverage |
|------|--------|----------|
| API | Endpoints | Routes, request/response schemas, versioning |
| FRO | Frontend | Client integration, SDK, webhooks |
| BAK | Backend | Business logic, services, utilities |
| TST | Testing | Unit tests, integration tests, fixtures, coverage |
| DEV | DevOps | Docker, CI/CD, deployment, environments |
| DAT | Database | PostgreSQL, Redis, migrations, models |
| SEC | Security | Auth, JWT, permissions, rate limiting, input validation |

### Weights (W1-W5)

| Weight | Meaning | Instruction |
|--------|---------|-------------|
| W1 | Critical | Always read. Fundamental definition |
| W2 | High | Read if working in this area |
| W3 | Medium | Consult when going deeper |
| W4 | Low | Only for specific detail |
| W5 | Note | Ignore unless directed |

### Roles

| Code | Role | Marks |
|------|------|-------|
| DEF | Definition | What something IS |
| DEC | Decision | Why something was chosen |
| DEP | Dependency | Requires another element |
| REF | Reference | See also -- related content elsewhere |
| PAT | Pattern | Reusable pattern |
| RIS | Risk | Identified threat or mitigation |

### Beacon Format

```
[*(DOMAIN.WEIGHT.ROLE>DESTINATION)*]
```

---

## CPA Protocol: Consult-Plan-Act [*(BAK.W1.DEF>S1)*]

### Phase C -- Consult

On every request, evaluate whether you have enough context to proceed:
- **Clear request** --> Move directly to Phase P
- **Ambiguous request** --> Ask a single, complete set of clarifying questions

Never ask multiple rounds of questions. One round covers everything.

### Phase P -- Plan

Before modifying any file:
1. List all files to create/modify/delete
2. Identify order of operations and dependencies
3. Flag impact on memory files (MEMORY.md, missions, SIGNAL_REGISTRY.md)
4. Estimate scope: trivial (1-2 files), standard (3-5), major (6+)

### Phase A -- Act

Execute the plan:
1. Make changes in dependency order
2. Verify each change before proceeding
3. Propagate updates to memory files
4. Run linter and tests if code was modified

---

## Session Commands [*(BAK.W1.DEF>S1)*]

1. **"load memory"** -- Read MEMORY.md, confirm project state, wait for instructions
2. **"analyze [name]"** -- Find and read the mission file for a feature, report its status
3. **"mission MIS-XXX"** -- Read a specific mission file by ID
4. **"new mission: [slug]"** -- Create a new mission (wait for description, propose classification, create after approval)
5. **"review PR"** -- Analyze current branch changes, check for issues, suggest improvements
6. **"run tests"** -- Execute pytest, report results, update mission if relevant
7. **"analyze endpoint [route]"** -- Examine a specific endpoint: handler, schemas, tests, docs
8. **"check coverage"** -- Run coverage report, identify untested code paths
9. **"roadmap"** -- Show active P1/P2 missions with current status
10. **"status"** -- Quick summary of all missions by priority and state
11. **"new handshake"** -- Apply the PHS pre-commit protocol: read HANDSHAKES.md, create `handshakes/hs-N-YYYY-MM-DD-slug.md`, update HANDSHAKES.md index, update MEMORY.md footer counter, then return "ready to commit"
12. **"handshakes"** -- Show the chronological index from HANDSHAKES.md
13. **"handshake HS-NNN"** -- Read a specific handshake file

### Signal Commands

- `[[pause X]]` -- Pause a mission (explicit decision)
- `[[wait X]]` -- Mark mission waiting on external dependency
- `[[resume X]]` -- Resume from pause or wait
- `[[complete X]]` -- Mark mission as completed (immutable)

---

## Directory Structure [*(DEV.W2.DEF>S4)*]

```
taskflow/
├── COGNIDOC.md            <-- This file (bootloader)
├── MEMORY.md              <-- Project memory
├── SIGNAL_REGISTRY.md     <-- Mission state tracking
├── HANDSHAKES.md          <-- Handshake index (one per commit)
├── missions/              <-- Mission files
│   └── mis-XXX-slug.md
├── handshakes/            <-- Immutable per-commit checkpoints
│   └── hs-NNN-YYYY-MM-DD-slug.md
├── src/
│   ├── app.py             <-- FastAPI application entry
│   ├── config.py           <-- Settings and environment
│   ├── models/             <-- SQLAlchemy models
│   ├── schemas/            <-- Pydantic schemas
│   ├── routers/            <-- API route handlers
│   ├── services/           <-- Business logic
│   ├── middleware/          <-- Auth, logging, rate limiting
│   └── utils/              <-- Helpers and shared utilities
├── tests/
│   ├── conftest.py         <-- Fixtures and test config
│   ├── test_tasks.py
│   ├── test_users.py
│   └── test_auth.py
├── migrations/             <-- Alembic database migrations
├── docker-compose.yml
├── Dockerfile
├── pyproject.toml
└── docs/
    └── api.md              <-- API documentation
```

---

## Update Methodology [*(BAK.W1.DEF>S1)*]

- **Mission files**: Update checks `[x]`, milestones, and progress log on every advance
- **MEMORY.md Roadmap (S9)**: Update when a P1/P2 mission changes state or phase
- **MEMORY.md Catalog (S10)**: Update when any mission is created, reclassified, or completed
- **MEMORY.md footer**: Bump `Handshakes: N (latest: HS-N)` on every handshake generation
- **SIGNAL_REGISTRY.md**: Update on every state transition (create, pause, wait, resume, complete)
- **HANDSHAKES.md**: Append a Quick Index entry on every handshake generation; update header counters
- **Handshake files**: Generated before every commit that changes project content. Immutable once written. See `specs/PHS-v1.0.md`

---

## Development Principles [*(BAK.W1.DEF>S1)*]

1. **Test before ship** -- No endpoint merges without passing tests
2. **Document as you go** -- API docs update with every route change
3. **Memory is truth** -- MEMORY.md and mission files reflect the real project state
4. **Migrations are immutable** -- Never edit a committed migration; create a new one
5. **Schemas validate everything** -- All input goes through Pydantic validation
6. **One mission, one feature** -- Each feature gets its own mission file with full tracking
7. **Signals track state** -- Use the signal registry, not mental bookkeeping
8. **Security by default** -- Auth middleware on all non-public routes
