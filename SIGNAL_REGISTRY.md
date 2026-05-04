# SIGNAL_REGISTRY.md — CogniDoc Tier 1 [*(COG.W1.DEF>SR)*]

> Atomic state registry for missions, phases, and processes (PSS protocol).
> Subordinate to MEMORY.md. Every signal here MUST cross-reference an entry in the catalog (S10).

**Last updated:** 2026-05-02
**Total signals:** 3 (2 ACTIVE, 1 WAITING, 0 PAUSED, 0 COMPLETED)

---

## Quick Index [*(COG.W1.DEF>SR)*]

| Signal | Target | State | Type | Last transition |
|--------|--------|-------|------|-----------------|
| SIG-001 | MIS-001 community-engagement | ACTIVE | Mission | 2026-05-02 (created) |
| SIG-002 | MIS-002 t2-preparation | ACTIVE | Mission | 2026-05-02 (created) |
| SIG-003 | MIS-003 spanish-translation | WAITING | Mission | 2026-05-02 (created → waiting) |

---

## SIG-001 — Community engagement [*(BIZ.W2.SIG>SR.SIG-001)*]

- **Target:** MIS-001 (`missions/mis-001-community-engagement.md`)
- **State:** ACTIVE
- **Created:** 2026-05-02 (organic creation alongside the public release)
- **Reason:** Initial outreach to early adopters and design partners is the top priority for the public alpha
- **Linked signals:** SIG-002 (parallel P1), SIG-003 (downstream — Spanish translation depends on community traction)
- **History:**
  - 2026-05-02 — Created (ACTIVE) on public release of v0.1.0

---

## SIG-002 — T2 (Starter) preparation [*(ARQ.W2.SIG>SR.SIG-002)*]

- **Target:** MIS-002 (`missions/mis-002-t2-preparation.md`)
- **State:** ACTIVE
- **Created:** 2026-05-02
- **Reason:** Extracting a programmatic library and PDF generator from the T1 specs is the next product milestone
- **Linked signals:** SIG-001 (parallel P1 — feedback from community informs T2 scope)
- **History:**
  - 2026-05-02 — Created (ACTIVE) on public release of v0.1.0

---

## SIG-003 — Spanish translation [*(COG.W3.SIG>SR.SIG-003)*]

- **Target:** MIS-003 (`missions/mis-003-spanish-translation.md`)
- **State:** WAITING
- **Created:** 2026-05-02 (created in WAITING state — no work scheduled yet)
- **Reason:** Waiting for community traction before investing in translation. Trigger condition: sustained interest signal from non-English-speaking adopters or 50+ stars on the public repository
- **Linked signals:** SIG-001 (upstream — community engagement determines when this signal transitions to ACTIVE)
- **History:**
  - 2026-05-02 — Created in WAITING state. External trigger required to activate

---

## Notes

- Signal IDs are sequential and never reused
- WAITING means waiting for an external trigger; PAUSED means an explicit decision to halt
- Transitions are logged here AND in the corresponding mission file's progress log
