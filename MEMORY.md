# MEMORY.md — CogniDoc Tier 1 (Foundation) [*(COG.W1.DEF>S1)*]

> Cognitive memory core for the public CogniDoc Tier 1 release.
> This file is the canonical source of truth for the project's state.
> The repository dogfoods its own conventions: CogniDoc documents itself with CogniDoc.

---

## 1. Identity [*(COG.W1.DEF>S1)*]

**Project:** CogniDoc Tier 1 (Foundation)
**Type:** Public, open-source cognitive documentation system
**License:** Apache License 2.0
**Audience:** Developers, technical writers, and LLM-driven projects that need a navigable, self-aware documentation layer
**Operating model:** Bring-your-own-LLM. CogniDoc T1 ships specifications, templates, examples, and lightweight tooling — never an LLM itself
**Tagline:** Documentation that knows itself.

The system is built around four protocol specifications (SBS, PSS, CPA, Classification) that any LLM can interpret to navigate, update, and reason over a project's documentation as a structured cognitive graph.

---

## 2. Stack [*(ARQ.W1.DEF>S2)*]

| Layer | Technology |
|-------|-----------|
| Documentation format | Markdown (CommonMark + GitHub-flavored extensions) |
| Tooling | Bash 4+ shell scripts (POSIX-portable where possible) |
| CI / Validation | GitHub Actions |
| License | Apache License 2.0 |
| Language (primary) | English |

No runtime dependencies. No package manager required. The entire system is plain text and shell scripts.

---

## 3. Architecture (overview) [*(ARQ.W1.DEF>S3)*]

CogniDoc T1 is composed of four pillars:

1. **Protocol specifications** (`specs/`) — the formal definitions of SBS, PSS, CPA, and the Classification system
2. **Templates** (`templates/`) — ready-to-fill skeletons for MEMORY, SIGNAL_REGISTRY, missions, and handshakes
3. **Examples** (`examples/`) — three reference projects demonstrating the system in different domains
4. **Tooling** (`tools/`) — shell scripts to bootstrap and validate a CogniDoc-enabled repository

Supporting layers: a bootloader template (`bootloader/COGNIDOC.md.template`) that LLMs auto-load, conceptual documentation (`docs/`), and the dogfooding artifacts in this repository (this MEMORY.md, SIGNAL_REGISTRY.md, and the missions/ directory).

---

## 4. Current State [*(COG.W1.DEF>S4)*]

| Metric | Value |
|--------|-------|
| Version | 0.1.1 |
| Stage | Public Alpha |
| Release date | 2026-05-02 |
| Total tracked files | 47 |
| Protocol specs | 4 (SBS, PSS, CPA, Classification) |
| Concept docs | 6 |
| Reference examples | 3 |
| Tools | 2 (init.sh, validate-beacons.sh) |
| Active missions | 3 |
| Active signals | 3 |

---

## 5. Architecture Detail [*(ARQ.W2.DEF>S5)*]

```
cognidoc/
├── specs/         ← Protocol specifications (SBS, PSS, CPA, Classification)
├── templates/     ← Fillable skeletons for MEMORY, SIGNAL_REGISTRY, missions, handshakes
├── examples/      ← Three reference projects in different domains
├── tools/         ← Bootstrap and validation shell scripts
├── docs/          ← Conceptual documentation (getting-started, concepts, comparison, etc.)
├── bootloader/    ← COGNIDOC.md.template that downstream projects copy as their LLM bootloader
├── missions/      ← This project's own missions (dogfooding)
└── .github/       ← CI workflows for beacon validation and link checking
```

| Directory | Purpose |
|-----------|---------|
| `specs/` | Source of truth for the protocols. Versioned independently |
| `templates/` | Copy-paste starting points for adopters |
| `examples/` | Three working projects: personal knowledge base, research notes, software project |
| `tools/` | `init.sh` bootstraps a new project, `validate-beacons.sh` lints SBS tags |
| `docs/` | Reader-facing prose: concepts, getting-started, comparison, glossary, upgrade-path, use-cases |
| `bootloader/` | The COGNIDOC.md template adopters install at the root of their own repos |
| `missions/` | The dogfooded missions for the CogniDoc project itself |
| `.github/` | CI: lint markdown, validate beacons, check internal links |

---

## 6. History [*(COG.W2.DEF>S6)*]

| Date | Event |
|------|-------|
| 2026-05-02 | Initial public release v0.1.0. Repository made public. Specs, templates, examples, tools, docs, and dogfooded MEMORY/SIGNAL_REGISTRY/missions all shipped together |

---

## 7. Decisions [*(COG.W2.DEC>S7)*]

| ID | Decision | Rationale |
|----|----------|-----------|
| D1 | Apache License 2.0 over MIT | Apache 2.0 provides explicit patent grant and contributor terms appropriate for a system that may be embedded in commercial pipelines |
| D2 | T1 ships specs + templates + examples — no programmatic library | T1 is a literacy product: it teaches a convention. A library would couple adopters to a runtime; specs alone keep the system LLM-agnostic and language-neutral |
| D3 | Bring-your-own-LLM | The protocols are designed to be interpreted by any sufficiently capable LLM. Tying T1 to a specific model would fragment adoption and create vendor lock-in |
| D4 | English as primary documentation language | Maximizes initial reach. Spanish translation tracked as a P2 mission once community traction justifies the investment |

---

## 8. Lessons [*(COG.W3.DEF>S8)*]

*(No lessons recorded yet — this section will accumulate insights from community feedback and the T2 preparation process.)*

---

## 9. Active Roadmap (P1-P2 missions only) [*(COG.W1.DEF>S9)*]

| ID | Mission | Type | Priority | State | Phase |
|----|---------|------|----------|-------|-------|
| MIS-001 | Community engagement | ROOT | P1 | ACTIVE | Phase 1 — Announcement |
| MIS-002 | T2 (Starter) preparation | ROOT | P1 | ACTIVE | Phase 1 — Library scope |
| MIS-003 | Spanish translation | SATELLITE | P2 | WAITING | Pre-phase (waiting for traction) |

Detailed status lives in each mission file under `missions/`.

---

## 10. Catalog (all missions) [*(COG.W1.DEF>S10)*]

### Active

| ID | Slug | Type | Priority | State | File |
|----|------|------|----------|-------|------|
| MIS-001 | community-engagement | ROOT | P1 | ACTIVE | `missions/mis-001-community-engagement.md` |
| MIS-002 | t2-preparation | ROOT | P1 | ACTIVE | `missions/mis-002-t2-preparation.md` |
| MIS-003 | spanish-translation | SATELLITE | P2 | WAITING | `missions/mis-003-spanish-translation.md` |

### Completed

*(None yet.)*

---

**Footer**
Version: 0.1.1 — Public Alpha
Last updated: 2026-05-02
Total missions: 3 (3 active, 0 completed)
Total signals: 3 (2 ACTIVE, 1 WAITING, 0 PAUSED, 0 COMPLETED)
Total tracked files: 47
