# CogniDoc Example: Autonomous Agents Research

## What This Is

This example demonstrates CogniDoc adopted for **academic research workflow management**.
A researcher studying "Autonomous AI Agents" uses CogniDoc to systematically track papers,
organize findings, synthesize knowledge across sources, and identify research gaps.

## The Researcher's Problem

Academic research generates enormous cognitive load: dozens of papers to track, competing
methodologies to compare, evolving terminology, and threads that branch and converge
unpredictably. Traditional tools (spreadsheets, folders of PDFs, scattered notes) lose
the connections between ideas. CogniDoc solves this by giving the LLM assistant a
structured memory that persists across sessions.

## What This Example Demonstrates

- **Custom SBS domains** tailored to research: LIT (Literature), MET (Methodology),
  FND (Findings), SYN (Synthesis), GAP (Research Gaps), EXP (Experiments)
- **Research-specific session commands**: "add paper", "literature review",
  "synthesize findings", "identify gaps"
- **Mission-based research tracking**: each research thread is a mission with
  objectives, methodology checks, and a progress log
- **Signal-based state management**: know at a glance which threads are active,
  which are waiting on external resources (GPU access, dataset availability),
  and which are complete
- **Claim traceability**: every finding traces back to its source paper(s)

## Directory Structure

```
research-notes/
  COGNIDOC.md            -- Bootloader: research protocols and commands
  MEMORY.md              -- Project memory: state, stack, roadmap, catalog
  SIGNAL_REGISTRY.md     -- State tracking for all research threads
  missions/
    mis-001-lit-review-memory.md   -- Literature review on agent memory systems
    mis-002-comparison-framework.md (planned)
    mis-003-experiment-reproduction.md (planned)
```

## How to Use

Point any LLM assistant at this directory and say "access memory". The assistant
will read MEMORY.md, acquire context about the research project, and be ready to
help with literature review, synthesis, gap analysis, or experiment planning --
all while maintaining structured, traceable, session-persistent memory.
