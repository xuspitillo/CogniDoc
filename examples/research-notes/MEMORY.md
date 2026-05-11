# Research Memory -- Autonomous Agents Research

> Last updated: 2026-05-02 | Papers reviewed: 47 | Active threads: 3 | Missions: 3

---

## S1 -- Identity [*(SYN.W1.DEF>S1)*]

**Project:** Autonomous Agents Research -- a systematic review of LLM-based autonomous agent architectures published between 2024 and 2026. The goal is to map the landscape of agent memory systems, planning mechanisms, and tool-use frameworks, identify convergent design patterns, and produce a comparison framework useful for both academic publication and practical system design.

**Researcher scope:** Single-researcher project with LLM assistant support. Not affiliated with a specific lab; independent review intended for a survey paper submission.

---

## S2 -- Stack [*(MET.W2.DEF>S2)*]

| Component | Tool | Purpose |
|-----------|------|---------|
| Notes & memory | Markdown + MandelDoc | Structured research memory, synthesis, gap tracking |
| Reference management | Zotero | Bibliographic data, PDF storage, citation export |
| Analysis scripts | Python 3.11 | Quantitative analysis, table generation, figure plotting |
| LLM assistant | Any (Claude, GPT, etc.) | Research support via MandelDoc protocol |
| Version control | Git | Track evolution of notes, synthesis, and analysis |

---

## S3 -- Key Definitions [*(LIT.W2.DEF>S3)*]

- **Agent memory system:** The mechanism by which an LLM-based agent retains, retrieves, and uses information across reasoning steps or sessions. Includes working memory, episodic memory, and semantic memory architectures.
- **Planning mechanism:** The method an agent uses to decompose goals into sub-tasks, sequence actions, and adapt plans based on feedback. Includes ReAct, tree-of-thought, and hierarchical planning.
- **Tool-use framework:** The interface layer enabling an agent to invoke external tools (APIs, code execution, search) as part of its reasoning loop.

---

## S4 -- Current State [*(SYN.W1.DEF>S4)*]

- **Papers reviewed:** 47 (of estimated 70-80 relevant papers in scope)
- **Papers with structured reading notes:** 31
- **Architecture patterns identified:** 5 (preliminary; memory-focused subset)
- **Research threads active:** 3 (see S9 Roadmap)
- **Synthesis documents drafted:** 1 (agent memory taxonomy, draft v0.2)
- **Experiments attempted:** 0 (blocked on GPU access for MIS-003)

---

## S5 -- Methodology [*(MET.W1.DEF>S5)*]

**Search strategy:** Systematic search across Semantic Scholar, arXiv, and ACL Anthology using queries: "LLM agent memory", "autonomous agent architecture", "tool-augmented language model", "agent planning LLM". Snowball sampling from reference lists of key survey papers (Wang et al. 2024, Xi et al. 2025).

**Inclusion criteria:** Papers presenting or evaluating a concrete agent architecture with at least one of: memory system, planning mechanism, or tool-use framework. Published 2024-2026. English language.

**Exclusion criteria:** Pure prompt engineering without architectural contribution. Benchmark-only papers without system description. Non-peer-reviewed blog posts (unless highly cited and technically detailed).

---

## S9 -- Active Roadmap [*(SYN.W1.DEF>S9)*]

### P1 -- Critical

| Mission | Title | Phase | Status |
|---------|-------|-------|--------|
| MIS-001 | Literature review on agent memory systems | Phase 2 (pattern extraction) | ACTIVE -- 14/20+ papers surveyed, 3/5 patterns identified |

### P2 -- High

| Mission | Title | Phase | Status |
|---------|-------|-------|--------|
| MIS-002 | Comparison framework for agent architectures | Phase 1 (dimension definition) | ACTIVE -- 4 comparison dimensions drafted |

---

## S10 -- Mission Catalog [*(SYN.W2.DEF>S10)*]

### ROOT Missions

| ID | Slug | Priority | Status | Description |
|----|------|----------|--------|-------------|
| MIS-001 | lit-review-memory | P1 | ACTIVE | Literature review on agent memory systems |
| MIS-002 | comparison-framework | P2 | ACTIVE | Comparison framework for agent architectures |

### SATELLITE Missions

| ID | Slug | Priority | Status | Description |
|----|------|----------|--------|-------------|
| MIS-003 | experiment-reproduction | P3 | WAITING | Reproduce MemGPT and Voyager memory benchmarks |

---

> Footer: Papers=47 | Threads=3 | Missions=3 (2 ROOT, 1 SATELLITE) | Signals=3 | Last updated: 2026-05-02
