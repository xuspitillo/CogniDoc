# CogniDoc Tier 1 — Handshakes Index

> Last updated: 2026-05-04
> Total handshakes: 1
> Latest: HS-001

---

## Quick Index

| HS | Date | Title | Commit |
|----|------|-------|--------|
| HS-001 | 2026-05-04 | PHS protocol integration (handshakes go from orphan feature to first-class protocol) | *(this commit)* |

---

## Storage

Individual handshake files live at:

```
handshakes/hs-NNN-YYYY-MM-DD-slug.md
```

- `HS-NNN` — sequential counter, zero-padded three digits, never reused.
- `YYYY-MM-DD` — generation date.
- `slug` — kebab-case 2-5 word description.

Alphabetical ordering of files equals chronological ordering of handshakes.

---

## Protocol Invariants

1. **Immutable.** Once committed, a handshake file is never modified. Corrections go into the next handshake.
2. **Continuous.** The set HS-001..HS-N has no gaps.
3. **Pre-commit generation.** A handshake is generated BEFORE every commit that changes project content. See `specs/PHS-v1.0.md`.
4. **Atomic propagation.** Generating handshake HS-NNN updates this index AND `MEMORY.md` footer counter BEFORE the commit. The developer commits only after the agent confirms the propagation is complete.

---

## Self-Containedness

Each handshake is a complete state checkpoint. An LLM agent reading only the latest handshake — without the bootloader, without `MEMORY.md`, without prior context — must be able to identify the project, understand current state, list active missions, and continue work coherently. If reading the latest handshake alone leaves gaps, those gaps are documented in the next handshake.

---

## Backfill notice

CogniDoc Tier 1 v0.1.0 and v0.1.1 were released before the PHS protocol was integrated. HS-001 is the first handshake of the project, generated alongside the v0.2.0 release that integrated PHS. From v0.2.0 onward, every commit that changes project content is preceded by a handshake.
