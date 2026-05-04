# MIS-002 — T2 (Starter) Preparation [*(ARQ.W1.DEF>S9 | COG.W2.REF>S10)*]

## METADATA

| Field | Value |
|-------|-------|
| ID | MIS-002 |
| Slug | t2-preparation |
| Type | ROOT |
| Priority | P1 |
| State | ACTIVE |
| Signal | SIG-002 |
| Parent | — |
| Children | — |
| Dependencies | — |
| Linked missions | MIS-001 (parallel P1 — feedback informs scope) |
| Created | 2026-05-02 |
| Last updated | 2026-05-02 |

---

## Objective [*(ARQ.W1.DEF>S1)*]

Prepare the next tier of the product (Tier 2 — Starter) by extracting a programmatic library from the T1 specs, building a PDF manual generator, and designing a frictionless upgrade path for existing T1 adopters.

T2 turns the literacy product (T1) into a tooling product: parsers, validators, and generators that automate what T1 adopters currently do by hand.

### Specific objectives

1. Extract a programmatic library exposing the four protocols as parseable, queryable artifacts
2. Build a PDF manual generator that compiles a project's MEMORY, missions, and signals into a single readable document
3. Design an upgrade path so any T1 adopter can move to T2 with zero documentation rewrites

---

## Milestones [*(ARQ.W2.HIT>S1)*]

### M1 — Library scope defined

- [x] Target language chosen
- [x] Public API surface drafted (parsers for SBS, PSS, MEMORY, missions)
- [x] Compatibility contract with T1 specs documented
- [ ] Scope review published for community input

### M2 — Parsers extracted

- [ ] SBS beacon parser with full grammar coverage
- [ ] MEMORY.md structured reader (sections, catalog, footer)
- [ ] SIGNAL_REGISTRY parser with state-machine validation
- [ ] Mission file parser with metadata extraction
- [ ] Test suite covering all four parsers

### M3 — PDF generator MVP

- [ ] Layout templates for cover, table of contents, and per-mission pages
- [ ] Cross-reference rendering (beacons become clickable anchors)
- [ ] Reproducible builds (deterministic output for CI)
- [ ] First MVP shipped to design partners for feedback

---

## Roadmap [*(ARQ.W2.DEF>S9)*]

| Phase | Name | Status | Goal |
|-------|------|--------|------|
| Phase 1 | Library scope | IN PROGRESS | Lock target language, public API, and compatibility contract with T1 |
| Phase 2 | Parsers + tests | PENDING | Extract parsers for the four core artifacts with comprehensive tests |
| Phase 3 | PDF generator MVP | PENDING | Ship a working PDF generator validated by at least 3 design partners |

---

## Progress log

### 2026-05-02 — Mission created alongside public release
- Mission registered with SIG-002 (ACTIVE)
- Phase 1 underway: library scope and public API surface drafted
- Compatibility contract with T1 documented as a non-negotiable constraint — any T1 project must work with T2 tooling without modifications

---

## Notes

- T1 (this release) deliberately ships **no programmatic library** (see Decision D2 in MEMORY.md). T2 is where the library lives. Keeping T1 minimal protects adopters from runtime coupling
- Feedback from MIS-001 design partners is a primary input for T2 prioritization
