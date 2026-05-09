# Project Signal System (PSS) -- Specification v1.0

## Abstract

The Project Signal System (PSS) is a protocol for atomic state tracking of missions, phases, and processes within a cognitive documentation ecosystem. It provides a formal 5-state machine with signal-driven transitions, an evolution pattern for immutable-yet-improvable records, and a propagation cascade that keeps all project documentation synchronized after every state change. PSS operates as a dedicated registry layer subordinate to the project's core memory, enabling any agent or stakeholder to determine the complete state of every tracked element in a single lookup.

---

## 1. The 5-State Machine

| State | Meaning | How It Is Reached |
|-------|---------|-------------------|
| ACTIVE | Process in progress | Organic (on creation) or via `[[resume X]]` |
| PAUSED | Paused by explicit decision | `[[pause X]]` |
| WAITING | Awaiting an external trigger or condition | `[[wait X]]` |
| COMPLETED | Finished; record is immutable | `[[complete X]]` |
| EVOLUTION | New SIG derived from a COMPLETED SIG | Organic (new SIG with `Ancestor` field) |

**Key distinction:** PAUSED reflects a deliberate decision by the project owner. WAITING reflects a dependency on an external condition the owner does not control.

### 1.1 Valid Transitions

```
           resume              resume
PAUSED <---------- ACTIVE ----------> WAITING
                   |   ^                 |
          pause    |   | resume          | resume
                   v   |                 v
               (self)  +<---------------+
                   |
        complete   |
                   v
              COMPLETED -----(spawns)-----> EVOLUTION
                              (new SIG)
```

| From | To | Via |
|------|----|-----|
| ACTIVE | PAUSED | `[[pause X]]` |
| ACTIVE | WAITING | `[[wait X]]` |
| ACTIVE | COMPLETED | `[[complete X]]` |
| PAUSED | ACTIVE | `[[resume X]]` |
| WAITING | ACTIVE | `[[resume X]]` |
| COMPLETED | *(immutable)* | No outbound transitions. A new SIG with state EVOLUTION may be spawned referencing the completed SIG as its ancestor. |

Invalid transitions (e.g., PAUSED to COMPLETED, WAITING to COMPLETED) must pass through ACTIVE first.

### 1.2 Birth State and Dependencies

**Every mission is born ACTIVE.** No mission is ever created directly in PAUSED, WAITING, COMPLETED, or EVOLUTION state. The organic creation signal always produces an `ACTIVE` initial state with a single history entry: `Created → ACTIVE`.

When a mission is created with unresolved dependencies (i.e., it cannot actually progress because another mission must complete first), the bootloader's `new mission` workflow MUST emit a separate, explicit `[[wait X]]` signal **immediately after** creation. This produces two distinct, sequential history entries in the SIG:

```
| Date       | Signal  | Previous State | New State | Reason                                |
|------------|---------|----------------|-----------|---------------------------------------|
| YYYY-MM-DD | Created | —              | ACTIVE    | Mission created with scope and goals |
| YYYY-MM-DD | Wait    | ACTIVE         | WAITING   | Blocked by MIS-XXX (dependency)      |
```

Direct creation in WAITING state — i.e., a single history row showing `Created → WAITING` or a fabricated synthetic transition `Created → ACTIVE → Wait → WAITING` collapsed into the creation step — is **invalid**. It compromises audit-trail integrity: the PSS history must reflect signals that were actually emitted, not implied or inferred.

The same principle applies to PAUSED: a mission is never born PAUSED. To begin a mission already paused, create it ACTIVE and immediately emit `[[pause X]]`.

This rule applies to LLM agents implementing PSS: when a user creates a mission with dependencies, the agent must emit two signals (one organic, one explicit) and produce two history entries. Combining them into a single phantom transition is a protocol violation.

---

## 2. Signals

| Signal | Syntax | Type | Description |
|--------|--------|------|-------------|
| Create | *(organic)* | Automatic | Emitted implicitly when a mission or process is created. No explicit syntax required. |
| Pause | `[[pause X]]` | Explicit / contextual | Transitions target X from ACTIVE to PAUSED. |
| Wait | `[[wait X]]` | Explicit / contextual | Transitions target X from ACTIVE to WAITING. |
| Resume | `[[resume X]]` | Explicit / contextual | Transitions target X from PAUSED or WAITING to ACTIVE. |
| Complete | `[[complete X]]` | Explicit / contextual | Transitions target X from ACTIVE to COMPLETED. Immutable thereafter. |

### 2.1 Target Convention

The target `X` in any signal is a free-form identifier following these conventions:

- `MIS-XXX` -- a mission (e.g., `MIS-003`)
- `MIS-XXX/P-N` -- a specific phase within a mission (e.g., `MIS-003/P-2`)
- Descriptive slug -- a named process (e.g., `ci-pipeline-migration`)

Targets are case-insensitive for matching but stored in their canonical form.

### 2.2 Contextual Recognition

An LLM agent implementing PSS recognizes signals by both explicit syntax (`[[pause MIS-009]]`) and semantic context in natural language (e.g., "let's pause the API redesign for now" maps to `[[pause MIS-009]]` if that mission covers the API redesign). The agent confirms interpretation before executing the transition.

---

## 3. Signal Registry

The Signal Registry is a dedicated file (`SIGNAL_REGISTRY.md`) that serves as the single source of truth for all tracked states. It is subordinate to the project's core memory document, which references it as an extension of the metacognitive nucleus.

### 3.1 Structure

The registry contains two sections:

1. **Quick Index** -- a summary table enabling full-project state awareness in one pass.
2. **Detailed Entries** -- one block per SIG-NNN with complete history.

### 3.2 Entry Format

```markdown
### SIG-NNN

- **Target:** MIS-XXX | MIS-XXX/P-N | slug
- **State:** ACTIVE | PAUSED | WAITING | COMPLETED | EVOLUTION
- **Created:** YYYY-MM-DD
- **Last updated:** YYYY-MM-DD
- **Ancestor:** SIG-XXX (only if EVOLUTION)
- **Evolutions:** SIG-YYY (forward pointer, only if spawned)
- **Linked missions:** MIS-AAA (dependency), MIS-BBB (parent)
- **History:**
  - YYYY-MM-DD | ACTIVE | Created organically with mission MIS-XXX
  - YYYY-MM-DD | PAUSED | Reason: awaiting design review approval
  - YYYY-MM-DD | ACTIVE | Resumed after review completed
```

### 3.3 Quick Index

```markdown
| SIG | Target | State | Last Updated | Notes |
|-----|--------|-------|--------------|-------|
| SIG-001 | MIS-001 | COMPLETED | 2026-01-15 | Foundation phase |
| SIG-002 | MIS-003 | ACTIVE | 2026-04-20 | Core platform |
| SIG-003 | MIS-003/P-2 | WAITING | 2026-04-22 | Blocked on dependency |
```

The Quick Index allows any agent to assess the entire project state without parsing individual entries.

---

## 4. Propagation Cascade

When any signal is emitted, the following propagation is mandatory:

1. **SIGNAL_REGISTRY.md:** Create or update the SIG-NNN entry. Append to the signal history with timestamp, new state, and reason.
2. **Mission target:** Update the METADATA block of the target mission file (state field) and append a log entry referencing the signal.
3. **Core memory (MEMORY.md):** If the affected mission is P1 or P2 priority, update the active roadmap section to reflect the new state.
4. **Audit level:** `[[pause]]` and `[[complete]]` require full documentary audit (cross-check all references). `[[wait]]`, `[[resume]]`, and organic creation require lightweight audit only.

The cascade executes atomically: all propagation targets are updated before the transition is considered complete.

---

## 5. Evolution Pattern

When a COMPLETED SIG requires improvement due to new knowledge, requirements, or scope:

1. The original SIG remains **immutable** at COMPLETED. Its record is never modified except to add a forward pointer.
2. A new SIG is created with `Ancestor: SIG-XXX` referencing the original.
3. The original SIG receives a single update: `Evolutions: SIG-YYY` (forward pointer to the new SIG).
4. Cross-reference beacons link both SIGs bidirectionally for navigation.
5. The new SIG has equal or higher hierarchy than its ancestor -- it is a continuation, not a sub-task.

This pattern preserves historical integrity while enabling iterative improvement.

---

## 6. Best Practices

- **Proactive suggestion:** The implementing LLM MAY suggest signals when context advises it (e.g., "Since MIS-003 is paused, consider `[[wait MIS-010]]` as it depends on MIS-003").
- **One signal per transition:** Each state change is a discrete signal. Do not batch multiple transitions into a single operation.
- **Always include a reason:** Every entry in the signal history must state why the transition occurred. Signals without reasons degrade the audit trail.
- **COMPLETED is permanent:** Never attempt to reopen a completed SIG. Use the Evolution pattern instead.
- **Organic creation:** When a new mission or process is created through standard project workflows, the corresponding SIG is generated automatically. No explicit signal is required.
- **Validate before transitioning:** The agent must confirm the transition is valid per the state machine (Section 1.1) before executing. Invalid transitions are rejected with an explanation.

---

## 7. Versioning

This document defines PSS v1.0. Future versions within the v1.x line will maintain full backward compatibility: existing states, signals, and registry formats remain valid. New capabilities (additional states, extended metadata) will be additive only. Breaking changes require a v2.0 designation.
