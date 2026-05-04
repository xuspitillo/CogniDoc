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

1. **Protocol specifications** (`specs/`) — the formal definitions of SBS, PSS, CPA, Classification, and PHS
2. **Templates** (`templates/`) — ready-to-fill skeletons for MEMORY, SIGNAL_REGISTRY, HANDSHAKES, missions, and handshakes
3. **Examples** (`examples/`) — three reference projects demonstrating the system in different domains
4. **Tooling** (`tools/`) — shell scripts to bootstrap, validate, and bundle a CogniDoc-enabled repository

Supporting layers: a bootloader template (`bootloader/COGNIDOC.md.template`) that LLMs auto-load, conceptual documentation (`docs/`), and the dogfooding artifacts in this repository (this MEMORY.md, SIGNAL_REGISTRY.md, HANDSHAKES.md, and the missions/ and handshakes/ directories).

---

## 4. Current State [*(COG.W1.DEF>S4)*]

| Metric | Value |
|--------|-------|
| Version | 0.2.0 |
| Stage | Public Alpha |
| Release date | 2026-05-04 |
| Total tracked files | 53 |
| Protocol specs | 5 (SBS, PSS, CPA, Classification, PHS) |
| Concept docs | 6 |
| Reference examples | 3 |
| Tools | 3 (init.sh, validate-beacons.sh, context.sh) |
| Active missions | 3 |
| Active signals | 3 |
| Total handshakes | 1 (latest: HS-001) |

---

## 5. Architecture Detail [*(ARQ.W2.DEF>S5)*]

```
cognidoc/
├── specs/         ← Protocol specifications (SBS, PSS, CPA, Classification, PHS)
├── templates/     ← Fillable skeletons for MEMORY, SIGNAL_REGISTRY, HANDSHAKES, missions, handshakes
├── examples/      ← Three reference projects in different domains
├── tools/         ← Bootstrap, validation, and bundling shell scripts
├── docs/          ← Conceptual documentation (getting-started, concepts, comparison, etc.)
├── bootloader/    ← COGNIDOC.md.template that downstream projects copy as their LLM bootloader
├── missions/      ← This project's own missions (dogfooding)
├── handshakes/    ← This project's own handshake chain (dogfooding)
└── .github/       ← CI workflows for beacon validation and link checking
```

| Directory | Purpose |
|-----------|---------|
| `specs/` | Source of truth for the protocols. Versioned independently |
| `templates/` | Copy-paste starting points for adopters |
| `examples/` | Three working projects: personal knowledge base, research notes, software project |
| `tools/` | `init.sh` bootstraps a new project, `validate-beacons.sh` lints SBS tags, `context.sh` bundles all docs into an LLM-ready block |
| `docs/` | Reader-facing prose: concepts, getting-started, comparison, glossary, upgrade-path, use-cases |
| `bootloader/` | The COGNIDOC.md template adopters install at the root of their own repos |
| `missions/` | The dogfooded missions for the CogniDoc project itself |
| `handshakes/` | The dogfooded handshake chain for this repository (one HS-NNN per commit per PHS) |
| `.github/` | CI: lint markdown, validate beacons, check internal links |

---

## 6. History [*(COG.W2.DEF>S6)*]

| Date | Event |
|------|-------|
| 2026-05-02 | Initial public release v0.1.0. Repository made public. Specs, templates, examples, tools, docs, and dogfooded MEMORY/SIGNAL_REGISTRY/missions all shipped together |
| 2026-05-03 | v0.1.1 quality-audit release. Cross-file version unification, repo URL fixes, removal of Spanish term residues, placeholder cleanup, ROP acronym replaced, file count corrected, example READMEs annotated, CLAUDE.md fallback reframed as Claude Code integration |
| 2026-05-04 | v0.2.0 PHS protocol integration. Handshakes go from orphan feature (template-only) to first-class protocol with spec, index file, bootloader commands, propagation cascade, and dogfooded HS-001. Five foundational protocols total |

---

## 7. Decisions [*(COG.W2.DEC>S7)*]

| ID | Decision | Rationale |
|----|----------|-----------|
| D1 | Apache License 2.0 over MIT | Apache 2.0 provides explicit patent grant and contributor terms appropriate for a system that may be embedded in commercial pipelines |
| D2 | T1 ships specs + templates + examples — no programmatic library | T1 is a literacy product: it teaches a convention. A library would couple adopters to a runtime; specs alone keep the system LLM-agnostic and language-neutral |
| D3 | Bring-your-own-LLM | The protocols are designed to be interpreted by any sufficiently capable LLM. Tying T1 to a specific model would fragment adoption and create vendor lock-in |
| D4 | English as primary documentation language | Maximizes initial reach. Spanish translation tracked as a P2 mission once community traction justifies the investment |
| D5 | PHS as a peer protocol of SBS/PSS/CPA, not a CPA sub-section | Handshakes have their own format, lifecycle, and propagation rules. Naming the protocol PHS keeps it parallel to the others and gives it a clear authoritative spec file (`specs/PHS-v1.0.md`) |
| D6 | Handshake storage at project root, not under `workspace/generated/` | The original orphan reference cited `workspace/generated/`; that path existed nowhere. Symmetry with the existing layout (siblings of MEMORY.md and missions/) wins over introducing a new directory hierarchy |
| D7 | One handshake per content-changing commit | Defines the auditable unit. Hygiene-only commits (gitignore, formatting) are exempt at maintainer discretion. The pre-commit cascade is enforced strictly: counter updates BEFORE the developer commits |

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
Version: 0.2.0 — Public Alpha
Last updated: 2026-05-04
Total missions: 3 (3 active, 0 completed)
Total signals: 3 (2 ACTIVE, 1 WAITING, 0 PAUSED, 0 COMPLETED)
Total tracked files: 53
Handshakes: 1 (latest: HS-001)
