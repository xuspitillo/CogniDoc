# CogniDoc Example: Software Development Project

## What This Is

This example shows CogniDoc adopted for **TaskFlow API** -- a RESTful task management
service built by a small development team (2-3 engineers). It demonstrates how CogniDoc
brings structured cognitive memory to everyday software development.

## The Scenario

TaskFlow API is a FastAPI + PostgreSQL backend for a task management application.
The team is at v0.3.0 with 12 endpoints and 45 passing tests. They are actively working
on user authentication (P1) and planning real-time notifications (P2).

## What This Demonstrates

- **Custom SBS domains** tailored to software development (API, BAK, FRO, TST, DEV, DAT, SEC)
- **CPA pipeline** adapted for dev workflows: PR reviews, endpoint analysis, test runs
- **Mission tracking** for features with phases, checks, and progress logs
- **Signal Registry** showing the 5-state machine tracking feature status
- **Memory file** as the single source of truth for project state

## Files

| File | Purpose |
|------|---------|
| `COGNIDOC.md` | Bootloader -- configures any LLM to work with this project |
| `MEMORY.md` | Project memory -- state, stack, architecture, roadmap, catalog |
| `SIGNAL_REGISTRY.md` | Signal registry -- atomic state tracking for all missions |
| `HANDSHAKES.md` | Handshake index -- chronological per-commit checkpoints |
| `missions/mis-001-auth-system.md` | Example mission -- JWT authentication feature |
| `handshakes/hs-001-2026-04-15-api-docs-shipped.md` | Example handshake -- demonstrates the PHS format |

> **Note:** This example ships with one fully detailed mission file (`mis-001-auth-system.md`) and one fully detailed handshake (`hs-001-...md`). The additional missions referenced in `MEMORY.md` and `SIGNAL_REGISTRY.md` (mis-002 notifications, mis-003 api-docs, mis-004 rate-limiting) are intentionally left as catalog-only entries to demonstrate how a real project's memory grows over time -- you can see how missions are tracked through the catalog and signal registry without needing every detail file to be present.

## How to Try It

1. Copy this directory into your own project
2. Adapt `COGNIDOC.md` with your stack, domains, and directory structure
3. Fill `MEMORY.md` with your project's real state
4. Create mission files for your active features
5. Point your LLM at `COGNIDOC.md` and start working

## Key Insight

CogniDoc is not documentation -- it is cognitive infrastructure. Your LLM does not just
read your code; it understands your project's history, decisions, and direction. Every
session starts with context, not from zero.
