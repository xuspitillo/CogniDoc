# HS-NNN — {{PROJECT_NAME}} Handshake — YYYY-MM-DD — {{Descriptive Title}}

<!--
  NAMING CONVENTION:
  - HS-NNN: Sequential counter, zero-padded 3 digits (001, 002, 003...). Never reused.
  - YYYY-MM-DD: Date this handshake was generated.
  - Descriptive Title: A short phrase that identifies the handshake without opening it.

  Handshakes form a chronological chain. Alphabetical ordering of HS-NNN files
  IS chronological ordering. Each handshake is a complete state checkpoint that
  an agent without prior context can read and gain full project comprehension.
-->

## Executive Summary

*1-3 paragraphs covering the key changes since the last handshake. What happened, why it matters, and what the project state is now.*

## System State

| Metric | Value |
|--------|-------|
| Version | *{{current version}}* |
| Missions Active | *{{count}}* |
| Missions Paused | *{{count}}* |
| Missions Completed | *{{count}}* |
| *{{key counter 1}}* | *{{value}}* |
| *{{key counter 2}}* | *{{value}}* |

*Add or remove rows as needed for the project. Track metrics that matter.*

## Advances Since Last Handshake

*Detailed narrative organized by area. For each area: what changed, what was built, what was decided, and why. Write for an audience with zero prior context.*

## Files Created / Modified

| File | Action | Description |
|------|--------|-------------|
| *{{path/to/file}}* | *created / modified / deleted* | *Brief description of change* |

## Decisions Taken

*Each decision listed with its justification and downstream impact. Decisions are the "why" behind the "what" documented above.*

## Impact on Missions

| Mission | Impact | New State |
|---------|--------|-----------|
| *{{MIS-XXX}}* | *{{description of impact}}* | *{{active / paused / completed / waiting}}* |

## Roadmap and Next Steps

*What comes next: priorities, planned work, known blockers, and dependencies that must resolve before progress can continue.*

## Warnings and Risks

*Identified risks, mitigations applied, mitigations still needed. Include technical debt, external dependencies, and time-sensitive items.*

## Context for External Agents

*A self-contained summary that an LLM reading ONLY this handshake can use to understand the current project state, active priorities, and recent trajectory. Assume no prior context.*

---

*Handshakes are IMMUTABLE. Once generated, a handshake is never modified. If corrections are needed, document them in the NEXT handshake.*
