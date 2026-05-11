# Record of Propagation (ROP) — Specification v1.0

## Abstract

A Record of Propagation (ROP) is a project-local table that maps every volatile metric, identifier, or counter that appears in more than one document to the complete set of locations where that value lives. After any edit that changes a tracked value, the ROP table is consulted to verify that all propagation targets received the update. ROP is a **discipline**, not an enforcer: the public protocol defines the table format and the verification ritual; programmatic validation is a separate concern handled by tooling outside the v1.0 surface.

ROP exists because cognitive documentation systems accumulate "shared facts" — endpoint counts, mission totals, version numbers, handshake counters, line-count snapshots, model versions — that appear in `MEMORY.md`, in mission files, in the bootloader, in auto-generated manuals, and in the handshake chain. Without a propagation discipline, these values drift. With ROP, drift is detectable in a single pass.

---

## 1. When to Use ROP

A value belongs in the ROP table if **all three** of the following are true:

1. **It is volatile.** The value changes over the project's lifetime (versions, counts, dates).
2. **It is duplicated.** The value appears in two or more documents (`MEMORY.md` Section 7 _and_ a mission file _and_ a manual, etc.).
3. **Drift would be a documentary defect.** A reader cross-checking the two locations would find the project documentation contradicting itself.

If any one of those three is false, the value does not need ROP tracking:

- Single-location values are self-consistent by definition.
- Static values (project name, license) do not drift.
- Internal-only working-state values that no external reader will compare across documents do not require formal tracking.

Examples of values that typically belong in the ROP table:

- API endpoint count
- Source-file count
- Lines of code (LOC) for the codebase
- Test count
- Mission totals (active / paused / waiting / completed)
- Signal totals
- Handshake counter (`HS-NNN` latest)
- Project version
- Headline architectural metric (e.g., "7 layers", "3 tenants")

Examples that typically do not:

- Project name (static)
- License (static)
- The text of design decisions (lives in one place — the mission file or handshake)

---

## 2. ROP Table Format

The ROP table is a single Markdown table, normally stored at `docs/ROP.md` or as Section 8 of `MEMORY.md`. The exact location is a project choice; what matters is that it exists in exactly one place per project.

```markdown
| Metric | Authoritative Source | Propagation Targets | Update Trigger |
|--------|----------------------|---------------------|----------------|
| API endpoint count | `MEMORY.md` §3 | `missions/mis-006-*.md` METADATA; `docs/manual.md` ch.2; `HANDSHAKES.md` header | After every commit that adds/removes an endpoint |
| Mission totals | `MEMORY.md` §10 (catalog) | `MEMORY.md` §9 (roadmap); `SIGNAL_REGISTRY.md` Quick Index | On any mission state change |
| Handshake counter | `HANDSHAKES.md` header | `MEMORY.md` footer | On every handshake generation (see PHS §5) |
| Project version | `VERSION` file | `README.md` Status block; `bootloader/MANDELDOC.md.template` header | On every release tag |
| Source-file count | `MEMORY.md` §3 | mission files referencing module size; manual ch. 1 | After significant file additions/deletions |
```

| Column | Purpose |
|--------|---------|
| **Metric** | Human-readable name of the tracked value. |
| **Authoritative Source** | The single file + section where the value is canonical. All other instances are copies. |
| **Propagation Targets** | Every other location the value appears. Updates flow from the authoritative source to these. |
| **Update Trigger** | The event that obliges propagation (commit, release, state change). |

---

## 3. The Propagation Ritual

After any edit that changes a tracked value:

1. **Locate the authoritative source** for the changed value in the ROP table.
2. **Update the authoritative source first.** If you wrote the new value somewhere else first, move the canonical value to the authoritative source and reduce the other location to a copy.
3. **Walk every propagation target.** For each target listed in the ROP row, open the file and update the value.
4. **Verify before committing.** A simple `grep` for the old value across the project must return zero hits (excluding deliberate historical references such as case studies or `CHANGELOG.md`).
5. **Document in the handshake.** The handshake's _Files Created / Modified_ section lists every file touched by the propagation. The `Advances Since Last Handshake` section may note "propagation completed for metric X".

If a propagation target is missed, the next reader will encounter contradictory documentation. The contradiction is the protocol's failure mode; ROP's purpose is to make it preventable.

---

## 4. Adding a Tracked Value

When a new value enters the project that meets the three conditions in Section 1:

1. Choose the authoritative source. Default: the file where the value is most naturally a primary fact (counters → `MEMORY.md`, version → `VERSION`).
2. Add a row to the ROP table listing the source, every known target, and the update trigger.
3. Verify all current targets agree with the authoritative value. If they disagree, fix the divergence in the same commit that adds the ROP row.

Adding a row to the ROP table is itself a content change and is captured in the next handshake.

---

## 5. Why ROP Is Discipline, Not Tooling (in v1.0)

The seed-project case study (`docs/case-studies/seed-project.md`, Friction 2, and the "Beyond T1" section) documents that the seed project runs a Python validator that consumes a ROP-style table and emits a coherence report after edits. **That validator is not part of the v1.0 public surface.** The v1.0 contract is:

- The table format above.
- The propagation ritual.
- The expectation that adopters maintain the table by hand or with their own tooling.

This split is deliberate. The protocol layer (this document) defines _what coherence looks like_. The validator layer (which may or may not become public in a later release) defines _how coherence is checked_. Protocol stability does not depend on validator availability.

---

## 6. Anti-Patterns

**ROP table is never updated.** Symptom: the table lists 3 metrics but the project tracks 12. Cause: no one added rows when new tracked values entered the project. Fix: audit the project for duplicated volatile values and bring the table back in sync.

**Authoritative source is ambiguous.** Symptom: two files claim to be canonical for the same metric. Cause: the ROP row never specified which is the source of truth. Fix: pick one; reduce the other to a propagation target.

**Update propagates partially.** Symptom: `MEMORY.md` shows 304 endpoints; a mission file still shows 287. Cause: the propagation ritual was skipped on a previous edit. Fix: run the propagation ritual for the affected metric and document the correction in the next handshake.

**ROP table tracks values that do not need it.** Symptom: the table includes static values like project name. Cause: over-tracking. Fix: remove rows that violate Section 1's three conditions.

---

## 7. Versioning

This document defines **ROP v1.0**. The v1.x line maintains backward compatibility: a v1.0 ROP table is valid under any v1.x parser. New optional columns (e.g., `Owner`, `Last Verified`) may be added in minor versions without breaking existing tables. The propagation ritual is invariant within v1.x.
