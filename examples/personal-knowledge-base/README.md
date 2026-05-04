# Personal Knowledge Base -- CogniDoc Example

This example demonstrates CogniDoc adopted for a **personal knowledge management system**
called "My Knowledge Garden." It shows how a single person can use cognitive documentation
to capture, organize, and synthesize knowledge from books, articles, papers, and conferences.

## What this example demonstrates

- **Custom semantic domains** tailored to knowledge work (KNO, RES, REA, WRI, REF)
  instead of infrastructure-heavy defaults.
- **Simplified CPA protocol** -- no package orchestration or swarm agents. Just the
  Consult-Plan-Autonomy pipeline adapted for a solo knowledge worker.
- **Mission-driven reading** -- treating reading goals, synthesis projects, and note
  organization as trackable missions with milestones and progress logs.
- **Signal tracking** for pausing and resuming research threads across sessions.
- **A living memory** that any LLM can read to pick up exactly where you left off.

## Files in this example

| File | Purpose |
|------|---------|
| `COGNIDOC.md` | Bootloader -- session protocol, domains, commands, principles |
| `MEMORY.md` | Project memory -- identity, state, roadmap, catalog |
| `SIGNAL_REGISTRY.md` | State tracking for missions and research threads |
| `missions/mis-001-reading-backlog.md` | Example mission: organizing a reading backlog |

> **Note:** This example ships with one fully detailed mission file (`mis-001-reading-backlog.md`). The additional missions referenced in `MEMORY.md` and `SIGNAL_REGISTRY.md` (mis-002 ai-agents-synthesis, mis-003 conference-notes) are intentionally left as catalog-only entries to demonstrate how a personal knowledge project's memory grows over time -- you can see how missions are tracked through the catalog and signal registry without needing every detail file to be present.

## How to try it

1. Copy this directory into your own repository.
2. Adjust `COGNIDOC.md` to match your knowledge domains and reading habits.
3. Open a conversation with any LLM that reads `COGNIDOC.md` on startup.
4. Say `"access memory"` to load context, then start working.

## Who is this for

Anyone who reads a lot, takes notes, and wants an LLM assistant that remembers
their research context across sessions -- without relying on a proprietary app.
All you need is Markdown files, git, and an LLM.
