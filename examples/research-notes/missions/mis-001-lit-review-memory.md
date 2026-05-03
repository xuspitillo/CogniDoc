# MIS-001 -- Literature Review: Agent Memory Systems

## METADATA [*(LIT.W1.DEF>MIS-001)*]

- **ID:** MIS-001
- **Slug:** lit-review-memory
- **Priority:** P1 (Critical)
- **Type:** ROOT
- **State:** ACTIVE [*(LIT.W1.SIG>SR.SIG-001)*]
- **Created:** 2026-03-10
- **Dependencies:** None (foundational thread)
- **Linked missions:** MIS-002 (feeds comparison dimensions), MIS-003 (paper selection for reproduction)

---

## Objective

Conduct a systematic literature review of memory systems in LLM-based autonomous agents (2024-2026). Produce a structured taxonomy of memory architectures, identify convergent design patterns, and write a synthesis document suitable for inclusion in a survey paper.

---

## Phase Checklist

### Phase 1 -- Paper Collection and Initial Reading (COMPLETE)
- [x] Define search queries and inclusion/exclusion criteria
- [x] Run systematic search across Semantic Scholar, arXiv, ACL Anthology
- [x] Snowball sampling from Wang et al. 2024, Xi et al. 2025 reference lists
- [x] Screen abstracts -- 63 candidates identified, 47 passed initial screen
- [x] Read and create structured notes for top-priority papers (20 target)

### Phase 2 -- Pattern Extraction and Taxonomy (IN PROGRESS)
- [x] Identify memory architecture categories (result: 5 preliminary patterns)
- [x] Map each reviewed paper to architecture category
- [ ] Complete reading notes for remaining 16 papers without structured notes
- [ ] Validate taxonomy against edge cases (hybrid architectures, multi-agent memory)
- [ ] Draft taxonomy visualization (table or diagram)

### Phase 3 -- Synthesis and Writing
- [ ] Write synthesis narrative (target: 3000-4000 words)
- [ ] Create comparison table: paper x memory type x retrieval method x evaluation
- [ ] Identify and document research gaps with evidence
- [ ] Internal review pass: check every claim traces to source paper(s)
- [ ] Format citations in ACL style via Zotero export

---

## Architecture Patterns Identified (Preliminary) [*(FND.W2.DEF>MIS-001)*]

1. **Sliding Window Buffer** -- Fixed-size context window with recency bias. Used by early ReAct variants. Simple but loses long-term information. (Yao et al. 2024, Shinn et al. 2024)

2. **Retrieval-Augmented Memory** -- External vector store queried at each reasoning step. Dominant pattern in 2024-2025. Scalable but retrieval quality bottlenecks performance. (Park et al. 2024, Zhong et al. 2025)

3. **Hierarchical Compression** -- Multi-tier memory with summarization between tiers. Working memory (full context) feeds into compressed episodic memory feeds into abstract semantic memory. (Packer et al. 2024 "MemGPT", Lee et al. 2025)

4. **Persistent Scratchpad** -- Structured external document the agent reads and writes explicitly. Unlike vector retrieval, the agent controls organization. (Wang et al. 2024 "Voyager", Sumers et al. 2025)

5. **Graph-Structured Memory** -- Knowledge graph updated during reasoning. Entities and relations rather than text chunks. Promising for multi-hop reasoning but high maintenance cost. (preliminary -- only 2 papers, needs more evidence)

---

## Progress Log

### 2026-04-15 -- Phase 1 Complete, Phase 2 Started [*(LIT.W2.HIT>MIS-001)*]

Completed initial reading of 20 priority papers. Search yielded 63 candidates from systematic queries plus snowball sampling. After abstract screening, 47 papers passed inclusion criteria. Created structured reading notes for 31 papers total (20 priority + 11 additional from early screening rounds).

Key finding from Phase 1: memory architectures cluster more cleanly than expected. Initial taxonomy draft has 5 categories with good coverage. The retrieval-augmented pattern (Pattern 2) dominates the literature -- 19 of 31 noted papers use some variant. Hierarchical compression (Pattern 3) is the most novel and underexplored, with only MemGPT and 3 follow-up papers.

Updated MEMORY.md S4 and S9. Signal SIG-001 transitioned from creation to Phase 2 active.

### 2026-04-28 -- Pattern Mapping Progress [*(FND.W2.EVL>MIS-001)*]

Mapped 28 of 31 structured papers to architecture categories. Three papers resist clean categorization -- they combine retrieval-augmented (Pattern 2) with hierarchical compression (Pattern 3) in ways that may constitute a 6th pattern ("Retrieval + Compression Hybrid") or may be better understood as instantiations of Pattern 3 with retrieval as the inter-tier mechanism. Flagged for deeper analysis.

Also noted a methodological gap: only 8 of 31 papers evaluate memory systems in isolation (controlled ablation). The rest evaluate the full agent pipeline, making it impossible to attribute performance gains to the memory system vs. planning or tool-use improvements. This is a significant finding for the research gaps section and relevant to MIS-002 (comparison framework -- need an "evaluation methodology" dimension). Updated MIS-002 linked notes.

Remaining work for Phase 2: finish notes on 16 remaining papers, resolve the hybrid pattern question, draft taxonomy visualization. Estimate 2-3 more sessions to complete Phase 2.
