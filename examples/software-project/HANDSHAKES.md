# TaskFlow API — Handshakes Index

> Last updated: 2026-04-15
> Total handshakes: 1
> Latest: HS-001

---

## Quick Index

| HS | Date | Title | Commit |
|----|------|-------|--------|
| HS-001 | 2026-04-15 | API documentation milestone (MIS-003 complete) | a1b2c3d |

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
3. **Pre-commit generation.** A handshake is generated BEFORE every commit that changes project content.
4. **Atomic propagation.** Generating handshake HS-NNN updates this index AND `MEMORY.md` footer counter BEFORE the commit.

---

## Note for the example

This example ships with a single handshake (HS-001) that demonstrates the format and content expected. In a real adopted project, additional handshakes would accumulate as commits are made. See `specs/PHS-v1.0.md` in the MandelDoc repository for the full protocol.
