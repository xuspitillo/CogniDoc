# CogniDoc — Use Cases

CogniDoc adapts to any project where LLMs participate in long-lived work. These seven scenarios illustrate how the system adds value across different domains.

## 1. Solo Developer with AI Copilot

**Scenario:** A developer uses Claude or GPT as a coding partner across weeks of work on a side project. Every new chat session starts from zero — the LLM forgets the architecture decisions, the tech debt, the roadmap.

**With CogniDoc:** The LLM reads COGNIDOC.md at session start and immediately knows: the project structure, active missions, recent decisions, and what comes next. Continuity without manual re-briefing.

**Key features used:** Bootloader, MEMORY.md, mission files.

## 2. Small Team Building a Product

**Scenario:** A 3-person startup uses LLMs for code review, documentation, and planning. Each team member uses their own LLM sessions. Knowledge fragments across chat histories. Nobody has the complete picture.

**With CogniDoc:** All three share the same MEMORY.md and mission files via git. Each LLM session reads the same bootloader. Knowledge accumulates in one place instead of scattering across chat windows.

**Key features used:** Bootloader, shared memory, mission classification (P1-P5 helps prioritize).

## 3. Research Project with Literature Review

**Scenario:** A PhD student uses LLMs to help analyze papers, synthesize findings, and track research threads. After 200 papers and 6 months, the context is overwhelming.

**With CogniDoc:** Each research thread becomes a mission. Papers and findings are tracked in progress logs. SBS beacons connect related concepts across threads. The signal registry tracks which threads are active, paused, or waiting on external input.

**Key features used:** Mission files as research threads, SBS for cross-referencing, PSS for thread state.

## 4. Technical Documentation Maintenance

**Scenario:** A company's docs are always outdated. Engineers change the code but forget to update docs. The LLM assistant writes docs but doesn't know what changed since last time.

**With CogniDoc:** The bootloader's update methodology instructs the LLM to update documentation as part of every code change, not as a separate afterthought. SBS beacons mark which docs relate to which code areas. The CPA pipeline ensures documentation impact is evaluated during planning, before execution begins.

**Key features used:** Update methodology, SBS domain mapping, CPA pipeline (Phase P includes doc impact).

## 5. Freelance Consultant Managing Multiple Clients

**Scenario:** A consultant works with 5 clients simultaneously, each with their own project context. Switching between contexts is mentally expensive and error-prone.

**With CogniDoc:** Each client project has its own CogniDoc instance. The consultant opens the relevant COGNIDOC.md, and the LLM has full context in seconds. No mental overhead for context switching.

**Key features used:** Independent instances, bootloader as instant context loader.

## 6. Open Source Project Onboarding

**Scenario:** New contributors to an open source project spend hours reading READMEs, wikis, and issue trackers to understand the project. Much knowledge lives only in maintainers' heads.

**With CogniDoc:** MEMORY.md captures the project's identity, architecture, decisions, and lessons learned. Mission files document active work streams with full context. New contributors (and their LLMs) get oriented in minutes, not hours.

**Key features used:** MEMORY.md sections 1-8, mission catalog (section 10), decision records (section 7).

## 7. Compliance-Sensitive Operations

**Scenario:** A team working in a regulated industry (finance, healthcare) needs to demonstrate that every decision was documented, every change was tracked, and every process followed protocol.

**With CogniDoc:** The PSS provides auditable state transitions with a formal 5-state machine. Handshakes create immutable narrative checkpoints. Mission logs record what was done, when, and why. The CPA pipeline ensures every operation follows a documented process from consultation through execution.

**Key features used:** PSS (auditable signals), handshakes (immutable checkpoints), CPA (process compliance), mission logs.

## Choosing the Right Level of Adoption

- **Start minimal:** Bootloader + MEMORY.md + one mission file. See if the value is immediate.
- **Add signal tracking** when you have 3+ missions and need state awareness across work streams.
- **Add beacons** when documents grow large enough that navigation matters.
- **Add the CPA pipeline** when you want structured planning and execution guarantees.

The system scales with your project. Adopt what you need, when you need it.
