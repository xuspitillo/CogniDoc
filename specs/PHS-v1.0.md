# Project Handshake System (PHS) — Specification v1.0

## Abstract

The Project Handshake System (PHS) is a protocol for generating immutable, chronological narrative checkpoints of a project's state. Each handshake is a self-contained snapshot — readable by any LLM agent without prior context — that documents exactly what changed since the previous handshake, why those changes were made, and how they affect the project's missions, decisions, and roadmap.

PHS is the project's logbook. Handshakes are generated **before every commit** and form an append-only chain. Once a handshake is generated and committed, it is never modified. Corrections, retractions, or additions are documented in the next handshake. The combination of immutability and chronological ordering creates a forensic-quality audit trail of the project's evolution.

PHS is one of the four foundational protocols of MandelDoc, alongside SBS (navigation), PSS (state tracking), and CPA (operational pipeline). It ties them together: a handshake references missions (PSS), follows the CPA execution model, and is annotated with SBS beacons.

---

## 1. Format

### 1.1 Identifier

```
HS-NNN
```

| Component | Rule |
|-----------|------|
| `HS` | Literal prefix. Always uppercase. |
| `NNN` | Sequential counter, zero-padded to three digits (`001`, `002`, ..., `099`, `100`). |

**Identifiers are global, sequential, and never reused.** If a handshake is deleted (which should never happen), its number is retired permanently.

### 1.2 Filename

```
handshakes/hs-NNN-YYYY-MM-DD-slug.md
```

| Component | Rule |
|-----------|------|
| `handshakes/` | Fixed directory at the project root. |
| `hs-NNN` | Lowercase prefix mirroring the identifier. |
| `YYYY-MM-DD` | The date the handshake was generated. |
| `slug` | A 2-5 word kebab-case description (e.g. `auth-system-phase-2`). |
| `.md` | Markdown only. |

The combined filename ensures alphabetical ordering equals chronological ordering. The date redundancy (also stored inside the file) accelerates browsing in the file system.

### 1.3 File Structure

A handshake file is composed of three **REQUIRED** sections plus seven **RECOMMENDED** sections. Required sections must be present in every handshake, even for trivial commits. Recommended sections may be omitted when not applicable to the commit being checkpointed; their absence is not a protocol violation. The intent is to keep the audit trail compact for routine commits while preserving the option for richer narrative when a commit warrants it.

**REQUIRED (always present):**

1. **Title and metadata block** — handshake ID, project name, date, slug, previous-handshake reference.
2. **Executive Summary** — at minimum one sentence: what this commit changed and why. For substantive commits, 1-3 paragraphs are appropriate.
3. **Files Created / Modified** — table listing every file touched and the type of change. This is the audit-trail contract: a handshake without it does not satisfy PHS.

**RECOMMENDED (include when applicable, omit when not):**

4. **System State** — current metrics in a table. Include when at least one metric changed in this commit.
5. **Advances Since Last Handshake** — narrative description of work completed. Include for any commit that produced more than a trivial change.
6. **Decisions Taken** — architectural, design, or strategic decisions with their rationale. Include only if real decisions were taken.
7. **Impact on Missions** — table mapping affected missions to state changes. Include only if mission state changed.
8. **Roadmap and Next Steps** — what comes next and any blockers. Include if the roadmap shifted.
9. **Warnings and Risks** — identified risks, mitigations applied, debt accumulated. Include if new risks were identified.
10. **Context for External Agents** — a self-contained summary for an LLM that reads ONLY this handshake. Strongly recommended for milestone commits, version releases, and anything an external reader is likely to start from. Optional for routine intermediate commits.

For trivial commits (e.g., a one-line typo fix), a handshake of three sections — title and metadata, one-sentence Executive Summary, and Files Created / Modified — is sufficient and within protocol.

The full template (showing all ten sections with annotations) is in `templates/handshakes/_template.md`. Adopters may delete any of the seven recommended sections from the template when not applicable.

### 1.4 Tiered Depth by Commit Size

The required-vs-recommended split exists to make the protocol sustainable in practice. The seed-project case study (`docs/case-studies/seed-project.md`, Friction 1) records that an "every commit gets the full audit" framing produced ~30% of commits without a full handshake despite the protocol nominally requiring 1:1. The matrix below makes the realistic expectation explicit.

| Commit size | Recommended depth | Rationale |
|---|---|---|
| **Trivial** (typo, formatting, single-line fix; <10 lines, 1 file, no semantic change) | 3 required sections only (title, 1-sentence summary, files table) | Audit-trail entry exists. Narrative would be larger than the change. |
| **Routine** (single feature increment, 2-5 files, no architectural decisions) | 3 required + Advances Since Last Handshake + Impact on Missions if applicable | Captures the work-mission link without inflating ceremony. |
| **Substantive** (multi-file feature, mission completion, schema/state change) | 3 required + Advances + Decisions + Impact + Roadmap | Decisions and roadmap shifts must enter the chain at the moment they happen. |
| **Milestone** (version release, major architectural change, security boundary change) | All 10 sections including Context for External Agents | Future readers may start from this handshake without prior context. |

Adopters calibrate the matrix to their project. The principle is constant: ceremony scales with semantic impact, never with mechanical effort. A 500-line refactor that changes nothing semantically is routine. A 5-line config change that flips a security boundary is substantive.

---

## 2. The Chain

### 2.1 Append-Only

The set of handshakes forms an **append-only chain**. The properties are:

- **Strictly chronological.** HS-002 is generated after HS-001. Time flows forward.
- **Immutable.** Once a handshake is generated, its content is never modified. Typos, missed details, or retractions are documented in the next handshake.
- **Continuous.** No gaps. If HS-007 exists, then HS-001 through HS-006 also exist.

### 2.2 Continuity

Each handshake references the previous one in its metadata block (`Previous: HS-NNN`). HS-001 is the only handshake that references no predecessor; its `Previous` field is `—`.

The narrative section "Advances Since Last Handshake" must explicitly contrast the current state with the state captured in the previous handshake. Reading any two consecutive handshakes shows the delta between them. Reading them all in order reconstructs the project's full evolution.

### 2.3 Self-Containedness

Each handshake is self-contained. An LLM that reads ONLY the latest handshake (without prior context, without the bootloader, without other documents) MUST be able to:

- Identify the project.
- Understand its current state.
- Know which missions are active and at what phase.
- Continue work coherently.

The "Context for External Agents" section enforces this property. If you cannot bootstrap from the latest handshake alone, the handshake is incomplete and must be amended in the next one.

---

## 3. Generation Trigger

### 3.1 Pre-Commit Rule

A handshake is generated **before every commit that affects project content**. The order is strict:

```
1. Work is performed (changes to code, missions, memory, etc.)
2. Generate handshake HS-NNN documenting that work
3. Update HANDSHAKES.md index
4. Update MEMORY.md handshake counter
5. Commit (developer action)
```

Steps 2-4 are atomic: the LLM completes all three before returning control. The developer commits after.

### 3.2 What Counts as a "Commit"

- **Generates a handshake**: any commit that modifies content (code, documentation, missions, memory, signals, configuration with semantic impact).
- **Does not generate a handshake**: pure repository hygiene that does not change project state — `.gitignore` adjustments, formatting-only commits, fixing a single typo in a comment. The project may apply these without a handshake at the maintainer's discretion.

When in doubt, generate the handshake. The cost of an extra handshake is low; the cost of a missing audit entry is high.

### 3.3 Multi-Commit Sessions

If a single LLM session produces several logical units that will be committed separately, generate one handshake per commit. Do NOT batch multiple commits under one handshake — the chain loses resolution.

---

## 4. Counter and Index

### 4.1 HANDSHAKES.md

A file named `HANDSHAKES.md` lives at the project root. It is the index of all generated handshakes. Its structure mirrors `SIGNAL_REGISTRY.md`:

- **Header** with last-updated date, total count, and latest HS reference.
- **Quick Index table** with one row per handshake (ID, date, title, optional commit hash).
- **Storage section** documenting the filename convention.
- **Conventions section** documenting the protocol invariants.

The Quick Index is the single source of truth for which handshakes exist and in what order. An agent that reads only `HANDSHAKES.md` gets the project's chronological backbone in one pass.

### 4.2 MEMORY.md Footer Counter

`MEMORY.md` carries a small counter in its footer that mirrors the `HANDSHAKES.md` total:

```
Handshakes: N (latest: HS-NNN)
```

This counter is updated on every handshake generation as part of the propagation cascade.

### 4.3 Two Sources, One Truth

The HANDSHAKES.md index is authoritative. The MEMORY.md counter is a convenience copy. If the two ever disagree, HANDSHAKES.md wins, and the discrepancy must be resolved in the next handshake.

---

## 5. Propagation Cascade

When a handshake HS-NNN is generated, the following propagation is **mandatory**:

1. **Create the handshake file.** `handshakes/hs-NNN-YYYY-MM-DD-slug.md` populated from the template, with all 10 sections filled.
2. **Update `HANDSHAKES.md`.** Append a row to the Quick Index. Update the header counters and `latest` reference.
3. **Update `MEMORY.md` footer.** Bump the `Handshakes: N` counter and the `latest: HS-NNN` reference.
4. **Cross-reference affected missions.** Each mission whose state changed during this work cycle should reference HS-NNN in its progress log (the handshake captures the same change at the project level; the mission entry captures it at the mission level).
5. **Verify chain continuity.** Confirm HS-NNN is exactly previous-N + 1 and that the `Previous` field in the new handshake correctly cites HS-(NNN-1).

The cascade executes **atomically before the commit**. If any step is skipped, the commit captures an inconsistent state and the audit trail is broken.

This is the rule that prevents the failure mode the protocol exists to eliminate: handshake file present but counter stale. **The agent that generates the handshake is responsible for the cascade. The developer's commit happens after the cascade completes.**

---

## 6. Pre-Commit Protocol (Strict Ordering)

The following sequence is non-negotiable. Steps must execute in order. A skipped step is a protocol violation.

| Step | Action | Performed by |
|------|--------|--------------|
| 1 | Complete all content changes (code, docs, missions, memory updates, signal transitions) | LLM agent or developer |
| 2 | Determine the next handshake number N (read HANDSHAKES.md, increment) | LLM agent |
| 3 | Generate `handshakes/hs-N-YYYY-MM-DD-slug.md` from template, fill all sections | LLM agent |
| 4 | Append entry to `HANDSHAKES.md` Quick Index | LLM agent |
| 5 | Update `HANDSHAKES.md` header (total, latest, last-updated) | LLM agent |
| 6 | Update `MEMORY.md` footer counter (`Handshakes: N (latest: HS-N)`) | LLM agent |
| 7 | Cross-reference HS-N in affected mission progress logs | LLM agent |
| 8 | Return control with: "handshake HS-N generated, ready to commit" | LLM agent |
| 9 | Commit (with all changes from steps 1-7 included) | Developer |

If the developer commits before step 6 completes, the commit captures stale counters. The protocol REQUIRES the agent to confirm step 8 explicitly so the developer knows when it is safe to commit.

---

## 7. Storage

Handshakes live in `handshakes/` at the project root, alongside `MEMORY.md`, `SIGNAL_REGISTRY.md`, `HANDSHAKES.md`, and `missions/`. Example layout:

```
my-project/
├── MANDELDOC.md
├── MEMORY.md
├── SIGNAL_REGISTRY.md
├── HANDSHAKES.md
├── missions/
│   ├── mis-001-slug.md
│   └── mis-002-slug.md
└── handshakes/
    ├── hs-001-2026-05-02-foundation.md
    ├── hs-002-2026-05-04-protocol-integration.md
    └── hs-003-2026-05-08-first-feature.md
```

Handshakes are committed to the same git repository as the rest of the project. They are part of the source.

---

## 8. Best Practices

1. **One handshake per commit.** Maintain the chain at full resolution. If a logical unit spans multiple commits, generate one handshake per commit.
2. **Write for an external reader.** Assume the handshake will be read by an LLM with zero prior context. Be specific about file paths, mission IDs, and dates.
3. **Quantify when possible.** "Reduced latency from 2s to 80ms" is more useful than "improved performance".
4. **Document negative results.** A handshake that records "investigated approach X, decided not to use it because Y" is as valuable as one that records a successful implementation.
5. **Never edit a past handshake.** If a previous handshake contains an error, document the correction in the next handshake. The chain is forensic.
6. **Title each handshake meaningfully.** "HS-007 — auth phase 2 complete" beats "HS-007 — updates".
7. **Handshakes complement, not replace, mission progress logs.** Missions log per-mission progress; handshakes log per-commit project state. Both layers exist for different reading granularities.

---

## 9. Versioning

This document defines **PHS v1.0**.

- All future v1.x releases will maintain full backward compatibility: handshake files written under v1.0 remain valid under any v1.x parser or protocol.
- New optional sections, additional metadata fields, or extended cross-references introduced in minor versions will be additive, never breaking.
- A major version increment (v2.0) would be required to change the immutability rule, the chain ordering, the pre-commit trigger, or the identifier format.
