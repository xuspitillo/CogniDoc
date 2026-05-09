# Semantic Beacon System (SBS) — Specification v1.0

## Abstract

SBS is a network of inline semantic tags embedded organically throughout project documentation that enables LLM agents to navigate, filter, and cross-reference knowledge without reading entire documents. Each beacon encodes four dimensions — domain, weight, role, and destination — allowing an agent to assess the importance, context, function, and connections of any fragment of information in a single glance.

---

## 1. Beacon Format

### 1.1 Simple Beacon

```
[*(DOMAIN.WEIGHT.ROLE>DESTINATION)*]
```

| Component | Purpose |
|-----------|---------|
| `DOMAIN` | Semantic context of the tagged fragment (3-letter code) |
| `WEIGHT` | Attention priority for the reading agent (W1 through W5) |
| `ROLE` | Functional classification of the information (3-letter code) |
| `DESTINATION` | Cross-reference target the beacon points to |

Example: `[*(ARC.W1.DEF>S3)*]` marks a critical architectural definition that references Section 3.

### 1.2 Pack Beacon

```
[*(DOM.W.ROL>DEST | DOM.W.ROL>DEST)*]
```

A pack beacon combines multiple dimensions separated by ` | `. It signals high semantic density: the annotated paragraph connects multiple domains, roles, or destinations simultaneously.

Example: `[*(SEC.W1.DEC>S2 | ARC.W2.DEP>MIS-004)*]` marks a critical security decision referencing Section 2 that also carries a high-priority architectural dependency on mission MIS-004.

### 1.3 Syntax Rules

- Beacons are **inline** — embedded within the text they annotate, not in separate metadata blocks.
- Always wrapped in `[*( )*]` delimiters.
- Components within a single beacon are separated by dots (`.`), with the destination preceded by `>`.
- Pack components are separated by ` | ` (space-pipe-space).
- Beacons carry no executable semantics; they are passive navigation aids consumed by reading agents.

---

## 2. Domains

Domains identify the semantic context of the tagged fragment. The following table defines the 10 default domains.

| Code | Name | Coverage |
|------|------|----------|
| ARC | Architecture | Layers, patterns, structural design |
| SRV | Services | Infrastructure, containers, operational services |
| COG | Cognitive | Memory system, self-awareness, beacons, missions |
| HW | Hardware | GPUs, VRAM, monitoring, physical resources |
| AI | AI Processes | Training, quantization, inference, models |
| EXT | External | Integrations, webhooks, third-party services, cloud |
| SEC | Security | Authentication, encryption, communication tiers |
| BIZ | Business | Products, domains, commercial strategy |
| UI | Interface | Dashboard, web, UX, templates |
| DAT | Data | Persistence, databases, caches, event systems |

Domains are customizable. Projects may add, remove, or redefine domains to match their specific knowledge topology (see Section 8).

---

## 3. Weights

Weights encode the attention priority an LLM agent should assign to the tagged fragment.

| Weight | Meaning | Implicit Instruction |
|--------|---------|----------------------|
| W1 | Critical | Always read. Fundamental definition or constraint. |
| W2 | High | Read when the working context is relevant. |
| W3 | Medium | Consult when deeper understanding is needed. |
| W4 | Low | Read only when seeking specific detail. |
| W5 | Note | Ignore unless performing a directed search. |

Weights are relative within a project. A W1 beacon in one document is not inherently more important than a W1 in another; both signal maximum local priority within their respective contexts.

---

## 4. Roles

Roles classify the function of the information a beacon annotates.

| Code | Role | What It Marks |
|------|------|---------------|
| DEF | Definition | What something IS — a fundamental concept or specification |
| DEC | Decision | Why something was chosen — architectural or design justification |
| DEP | Dependency | Requires or depends on another element |
| REF | Reference | See also — related content located elsewhere |
| HIT | Milestone | A checkpoint reached or a deliverable completed |
| PAT | Pattern | A reusable pattern, exportable to other contexts |
| RIS | Risk | An identified threat or applied mitigation |
| EVL | Evolution | A change, progression, or transformation of something prior |
| SIG | Signal | A state transition of a tracked process or mission |

---

## 5. Destinations

Destinations specify where a beacon points. The format after `>` is flexible but follows conventions.

| Format | Points To |
|--------|-----------|
| `>MIS-XXX` | A specific mission or tracked work item |
| `>SN` | Section N of a primary document (e.g., `>S3` for Section 3) |
| `>SR` | The project's signal registry (state tracking ledger) |
| `>SR.SIG-NNN` | A specific signal entry in the registry |
| `>custom-slug` | Any project-defined target (chapter, appendix, module) |

Destination identifiers are project-defined. The only requirement is internal consistency: every destination referenced by a beacon must resolve to an actual location in the project documentation.

---

## 6. Usage Protocol

The following numbered protocol defines how an LLM agent should interact with beacons.

1. **When reading a document:** Scan for W1 beacons first. They establish foundational context and should be processed before any other content.
2. **When searching for information:** Filter by the relevant domain code. For example, when working on security, prioritize fragments tagged with `SEC.*`.
3. **When following references:** Beacons with role `REF` point to complementary content. Follow them only when the referenced material is necessary for the current task.
4. **When updating documents:** Verify that existing beacons remain accurate after edits. If the content changes domain, weight, or destination, update the beacon accordingly.
5. **When creating new content:** Insert beacons at semantically dense points — definitions, decisions, milestones, and dependency declarations.
6. **When encountering pack beacons:** Treat them as indicators of high information density. The annotated paragraph connects multiple domains or concerns and may require reading across several areas.
7. **When resolving destinations:** Treat unresolvable destinations as documentation debt. Log them for correction but do not halt processing.

---

## 7. Examples

### A critical definition (W1, simple beacon)

> The event bus is the central asynchronous communication layer between all services. Every service publishes domain events to the bus and subscribes to events it depends on. `[*(ARC.W1.DEF>S5)*]`

The beacon marks this paragraph as a critical architectural definition and points the reader to Section 5 for the full specification.

### A cross-domain decision (pack beacon)

> We chose PostgreSQL over SQLite for the metadata store because the system requires concurrent writes from multiple services and transactional integrity across the event pipeline. `[*(DAT.W1.DEC>S4 | SRV.W2.DEP>MIS-012)*]`

The pack beacon signals that this decision is a critical data-layer justification (referencing Section 4) and simultaneously a high-priority service dependency tied to mission MIS-012.

### A reference to related content

> The authentication flow is documented in the security architecture section. `[*(SEC.W3.REF>S7)*]`

A medium-weight reference beacon that directs the agent to Section 7 only if deeper security context is needed.

### A milestone with evolution

> Migrated from REST polling to WebSocket push for real-time updates. Latency reduced from 2s to 80ms. `[*(ARC.W2.EVL>MIS-005)*]`

An evolution beacon documenting an architectural change tied to a specific mission.

### Placement in mission and handshake files

Mission files (`missions/mis-XXX-slug.md`) and handshake files (`handshakes/hs-NNN-YYYY-MM-DD-slug.md`) carry beacons in two specific positions, both **inline and visible to a reader** — never hidden inside an HTML comment.

1. **Next to the file's main heading (level 1)**, expressing what the file *is*. Example for a mission:

   ```markdown
   # MIS-001 — Define MVP Scope [*(BIZ.W1.DEF>SR.SIG-001 | COG.W1.DEF>S10)*]
   ```

   The pack beacon signals that this file is the canonical definition of mission MIS-001 (BIZ domain, weight W1) cross-referenced from the signal registry SIG-001 and from the project memory catalog (COG domain, S10).

2. **Inside the metadata block as an explicit `Beacon` field**, when the file follows the metadata-table convention provided by the templates:

   ```markdown
   | Beacon | `[*(BIZ.W1.DEF>SR.SIG-001)*]` |
   ```

   The beacon here is wrapped in inline code (backticks) so it renders literally and is not consumed by markdown processors.

**Anti-pattern:** placing the beacon inside an HTML comment (`<!-- [*(...)*] -->`). This hides it from human readers and from the SBS validator, defeating the purpose. If a beacon belongs to the file, expose it in plain markdown next to the heading or in the metadata table.

---

## 8. Customization Guide

Projects adopt SBS by defining a domain table tailored to their knowledge topology. Rules for custom domains:

1. **Code format:** Exactly 3 uppercase letters (e.g., `FIN`, `MKT`, `OPS`).
2. **Uniqueness:** No two domains may share the same code within a project.
3. **Coverage description:** Each domain must include a concise coverage statement that defines its semantic boundary.
4. **No conflicts with roles or weights:** Domain codes must not collide with role codes (`DEF`, `DEC`, etc.) or weight labels (`W1`-`W5`).
5. **Documentation:** The project's domain table must be documented in a location accessible to all reading agents (typically the project's cognitive bootloader or root configuration).

Custom domains coexist with the defaults. Projects may use the 10 default domains as-is, extend them, or replace them entirely. The only invariant is that every beacon in the project uses a domain code defined in the project's domain table.

---

## 9. Versioning

This document defines **SBS v1.0**.

- All future v1.x releases will maintain full backward compatibility: beacons written under v1.0 will remain valid and correctly interpreted under any v1.x parser or protocol.
- New domains, roles, or destination conventions introduced in minor versions will be additive, never breaking.
- A major version increment (v2.0) would be required for changes to the core syntax (`[*( )*]` delimiters, component separators, or dimensional structure).
