# Changelog

All notable changes to CogniDoc Tier 1 (Foundation) are documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.3.1] — 2026-05-10

### Added — First production case study and visual assets

This release publishes the first empirical evidence of CogniDoc adoption at production scale, plus the diagram and OG image assets the README references.

- **`docs/case-studies/seed-project.md`** — retrospective case study documenting the original adoption of CogniDoc on the project where the protocols were extracted from. 33 days of intensive use, 41 handshakes, 16 signals, 13 missions over a codebase that grew from ~14K to ~41K LOC of Python (304 API endpoints, 168 source files). Includes 5 wins, 5 honest frictions (with the 41/59 commit-handshake ratio disclosed at 70%), beyond-T1 extensions list (validation modules ~3K LOC validated in 5+ weeks of production), 6-item v0.4 roadmap derived from real friction, and a sanitized HS-015 handshake as Appendix A. Reviewed and approved by the seed-project agent in two rounds before publication.
- **`docs/img/architecture.svg`** — concept diagram of the CogniDoc protocol flow (LLM session → bootloader → memory/missions/signals/handshakes). Used in README and external posts.
- **`docs/img/og-image.svg`** — 1200x630 OG image for social sharing of the repository link.

### Changed

- Version bump 0.3.0 → 0.3.1 (patch). VERSION, README.md, bootloader template, and tools/init.sh substitution updated.

### Notes

This is a documentation release. No protocol surface change. No breaking change. v0.3.0 adopters can ignore this version safely; the only upgrade reason is to receive the case study and the visual assets.

---

## [0.3.0] — 2026-05-09

### Changed — Post-launch revision based on critical review

After publishing v0.2.1, a critical review surfaced positioning and tone problems
that the existing release did not address despite previous audit passes. v0.3.0 is
the response: a revision that recalibrates the framing of the project from
"cognitive documentation infrastructure with a six-tier commercial roadmap" to
"a markdown convention pack for keeping LLM project context coherent across
sessions, with future tiers in private development under no committed timeline".

The protocols themselves are not changed in any breaking way. Templates,
specifications, and tooling remain backward-compatible: artifacts authored under
v0.1.x, v0.2.x continue to validate under v0.3.0. The change is **what the project
honestly is and how it is presented**, not what it does.

#### Branding and licensing

- **Removed all references to "LIGHT Corp"** from `LICENSE`, `NOTICE`, `README.md`,
  and any other repo location. The project is now attributed to "The CogniDoc
  Project Contributors" — a generic placeholder appropriate for a community-
  contributed open-source repository, leaving the door open to future
  contributions without locking the project to a specific corporate identity.
- **Rewrote `NOTICE`** to drop the "registered project name", "internal cognitive
  infrastructure", and other corporate-flavored framings that did not match the
  reality of a small protocol pack published under Apache 2.0. The new NOTICE is
  half the length and accurate.
- **Rewrote the `Origin` line** in the README Status section. Previously read
  "developed and validated internally at LIGHT Corp before being extracted for
  public release". Now reads "developed iteratively against real-world LLM
  workflows ... and tested end-to-end with a non-expert user adopting the
  protocol on a fresh project before public release", which is the actual
  development story.

#### Roadmap honesty

- **Drastically reduced `docs/upgrade-path.md`**. Earlier versions described six
  tiers (T1 through T6) with detailed feature tables, including categories like
  "Enterprise Premium" with "exclusive fine-tuned model trained on your data
  under strict NDA", "white-glove support", and "voice-enabled cognitive
  interface". For a project that ships protocol specifications and three shell
  scripts, that content read as commercial pitch rather than honest roadmap.
  v0.3.0 replaces it with a single short page: T1 ships today, higher tiers
  are in private development, no timelines, no signup, no paid plan, watch
  the repo for announcements.
- **Updated the README "Beyond Tier 1" section** to match: a single paragraph
  pointing at the shorter `upgrade-path.md`, dropping the "commercial tiers
  with advanced tooling" framing.

#### Positioning

- **New file `docs/competitive-context.md`** clarifying where CogniDoc sits in
  the AI-coding-tool ecosystem. The document makes explicit that `CLAUDE.md`,
  `.cursorrules`, `.windsurfrules`, `AGENTS.md`, and similar per-tool convention
  files are **slots** (file locations that specific tools auto-read), not
  competitors of CogniDoc. CogniDoc is content you can install in any of those
  slots. The real comparison is CogniDoc-installed slot vs ad-hoc-prose slot,
  and the document includes a concrete table of what each gives you.
- **Updated README** to point at `docs/competitive-context.md` from the intro
  and the `What you get` section.
- **Toned down the README tagline** from "Cognitive documentation infrastructure
  for LLM-driven projects" to "A markdown convention pack for keeping LLM
  project context coherent across sessions". The new tagline says what the
  project does in plain English.

#### Specifications

- **`specs/PHS-v1.0.md` softened.** The previous spec required all 10 sections
  in every handshake. v0.3.0 marks 3 sections as REQUIRED (Title and metadata,
  Executive Summary, Files Created / Modified) and the remaining 7 as
  RECOMMENDED — to be included when applicable, omitted when not. For trivial
  commits (typo fixes, small edits), a three-section handshake is now within
  protocol. Substantive commits still benefit from the fuller form. Adopters
  with handshakes already authored under v0.2.x do not need to change anything;
  the relaxation is backward-compatible.
- **`docs/concepts.md` adds a section "Why inline beacons and not YAML
  frontmatter"** explaining the design trade-off explicitly. Beacons compete
  with YAML frontmatter as a way to attach metadata to documentation, and the
  spec should defend its choice rather than leave it implicit.

### Changed
- **Version bump 0.2.1 → 0.3.0**: minor release per semver. No breaking changes
  to specifications or templates. The bump reflects substantive documentation
  rewrites and a softened PHS spec, both visible enough to a returning adopter
  that the version increment is appropriate.
- VERSION, README.md, bootloader template, and tools/init.sh updated to 0.3.0.

### Notes

The launch of v0.2.1 happened. v0.3.0 is what was learned from launching: that
the framing was the weakest part of the release, and that the protocols
themselves are stronger than their presentation suggested. Adopters of v0.2.x
do not need to do anything to upgrade; v0.3.0 is a presentation revision plus
a backward-compatible spec relaxation.

---

## [0.2.1] — 2026-05-09

### Fixed — Findings from end-to-end adoption test

This patch release closes 11 findings surfaced during a full end-to-end test of the
v0.2.0 protocol, where a non-expert user adopted CogniDoc on a fresh project using a
chat-based LLM (Claude.ai web with `tools/context.sh` bundled context). The test
exercised: project bootstrap, MEMORY.md customization, mission creation with
classification, signal transitions, dependency wiring, and the full PHS pre-commit
cascade ending in a real `git commit`. All structural pieces worked; the fixes below
address spec ambiguities, template residues, and friction points that surfaced.

#### Templates
- **`templates/MEMORY.md.template`**: Section 2, 3, and 5 beacons now use `ARC` (the
  domain code defined in the SBS spec and the bootloader) instead of `ARQ` (a Spanish
  residue from internal pre-public versions). Adopters whose `MEMORY.md` was generated
  with v0.2.0 should manually replace `ARQ` with `ARC` in those three section headers.
- **`templates/MEMORY.md.template`**: Section 7 (Key Decisions) no longer ships with a
  fake `DEC-001` placeholder row that looked like a real decision. Replaced by an
  empty row plus a commented-out example.
- **`templates/MEMORY.md.template`**: Footer comment about the `Handshakes` counter
  no longer references `specs/PHS-v1.0.md` (a path that does not exist in adopter
  projects). The comment now points to the local `COGNIDOC.md` "Project Handshake
  System" section and provides the upstream URL.
- **`templates/SIGNAL_REGISTRY.md.template`**: example beacon row also updated
  `ARQ` → `ARC` for consistency with the spec.
- **`templates/HANDSHAKES.md.template`**: Quick Index header comment now documents
  three valid conventions for the `Commit` column (blank, `(pending)`, or actual
  short hash) so adopters know the protocol does not block on the commit hash being
  available before the handshake is authored. The Protocol Invariants section
  references the local bootloader instead of `specs/PHS-v1.0.md`.
- **`templates/handshakes/_template.md`**: `Files Created / Modified` table now ships
  with an HTML comment defining when "created" applies (genuinely new files in the
  commit) vs "modified" (pre-existing files). Files generated by `init.sh` count as
  "created" only in HS-001 of a project's history.

#### Specifications
- **`specs/PSS-v1.0.md`**: New section 1.2 "Birth State and Dependencies" makes
  explicit that every mission is born ACTIVE and that creating a mission with
  unresolved dependencies requires emitting a separate, explicit `[[wait X]]` signal
  immediately after creation, producing two distinct history entries
  (`Created → ACTIVE` and `ACTIVE → WAITING`). Direct creation in WAITING state
  (whether single-row or as a synthetic collapsed transition) is now formally
  prohibited. This closes the spec ambiguity that allowed LLM agents in v0.2.0 to
  invent phantom transitions on creation, breaking the audit trail.
- **`specs/SBS-v1.0.md`**: New sub-section in Examples covering beacon placement in
  mission and handshake files. Beacons go either next to the file's main heading
  (level 1) or inside the metadata table as an explicit `Beacon` field. Hiding
  beacons inside HTML comments (`<!-- ... -->`) is now formally an anti-pattern.

#### Bootloader
- **`bootloader/COGNIDOC.md.template`**: New section "Operating Mode (Filesystem-
  Capable vs Chat-Based)" inserted near the top, before SBS. Documents the two
  classes of LLM that adopt CogniDoc and provides five explicit rules for chat-based
  mode: (1) treat "Read X" as "consult bundled context", (2) return updates as
  labeled code blocks, (3) specify exact paste location with file path, anchor, and
  operation type (REPLACE / INSERT-AFTER / INSERT-BEFORE / APPEND), (4) confirm
  "done" between edits to keep mental model in sync, (5) summarize net changes at
  end of session. Closes the friction observed during the v0.2.0 test where vague
  edit instructions (e.g. "paste this in Section 10") caused users to accidentally
  duplicate sections.

#### Documentation
- **`docs/getting-started.md`**: Step 1 Option A now states explicitly that
  `init.sh` creates the target directory (you do not need to `mkdir` or `cd`
  beforehand). Option B now lists `HANDSHAKES.md` and the `handshakes/` directory in
  the manual setup checklist (these were missing despite being part of v0.2.0).

### Changed
- Version bump 0.2.0 → 0.2.1: patch release per semver. No protocol surface changes;
  no new specs added. PSS spec gains an explicitly stated rule (1.2) that was
  implicit in v0.1.0 but has now been made explicit to remove ambiguity. SBS spec
  gains placement guidance that was implicit before. Both are clarifications, not
  protocol changes — handshakes, missions, and signals authored under v0.2.0 remain
  valid under v0.2.1.

---

## [0.2.0] — 2026-05-04

### Added — Project Handshake System (PHS) integrated as fifth foundational protocol

- **`specs/PHS-v1.0.md`** — Project Handshake System v1.0 specification. Defines handshake format, the immutable append-only chain, pre-commit generation trigger, propagation cascade, strict ordering rules, storage layout, and best practices. Peer protocol of SBS, PSS, CPA, and CLASSIFICATION.
- **`templates/HANDSHAKES.md.template`** — adopter template for the index file. Adopters generate `HANDSHAKES.md` in their own projects via `init.sh`.
- **Bootloader (`bootloader/COGNIDOC.md.template`)** now includes a full PHS section, three new session commands (`new handshake` / `generate handshake`, `handshakes` / `handshake history`, `handshake HS-NNN`), update methodology entries for HANDSHAKES.md and the MEMORY.md footer counter, updated directory structure, and two new fundamental principles (handshake immutability and pre-commit cascade enforcement).
- **`tools/init.sh`** generates `HANDSHAKES.md` in the adopter's project from the new template alongside the other root files. Numbered steps go from 5 to 6.
- **`tools/context.sh`** bundles `HANDSHAKES.md` (Section 4) and the three most recent handshake files (Section 6) from the adopter's project into the LLM-ready context block.
- **`templates/MEMORY.md.template`** footer counter format is now `Handshakes: N (latest: HS-N)` with a comment explaining the PHS pre-commit cascade.
- **`docs/glossary.md`** — `Handshake` entry rewritten to reflect the integrated protocol; new entries for `HANDSHAKES.md`, `HS-NNN`, and `PHS`. Orphan reference to `workspace/generated/` removed.
- **`docs/concepts.md`** — Handshakes added as a section in "Living memory vs static docs"; `PHS` added to terminology table.
- **`examples/software-project/`** — example `HANDSHAKES.md` and a sample handshake (`hs-001-2026-04-15-api-docs-shipped.md`) demonstrate the format in a realistic adopter project.

### Changed

- **Version bump 0.1.1 → 0.2.0**: minor-version event per semver because a new foundational protocol was added. Backward-compatible: v0.1.x adopters can upgrade by copying `HANDSHAKES.md` from the new template and adopting the bootloader's PHS section without rewriting existing memory or missions.
- **Repository scope clarified**: the CogniDoc repo defines and ships the protocol; it does **not** apply the protocol to itself. All root-level dogfooding (`MEMORY.md`, `SIGNAL_REGISTRY.md`, `missions/`) has been removed. The repository is now strictly the deliverable that adopters consume — protocol specs, templates, examples, tooling, and documentation. Information that previously lived in the dogfooded `MEMORY.md` decisions log lives in the protocol specs themselves and in this CHANGELOG; ongoing project planning lives in GitHub issues, not in repo files.

### Notes on scope

CogniDoc applies to the projects that adopt it. The CogniDoc repository itself does **not** apply CogniDoc to its own commits, missions, signals, or handshakes — this repository is the source of the protocol, not a CogniDoc-managed project. Adopters get a working `MEMORY.md`, `SIGNAL_REGISTRY.md`, `HANDSHAKES.md`, `missions/`, and `handshakes/` in their projects via `init.sh`; the example under `examples/software-project/` demonstrates a complete adopter setup including a real handshake.

## [0.1.1] — 2026-05-03

### Fixed — Quality audit and universal LLM compatibility

- **Renamed `CLAUDE.md` to `COGNIDOC.md`** across all files, templates, examples, docs, and CI. The bootloader is now LLM-vendor-neutral.
- **Unified mission ID prefix** from inconsistent `MEM-XXX` / `MIS-XXX` to `MIS-XXX` everywhere.
- **Fixed `init.sh`**: now replaces `{{OWNER}}` and `{{PROJECT_ROOT}}` in MEMORY.md (previously left as raw placeholders). Removed unused `domain` argument.
- **Added `tools/context.sh`** — context bundler that concatenates all CogniDoc files into a single LLM-ready block for pasting into ChatGPT, Gemini, Ollama, or any non-file-capable LLM.
- **Rewrote `docs/getting-started.md` Step 4** with specific instructions per LLM type (code-integrated, chat-based, local, API).
- **Updated `docs/getting-started.md` Step 5** to be honest about file management: automatic for code-integrated LLMs, manual for chat-based.
- **Added LLM compatibility table** to README showing how CogniDoc works with each LLM type.
- **Reduced "Beyond Tier 1" section** in README from a long feature list to a single line.
- **Added troubleshooting FAQ** for "My LLM says it can't access files."

---

## [0.1.0] — 2026-05-02

### Added — Initial Public Release (Tier 1: Foundation)

- **LICENSE** — Apache License 2.0.
- **NOTICE** — Attribution to LIGHT Corp and tier scope clarification.
- **README** — Value proposition, quickstart, comparison with adjacent tools.
- **Bootloader template** (`bootloader/COGNIDOC.md.template`) — generic, project-agnostic entry point for any LLM.
- **Memory templates** (`templates/`):
  - `MEMORY.md.template` — 10-section project memory structure.
  - `SIGNAL_REGISTRY.md.template` — Project Signal System registry skeleton.
  - `missions/_template.md` — mission file template with metadata, roadmap, log.
  - `handshakes/_template.md` — narrative checkpoint document template.
- **Protocol specifications** (`specs/`):
  - `SBS-v1.0.md` — Semantic Beacon System: format, ten base domains, weights W1-W5, roles, destinations.
  - `PSS-v1.0.md` — Project Signal System: 5-state machine, signal syntax, evolution pattern, propagation cascade.
  - `CPA-v1.0.md` — Consult-Plan-Autonomy pipeline: three operational phases for every LLM request.
  - `CLASSIFICATION.md` — Priority (P1-P5) × Type (Root/Branch/Satellite/Note) taxonomy.
- **Adoption documentation** (`docs/`):
  - `getting-started.md` — five-minute end-to-end onboarding.
  - `concepts.md` — fundamentals of cognitive documentation.
  - `comparison.md` — differentiation against RAG, LangChain, n8n, custom memory.
  - `upgrade-path.md` — what is reserved for Tier 2 and above.
  - `use-cases.md` — seven canonical scenarios.
  - `glossary.md` — terminology reference.
- **Reference examples** (`examples/`):
  - `personal-knowledge-base/` — adoption for personal notes / knowledge / reading list.
  - `software-project/` — adoption for a small software development team.
  - `research-notes/` — adoption for academic or personal research workflows.
- **Tooling** (`tools/`):
  - `init.sh` — initialization script that scaffolds a new CogniDoc project from templates.
  - `validate-beacons.sh` — basic beacon syntax validator using grep / awk.
- **CI** (`.github/workflows/lint.yml`) — markdown linting and template validation on pull requests.

### Notes

- This is the first public release. Specifications are considered stable; templates and tooling may evolve based on adopter feedback during the Public Alpha.
- The validated programmatic library and higher-tier features are intentionally out of scope for Tier 1 — see `docs/upgrade-path.md`.
