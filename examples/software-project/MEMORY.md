# TaskFlow API -- Project Memory

> Last updated: 2026-05-01 | Version: v0.3.0 | Endpoints: 12 | Tests: 45 | Missions: 4

---

## S1 -- Identity [*(BAK.W1.DEF>S1)*]

**TaskFlow API** is a RESTful task management service built with FastAPI and PostgreSQL.
It provides a backend for organizing tasks into projects, assigning owners, setting
priorities and deadlines, and tracking completion. Designed for small-to-medium teams
who need a reliable, self-hosted alternative to SaaS task tools.

The project is maintained by a 3-person engineering team. Development follows a
mission-based workflow tracked through MandelDoc cognitive memory.

---

## S2 -- Stack [*(DEV.W2.DEF>S2)*]

| Layer | Technology | Version |
|-------|-----------|---------|
| Language | Python | 3.12 |
| Framework | FastAPI | 0.115.x |
| Database | PostgreSQL | 16 |
| Cache | Redis | 7.2 |
| ORM | SQLAlchemy | 2.0 |
| Migrations | Alembic | 1.13 |
| Validation | Pydantic | 2.x |
| Testing | pytest + httpx | latest |
| Containers | Docker Compose | v2 |
| Linter | ruff | latest |

---

## S4 -- Current State [*(BAK.W1.DEF>S4)*]

- **Version:** v0.3.0
- **Endpoints:** 12 (CRUD tasks, CRUD projects, health, search)
- **Tests:** 45 passing, 0 failing
- **Coverage:** 82%
- **Source files:** 18
- **Lines of code:** ~2,400
- **Database tables:** 3 (tasks, projects, tags)
- **Docker services:** 3 (api, postgres, redis)
- **Open issues:** 7

---

## S9 -- Active Roadmap [*(BAK.W1.DEF>S9)*]

### P1 -- Critical

| ID | Mission | Type | Phase | Status |
|----|---------|------|-------|--------|
| MIS-001 | auth-system | ROOT | Phase 2 (JWT endpoints) | ACTIVE -- user model done, building login/register |

### P2 -- High

| ID | Mission | Type | Phase | Status |
|----|---------|------|-------|--------|
| MIS-002 | notifications | ROOT | Pre-phase | WAITING -- depends on MIS-001 (needs auth for user channels) |

---

## S10 -- Mission Catalog [*(BAK.W2.DEF>S10)*]

### Active Missions

| ID | Slug | Priority | Type | State | File |
|----|------|----------|------|-------|------|
| MIS-001 | auth-system | P1 | ROOT | ACTIVE | `missions/mis-001-auth-system.md` |
| MIS-002 | notifications | P2 | ROOT | WAITING | `missions/mis-002-notifications.md` |
| MIS-004 | rate-limiting | P3 | SATELLITE | PAUSED | `missions/mis-004-rate-limiting.md` |

### Completed Missions

| ID | Slug | Priority | Type | Completed |
|----|------|----------|------|-----------|
| MIS-003 | api-docs | P2 | SATELLITE | 2026-04-15 |

---

> Footer: v0.3.0 | 12 endpoints | 45 tests | 18 source files | ~2,400 LOC | 4 missions (1 active, 1 waiting, 1 paused, 1 completed) | Handshakes: 1 (latest: HS-001)
