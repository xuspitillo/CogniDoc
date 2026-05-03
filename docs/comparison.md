# CogniDoc vs Alternatives

## The Landscape

The AI tooling space is rich with solutions that address fragments of the problem CogniDoc solves: memory, retrieval, orchestration, automation. None address the full picture -- a coherent, living cognitive layer that gives LLMs persistent awareness of an entire project's state, history, and direction.

This document provides an honest comparison. No tool is universally better or worse. The right choice depends on the problem you are solving.

## Comparison Matrix

| Dimension | CogniDoc | RAG Systems | LangChain/CrewAI | n8n/Make | Custom Memory | Plain Prompts |
|---|---|---|---|---|---|---|
| **Session persistence** | Yes -- memory files persist across sessions, models, and providers | Partial -- vector store persists but lacks structured state | No -- state resets per run unless custom persistence is added | No -- workflows are stateless by design | Partial -- depends entirely on implementation quality | No -- context dies with the session |
| **Project state tracking** | Yes -- missions, phases, signals, and roadmaps with formal state machine | No -- RAG retrieves content, does not track state | Partial -- agent memory modules exist but lack project-level structure | No -- tracks workflow runs, not project state | Partial -- possible but typically ad-hoc and fragile | No -- no mechanism for tracking state |
| **Document coherence guarantee** | Yes -- cross-document propagation with audit protocols ensure zero drift | No -- chunks are independent; no coherence layer | No -- no built-in coherence verification | No -- no document awareness | No -- coherence is manual and error-prone | No -- prompt and reality diverge silently |
| **Semantic navigation** | Yes -- beacon system (SBS) lets LLMs filter by domain, weight, and role | Partial -- embeddings provide similarity search, not structured navigation | No -- no semantic indexing of project knowledge | N/A | No -- navigation is custom-coded or absent | No -- LLM must scan everything linearly |
| **Mission/task classification** | Yes -- formal taxonomy (priority P1-P5, type RAIZ/RAMA/SATELITE/NOTA) | N/A | Partial -- task decomposition exists but without persistent classification | Partial -- workflow categories, not mission-level | No -- typically flat task lists | No |
| **State machine for processes** | Yes -- 5-state machine (ACTIVO/EN PAUSA/EN ESPERA/COMPLETADO/EVOLUCION) with signal protocol | No | No -- agent state is ephemeral | Partial -- workflow states exist but are pipeline-specific | Partial -- can be built but rarely is | No |
| **Cross-document propagation** | Yes -- changes in one document cascade to all dependent documents automatically | No -- no concept of document relationships | No | No | No -- propagation is manual | No |
| **Works with any LLM** | Yes -- protocol is model-agnostic; works via markdown files and system prompts | Partial -- tied to embedding model and vector DB | Partial -- supports multiple LLMs but requires their specific integrations | Yes -- LLM-agnostic workflow execution | Depends -- often tied to specific model or API | Yes -- but effectiveness varies by model |
| **Requires infrastructure** | No -- markdown files in a git repository. No servers, databases, or APIs required | Yes -- vector database, embedding pipeline, retrieval API | Yes -- Python environment, API keys, often a server | Yes -- hosted platform or self-hosted instance | Varies -- often requires database and custom API | No |
| **Learning curve** | Moderate -- protocols require initial reading; templates accelerate onboarding | Moderate -- requires understanding embeddings, chunking, retrieval tuning | High -- framework abstractions, agent design, tool configuration | Low-Moderate -- visual workflow builder with learning curve for complex flows | High -- building from scratch requires deep understanding | Low -- just write prompts |
| **Team collaboration** | Yes -- git-native; teams collaborate on memory files like code | Partial -- shared vector store, but no structured collaboration protocol | No -- agent configs are typically single-developer | Yes -- shared workflows with versioning | Partial -- depends on implementation | No -- prompts live in individual sessions |
| **Cost** | Low -- files in a repo. No compute beyond the LLM you already use | Medium-High -- vector DB hosting, embedding compute, retrieval API calls | Medium -- framework is free but requires compute for agents and tools | Medium -- platform subscription fees | Variable -- development and maintenance cost | Free -- but scales poorly |

## Detailed Comparisons

### vs RAG (Retrieval-Augmented Generation)

RAG retrieves relevant chunks from a corpus to answer questions. CogniDoc maintains a coherent, living project state that evolves with the project.

- **Retrieval vs. awareness.** RAG answers "what exists in my documents?" CogniDoc tracks what is happening, what changed, what depends on what, and what comes next.
- **Infrastructure.** RAG requires a vector database, an embedding pipeline, and a retrieval API. CogniDoc requires markdown files in a git repository.
- **Coherence.** RAG has no concept of document coherence -- chunks are independent fragments. CogniDoc guarantees cross-document consistency through propagation protocols.
- **Complementary.** You can use RAG inside a CogniDoc-managed project. RAG handles retrieval over large corpora; CogniDoc handles structured project cognition. They solve different problems.

### vs Agent Frameworks (LangChain, CrewAI, AutoGen)

Agent frameworks orchestrate tool calls and multi-step reasoning. CogniDoc provides the project structure and cognitive layer those agents operate on.

- **Without CogniDoc:** agents execute tasks but forget what they did. Each session starts from zero. Project knowledge lives nowhere persistent.
- **With CogniDoc:** agents follow operational protocols, update mission files, emit state signals, and maintain coherent project memory. The next agent -- or the next session -- picks up exactly where the last one left off.
- **Scope.** Agent frameworks are execution engines. CogniDoc is the cognitive substrate. One handles "how to do things"; the other handles "what the project knows about itself."
- **Complementary.** Use LangChain or CrewAI for multi-step tool orchestration. Use CogniDoc to give those agents persistent, structured awareness of the project they are working on.

### vs Workflow Engines (n8n, Make, Zapier)

Workflow engines automate data pipelines, integrations, and triggers. CogniDoc manages cognitive state -- what the project is, where it stands, and what matters.

- **Automation vs. awareness.** n8n can trigger an action when a webhook fires. It cannot tell you what mission that action belongs to, what state that mission is in, or what documents need updating as a consequence.
- **Statelessness.** Workflow engines process events. They do not accumulate project knowledge, track mission progress, or maintain document coherence.
- **Complementary.** Workflow engines handle automation plumbing. CogniDoc handles the cognitive layer. You can trigger CogniDoc updates from n8n, or use CogniDoc state to inform workflow decisions.

### vs Custom Memory Layers

Many teams build custom context and memory systems for their LLMs: databases, JSON files, prompt templates, session stores.

- **Fragility.** Custom solutions are typically project-specific, undocumented, and maintained by whoever built them. When that person leaves, the memory system decays.
- **Coherence.** Custom memory rarely includes coherence guarantees. Documents drift. Metrics desynchronize. Nobody notices until something breaks.
- **Reusability.** CogniDoc provides a tested, documented, reusable system with formal protocols that work across projects, teams, and LLM providers.
- **Migration.** CogniDoc templates can absorb existing custom memory into a standardized structure. You do not lose what you built -- you organize it.

### vs Plain Prompt Engineering

Detailed system prompts can teach LLMs to "remember" context, follow conventions, and maintain state. Up to a point.

- **Scaling wall.** As the project grows, the prompt grows. Context windows overflow. Information gets dropped. The LLM starts hallucinating or ignoring instructions buried deep in a 50K-token prompt.
- **Structured navigation.** CogniDoc provides structure: the LLM reads the bootloader once, then navigates to what is relevant via semantic beacons, rather than carrying everything in a single prompt. Memory is distributed across files, not crammed into one context window.
- **Persistence.** Prompts die with the session. CogniDoc memory files persist in git, available to any future session, any model, any team member.

## When NOT to Use CogniDoc

CogniDoc adds structure. Structure has overhead. That overhead is not always justified.

- **One-shot scripts or throwaway projects.** If the project has no future, there is no memory to maintain.
- **Projects where LLMs are not involved.** CogniDoc is a cognitive layer for LLM-assisted development. If no LLM touches your project, there is nothing to give cognition to.
- **Extremely small projects.** A single file with one developer needs a README, not a cognitive system.
- **Very limited context windows.** If your LLM cannot handle at least 8K tokens, the bootloader protocol may not fit. CogniDoc works best with 32K+ context windows.

## The Complementarity Principle

CogniDoc does not replace any tool in your stack. It organizes them.

You can run RAG + LangChain + n8n + CogniDoc together. Each handles a different layer:

- **RAG** retrieves knowledge from large corpora
- **Agent frameworks** orchestrate multi-step task execution
- **Workflow engines** automate integrations and pipelines
- **CogniDoc** provides the persistent cognitive layer -- the project's self-awareness

The result is an AI-assisted development environment where tools do not just execute -- they know what they are doing, why, and what comes next.
