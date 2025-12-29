# Research: Scaffolding Content Design

**Research Topic:** Transition-Plan Two-Mode Pattern  
**Question:** What should setup mode scaffolding contain vs. leave empty for expand mode?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29  
**Completed:** 2025-12-29

---

## 🎯 Research Question

What should setup mode scaffolding contain vs. leave empty for expand mode?

**Sub-questions:**
- Should phase headers include empty task lists or just headers?
- Should goals be populated in scaffolding or during expansion?
- Should prerequisites be identified in scaffolding?
- What's the minimum viable scaffolding?

---

## 🔍 Research Goals

- [x] Goal 1: Define what "scaffolding" means for transition planning
- [x] Goal 2: Identify the balance between useful structure and premature detail
- [x] Goal 3: Determine which fields should be populated vs. placeholders
- [x] Goal 4: Establish minimum viable scaffolding requirements
- [x] Goal 5: Document scaffolding patterns from similar systems

---

## 📚 Research Methodology

**Sources:**
- [x] Existing phase document template: `docs/PHASE-DOCUMENT-TEMPLATE.md` (297 lines)
- [x] Current `/transition-plan` output patterns (analyzed from command)
- [x] `/research` command scaffolding approach (template vs. conduct comparison)
- [x] Web search: Documentation scaffolding patterns and UX best practices

---

## 📊 Findings

### Finding 1: Phase Document Template is Comprehensive (~300 lines)

The `docs/PHASE-DOCUMENT-TEMPLATE.md` defines a comprehensive phase document structure with 15+ sections:

| Section | Purpose | Lines |
|---------|---------|-------|
| Header | Phase metadata, status, prerequisites | ~10 |
| Overview | What phase delivers, success definition | ~10 |
| Goals | Numbered list of phase goals | ~10 |
| Tasks | TDD flow with RED/GREEN structure | ~80 |
| Completion Criteria | Checklist of requirements | ~15 |
| Deliverables | What gets created/delivered | ~20 |
| Dependencies | Prerequisites, external deps, blocks | ~20 |
| Risks | Risk assessment with mitigation | ~15 |
| Progress Tracking | Status by category | ~15 |
| Implementation Notes | TDD workflow, patterns, examples | ~60 |
| Related Documents | Links to related docs | ~10 |

**Source:** `docs/PHASE-DOCUMENT-TEMPLATE.md` (297 lines)

**Relevance:** Current template tries to do everything at once. Scaffolding should create the structure; expansion should add the detail (especially Tasks and Implementation Notes sections).

---

### Finding 2: `/research` Scaffolding Pattern - Structure vs. Content

The `/research` command demonstrates the proven scaffolding pattern:

**Setup Mode Creates (Scaffolding):**
```markdown
## 📊 Findings

### Finding 1: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]
```

**Conduct Mode Fills (Expansion):**
```markdown
## 📊 Findings

### Finding 1: Flag-Based Mode Switching

The `/research` command uses a flag-based approach to switch between modes...
[actual content with real analysis]

**Source:** `/research` command lines 49-70

**Relevance:** This is the proven pattern we should adopt...
```

**Source:** `/research` command template analysis

**Relevance:** The pattern is clear: **scaffolding = headers + placeholder structure**; **expansion = actual content + detail**. The same approach should apply to phase documents.

---

### Finding 3: Minimum Viable Scaffolding Definition

Based on the `/research` pattern and phase document template analysis, minimum viable scaffolding should include:

**INCLUDE in Scaffolding:**
1. **Header metadata** - Phase number, name, status, prerequisites
2. **Overview placeholder** - What phase delivers (from ADR/source)
3. **Goals** - Extracted from source, may be brief
4. **Task section headers** - Categories identified, but details empty
5. **Completion criteria placeholders** - Key checkpoints identified
6. **Dependencies** - Prerequisites between phases (important for planning)
7. **Estimated effort** - From source

**LEAVE EMPTY for Expansion:**
1. **Detailed task breakdowns** - TDD RED/GREEN structure
2. **Code examples** - Language-specific implementation
3. **Testing commands** - Specific commands to run
4. **Implementation notes** - Patterns, workflows, tips
5. **Risk assessment** - Can be added during expansion if needed
6. **Progress tracking** - Empty checkboxes initially

**Source:** Analysis of `/research` pattern + phase template requirements

**Relevance:** This split allows human review of phase structure (goals, dependencies) before committing to detailed implementation plans.

---

### Finding 4: User Experience - Clear Mode Indicators

Research on two-mode interfaces shows:

1. **Mode confusion is common** - Users need clear indicators of current state
2. **Cognitive load increases** with unclear transitions
3. **Clear markers prevent errors** - Visual/textual cues are essential

**Source:** Web search - UX best practices for mode-based interfaces

**Relevance:** Scaffolding should include **clear markers** indicating that content is placeholder vs. expanded:

```markdown
**Status:** 🔴 Scaffolding (needs expansion)
# vs
**Status:** ✅ Expanded
```

Or within sections:
```markdown
## 📝 Tasks

> ⚠️ **Scaffolding:** This section requires expansion. Run `/transition-plan [topic] --expand --phase N` to add detailed tasks.

### TDD Flow

[Placeholder - will be expanded with detailed tasks]
```

---

### Finding 5: Current `/transition-plan` Problem - All-at-Once Detail

The current `/transition-plan` command tries to create fully-detailed phase documents immediately:

From the command (lines 604-623):
```markdown
**Key sections to populate:**
- **Tasks:** Expand transition plan tasks into detailed TDD flow with proper ordering:
  - **TDD Task Ordering (IMPORTANT):** Order tasks following RED → GREEN → REFACTOR
  - Group tasks into RED/GREEN pairs where applicable
  - Add detailed sub-tasks with checkboxes
  - Include code examples where applicable
```

**Problem:** This "all-at-once" approach leads to:
- Variable output quality
- Inconsistent TDD ordering
- No human review of structure before detail

**Source:** Current `/transition-plan` command analysis

**Relevance:** Scaffolding should **stop before detailed task expansion**. The current approach tries to do step 4 and step 5 simultaneously.

---

### Finding 6: Proposed Scaffolding Template Structure

Based on all findings, here's the proposed scaffolding structure for phase documents:

```markdown
# [Feature Name] - Phase [N]: [Phase Name]

**Phase:** [N] - [Phase Name]  
**Duration:** [Estimated from source]  
**Status:** 🔴 Scaffolding (needs expansion)  
**Prerequisites:** [From source/previous phase]

---

## 📋 Overview

[Brief overview from ADR/source - 1-2 sentences]

**Success Definition:** [Extracted from source]

---

## 🎯 Goals

1. **[Goal 1]** - [From source]
2. **[Goal 2]** - [From source]
3. **[Goal 3]** - [From source]

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan [topic] --expand --phase [N]` to add detailed TDD tasks.

### Task Categories

- [ ] **[Category 1]** - [Brief description]
- [ ] **[Category 2]** - [Brief description]
- [ ] **[Category 3]** - [Brief description]

---

## ✅ Completion Criteria

- [ ] [Criterion 1 from source]
- [ ] [Criterion 2 from source]
- [ ] [Criterion 3 from source]

---

## 📦 Deliverables

- [Deliverable 1 from source]
- [Deliverable 2 from source]

---

## 🔗 Dependencies

### Prerequisites
- [Previous phase or requirement]

### Blocks
- Phase [N+1]: [Description of what this blocks]

---

## 🔗 Related Documents

- [Previous Phase](phase-[N-1].md)
- [Next Phase](phase-[N+1].md)
- [Feature Plan](feature-plan.md)
- [ADR](../../decisions/[topic]/adr-001.md)

---

**Last Updated:** YYYY-MM-DD  
**Status:** 🔴 Scaffolding  
**Next:** Expand with `/transition-plan [topic] --expand --phase [N]`
```

**Source:** Synthesis of all research findings

**Relevance:** This template provides **reviewable structure** while clearly indicating what needs expansion.

---

## 🔍 Analysis

Based on the findings, the scaffolding design should follow these principles:

| Principle | Implementation |
|-----------|----------------|
| **Structure over detail** | Headers and placeholders, not full content |
| **Extractable from source** | Goals, criteria, deliverables from ADR |
| **Human-reviewable** | Can verify phase breakdown before detail |
| **Clear indicators** | Status markers show what's scaffolding |
| **Minimal viable** | ~60-80 lines vs. full template's ~300 lines |

**Key Insights:**
- [x] Insight 1: Scaffolding should be ~60-80 lines (vs. full template's ~300 lines)
- [x] Insight 2: Goals and dependencies should be in scaffolding (reviewable structure)
- [x] Insight 3: Task details and code examples belong in expansion
- [x] Insight 4: Clear status indicators prevent mode confusion
- [x] Insight 5: Scaffolding should include placeholder markers for sections needing expansion

---

## 💡 Recommendations

- [x] Recommendation 1: Create scaffolding template (~60-80 lines) separate from full phase template
- [x] Recommendation 2: Include goals, dependencies, criteria in scaffolding (structure elements)
- [x] Recommendation 3: Leave Tasks, Implementation Notes, Risks empty for expansion
- [x] Recommendation 4: Add clear status indicators (`🔴 Scaffolding` vs. `✅ Expanded`)
- [x] Recommendation 5: Add placeholder messages guiding users to run expansion command
- [x] Recommendation 6: Scaffolding should be consistent/predictable (simpler = more reliable)

---

## 📋 Requirements Discovered

- [x] FR-8: Scaffolding Template (~60-80 lines)
  - Create a separate scaffolding template for phase documents
  - Include only structure elements, not detailed content
  
- [x] FR-9: Status Indicators for Scaffolding vs. Expanded
  - Phase documents should have clear status: `🔴 Scaffolding` or `✅ Expanded`
  - Status should be in header metadata
  
- [x] FR-10: Placeholder Messages in Scaffolding
  - Empty sections should include placeholder text
  - Placeholder text should guide users to run expansion command
  
- [x] NFR-6: Scaffolding Consistency
  - Scaffolding output should be identical for the same input
  - Simpler structure = more predictable/reliable output

- [x] NFR-7: Scaffolding Size Limit
  - Scaffolding phase documents should be ~60-80 lines
  - Full expanded documents should be ~200-300 lines (per existing pattern)

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with Topic 6: Command Structure Refactoring (also High priority)
3. Create scaffolding template as part of implementation

---

**Last Updated:** 2025-12-29
