# CogniDoc

**Cognitive documentation infrastructure for LLM-driven projects.**

CogniDoc gives a project a persistent memory and navigation layer that any LLM can read at session start and keep up to date as work progresses — across sessions and across team members.

It is not prompt engineering, not a RAG framework, and not an agent library. It is a documentation and protocol layer those tools operate on top of: a structured representation of what the project knows about itself, expressed in a form an LLM can navigate, update, and keep coherent.

---

## The problem CogniDoc solves

LLMs are excellent at one-shot tasks. They are unreliable at long-lived projects:

- **Context dies between sessions.** Every new chat starts blind.
- **Documentation rots instantly.** The moment you change code, the docs lie.
- **Tribal knowledge becomes a single point of failure.** If the expert is unavailable, work stops.
- **Tasks scatter without classification.** Priorities, dependencies, and history get lost in chat scrollback.
- **LLMs read entire documents to find one paragraph.** Wasted tokens, wasted attention, wasted accuracy.

CogniDoc addresses all five with a small set of protocols, templates, and conventions that any LLM can read on session start.

---

## What you get in this repository (Tier 1: Foundation)

This is the **public, open-source foundation** of CogniDoc. It contains:

- **Bootloader template** (`bootloader/COGNIDOC.md.template`) — the entry point any LLM reads first to understand the project.
- **Memory templates** (`templates/`) — `MEMORY.md`, mission files, signal registry. The structure your project uses to remember itself.
- **Protocol specifications** (`specs/`) — five foundational protocols:
  - **SBS** — Semantic Beacon System (cognitive navigation tags)
  - **PSS** — Project Signal System (5-state machine for processes/missions)
  - **CPA** — Consult-Plan-Autonomy pipeline (how the LLM processes each request)
  - **CLASSIFICATION** — Priority × Type taxonomy for missions
  - **PHS** — Project Handshake System (immutable per-commit narrative checkpoints)
- **Adoption documentation** (`docs/`) — getting started, concepts, comparisons, glossary.
- **Reference examples** (`examples/`) — three working demos: personal knowledge base, software project, research notes.
- **Lightweight tooling** (`tools/`) — initialization script, context bundler for non-file-capable LLMs, and basic beacon validator.

CogniDoc is **bring-your-own-LLM**:

| LLM type | How it works | File management |
|----------|-------------|-----------------|
| Code-integrated (Claude Code, Cursor, Windsurf) | Auto-reads `COGNIDOC.md` | Automatic |
| Chat-based (ChatGPT, Gemini, Claude web) | Paste context via `tools/context.sh` | Manual |
| Local (Ollama, LM Studio, Qwen, Mistral) | Pipe context via `tools/context.sh` | Manual or scripted |
| API | System message | Programmatic |

See `docs/getting-started.md` for setup instructions per LLM type.

---

## Quickstart (5 minutes)

```bash
# 1. Clone the repo
git clone https://github.com/xuspitillo/CogniDoc.git
cd CogniDoc

# 2. Initialize a new project from the templates
./tools/init.sh ~/my-project "My Project Name"

# 3. Feed COGNIDOC.md to your LLM (see docs/getting-started.md for your LLM type)
```

That is it. From the first message in your LLM session, the assistant knows:
- What the project is
- What its mission roadmap looks like
- What state every active process is in
- How to update the documentation as work progresses
- How to coordinate with other LLMs working on the same project

---

## How it works (in three sentences)

1. **The bootloader (`COGNIDOC.md`)** is the protocol the LLM reads first. It defines how to navigate, how to update memory, how to classify work, and how to verify coherence before committing changes.
2. **The memory system (`MEMORY.md` + missions + signal registry)** is the project's living state. Every change updates it. Every LLM session reads it.
3. **The semantic beacons (`[*(domain.weight.role>destination)*]`)** are inline tags that let any LLM jump directly to relevant content. The LLM filters by domain, weight, or role rather than scanning every document linearly.

---

## Why this is different from what you have tried before

| Tool | What it does | What it does NOT do |
|------|--------------|---------------------|
| **RAG** | Retrieves relevant chunks for Q&A | Maintains coherent project state across time |
| **LangChain / agent frameworks** | Orchestrates tool calls | Provides a self-aware project structure |
| **n8n / workflow engines** | Automates pipelines | Tracks cognitive state of long-lived missions |
| **Custom memory layers** | Stores context in a database | Forms a self-coherent operating protocol |
| **CogniDoc** | Persistent, navigable project state that the above tools can operate on top of | (Use any of those tools INSIDE a CogniDoc-managed project; CogniDoc is the documentation layer, not a replacement for execution engines or retrieval systems) |

CogniDoc does not replace your existing stack. It **organizes** it.

---

## Beyond Tier 1

This repository is the **Foundation tier** — public, free, permissively licensed. Commercial tiers with advanced tooling (programmatic libraries, audit systems, fine-tuned models) are in development. See `docs/upgrade-path.md` for details.

---

## License

Apache License 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE).

The CogniDoc protocol specifications, templates, and tooling in this repository are licensed under Apache 2.0. The CogniDoc name and the validated programmatic implementations of higher tiers are property of LIGHT Corp.

---

## Status

**Version:** 0.2.1 — Public Alpha
**Stability:** Specifications are stable. Templates and tooling may evolve based on early adopter feedback.
**Origin:** CogniDoc was developed and validated internally at LIGHT Corp before being extracted for public release.
**Built with:** Anthropic Claude Code, under human direction (project lead: [@xuspitillo](https://github.com/xuspitillo)). Protocol design, architectural decisions, and end-to-end adoption testing are human-supervised; mechanical commit authorship in `git log` mostly reflects the sandbox identity (`Claude <noreply@anthropic.com>`) used during implementation.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). We welcome issues, discussion, and pull requests against the public T1 surface.

## Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Changelog

See [CHANGELOG.md](CHANGELOG.md).
