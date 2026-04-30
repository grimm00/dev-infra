# Research: Scaffolding Boundaries

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** What content boundaries should `/explore` use for Setup vs Conduct mode?  
**Status:** ✅ Complete  
**Priority:** 🟡 Medium  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

What content boundaries should `/explore` use for Setup vs Conduct mode?

**Context:** Need consistent, predictable output sizes like transition-plan-two-mode achieved (~60-80 lines setup, ~200-300 conduct). The `/explore` command should follow this pattern.

---

## 🔍 Research Goals

- [x] Goal 1: Analyze transition-plan-two-mode scaffolding boundaries (ADR-002)
- [x] Goal 2: Define what sections go in scaffolding vs detailed exploration
- [x] Goal 3: Determine when `research-topics.md` should be created (Setup or Conduct)
- [x] Goal 4: Evaluate how much context Setup mode should include

---

## 📚 Research Methodology

**Sources:**
- [x] Transition-plan-two-mode ADR-002 (Scaffolding Content Boundaries)
- [x] Current `/explore` command output analysis
- [x] `/research` command scaffolding analysis

**Sub-questions to investigate:**
- What sections go in scaffolding vs detailed exploration?
- Should research-topics.md be created in Setup or Conduct mode?
- How much context should Setup mode include?
- Should Setup mode prompt for key questions or leave them for Conduct?

---

## 📊 Findings

### Finding 1: ADR-002 Establishes Clear Scaffolding Pattern

ADR-002 from transition-plan-two-mode defines:

**Scaffolding Content (~60-80 lines):**
- Header: Status, prerequisites, estimated effort
- Overview: 1-2 sentences
- Goals: Numbered list from source
- Tasks: Category headers only + placeholder
- Completion Criteria: Checklist from source
- Dependencies: Prerequisites and blocks

**Expansion Content (adds ~150-200 lines):**
- Detailed TDD breakdown
- Code examples
- Testing commands
- Implementation notes
- Progress tracking

**Source:** `admin/decisions/transition-plan-two-mode/adr-002-scaffolding-content-boundaries.md`

**Relevance:** Provides proven pattern to adapt for `/explore`

---

### Finding 2: /explore Has Unique Structure Needs

The `/explore` command creates different artifacts than `/transition-plan`:

| Artifact | transition-plan | explore |
|----------|-----------------|---------|
| Main document | `transition-plan.md` | `exploration.md` |
| Phase docs | `phase-N.md` | N/A |
| Secondary | N/A | `research-topics.md` |

**Source:** Command documentation analysis

**Relevance:** Need to map scaffolding pattern to exploration structure

---

### Finding 3: research-topics.md Should Be Created in Setup Mode

`research-topics.md` should be created in Setup Mode because:
1. Lists questions to investigate - structure, not content
2. Allows human review of research scope before deep exploration
3. Similar to how phase scaffolding lists task categories

**Source:** Pattern analysis from `/research` command

**Relevance:** research-topics.md is "structure" not "content"

---

### Finding 4: /explore Scaffolding Should Focus on Organization

Given that `/explore` uniquely handles unstructured input (Topic 3 finding), Setup Mode should:
1. **Organize input** into themed sections
2. **Extract questions** from unstructured thoughts
3. **Create research-topics.md** with prioritized questions
4. **Leave detailed exploration** for Conduct Mode

**Source:** Integration of Topic 3 insights

**Relevance:** Two-mode especially valuable for thought organization

---

## 🔍 Analysis

Mapping transition-plan-two-mode scaffolding to `/explore`:

**Explore Scaffolding Content (~60-80 lines):**

| Section | Content |
|---------|---------|
| **Header** | Topic, status, created date |
| **What Are We Exploring?** | 1-2 sentence summary |
| **Why Explore This?** | Brief context/motivation |
| **Initial Thoughts** | Organized themes from input (brief) |
| **Key Questions** | Checklist of questions |
| **Next Steps** | Link to research-topics.md |

**Explore Expansion Content (adds ~150-200 lines):**

| Section | Content |
|---------|---------|
| **Initial Thoughts** | Detailed analysis of each theme |
| **Options/Approaches** | Detailed exploration of options |
| **Trade-offs** | Detailed analysis |
| **Risks/Considerations** | Detailed assessment |
| **Notes** | Captured insights during exploration |

**Key Insights:**
- [x] Insight 1: ADR-002 pattern directly applicable to `/explore` with section mapping
- [x] Insight 2: research-topics.md is "structure" - belongs in Setup Mode
- [x] Insight 3: Setup Mode's unique value is "thought organization" from unstructured input
- [x] Insight 4: ~60-80 line scaffolding is sufficient for human review

---

## 💡 Recommendations

- [x] Recommendation 1: Create exploration scaffolding template (~60-80 lines)
- [x] Recommendation 2: Create research-topics.md in Setup Mode (structure, not content)
- [x] Recommendation 3: Setup Mode should organize unstructured input into themes
- [x] Recommendation 4: Use `--conduct` flag for expansion (consistency with other commands)
- [x] Recommendation 5: Add placeholder message guiding to conduct mode

---

## 📋 Requirements Discovered

**Functional Requirements:**

- [x] FR-SB-1: Setup Mode MUST produce scaffolding of ~60-80 lines
- [x] FR-SB-2: Setup Mode MUST create research-topics.md with prioritized questions
- [x] FR-SB-3: Conduct Mode MUST expand to ~200-300 lines
- [x] FR-SB-4: Scaffolding MUST include placeholder message guiding to conduct

**Non-Functional Requirements:**

- [x] NFR-SB-1: Output sizes MUST be predictable across runs
- [x] NFR-SB-2: Scaffolding structure MUST be consistent with other two-mode commands

---

## 🚀 Next Steps

1. ✅ Research complete
2. Use findings to inform `/explore` command updates
3. After all research, use `/decision explore-two-mode --from-research`

---

**Last Updated:** 2026-01-09

