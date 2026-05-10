# Case Study: Production Adoption of CogniDoc on a Local AI Platform

> **Status:** Retrospective case study, written 2026-05-10 against
> CogniDoc v0.3.0. Documents adoption that took place during
> 2026-02-14 to 2026-03-22 (33 days of intensive use).
>
> **Author:** Project lead, [@xuspitillo](https://github.com/xuspitillo).
> Reports observations from the original project where the CogniDoc
> protocols were extracted from. Project name and several technical
> details are anonymized; the methodology and metrics are preserved
> verbatim from internal records.

## TL;DR

CogniDoc was not designed in a vacuum. The five protocols (SBS, PSS, CPA, CLASSIFICATION, PHS) were extracted from a separate, larger project — referred to in this document as **the seed project** — where they emerged organically over five weeks of intensive daily use. By the time CogniDoc was packaged as a separate public release, the seed project had:

- 41 handshakes (HS-001 through HS-041) over 33 days
- 16 signals tracked in the Signal Registry (6 active, 1 paused, 2 waiting, 7 completed at the snapshot date)
- 13 missions across the priority and type taxonomy
- A codebase that grew from ~14,000 to ~41,000 lines of Python under the protocol's management
- 304 API endpoints, 168 Python source files, 17 UI pages
- A 118-page auto-generated PDF manual built by extracting live metrics from the codebase
- A bootloader file (the seed project's equivalent of `COGNIDOC.md`) of 1,188 lines

> **Note on mission ID prefix.** The seed project used `MEM-XXX` internally as the mission ID prefix (a convention specific to that project). For consistency with CogniDoc T1 public — which standardizes on `MIS-XXX` — references in this case study use `MIS-XXX`. The numbers (e.g., MIS-014) match the corresponding internal IDs.

## What "the seed project" is

A self-hosted local AI operations platform integrating multiple model pipelines (text, image, video, audio, text-to-speech) with workflow automation, a real-time dashboard, and a conversational orchestration interface. It runs on local infrastructure with GPU acceleration. At the snapshot date used for this case study, it was at approximately 41,000 lines of Python managing 304 API endpoints across 17 UI pages.

The platform was operational before any cognitive protocol existed. The protocols emerged when the developer noticed that the platform's growth trajectory was making chat-history-as-documentation untenable.

## Before: what the seed project was like without a protocol

Up until 2026-02-14, the project's institutional knowledge lived in exactly two places: the codebase itself, and whatever LLM chat session happened to be active. Three concrete failure modes from that period:

**1. Session amnesia.** Every new LLM session started from zero. The developer had to re-explain what the project was, what it did, what had been decided, and what was in progress. With a codebase at ~14,000 LOC across 80+ files at the time, this context injection consumed significant time and was always incomplete. Some decisions lived only in expired chat sessions and were effectively lost.

**2. Context degradation in long sessions.** As described by the developer (paraphrased):

> "When the development started growing, I noticed Claude Code began making mistakes correcting code when too much context accumulated. From my admittedly non-technical perspective, this seemed to improve a lot once the protocol was in place — things started working as I wanted again."

This matches a known LLM failure mode (context window saturation degrading attention). The implementation of structured documentation gave new sessions a way to load relevant context selectively rather than carrying everything in a single session.

**3. The "skeptical-agent test" as informal validation.** The developer reports that opening a fresh LLM session in a "skeptical reviewer" role over the same repository produced critique demonstrating real understanding, without manual context injection. After protocol adoption this test passed consistently — a poor-man's empirical signal that context preservation across sessions worked.

**The trigger for formalization** was not a single catastrophic incident but the cumulative friction of a codebase outgrowing the developer's capacity to hold it in his head. At 14K LOC and 139 endpoints, this was still possible. The trajectory toward 30K, 40K, 300+ endpoints made chat-history-as-documentation visibly unsustainable. The first formal mission, MIS-001 "Self-awareness," was created on 2026-02-14 with the explicit goal of making the project know itself.

## Adoption timeline

The protocol was not designed first and applied after. It emerged through five formalization milestones over five weeks:

- **2026-02-14**: Founding missions MIS-001 ("Self-awareness") and MIS-002 ("Restructuring") completed. The seed project's `memory/` directory and mission file convention created.
- **2026-02-18**: Semantic Beacon System v1.0 formalized. Handshake naming convention established.
- **2026-02-22**: Auth & Multi-Tenant module shipped (HS-015, included in Appendix A). 10 missions tracked.
- **2026-02-26**: Project Signal System bootstrapped (HS-018). 12 retroactive signals created to capture the state of pre-existing missions.
- **2026-02-27**: PSS v1.0 declared complete (10/10 acceptance criteria met).
- **2026-03-01**: An agent swarm system (named SEA internally) was formalized as a fourth cognitive pillar — extending beyond what would later become CogniDoc T1 public.
- **2026-03-22**: Most recent protocol activity at the snapshot date. Security hardening and KnowledgeCache work in progress.

## Metrics evolution (33 days)

The following table reconstructs the project's growth during the protocol's first 33 days, from data preserved in the handshake chain. **Important note**: the Project Signal System did not exist before 2026-02-26. The first 12 signals (SIG-001 to SIG-012) were created retroactively on that date to formalize the state of missions that already existed. For dates before 2026-02-26, the Signals column is left empty.

| Date | Missions | Signals | Handshakes | LOC | Endpoints | Tests | Key event |
|------|----------|---------|------------|-----|-----------|-------|-----------|
| 2026-02-14 | 2 | — | 0 | ~14,300 | 139 | ~80 | Protocol born; no signal system yet |
| 2026-02-18 | 5 | — | 9 | ~17,000 | 196 | 128 | SBS v1.0 formalized; manual completed |
| 2026-02-22 | 10 | — | 17 | 19,854 | 205 | 158 | Auth module shipped (HS-015) |
| 2026-02-26 | 10 | 12 | 21 | ~20,000 | 205 | 158 | PSS bootstrap: 12 signals created retroactively |
| 2026-02-27 | 11 | 13 | 23 | ~20,000 | 205 | 158 | PSS v1.0 finalized (10/10 criteria) |
| 2026-03-04 | 12 | 15 | 29 | 26,715 | 270 | ~200 | Data paths, TTS, Director Chat |
| 2026-03-14 | 13 | 16 | 35 | 37,574 | ~290 | ~270 | Trading subsystem; SEA formalized |
| 2026-03-22 | 13 | 16 | 41 | 40,964 | 304 | 303 | Security hardening; KnowledgeCache |

Growth during the period:

- LOC: 14K → 41K (2.9x)
- Endpoints: 139 → 304 (2.2x)
- Tests: ~80 → 303 (3.8x)
- Missions: 2 → 13 (6.5x)
- Handshakes: 0 → 41 (avg 1.24/day)
- Signals: 0 → 16 (introduced 2026-02-26)

The largest LOC jump (~27K → 38K, March 4 to March 14) corresponds to the introduction of a trading-subsystem architecture (20 new Python modules covering market data, inference, and execution). The protocol absorbed this rapid growth without losing coherence between documents — arguably the strongest single piece of evidence that the protocol scales under real pressure.

## What worked: five concrete wins

**Win 1 — Context recovery after a 3-week pause (2026-03-19).** A trading subsystem mission (MIS-014 in this case study, MEM-014 internally) was paused due to data-source API costs. The signal registry recorded `[[pause MIS-014]]` with reason "blocked on dataset API cost", linked to the previous handshake (HS-037) which contained the full state at pause time. When the developer later revisits this work, the recovery cost is approximately one minute of reading the relevant handshake plus the mission file — versus the alternative of reconstructing the state from chat history that may no longer exist.

**Win 2 — Mission dependency graph prevented wasted work (2026-02-22).** A workflow-automation mission was marked WAITING because it depended on a different mission (the platform's core) reaching a specific phase. The dependency was made explicit in the mission's METADATA and reflected in the signal registry. When work would have started prematurely on the dependent mission, the WAITING state and the dependency reference made the blocker obvious. Rough estimate of work avoided: several days of premature integration that would have needed to be redone.

**Win 3 — A handshake caught documentation drift before it compounded (2026-02-27).** During the PSS finalization, HS-023's audit phase detected that `MEMORY.md` Section 9 (the active roadmap) listed a mission as "in progress" while the mission file itself showed 10/10 objectives completed. The handshake's pre-commit verification forced the correction in the same commit. Without the handshake protocol's audit step, this drift would have propagated to the auto-generated manual and other downstream documents.

**Win 4 — SBS beacons enabled targeted reading of a 1,188-line bootloader.** The seed project's bootloader file is 1,188 lines (substantially larger than what CogniDoc T1 ships publicly). Without beacons, every session would re-read the full file. With beacons, the LLM filters by domain or weight and reads only relevant sections. Over dozens of sessions, this saves a meaningful amount of context budget — and also reduces cognitive load on the LLM, which keeps attention on what is currently relevant rather than carrying everything.

**Win 5 — The mission promotion pattern preserved cross-references during reorganization (2026-02-17).** When a mission gained its first sub-mission, the file-to-folder promotion pattern (defined in CogniDoc's CLASSIFICATION spec) moved the original mission file into a folder named after the mission and created the sub-mission alongside it. All cross-references, signal links, and beacon destinations remained valid because the protocol formalized this reorganization. Without a defined pattern, the same operation would have broken links throughout the documentation set.

## What did not work: five honest frictions

Frictions are listed prominently because the project's credibility depends on not pretending these do not exist. CogniDoc v0.3.0 has already addressed several of them at the spec level; others remain open and inform v0.4 planning.

**Friction 1 — The full pre-commit verification protocol is too heavy at scale.** The seed project's internal pre-commit protocol specifies six phases including "audit the totality of the ecosystem" before every commit. In a codebase with 13 missions, a 917-line `MEMORY.md`, an 837-line signal registry, an 1,188-line bootloader, a 118-page manual, and a separate self-knowledge document, reading and cross-checking all of these before every commit is prohibitively expensive in time and tokens. In practice, a simplified version is run for routine commits. **The honest measure of friction**: 41 handshakes over 33 days corresponds to ~1.24 handshakes/day, but the project recorded ~59 commits in the same period — meaning approximately 30% of commits did not generate a full handshake despite the protocol specifying "every commit". CogniDoc T1 v0.3.0 addresses this by softening the PHS specification: 3 sections required, 7 recommended. Trivial commits can ship 3-section handshakes within protocol.

**Friction 2 — Manual propagation of metrics is error-prone.** Volatile metrics (endpoint count, LOC, test count, version) are referenced in multiple files: `MEMORY.md` (3 places), several mission files, the self-knowledge document, the auto-generated manual. Updating "304 endpoints" means editing 5-7 places by hand. The seed project has a Python validator (referred to internally as ROP, Record of Propagation) that catches drift but does not auto-propagate. CogniDoc T1 ships specifications and templates without this validator (which is part of the in-private-development T2-style modules, see "Beyond T1" below).

**Friction 3 — The bootloader at 1,188 lines consumes too much context.** The seed project's bootloader is large because protocol details, taxonomies, examples, and propagation rules all live inside it. CogniDoc T1's public bootloader is substantially shorter (around 350 lines), and the public release has explicit guidance to keep it lean. In retrospect, splitting protocol detail into separate spec files that are read on-demand (which is how T1 ships them: SBS, PSS, CPA, CLASSIFICATION, PHS as separate files) is the right pattern. The seed project will likely be refactored in this direction in a future revision.

**Friction 4 — Handshake generation adds 10-15 minutes per commit.** Each handshake requires reading the previous one, computing the delta, writing a comprehensive narrative, and updating counters. For a trivial two-file fix, this overhead is disproportionate. CogniDoc T1 v0.3.0's softening (3 required + 7 recommended sections) was a direct response to this friction.

**Friction 5 — Master-document verification can create circular dependencies.** The seed project has designated master documents (the manual, the self-knowledge document) with a coherence obligation: any commit must verify these are coherent with the rest of the documentation. But updating those master documents is itself a commit, which then needs verification, which may require updating them again. This recursion has caused sessions to spend more time on documentation ceremony than on development. CogniDoc T1 deliberately does not specify master-document machinery in its public release; the concept is reserved for higher tiers where programmatic enforcement makes the recursion tractable.

## Beyond T1: what the seed project extended

The CogniDoc public release ships the protocol specifications, templates, examples, and lightweight shell tooling. The seed project, in addition, has developed internally:

- **An agent swarm system** (a 5-role taxonomy: Explorer, Architect, Builder, Auditor, Propagator) with pre-deployment evaluation logic for parallel task execution
- **A pre-commit cognitive gating** protocol — the 6-phase verification mentioned in Friction 1
- **A propagation-validation table** (ROP) that maps each volatile metric to its propagation destinations and validates coherence after edits
- **A formal master-document ecosystem** with active coherence obligations between designated documents
- **Snapshot discipline for historical log entries** — a small but useful convention: progress-log entries that record metrics tag them with `(snapshot YYYY-MM-DD)` to distinguish "value at that time" from "current value", preventing confusion during ROP propagation
- **Seven Python validation modules** (~3,000 LOC total, validated in production over 5+ weeks managing a 40K+ LOC codebase): a beacon parser, a mission parser, a signal state machine implementation, a propagation validator, a mission classifier, a CPA planner, and a memory parser

These extensions exist in private use within the seed project. Productizing them as a separately distributable T2 release is the pending work — no committed timeline. The CogniDoc public repository is where any future announcement will be made.

## What CogniDoc T1 should learn from this adoption

The friction findings above translate directly into CogniDoc T1 evolution priorities for v0.4 and beyond:

1. **Tiered pre-commit depth based on change size.** The "every commit gets the full audit" framing in the public bootloader is unrealistic. Recommend explicit guidance on when full PHS applies vs. when a 3-section handshake suffices. (Partially addressed in v0.3.0 PHS softening; can be made more explicit.)
2. **Honest 1:1 commit-handshake ratio messaging.** CogniDoc T1's PHS spec implies 1:1 handshake-to-commit correspondence. Real adoption (this case study) achieves about 70% in heavy use. The spec should acknowledge this and make the trivial-commit exemption explicit (which v0.3.0 already does in PHS section 3.2 "What Counts as a Commit").
3. **Bootloader leanness as a hard rule.** The public bootloader template should remain under a target line count (e.g., 500 lines). Detailed protocol content lives in `specs/`, read on demand. (T1 already does this; the lesson is to maintain it under contributor pressure.)
4. **Formally define "ROP" (Record of Propagation) in a spec.** The acronym leaks into adopter projects without a clear definition in the public release. v0.4 should add a brief spec covering the propagation pattern (without requiring a programmatic enforcer).
5. **Snapshot discipline pattern.** Historical entries in mission progress logs benefit from an explicit "(snapshot YYYY-MM-DD)" tag. This convention should be documented in T1.
6. **Evolution pattern for completed signals.** The seed project formalized that a COMPLETED signal can spawn a descendant signal (with ancestry tracking) when the underlying work needs to continue beyond completion. This should be added to PSS in a future minor revision.

These six items constitute a concrete v0.4 roadmap derived from real-world friction, not from speculation.

## Conclusion: who should adopt CogniDoc

Based on the seed project's experience, CogniDoc T1 is a fit for projects where:

- The codebase exceeds approximately 5,000 LOC across more than 10 source files, **and**
- Multiple LLM sessions are used over the project's lifetime (i.e., not a single throwaway chat), **and**
- The cost of context loss between sessions is non-trivial (e.g., re-explaining architecture, recovering decisions, rebuilding mental models)

Below that scale, an ad-hoc `CLAUDE.md` (or `.cursorrules`, `AGENTS.md`, etc.) with discipline is likely sufficient and the protocol's overhead is not justified.

CogniDoc T1 is a literacy product. It teaches a convention. The convention has now been validated at production scale on a non-trivial codebase. What remains in private development (the validation modules, the master-document machinery) addresses the frictions that remain at higher scales. Whether and when those become a public T2 release will be decided based on adoption signals from T1 and the maturity of the private modules — there is currently no committed timeline.

This case study will be updated when relevant — with new metrics from continued adoption, with new friction findings, and with notes on which v0.4 priorities have been addressed.

---

## Appendix A — Sample handshake (HS-015, sanitized)

```markdown
# Handshake [PROJECT] — 2026-02-22 — Auth & Multi-Tenant Implementation

## Executive Summary

Session executed in **fully autonomous mode** (zero interactions with the
developer during implementation). Implemented the complete Auth &
Multi-Tenant module, advancing two missions simultaneously:

- **MIS-006** (Corporate Platform): Phases 2-3 substantially completed —
  gateway, security, multi-tenant isolation
- **MIS-009** (Commercial Launch): Technical hardening milestones 1.6-1.10
  completed

**Result:** 15 new files + 18 modified files. The platform goes from 196
to 205 API endpoints, from 88 to 98 source files, from 18,080 to 19,854
LOC, from 128 to 158 tests. Architecture Layer 8 (Auth & Multi-Tenant)
added. Full documentary audit with 0 post-verification discrepancies.
Enterprise manual regenerated. Legal docs (ToS + GDPR Privacy Policy)
updated.

## System State

| Metric              | Value                                |
|---------------------|--------------------------------------|
| Platform Version    | 0.8.2                                |
| API Endpoints       | 205 (196 pre-auth + 9 auth)          |
| Dashboard Pages     | 14                                   |
| Tests               | 158 total (128 existing + 30 auth)   |
| Python LOC (src/)   | 19,854                               |
| Source files        | 98                                   |
| Auth module         | 9 files, 1,462 LOC                   |
| Docker containers   | 7                                    |
| Missions in roadmap | 5 active                             |
| Missions completed  | 4                                    |
| Manual              | 14 chapters + 5 appendices, 111 pp   |

## Changes Since Last Handshake

### Auth Module — 9 files, 1,462 LOC

Three-tier access control:

| Level | Who         | Access                         |
|-------|-------------|--------------------------------|
| 1     | Internal    | Full platform, no restrictions |
| 2     | Partner     | JWT-authenticated API subset   |
| 3     | Client      | API-key, rate-limited, SLA     |

Components: ORM models (Tenant, APIKey, AuditLog), JWT RS256 handler,
API key generation with SHA-256 hashing, Redis sliding-window rate
limiter, multi-tenant schema routing, 3-layer middleware stack
(Auth → BlackBox → Audit), FastAPI dependency injection factories.
9 new API endpoints under /api/auth/*.

Graceful degradation throughout: without JWT library → API-key only;
without Redis → rate limiter fail-open; without database → auth
unavailable, local access unrestricted; AUTH_ENABLED=false → no
middleware mounted, platform operates as before.

### 30 New Tests (158 total)

Covering: key generation, JWT creation/validation/expiry, tenant
context, rate limiting, scope checking, auth dependencies, schema
validation, ORM serialization.

## Documentary Audit

| Metric          | Pre-Auth | Post-Auth | Delta  |
|-----------------|----------|-----------|--------|
| API Endpoints   | 196      | 205       | +9     |
| Source files    | 88       | 98        | +10    |
| LOC             | 18,080   | 19,854    | +1,774 |
| Tests           | 128      | 158       | +30    |
| Lifespan phases | 10       | 11        | +1     |
| Arch layers     | 7        | 8         | +1     |

15 documents verified for metric consistency. 14 discrepancies found
and corrected across mission files, memory core, self-knowledge doc,
and manual chapters. Post-correction: 0 discrepancies. Manual PDF
regenerated.

## Decisions Taken

| Decision                      | Justification                                    |
|-------------------------------|--------------------------------------------------|
| Auth as "spectacular advance" | Maximum impact: advances 2 missions simultaneously |
| JWT RS256 (asymmetric)        | Public key distributable without exposing private  |
| API Keys SHA-256              | Identifiable prefix, irreversible hash, never plaintext |
| Rate limiter Redis sorted sets| Precise sliding window, atomic pipeline, fail-open |
| 3 middleware layers           | Separation of concerns: auth → filtering → audit  |
| Graceful degradation          | Existing platform pattern: everything optional     |
| Autonomous mode               | Developer requested max-impact advance without consultation |

## Mission Impact

| Mission   | Impact |
|-----------|--------|
| MIS-003   | +1 arch layer, +9 endpoints, +30 tests. Auth integrated |
| MIS-006   | Phases 2-3 substantially advanced: gateway, JWT, API Keys, rate limiting, tenant isolation |
| MIS-009   | 5 technical hardening milestones completed. Legal docs updated |

## Warnings and Risks

| Risk                          | Mitigation                              |
|-------------------------------|------------------------------------------|
| Auth not tested in production | Unit + contract tests. Missing: integration test with real DB + Redis |
| JWT keys only in local dir    | Manual backup needed. Consider secrets manager |
| Rate limiter fail-open        | Design decision (local-first). Consider fail-closed for critical endpoints in production |
| Legal docs are drafts         | Require lawyer review before real use    |

*End of handshake — Generated 2026-02-22. Autonomous session.*
```

---

*Case study generated 2026-05-10. Project lead: [@xuspitillo](https://github.com/xuspitillo). Original project name and several technical details anonymized. Metrics and methodology preserved verbatim from internal records.*
