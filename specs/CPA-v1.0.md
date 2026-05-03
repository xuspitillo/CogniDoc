# Consult-Plan-Autonomy (CPA) — Specification v1.0

## Abstract

CPA is the default operational protocol for every LLM request in a CogniDoc-managed project. It ensures precision, efficiency, and zero errors from context overflow by routing every task through three mandatory phases: Consultation, Planning, and Autonomous Execution. The pipeline activates automatically on every request — the user never needs to invoke it.

---

## 1. Overview

The CPA pipeline defines a strict three-phase sequence:

```
Phase C (Consult) -> Phase P (Plan) -> Phase A (Autonomy)
```

Every request passes through all three phases. Phase C may resolve instantly (no consultation needed) or produce a single questionnaire. Phase P produces an actionable plan. Phase A executes it. The pipeline is infrastructure — transparent to the user and mandatory for the agent.

---

## 2. Phase C — Intelligent Consultation

### 2.1 Trigger

Automatically on receiving any request, before elaborating or executing any plan.

### 2.2 Flow

1. **Autonomous feasibility analysis.** The agent evaluates whether it has sufficient context to produce an optimal plan without user input. Evaluation criteria:
   - Ambiguity of the request (high -> consult, low -> autonomous)
   - Number of possible interpretations (>1 -> consult)
   - Impact on sensitive files (cognitive documents, configuration) — evaluate with heightened caution
   - Design decisions that only the user can make
   - Risk of wasted work if direction is incorrect

2. **Binary decision:**
   - **Sufficient context** -> advance directly to Phase P, documenting why no consultation was needed
   - **Insufficient or beneficial to consult** -> generate a single, complete questionnaire

3. **Single questionnaire rules:**
   - Analyze the ENTIRE request and identify ALL points of ambiguity or decision
   - Generate ONE questionnaire covering everything — NEVER fragment into multiple rounds
   - Each question includes: why it is being asked, concrete options if applicable, and the impact of each option
   - Questions are ordered by dependency (answers to earlier questions may constrain later ones)

### 2.3 Principles

- Minimize user interruptions: ask once, ask well.
- When in doubt, lean toward consultation over assumption.
- A skipped consultation must be justified (the justification is part of the audit trail).

---

## 3. Phase P — Action Plan

### 3.1 Trigger

After Phase C completes (with or without consultation), before any modification to files or state.

### 3.2 Flow

1. **Change inventory:** exhaustive list of files to create, modify, or delete.
2. **Operation order:** logical execution sequence respecting inter-file dependencies.
3. **Memory impact:** cognitive documents affected (memory files, mission files, signal registry, configuration).
4. **Propagation requirements:** cascade updates derived from the planned changes.
5. **Computational load estimate:** projected volume of work and proactive detection of operations requiring segmentation.
6. **Risk analysis:**
   - Zombie process prevention — identify operations that could remain incomplete and plan rollback
   - Circular dependency detection
   - Blocked or contested file anticipation
   - Context-limit estimation — if the plan exceeds single-execution capacity, segment before starting
   - Side-effect sweep — verify from the full project perspective that no secondary effect is left uncovered

7. **Segmentation into packages** (if applicable): see Section 5.

### 3.3 Plan Execution

- **Default:** the plan executes directly (autonomous mode).
- **If the user requested review:** present the plan for explicit approval before proceeding.

---

## 4. Phase A — Orchestrated Autonomy

### 4.1 Trigger

After Phase P. This is the actual execution of the plan.

### 4.2 Flow

1. **Sequential or parallel execution** according to the dependency graph defined in the plan.
2. **Post-operation verification:** each operation is validated before the next one begins.
3. **Automatic propagation:** cascade updates to cognitive documents are integral to execution, not a follow-up step.
4. **Light audit:** coherence check across all affected documents upon completion.

---

## 5. Package Orchestration (Autonomous Mode)

### 5.1 When It Activates

- Tasks affecting more than five files simultaneously.
- Read/write operations approaching or exceeding context limits.
- Tasks with independent, parallelizable subtasks.
- Any operation where volume-related error risk is non-trivial.

### 5.2 Package Protocol

1. **Intelligent segmentation.** Divide the plan into atomic packages. Each package has:
   - A single, verifiable objective
   - Self-contained scope (no reliance on ambiguous intermediate state)
   - A validatable partial result
   - Manageable size (does not risk exceeding token or compute limits)

2. **Parallel execution** for packages with no mutual dependencies.
3. **Sequential execution** for packages with ordering constraints.
4. **Integration and final validation** after all packages complete:
   - Verify coherence of the aggregated result
   - Execute propagation to cognitive documents
   - Confirm completion with an executive summary

### 5.3 Error Prevention

- **Proactive detection:** before launching a package, estimate whether the read/write volume is manageable.
- **Automatic partition:** if a package proves too large, subdivide it without waiting for failure.
- **Token consumption as risk vector:** treat context usage as a risk to manage actively, not a limit to discover by error.
- **Fallback re-segmentation:** on failure, re-segment the package with additional margin and relaunch.

---

## 6. Application by Request Type

| Request Type | Phase C | Phase P | Phase A | Package Mode |
|---|---|---|---|---|
| **Simple** (1-2 files) | Quick evaluation; no consult if clear | Inline plan (not explicitly stated) | Direct execution + propagation | N/A |
| **Medium** (3-5 files) | Evaluation; consult if ambiguous | Explicit plan with inventory | Sequential execution | Optional if parallelism exists |
| **Complex** (>5 files or multi-layer) | Mandatory consult if design decisions exist | Full plan with segmentation | Orchestrated via packages | **Mandatory** |
| **Cognitive / sensitive** | Evaluation with reinforced caution | Cross-document impact analysis | Execution with reinforced post-op verification | By volume |

---

## 7. Best Practices

1. **Always document why Phase C was skipped** when the agent determines context is sufficient. The justification is part of the verifiable audit trail.
2. **Plans must be specific enough to execute without interpretation.** Vague plans produce vague results. Each entry in the change inventory should name a file and describe the operation.
3. **Post-operation verification is not optional.** Every completed operation is validated before the next begins. No batch-and-hope.
4. **Propagation is part of execution, not a follow-up task.** Cascade updates to memory and cognitive documents happen inside Phase A, not after it.
5. **Segment before failure, not after.** If the plan is large enough to risk context-limit errors, divide it during Phase P — do not wait for Phase A to fail.
6. **One questionnaire, one round.** Phase C produces at most one questionnaire. If the agent needs to ask, it asks everything at once.

---

## 8. Versioning

This document defines **CPA v1.0**. Future versions within the v1.x line maintain backward compatibility: any project configured for v1.0 will operate correctly under v1.x without modification.
