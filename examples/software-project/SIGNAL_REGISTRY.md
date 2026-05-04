# TaskFlow API -- Signal Registry

> Total signals: 4 | Active: 1 | Waiting: 1 | Paused: 1 | Completed: 1
> Last updated: 2026-05-01

---

## Quick Index

| SIG | Target | State | Since | Summary |
|-----|--------|-------|-------|---------|
| SIG-001 | MIS-001 auth-system | ACTIVE | 2026-04-01 | JWT authentication system -- Phase 2 in progress |
| SIG-002 | MIS-002 notifications | WAITING | 2026-04-10 | Real-time notifications -- blocked on MIS-001 |
| SIG-003 | MIS-003 api-docs | COMPLETED | 2026-04-15 | OpenAPI docs and Redoc integration |
| SIG-004 | MIS-004 rate-limiting | PAUSED | 2026-04-22 | Redis-based rate limiter -- paused, team focus on auth |

---

## Signal Entries

### SIG-001 -- MIS-001 auth-system [*(SEC.W1.DEF>MIS-001)*]
- **State:** ACTIVE
- **Created:** 2026-04-01
- **Target:** MIS-001 (auth-system)
- **History:**
  - 2026-04-01: Created (organic) -- mission initiated, Phase 1 started
  - 2026-04-18: Phase 1 completed -- user model and migrations done

### SIG-002 -- MIS-002 notifications [*(API.W2.DEP>MIS-001)*]
- **State:** WAITING
- **Created:** 2026-04-10
- **Target:** MIS-002 (notifications)
- **Waiting on:** MIS-001 completion (needs authenticated user context for channels)
- **History:**
  - 2026-04-10: Created (organic) -- mission scoped and planned
  - 2026-04-10: Transitioned to WAITING -- depends on auth system

### SIG-003 -- MIS-003 api-docs [*(API.W2.DEF>MIS-003)*]
- **State:** COMPLETED
- **Created:** 2026-03-20
- **Completed:** 2026-04-15
- **Target:** MIS-003 (api-docs)
- **History:**
  - 2026-03-20: Created (organic) -- OpenAPI documentation initiative
  - 2026-04-15: Completed -- Redoc served at /docs, all 12 endpoints documented

### SIG-004 -- MIS-004 rate-limiting [*(SEC.W3.DEF>MIS-004)*]
- **State:** PAUSED
- **Created:** 2026-04-05
- **Target:** MIS-004 (rate-limiting)
- **Reason:** Team bandwidth redirected to MIS-001 (auth-system, P1 critical)
- **History:**
  - 2026-04-05: Created (organic) -- rate limiting research started
  - 2026-04-12: Prototype with Redis sliding window tested locally
  - 2026-04-22: Paused -- team decision to focus on P1 auth before hardening
