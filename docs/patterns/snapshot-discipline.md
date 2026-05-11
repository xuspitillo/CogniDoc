# Pattern: Snapshot Discipline for Historical Log Entries

**Status:** Documented pattern, not a protocol.
**Applies to:** mission progress logs, handshake narrative sections, any document where the same metric appears at different points in time.
**Sources:** seed-project case study (`docs/case-studies/seed-project.md`, "Beyond T1" section).

---

## Problem

Long-lived missions accumulate progress-log entries over weeks or months. Each entry records the project state at the moment it was written. Months later, a reader scanning the log encounters:

```markdown
## Progress Log

- 2026-02-22: Auth module shipped. 205 endpoints, 158 tests.
- 2026-03-04: TTS pipeline complete. 270 endpoints, ~200 tests.
- 2026-03-22: Security hardening done. 304 endpoints, 303 tests.
```

A reader who skims the first entry may walk away thinking "the project has 205 endpoints" — which was true on 2026-02-22 but is wrong today. A propagation validator (see [`specs/ROP-v1.0.md`](../../specs/ROP-v1.0.md)) that scans this file looking for "current" endpoint count will find three different values and cannot tell which is current.

The values are not wrong. They were correct at the time they were written. They are **snapshots**, and the document does not say so.

---

## The Pattern

Tag every historical metric entry with `(snapshot YYYY-MM-DD)`:

```markdown
## Progress Log

- 2026-02-22: Auth module shipped. 205 endpoints, 158 tests. *(snapshot 2026-02-22)*
- 2026-03-04: TTS pipeline complete. 270 endpoints, ~200 tests. *(snapshot 2026-03-04)*
- 2026-03-22: Security hardening done. 304 endpoints, 303 tests. *(snapshot 2026-03-22)*
```

Two effects:

1. **A human reader** sees explicitly that the number is "value at that time", not the current state.
2. **An automated propagation walker** (the ROP validator, a `grep` for current metrics, an LLM agent loading the project) sees the snapshot tag and skips the entry when looking for the authoritative current value.

The authoritative current value lives at its **ROP source** (typically `MEMORY.md` §3, or wherever the project's ROP table designates). Progress-log entries are by definition historical snapshots and never claim to be current.

---

## When to Use

Apply snapshot tags to any log entry where:

- The entry records a value that also appears elsewhere as a current/authoritative value.
- The log is append-only (entries are not edited to reflect later state).
- The document will be read by people or agents who may misinterpret historical values as current.

Typical locations:

- Mission progress logs (`missions/mis-XXX-*.md` "Progress Log" section).
- Handshake narrative sections ("Advances Since Last Handshake" tables that include metrics).
- Sub-mission completion records.
- `CHANGELOG.md` release notes that quote metrics at the time of release.

Do **not** apply snapshot tags to:

- The authoritative source itself. It is the current value by definition; the tag would be misleading.
- Static historical facts that are not "metric"-shaped (e.g., "Decided to use JWT RS256" — that is a decision, not a snapshot).

---

## Format Convention

Inline at the end of the entry:

```markdown
- 2026-02-22: Auth module shipped. 205 endpoints, 158 tests. *(snapshot 2026-02-22)*
```

The snapshot date and the entry date are usually the same; when they differ (e.g., a retroactive log entry written today about an event last week), the snapshot date is the date the metric was true, not the date the entry was written:

```markdown
- 2026-03-22 (written 2026-04-05): the trading subsystem reached 290 endpoints. *(snapshot 2026-03-22)*
```

---

## Interaction with ROP

The Record of Propagation (`specs/ROP-v1.0.md`) lists each tracked metric's authoritative source and propagation targets. **Historical snapshot entries are NOT propagation targets.** A propagation walk that touches every target updating "304 endpoints" must skip log entries tagged `(snapshot ...)`. Conversely, a `grep` audit for the current value can exclude all matches inside lines containing `(snapshot ` to reduce false positives.

If a propagation target is mistakenly tagged as a snapshot, the value silently drifts away from the authoritative source. If a snapshot is mistakenly treated as a propagation target, history is rewritten — a worse violation, because the audit trail loses fidelity.

---

## Anti-Patterns

**Editing past log entries to "fix" the metric.** Symptom: an old entry shows the current value, not the historical one. Cause: someone propagated the current value into the log. Fix: restore the historical value and add the snapshot tag.

**Omitting the snapshot tag on log entries.** Symptom: readers and automation cannot tell historical from current values. Cause: discipline lapse during log writing. Fix: backfill snapshot tags on existing entries; add the convention to the project's contributor guide.

**Snapshot-tagging the authoritative source.** Symptom: `MEMORY.md` §3 says "304 endpoints *(snapshot 2026-03-22)*". Cause: confusion about which file holds the current value. Fix: remove the tag from the authoritative source; the snapshot tag is only for retrospective entries.

---

## Why This Is a Pattern, Not a Protocol

The five MandelDoc protocols (SBS, PSS, CPA, CLASSIFICATION, PHS) define operational contracts that every adopter follows. The ROP spec defines a verification discipline. Snapshot Discipline is **a convention** that adopters apply where useful. The format is recommended but not required; the spirit (distinguish current from historical metric values) matters more than the exact syntax.

If an adopter prefers a different syntax (`[at 2026-02-22]`, `_(2026-02-22 state)_`, an HTML comment, etc.), that is fine as long as the distinction between current and historical values is made explicit somewhere in the document and is consistent across the project.

---

## Reference

The seed project (see `docs/case-studies/seed-project.md`) developed this convention organically during its second month under the protocol, after a propagation validator started flagging mission-log entries as "stale" when they were in fact historical snapshots. Adopting the explicit tag eliminated the false positives without requiring the validator to be made smarter.
