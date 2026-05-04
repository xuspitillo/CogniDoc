# HS-001 — CogniDoc Tier 1 Handshake — 2026-05-04 — PHS protocol integration

| Field | Value |
|-------|-------|
| Handshake ID | HS-001 |
| Project | CogniDoc Tier 1 (Foundation) |
| Date | 2026-05-04 |
| Slug | phs-protocol-integration |
| Previous | — (first handshake) |
| Author | LIGHT Corp |

---

## Executive Summary

HS-001 marks the integration of the **Project Handshake System (PHS)** as the fourth foundational protocol of CogniDoc Tier 1, alongside SBS (navigation), PSS (state tracking), and CPA (operational pipeline). Until this point, handshakes existed as an orphan feature: the file template was present in `templates/handshakes/_template.md` and `init.sh` created a `handshakes/` directory, but no spec defined the protocol, no bootloader command operated on handshakes, and the directory was never used in practice.

This release closes that gap. PHS is now formally specified in `specs/PHS-v1.0.md`, the bootloader knows how to generate, index, and propagate handshakes, and the project dogfoods its own protocol: this handshake is the first entry in the `handshakes/` chain. The version bumps from `0.1.1` to `0.2.0` to reflect the addition of a new foundational protocol (a minor-version bump per the CogniDoc compatibility contract — adopters of v0.1.x can upgrade by adopting `HANDSHAKES.md` and the new bootloader sections without breaking their existing memory or missions).

---

## System State

| Metric | Value |
|--------|-------|
| Version | 0.2.0 |
| Stage | Public Alpha |
| Release date | 2026-05-04 |
| Total tracked files | 53 |
| Protocol specs | 5 (SBS, PSS, CPA, CLASSIFICATION, **PHS**) |
| Concept docs | 6 |
| Reference examples | 3 |
| Tools | 3 (init.sh, validate-beacons.sh, context.sh) |
| Active missions | 3 |
| Active signals | 3 |
| Total handshakes | 1 (this one) |

---

## Advances Since Last Handshake

This is HS-001; there is no prior handshake. The following narrative covers the work that produced the v0.2.0 release.

### PHS specification authored

`specs/PHS-v1.0.md` is now the authoritative source for handshake protocol. Eight sections cover format, the chain (immutability, continuity, self-containedness), generation triggers, the counter and index files, propagation cascade, the strict pre-commit ordering, storage layout, best practices, and versioning. The spec is internally coherent with PSS (uses the same propagation cascade pattern), SBS (handshakes can carry beacons), and CPA (handshake generation runs through the standard Consult-Plan-Autonomy pipeline).

### Index file added

`HANDSHAKES.md` at the project root is now the single source of truth for which handshakes exist and in what order. Its structure mirrors `SIGNAL_REGISTRY.md`: a header with totals, a Quick Index table, and a section documenting protocol invariants. A template for adopters lives at `templates/HANDSHAKES.md.template`.

### Bootloader integrated

`bootloader/COGNIDOC.md.template` now includes:

- A full **Project Handshake System (PHS)** section between CPA and the Session Protocol.
- Three new session commands: `new handshake` / `generate handshake`, `handshakes` / `handshake history`, and `handshake HS-NNN`.
- Update methodology entries for `MEMORY.md` footer counter, `HANDSHAKES.md` index, and individual handshake files.
- Updated directory structure showing `HANDSHAKES.md` and `handshakes/` at the project root.
- Two new fundamental principles: handshake immutability, and pre-commit cascade enforcement.

### Tooling updated

`tools/init.sh` now generates `HANDSHAKES.md` from the template alongside `MEMORY.md` and `SIGNAL_REGISTRY.md`. The numbered steps went from 5 to 6. The "next steps" footer instructs the user to run `new handshake` before their first commit.

`tools/context.sh` now bundles `HANDSHAKES.md` (as a new Section 4) and the three most recent handshake files (as a new Section 6) into the LLM-ready context block. Chat-based and local LLMs without filesystem access now receive the handshake chain as part of the standard context dump.

### Templates updated

`templates/MEMORY.md.template` footer counter is now `Handshakes: 0 (latest: —)` instead of `Handshakes: 0`, with an HTML comment explaining that the counter is updated atomically with every handshake generation per the PHS pre-commit cascade.

`templates/missions/_template.md` had its placeholder beacon wrapped in inline code so the validator no longer false-positives.

### Documentation updated

`docs/glossary.md` had its broken `Handshake` entry rewritten and three new entries added: `HANDSHAKES.md`, `HS-NNN`, `PHS`. The orphan reference to `workspace/generated/` is gone.

`docs/concepts.md` adds a new "Handshakes" subsection in "Living memory vs static docs" and adds `PHS` to the terminology table.

---

## Files Created / Modified

| File | Action | Description |
|------|--------|-------------|
| `specs/PHS-v1.0.md` | created | Project Handshake System v1.0 specification |
| `HANDSHAKES.md` | created | Dogfooded handshake index for this repository |
| `handshakes/hs-001-2026-05-04-phs-protocol-integration.md` | created | This handshake |
| `templates/HANDSHAKES.md.template` | created | Adopter template for the index file |
| `bootloader/COGNIDOC.md.template` | modified | PHS section, 3 session commands, directory tree, principles |
| `tools/init.sh` | modified | Generates `HANDSHAKES.md`, 6-step flow |
| `tools/context.sh` | modified | Bundles `HANDSHAKES.md` and recent handshake files |
| `templates/MEMORY.md.template` | modified | Footer counter format `Handshakes: N (latest: HS-N)` |
| `docs/glossary.md` | modified | Handshake entry rewritten; added HANDSHAKES.md, HS-NNN, PHS |
| `docs/concepts.md` | modified | Handshakes subsection + PHS in terminology |
| `MEMORY.md` | modified | Footer counter, S4 metric updates |
| `examples/software-project/COGNIDOC.md` | modified | Handshake commands added |
| `examples/software-project/HANDSHAKES.md` | created | Example index with backfilled handshakes |
| `examples/software-project/handshakes/hs-001-2026-04-15-api-docs-shipped.md` | created | Example handshake demonstrating the format |
| `CHANGELOG.md` | modified | New `[0.2.0]` entry |
| `VERSION` | modified | `0.1.1` → `0.2.0` |
| `README.md` | modified | Status section bumped to 0.2.0 |
| `bootloader/COGNIDOC.md.template` | modified | Version line bumped |
| `tools/init.sh` | modified | Default version substitution bumped |

---

## Decisions Taken

1. **PHS named as a peer protocol, not a sub-section of CPA.** Handshakes are conceptually parallel to SBS, PSS, and CPA — they have their own format, lifecycle, and propagation rules. Embedding them inside CPA would have diluted the spec. Named `PHS` (Project Handshake System) for symmetry with PSS and to keep the abbreviation pattern of three-letter protocol acronyms.

2. **Storage at project root, not under `workspace/generated/`.** The original glossary entry referenced a `workspace/generated/` path that existed nowhere in the repo. Decision: `HANDSHAKES.md` lives at the project root (sibling of `MEMORY.md` and `SIGNAL_REGISTRY.md`), and individual handshake files live in `handshakes/` (sibling of `missions/`). Symmetry with the existing layout, no new directory hierarchies.

3. **One handshake per commit, strict.** The user (project lead) defined handshakes as "the developer's logbook, where every commit forces a handshake-generation process." The spec follows that: one handshake per commit that changes project content. Hygiene-only commits (gitignore, formatting) are exempt at maintainer discretion. When in doubt, generate.

4. **Pre-commit cascade is non-negotiable.** The user identified the precise failure mode that PHS exists to prevent: handshake N+1 generated, but counter in MEMORY.md still showing N. The spec encodes a strict 9-step ordering (steps 2-7 atomic, performed by the LLM agent before returning control; step 9 is the developer's commit). The agent MUST confirm "handshake HS-N generated, ready to commit" before the developer commits.

5. **Counter in two places.** `HANDSHAKES.md` is authoritative; `MEMORY.md` footer carries a convenience copy (`Handshakes: N (latest: HS-N)`). If they diverge, HANDSHAKES.md wins and the discrepancy is resolved in the next handshake. Documenting the dual location prevents future drift.

6. **Version bump to 0.2.0.** Adding a new foundational protocol is a minor-version event under semver. The bump signals to adopters that there is new functionality (handshakes), but no breaking changes to SBS / PSS / CPA / CLASSIFICATION specs. v0.1.x adopters can upgrade by copying `HANDSHAKES.md` from the new template and adopting the bootloader's PHS section without rewriting their existing memory or missions.

7. **Backfill rule.** v0.1.0 and v0.1.1 had no handshakes. HS-001 is generated as the first handshake of the project, covering the integration of PHS itself. From v0.2.0 onward, every content-changing commit is preceded by a handshake. This is documented in `HANDSHAKES.md` so adopters who clone the repo understand why the chain doesn't start at the v0.1.0 commit.

---

## Impact on Missions

| Mission | Impact | New State |
|---------|--------|-----------|
| MIS-001 community-engagement | None directly. PHS adds a dimension worth highlighting in adoption posts: "now with auditable per-commit checkpoints" | ACTIVE (unchanged) |
| MIS-002 t2-preparation | T2's library scope (`SIGNAL_REGISTRY` parser, `MEMORY` parser, mission parser) now includes a `HANDSHAKES.md` parser and HS file parser. Compatibility contract extends to PHS v1.0 | ACTIVE (scope expanded) |
| MIS-003 spanish-translation | When activated, must include `specs/PHS-v1.0.md` and `templates/HANDSHAKES.md.template` in the translation set | WAITING (scope expanded) |

---

## Roadmap and Next Steps

**Immediate (next 1-2 commits):**

- Generate HS-002 on the next content-changing commit. The PHS spec is now the contract, and the project follows it.
- Monitor first community feedback (MIS-001) for confusion around the pre-commit cascade. The strict ordering may need a tooling assist (a pre-commit hook that fails if HANDSHAKES.md and MEMORY.md counters disagree).

**Short term:**

- Produce a `tools/check-handshake.sh` that validates: HANDSHAKES.md totals match the actual count of `handshakes/hs-*.md` files; MEMORY.md footer counter matches; HS numbers are continuous with no gaps; the `Previous` field in each handshake correctly cites HS-(N-1).
- Wire that validator into the CI lint workflow.

**Medium term:**

- Update the other two reference examples (`research-notes`, `personal-knowledge-base`) with backfilled handshake examples, mirroring what was done for `software-project` in this release.

**Blockers:** None.

---

## Warnings and Risks

1. **Adoption friction.** The pre-commit cascade adds a step that adopters may forget. Risk mitigation: the bootloader command `new handshake` automates the cascade, and the validator (planned, not in this release) will catch missing or stale handshakes after the fact.

2. **Granularity tension.** "One handshake per commit" is the protocol, but real projects commit dozens of times a day. If a project commits at high frequency, the handshake chain becomes very long. The protocol allows hygiene-only commits without handshakes, but the maintainer's discretion is the safety valve. Future versions may add explicit handshake-batching rules if community feedback shows it is needed.

3. **Counter drift.** The dual location (`HANDSHAKES.md` authoritative, `MEMORY.md` convenience copy) is two places to keep in sync. The pre-commit cascade enforces this in the LLM agent, but a human committing without an LLM session could create drift. The future validator will catch this.

4. **Missing spec section: handshake authorship.** PHS v1.0 does not specify who authors handshakes (the LLM agent, the developer, or a hybrid). In practice the LLM generates the draft and the developer reviews. This is left intentionally implicit in v1.0; v1.1 may formalize an authorship-and-review protocol if community feedback requires it.

---

## Context for External Agents

CogniDoc Tier 1 is a public, open-source cognitive documentation system for LLM-driven projects. As of v0.2.0 (released 2026-05-04), it ships **five foundational protocols** in `specs/`:

- **SBS v1.0** — Semantic Beacon System (cognitive navigation tags).
- **PSS v1.0** — Project Signal System (5-state machine for processes/missions).
- **CPA v1.0** — Consult-Plan-Autonomy (operational pipeline for every LLM request).
- **CLASSIFICATION v1.0** — Priority × Type taxonomy for missions.
- **PHS v1.0** — Project Handshake System (immutable per-commit checkpoints). **NEW in this release.**

The repository structure: bootloader template at `bootloader/COGNIDOC.md.template`; memory/registry/index files at the project root (`MEMORY.md`, `SIGNAL_REGISTRY.md`, `HANDSHAKES.md`); per-mission and per-handshake files in `missions/` and `handshakes/`; conceptual docs in `docs/`; three reference examples in `examples/`; lightweight tooling in `tools/` (`init.sh`, `validate-beacons.sh`, `context.sh`).

License: Apache 2.0. No runtime dependencies. The system is plain markdown plus shell scripts. Bring-your-own-LLM (any model that reads markdown can adopt the protocol).

The project dogfoods its own protocols. This file (HS-001) is the first handshake in the project's chain. From now on, every commit that changes project content is preceded by a handshake; reading the latest handshake gives an LLM enough context to continue work coherently without prior session memory.

To bootstrap from this handshake:

1. Read `bootloader/COGNIDOC.md.template` (or `COGNIDOC.md` in an adopter project) to load the operational protocol.
2. Read `MEMORY.md` for project identity and roadmap.
3. Read `HANDSHAKES.md` for the chronological backbone.
4. Read the latest handshake (this file or its successor) for the most recent state.
5. Apply the CPA pipeline to any user request from there.
