# Autonomous Agents Research -- MandelDoc Bootloader

This project uses MandelDoc for structured research memory management.
Any LLM assistant operating in this repository MUST follow this protocol.

---

## Semantic Beacon System (SBS)

### Beacon Format

```
[*(DOMAIN.WEIGHT.ROLE>DESTINATION)*]
```

### Domains (research-specific)

| Code | Domain | Coverage |
|------|--------|----------|
| LIT  | Literature | Papers, citations, bibliographic data, reading status |
| MET  | Methodology | Research methods, experimental design, evaluation criteria |
| FND  | Findings | Results, observations, data points, extracted claims |
| SYN  | Synthesis | Cross-paper analysis, pattern identification, frameworks |
| GAP  | Research Gaps | Open questions, contradictions, unexplored areas |
| EXP  | Experiments | Reproduction attempts, benchmarks, scripts, datasets |

### Weights (W1-W5)

| Weight | Meaning | Instruction |
|--------|---------|-------------|
| W1 | Critical | Always read. Foundational definition |
| W2 | High | Read if working in relevant context |
| W3 | Medium | Consult when deeper detail is needed |
| W4 | Low | Only for specific detail searches |
| W5 | Note | Ignore unless directed |

### Roles

| Code | Role | What it marks |
|------|------|---------------|
| DEF | Definition | What something IS |
| DEC | Decision | Why something was chosen |
| DEP | Dependency | Requires another element |
| REF | Reference | See also -- related content elsewhere |
| HIT | Milestone | Checkpoint reached |
| PAT | Pattern | Reusable pattern across papers/experiments |
| EVL | Evolution | Change from a prior understanding |

### Destinations

| Format | Points to |
|--------|-----------|
| >MIS-XXX | Specific mission |
| >SN | Section N of MEMORY.md |
| >SR | SIGNAL_REGISTRY.md |
| >SR.SIG-NNN | Specific signal entry |

---

## Session Protocol [*(SYN.W1.DEF>S1)*]

### Commands

1. **"access memory"** -- Read MEMORY.md. Confirm: research state, active threads, papers reviewed. Wait for instructions.

2. **"add paper [title/DOI]"** -- Register a new paper:
   a. Record: title, authors, year, venue, DOI/URL
   b. Assign to relevant mission(s)
   c. Create a structured reading note template (key claims, methodology, findings, limitations)
   d. Update paper count in MEMORY.md

3. **"literature review [topic]"** -- Synthesize all papers read on a given topic:
   a. Identify all papers tagged with the topic across missions
   b. Group by methodology, findings, or chronology (as appropriate)
   c. Highlight agreements, contradictions, and gaps
   d. Output a structured review section with citations

4. **"synthesize findings [scope]"** -- Cross-paper analysis:
   a. Extract key findings from papers within scope
   b. Identify recurring patterns and outliers
   c. Build or update a comparison table
   d. Note confidence levels and evidence strength

5. **"identify gaps [area]"** -- Research gap analysis:
   a. Survey what has been studied in the area
   b. Identify questions no paper adequately addresses
   c. Note methodological limitations across the literature
   d. Suggest potential research directions with justification

6. **"mission MIS-XXX"** -- Read the specified mission file. Confirm status and wait.

7. **"new mission: slug"** -- Create a new research thread:
   a. Wait for the researcher's description
   b. Propose classification (priority P1-P5, type ROOT/BRANCH/SATELLITE/NOTE)
   c. After validation, create the mission file and register in MEMORY.md and SIGNAL_REGISTRY.md

---

## CPA Protocol (Simplified) [*(MET.W1.DEF>S1)*]

Every request follows three phases:

- **Consult (C):** Evaluate if the request is clear. If ambiguous, ask ONE round of clarifying questions covering all uncertainties.
- **Plan (P):** Identify files to read/update, order of operations, and propagation targets (MEMORY.md, missions, SIGNAL_REGISTRY.md).
- **Act (A):** Execute the plan. Update all affected documents. Confirm completion.

---

## Directory Structure

```
research-notes/
  MANDELDOC.md            -- This file (bootloader)
  MEMORY.md              -- Research memory (state, stack, roadmap, catalog)
  SIGNAL_REGISTRY.md     -- Signal registry (thread states)
  missions/              -- Individual research thread files
    mis-XXX-slug.md      -- One file per research thread
  papers/                -- Reading notes organized by paper (optional)
  experiments/           -- Reproduction scripts, data, results (optional)
  synthesis/             -- Cross-cutting synthesis documents (optional)
```

---

## Research Principles [*(MET.W1.DEF>S1)*]

1. **Trace every claim to a source.** No finding exists without a citation. If a claim appears in synthesis, it links back to the paper(s) that support it.
2. **Track methodology explicitly.** For each paper, record HOW the authors reached their conclusions, not just WHAT they concluded. Methodology determines weight of evidence.
3. **Document negative results.** Failed reproductions, contradicted hypotheses, and papers that did NOT find expected results are as valuable as positive findings. Record them with equal rigor.
4. **Separate observation from interpretation.** Reading notes distinguish between what the paper says (observation) and what we think it means for our research (interpretation).
5. **Maintain version awareness.** AI agent research moves fast. Always note the date of a finding and whether subsequent work has superseded it.
6. **Quantify confidence.** When synthesizing across papers, note evidence strength: single paper, multiple papers agreeing, or consensus with minor dissent.
7. **MEMORY.md and mission files are the source of truth** for the state of this research project. Keep them accurate, complete, and current.
