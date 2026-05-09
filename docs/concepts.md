# CogniDoc -- Core Concepts

## Why cognitive documentation?

Traditional documentation is static -- it describes a system at a point in time and immediately begins aging. Cognitive documentation is **alive**: it updates as the project evolves, provides navigation aids for LLMs, tracks the state of every process, and guarantees coherence between what the documentation says and what the code does.

The shift: documentation is no longer a byproduct of work. It IS the operating layer that enables work to be coherent across time, across sessions, and across team members.

## The bootloader

The COGNIDOC.md file is the entry point. Every LLM session begins by reading it. It defines:

- How to navigate the project (SBS beacons)
- How to update memory (update methodology)
- How to process requests (CPA pipeline)
- How to track state (PSS signals)
- How to classify work (mission taxonomy)

Think of it as an operating system kernel for your project's cognitive layer. The LLM loads it and becomes aware.

## Living memory vs static docs

### MEMORY.md

The project's general memory. 10 sections covering identity, stack, architecture, state, history, decisions, lessons, roadmap, and catalog. Updated organically as work progresses.

### Mission files

Each mission (feature, task, initiative) gets its own file with metadata, objectives, milestones, roadmap, and a progress log. The file IS the mission's memory.

### Signal registry

A dedicated registry tracking the state of every mission and process using a formal 5-state machine (Active, Paused, Waiting, Completed, Evolution).

### Handshakes

An append-only chain of immutable narrative checkpoints. One handshake is generated before every commit that changes project content, documenting what changed since the previous handshake, why, and how it affected missions and decisions. The chain is forensic-quality: any LLM reading the latest handshake — without prior context — can bootstrap into the project. Handshakes complement mission progress logs: missions log per-mission progress; handshakes log per-commit project state.

## Semantic beacons

Inline tags like `[*(ARC.W1.DEF>S3)*]` embedded in documentation. They encode:

- **Domain** -- what area this content belongs to
- **Weight** -- how important it is (W1=critical, W5=note)
- **Role** -- what function it serves (definition, decision, reference, etc.)
- **Destination** -- where related content lives

LLMs use beacons to jump directly to relevant content without reading entire documents. Like hyperlinks, but for cognitive navigation.

### Why inline beacons and not YAML frontmatter

A reasonable alternative is YAML frontmatter at the top of each file (e.g., `---\ndomain: ARC\nweight: W1\nrole: DEF\ndestination: S3\n---`). The trade-offs that pushed CogniDoc toward inline beacons:

- **Granularity.** YAML frontmatter applies to a whole file. Beacons are inline and apply to a specific paragraph, table row, or section. A single mission file can carry dozens of beacons annotating dozens of distinct decisions, definitions, risks, and references. Frontmatter cannot do that without nesting structure that is harder to read than the prose it would annotate.
- **Survival under markdown rendering.** YAML frontmatter is consumed by some markdown renderers and disappears from the rendered HTML. Beacons render as visible text (or are gracefully ignored), so a human or LLM reading the rendered version still sees them.
- **Composition with prose.** Beacons sit inside the sentence they annotate, so the LLM (or human) reads beacon-and-content together. With frontmatter, you either jump to the top of the file to learn the metadata or you do not see it at all when reading a paragraph in the middle.
- **Pack semantics.** Beacons can be packed (`[*(SEC.W1.DEC>S2 | ARC.W2.DEP>MIS-004)*]`) to express that a single paragraph carries simultaneous meaning across multiple domains. YAML frontmatter has no compact equivalent.

The cost is real: beacons are noisier than YAML in plain text, and the syntax `[*(...)*]` is project-specific rather than a widely-known standard. CogniDoc accepts that cost in exchange for granular, inline, render-surviving navigation. For a project where the alternative — file-level metadata — is enough, plain YAML frontmatter is a perfectly valid choice and CogniDoc is overkill.

## The CPA pipeline

Every request follows three phases:

1. **Consult** -- Does the LLM have enough context? If not, ask once, ask completely.
2. **Plan** -- What will change? What's the order? What are the risks?
3. **Autonomy** -- Execute the plan, verify each step, propagate updates.

This prevents the common failure mode where LLMs dive into execution without understanding the full scope, leading to partial work, missed updates, or contradictory changes.

## Mission classification

Two orthogonal axes:

- **Priority (P1-P5)**: How urgent. P1=critical/now, P5=embryonic idea.
- **Type (ROOT/BRANCH/SATELLITE/NOTE)**: Architectural relationship. ROOT=mainline, BRANCH=child of another mission, SATELLITE=independent, NOTE=minimal idea.

These axes are independent. A SATELLITE can be P1. A ROOT can be P5. This prevents the common confusion between "this is important" and "this is part of the core."

## The coherence guarantee

CogniDoc's most distinctive property: the system is designed so that documentation and reality cannot diverge silently. The protocols enforce:

- Updates to mission files when work advances
- Updates to MEMORY.md when milestones are reached
- Signal emissions when states change
- Propagation cascades when metrics change
- Cross-document verification before major deliverables

Higher tiers add programmatic validation (parsers, validators, CI/CD integration) to make this guarantee machine-enforceable. In Tier 1, the guarantee is protocol-driven -- the bootloader instructs the LLM to maintain coherence as part of every operation.

## Key terminology

| Term | Meaning |
|------|---------|
| Bootloader | The COGNIDOC.md protocol file that initializes LLM awareness |
| Beacon | Inline semantic tag for cognitive navigation |
| Mission | A tracked unit of work with its own memory file |
| Signal | A state transition event in the PSS |
| Handshake | An immutable narrative checkpoint generated before every commit |
| CPA | Consult-Plan-Autonomy -- the operational pipeline |
| PSS | Project Signal System -- state tracking |
| PHS | Project Handshake System -- chronological narrative checkpoints |
| SBS | Semantic Beacon System -- navigation |

## What CogniDoc is NOT

- It is NOT a database. It is markdown files with protocols.
- It is NOT an agent framework. It organizes the project; agents operate on it.
- It is NOT a RAG system. RAG retrieves; CogniDoc structures, navigates, and maintains.
- It is NOT tied to any specific LLM. Any model that reads markdown can use it.
