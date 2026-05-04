# CogniDoc --- Glossary

This glossary defines the key terms used across CogniDoc documentation, specifications, and templates.

## Beacon
An inline semantic tag embedded in documentation. Format: `[*(DOM.W.ROL>DEST)*]`. Enables LLMs to navigate by importance, domain, and role without reading entire documents. See `specs/SBS-v1.0.md`.

## Bootloader
The `COGNIDOC.md` protocol file at the root of a CogniDoc-managed project. Read by the LLM at session start. Defines how to navigate, update, and operate on the project's memory and documentation.

## Branch (mission type)
A child sub-mission of another mission. Shares scope with its parent. Lives inside the parent mission's folder.

## Catalog
Section 10 of `MEMORY.md`. Contains ALL missions regardless of priority. The complete inventory of every tracked unit of work in the project.

## CPA
Consult-Plan-Autonomy. The three-phase operational pipeline that governs how an LLM processes every request. Ensures precision through structured consultation, planning, and orchestrated execution. See `specs/CPA-v1.0.md`.

## Domain
The semantic area a beacon belongs to (e.g., `ARC` = Architecture, `SEC` = Security). Customizable per project. Expressed as a three-letter code.

## Evolution
A PSS state indicating a new signal derived from a completed one. The original signal stays immutable with a forward pointer; the evolution continues the work as a peer-level entry.

## Handshake
An immutable, chronological narrative checkpoint of the project's state. One handshake is generated **before every commit that changes project content**. Each handshake is self-contained: an LLM that reads only the latest handshake can identify the project, understand its state, and continue work coherently. Handshakes are stored in `handshakes/` at the project root with filenames `hs-NNN-YYYY-MM-DD-slug.md`. The full protocol is in `specs/PHS-v1.0.md`.

## HANDSHAKES.md
The handshake index file at the project root. Mirrors the role of `SIGNAL_REGISTRY.md` for handshakes: a Quick Index table of every handshake (HS-NNN, date, title, optional commit hash) plus the protocol invariants. Updated atomically with every handshake generation, before the commit. See `specs/PHS-v1.0.md` and the `Handshakes: N (latest: HS-N)` counter in `MEMORY.md` footer.

## HS-NNN
A handshake identifier. `HS` is the literal uppercase prefix; `NNN` is a sequential, zero-padded three-digit counter that is never reused. Filenames use the lowercase form: `hs-NNN-YYYY-MM-DD-slug.md`.

## PHS
Project Handshake System. The protocol governing handshake generation: format, immutability, pre-commit trigger, propagation cascade, chain continuity. One of the four foundational CogniDoc protocols (alongside SBS, PSS, CPA). See `specs/PHS-v1.0.md`.

## MEMORY.md
The project's general memory file. Contains 10 sections covering identity, stack, architecture, current state, history, decisions, lessons learned, roadmap (P1-P2), and catalog (all missions).

## Mission
A tracked unit of work with its own memory file (`mis-XXX-slug.md`). Has metadata, objectives, milestones, roadmap, and a progress log. Classified by priority (P1-P5) and type (Root, Branch, Satellite, Note).

## Mission file
The markdown file that IS a mission's memory. Located in the `missions/` directory. Named `mis-XXX-slug.md`. Born as a flat file; promoted to a folder when it receives its first child mission.

## Note (mission type)
A minimal record of a future idea without defined scope. The lightest mission type. Used for embryonic concepts that may later be promoted.

## Pack beacon
A beacon with multiple domain-weight-role-destination tuples separated by `|`. Format: `[*(DOM.W.ROL>DEST | DOM.W.ROL>DEST)*]`. Indicates high semantic density where a paragraph connects multiple domains.

## Phase A
Autonomy. The third CPA phase where the validated plan is executed, each operation is verified, and propagation cascades are applied automatically.

## Phase C
Consultation. The first CPA phase where the LLM evaluates whether it has enough context to proceed or needs to ask clarifying questions.

## Phase P
Plan. The second CPA phase where the change inventory, execution order, impact analysis, and risks are documented before any modification begins.

## Priority (P1-P5)
How urgent a mission is. P1 = Critical (active roadmap), P2 = High, P3 = Medium, P4 = Low, P5 = Note (embryonic idea). Orthogonal to type: a Satellite can be P1 and a Root can be P3.

## Propagation cascade
The chain of updates triggered when a signal is emitted or a volatile metric changes. Flows from registry to mission file to `MEMORY.md` roadmap and catalog.

## PSS
Project Signal System. The protocol for tracking mission and process states using a formal 5-state machine (Active, Paused, Waiting, Completed, Evolution). See `specs/PSS-v1.0.md`.

## Roadmap
Section 9 of `MEMORY.md`. Contains only P1 and P2 missions. Represents the critical path of active development.

## Role
The semantic function a beacon marks. Examples: `DEF` = definition, `DEC` = decision, `DEP` = dependency, `REF` = reference, `PAT` = pattern. Tells the LLM what kind of information the tagged content represents.

## Root (mission type)
A trunk mission on the main development line. The primary mission type for core project work.

## Satellite (mission type)
An independent parallel project not on the critical path. Operates outside the main development line but is tracked with the same rigor.

## SBS
Semantic Beacon System. The network of inline navigation tags embedded throughout project documentation. Enables LLMs to filter by domain, weight, and role without full-document reads. See `specs/SBS-v1.0.md`.

## Signal
A state transition event in the PSS. Five types: create (organic), pause (explicit), wait (external trigger), resume, and complete (immutable).

## Signal Registry
`SIGNAL_REGISTRY.md`. A dedicated file tracking the state of every mission and process. Contains a quick-index table for single-pass scanning and detailed entries with transition history.

## Type (mission)
The architectural relationship of a mission: Root, Branch, Satellite, or Note. Describes how a mission relates to other missions. Orthogonal to priority.

## Weight (W1-W5)
How important a beacon's content is for LLM attention. W1 = Critical (always read), W2 = High (read if relevant), W3 = Medium, W4 = Low (specific detail only), W5 = Note (ignore unless directed).
