# Where MandelDoc fits in the AI-coding-tool ecosystem

MandelDoc is sometimes confused with the per-tool convention files that AI coding tools auto-read at session start. This document clarifies the precise relationship.

---

## MandelDoc is content for slots, not a competitor of slots

Several AI tools auto-read a specific filename from your project root at session start. Each is a **slot**:

| Tool | Slot the tool auto-reads |
|------|--------------------------|
| Claude Code | `CLAUDE.md` |
| Cursor | `.cursorrules` |
| Windsurf | `.windsurfrules` |
| Aider | `CONVENTIONS.md` (and `.aider.conf.yml`) |
| Cline | Project files generally |
| Cross-tool emerging convention | `AGENTS.md` |

These slots are file locations that specific tools watch. Each slot accepts whatever markdown you put in it. They do not compete with each other in any meaningful sense — each tool just looks for its own filename.

MandelDoc is **content you can install into any of these slots**. A typical adoption pattern:

```bash
# 1. Install MandelDoc in your project
cd ~/my-project
/path/to/mandeldoc/tools/init.sh . "My Project"

# 2. If you use Claude Code:
ln -s MANDELDOC.md CLAUDE.md

# 3. If you use Cursor:
ln -s MANDELDOC.md .cursorrules

# 4. If you use Windsurf:
ln -s MANDELDOC.md .windsurfrules

# 5. If you participate in the AGENTS.md emerging convention:
ln -s MANDELDOC.md AGENTS.md
```

Each tool reads its own slot, all slots resolve to the same `MANDELDOC.md` content, and the LLM operates under the same protocol regardless of which tool the human is using.

---

## What MandelDoc actually competes with

The real comparison is not MandelDoc vs `CLAUDE.md`. It is MandelDoc vs the **ad-hoc convention** that most engineers put inside `CLAUDE.md` (or `.cursorrules`, etc.) today: free-form prose with role descriptions, "always do X / never do Y" rules, project-specific notes, and occasional examples. The ad-hoc pattern works for small projects but has known limitations as projects grow.

| Dimension | Ad-hoc `CLAUDE.md` (or any slot) | MandelDoc-installed `CLAUDE.md` |
|-----------|-----------------------------------|--------------------------------|
| Format | Free-form prose, project-specific | Structured protocol with five named systems (SBS, PSS, CPA, Classification, PHS) |
| Project state across sessions | None — each session re-reads the same instructions; project state lives in chat history | `MEMORY.md` and `SIGNAL_REGISTRY.md` track state explicitly; new sessions read state, not transcripts |
| Mission/task structure | Implicit in free prose; no taxonomy | Formal Priority (P1-P5) × Type (ROOT / BRANCH / SATELLITE / NOTE) taxonomy with one file per mission |
| State machine for processes | None | Formal 5-state machine (ACTIVE, PAUSED, WAITING, COMPLETED, EVOLUTION) with explicit signal transitions and an audit-trail history |
| Cross-document propagation | None — each file is independent | Cascade rules ensure that emitting a signal updates the mission file, the signal registry, and the project memory atomically |
| Per-commit audit trail | None | `HANDSHAKES.md` chain with one immutable narrative checkpoint per content-changing commit |
| Navigation by relevance | None — LLM scans the whole file linearly | Inline beacons let the LLM filter by domain (e.g. SEC, ARC), weight (W1-W5), or role (DEF, DEC, REF, RIS, ...) |
| Cross-tool portability | Tool-specific (each tool's slot has bespoke content) | Same `MANDELDOC.md` content can be symlinked into any tool's slot |
| Onboarding cost | Low — just write what you want the LLM to know | Higher — read the bootloader once, follow the conventions thereafter |
| Per-session token cost | Low for small projects, scales poorly as the file grows | Higher base cost (the bootloader is bigger), but the LLM navigates by beacons rather than scanning everything |

**The honest summary:** the ad-hoc pattern is simpler. MandelDoc trades simplicity for structure, persistence, and auditability. Whether the trade is worth it depends on the project. A one-week prototype probably should not bother. A multi-month system with many LLM sessions per day and multiple human collaborators probably benefits.

---

## When NOT to use MandelDoc

Be honest with yourself. Skip MandelDoc when:

- Your project has fewer than ~5 active concerns to track. A single ad-hoc `CLAUDE.md` covers it.
- Your project will live under one human's chat history for its whole lifetime. There is nobody else to hand state off to.
- You want machine-enforced coherence today. Tier 1 is protocol-driven, not enforced. The LLM has to follow the protocol; if it does not (sloppy session, context overflow, a model that ignores instructions), coherence drifts. Programmatic enforcement is planned for Tier 2 but not shipping today.
- You are using a tool where the slot has a strict size limit and a long bootloader does not fit. Some hosted tools cap rules files at a few KB; the MandelDoc bootloader is larger than that.

If any of those apply, ad-hoc `CLAUDE.md` (or `.cursorrules`, etc.) plus discipline is enough. Use MandelDoc when the cost of context loss between sessions is high enough to justify the structure.

---

## Practical compatibility

`MANDELDOC.md` is plain markdown. Any tool that reads markdown files at session start can be pointed at it. The only tool-specific consideration is what filename the tool watches, which is what the symlink pattern above resolves.

If your tool is not in the table above and you want to use MandelDoc with it: name the bootloader whatever your tool expects (or symlink, or copy), and feed it as the LLM's system prompt or first message. The protocol is the protocol; the filename is a delivery detail.
