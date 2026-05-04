# Mission Classification System — Specification v1.0

## Abstract

The Mission Classification System provides a two-axis taxonomy for classifying project missions by temporal urgency (Priority, P1 through P5) and architectural relationship (Type). Priority and type are orthogonal axes that can be combined freely, enabling precise categorization of any mission regardless of its nature or stage.

## 1. Priorities (P1-P5)

| Level | Label | Meaning | Visibility in MEMORY.md |
|-------|-------|---------|--------------------------|
| P1 | CRITICAL | Active roadmap. Immediate integration into development | Roadmap + Catalog |
| P2 | HIGH | Important, plan soon. Impacts project goals | Roadmap + Catalog |
| P3 | MEDIUM | Valuable, wait for the right moment | Catalog only |
| P4 | LOW | Available when convenient | Catalog only |
| P5 | NOTE | Embryonic idea for the future | Catalog only |

Only P1 and P2 missions appear in the Roadmap (MEMORY.md Section 9). All missions, regardless of priority, appear in the Catalog (MEMORY.md Section 10).

## 2. Types

| Type | Meaning | File Location |
|------|---------|---------------|
| ROOT | Trunk mission on the main development line | `missions/mis-XXX-slug.md` |
| BRANCH | Child sub-mission of another mission (shares its scope) | `missions/mis-XXX-parent/mis-YYY-slug.md` |
| SATELLITE | Independent parallel project, not on the critical path | `missions/mis-XXX-slug.md` |
| NOTE | Minimal record of a future idea without defined scope | `missions/mis-XXX-slug.md` |

A BRANCH mission always resides inside its parent mission's folder. ROOT, SATELLITE, and NOTE missions reside at the top level of the `missions/` directory.

## 3. Orthogonality Principle

Priority and type are independent axes. Any combination is valid:

- A SATELLITE can be P1 if it becomes critical to the project timeline.
- A ROOT can be P3 if it is postponed in favor of more urgent work.
- A BRANCH can be P2 while its parent ROOT is P3.

**Priority** reflects temporal urgency: how soon must this mission be addressed. **Type** reflects architectural relationship: how this mission relates structurally to other missions in the project graph.

## 4. Reclassification Rules

Any mission can be reclassified at any time. The following rules govern state transitions:

- **Promoted to P1 or P2:** Add the mission to the MEMORY.md Roadmap (Section 9).
- **Demoted from P1 or P2:** Remove from the Roadmap; retain in the Catalog.
- **Type changed to BRANCH:** Move the mission file into the parent mission's folder. Set the parent reference in METADATA.
- **Type changed from BRANCH to another type:** Move the mission file out to the `missions/` root directory. Remove the parent reference from METADATA.
- **All reclassifications** must be logged in the mission's progress log with the date, previous classification, new classification, and reason.

## 5. File-to-Folder Promotion

Every mission starts as a flat file: `mis-XXX-slug.md`. When a mission receives its first BRANCH sub-mission, the flat file is promoted to a folder:

1. Create the folder `mis-XXX-slug/`.
2. Move the original file inside: `mis-XXX-slug/mis-XXX-slug.md`.
3. Create the new sub-mission inside: `mis-XXX-slug/mis-YYY-sub.md`.

Maximum nesting depth is three levels: `missions/parent/child/grandchild.md`. IDs are always global and sequential (MIS-001, MIS-002, MIS-003...), never nested or scoped to a parent.

## 6. ID Convention

- **Format:** `MIS-XXX` where XXX is a zero-padded three-digit number.
- **Sequence:** Strictly sequential. IDs are never reused, even if the original mission is deleted or archived.
- **Scope:** Global across the entire project. There is no per-parent or per-type numbering.
- **Next available ID:** Determined by consulting the highest existing entry in the MEMORY.md Catalog (Section 10) and incrementing by one.

## 7. Catalog Organization (in MEMORY.md Section 10)

The Catalog in Section 10 of MEMORY.md serves as the complete inventory of all missions. Recommended structure:

**Active missions**, grouped by type:

| MIS-XXX | Title | Priority | State | File Path |
|---------|-------|----------|-------|-----------|

Organize entries under subsections: ROOT missions, BRANCH missions (indented under their parent), SATELLITE missions, and NOTE missions.

**Completed missions** in a separate subsection at the end of the Catalog, preserving their original classification for historical reference.

Every mission, regardless of priority or type, must have an entry in the Catalog. The Catalog is the single source of truth for the existence and classification of all missions in the project.

## 8. Versioning

Classification System v1.0. All changes within the v1.x line will be backward compatible. New priority levels, types, or fields may be added in minor versions without breaking existing mission files or catalog entries.
