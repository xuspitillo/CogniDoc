# Changelog

All notable changes to CogniDoc Tier 1 (Foundation) are documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

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
