# My Knowledge Garden -- CogniDoc Bootloader

This project uses a cognitive documentation system for personal knowledge management.
Any LLM operating in this repository MUST follow this protocol.

---

## Semantic Beacon System (SBS) [*(KNO.W1.DEF>S1)*]

Beacons are navigation tags embedded in documentation. Format: `[*(DOMAIN.WEIGHT.ROLE>DEST)*]`

### Domains

| Code | Domain | Coverage |
|------|--------|----------|
| KNO | Knowledge | Core concepts, mental models, evergreen notes |
| RES | Research | Active investigations, hypotheses, evidence gathering |
| REA | Reading | Books, articles, papers, reading lists and logs |
| WRI | Writing | Synthesis, essays, summaries, output creation |
| REF | References | Citations, bibliographies, cross-references between sources |

### Weights (W1-W5)

| Weight | Meaning | Instruction |
|--------|---------|-------------|
| W1 | Critical | Always read. Foundational definition |
| W2 | High | Read if context is relevant |
| W3 | Medium | Consult when deeper detail is needed |
| W4 | Low | Only for specific detail searches |
| W5 | Note | Ignore unless directed |

### Roles

| Code | Role | Marks |
|------|------|-------|
| DEF | Definition | What something IS |
| DEC | Decision | Why a choice was made |
| DEP | Dependency | Requires another element |
| REF | Reference | Related content elsewhere |
| HIT | Milestone | Checkpoint reached |
| PAT | Pattern | Reusable pattern |
| SIG | Signal | State transition |

---

## Session Protocol [*(KNO.W1.DEF>S1)*]

### Commands

1. **"access memory"** -- Read `MEMORY.md`. Confirm context: project state, active missions,
   sources tracked. Wait for instructions.

2. **"mission MIS-XXX"** -- Read the corresponding mission file in `missions/`. Confirm
   status and wait for instructions.

3. **"add source [title by author]"** -- Register a new source in the active reading
   mission. Update the source count in MEMORY.md. Ask for tags, priority, and notes.

4. **"summarize topic [name]"** -- Search across missions and notes for everything related
   to the topic. Produce a structured synthesis with references to sources.

5. **"new mission: [slug]"** -- Propose classification (priority P1-P5, type ROOT/BRANCH/
   SATELLITE/NOTE). Wait for user validation before creating the file. Register in
   MEMORY.md catalog and SIGNAL_REGISTRY.md.

6. **"reading log"** -- Show recent reading activity: sources added, notes taken, missions
   advanced. Pull from mission progress logs.

7. **"[[pause X]]" / "[[resume X]]" / "[[complete X]]"** -- Transition the state of a
   mission or research thread in SIGNAL_REGISTRY.md.

---

## CPA Protocol: Consult-Plan-Autonomy [*(KNO.W1.DEF>S1)*]

Every request follows three phases:

- **Phase C (Consult):** Evaluate if the request is clear. If ambiguous, ask one round of
  clarifying questions. If clear, proceed silently.
- **Phase P (Plan):** Identify which files to read or modify. List them mentally. For
  changes affecting more than 3 files, state the plan before executing.
- **Phase A (Autonomy):** Execute the plan. Update all affected documents (mission file,
  MEMORY.md, SIGNAL_REGISTRY.md) in the same pass. Confirm when done.

No package orchestration or agent swarms are needed for personal use. Sequential execution
is the default.

---

## Directory Structure [*(KNO.W2.DEF>S1)*]

```
my-knowledge-garden/
├── COGNIDOC.md            <-- This file (bootloader)
├── MEMORY.md              <-- Project memory (identity, state, catalog)
├── SIGNAL_REGISTRY.md     <-- State tracking for missions and threads
└── missions/              <-- Individual mission files
    ├── mis-001-slug.md
    ├── mis-002-slug.md
    └── ...
```

---

## Update Methodology [*(KNO.W1.DEF>S1)*]

- **Mission files:** Update checks `[x]`, milestones, and progress logs whenever work
  advances.
- **MEMORY.md Roadmap (S9):** Update when a P1/P2 mission changes state or phase.
- **MEMORY.md Catalog (S10):** Update when any mission is created, reclassified, or
  completed.
- **SIGNAL_REGISTRY.md:** Update when a mission is created, paused, resumed, or completed.

---

## Fundamental Principles [*(KNO.W1.DEF>S1)*]

1. MEMORY.md and mission files are the SINGLE SOURCE OF TRUTH for the state of your
   knowledge work. Keep them accurate.
2. Every source deserves proper attribution. Never add a source without author and title.
3. Synthesis is more valuable than collection. Missions should aim to PRODUCE understanding,
   not just accumulate references.
4. Notes should be written so that a future you (or a future LLM) can understand them
   without additional context.
5. Reading is not linear. Missions can be paused, resumed, and branched freely. The signal
   system tracks where you left off.
6. Simplicity over ceremony. This system should reduce friction, not add it. If a protocol
   does not serve your thinking, adapt it.
