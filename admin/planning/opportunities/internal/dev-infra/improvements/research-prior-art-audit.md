# Dev-Infra Improvement: Prior Art / Existing Solutions Audit in `/research`

**Source:** Workflow Simplification research (Topic 3 conduct)  
**Target:** `/research` command (`.cursor/commands/research.md`)  
**Status:** 🔴 Not Started  
**Created:** 2026-02-14  
**Last Updated:** 2026-02-14

---

## 📋 Overview

During Topic 3 (Transition Plan Output Format) research, we discovered SpecWeave, TODO.md, and Openverse's implementation plan template through web searches aimed at finding *format examples*. The discovery was accidental -- we were searching for design patterns, not evaluating existing tools.

This revealed a gap in the `/research` conduct mode workflow: there is no deliberate "Prior Art / Existing Solutions Audit" step that asks **"Does an open-source tool already solve this problem?"** before building custom.

**Origin:** User observation while reviewing SpecWeave's `tasks.md` format -- "it does some of the same things I'm thinking about implementing."

---

## 🎯 Problem Statement

The current `/research --conduct` workflow:
1. Formulate search queries based on the research question
2. Execute web searches for information
3. Document findings with sources
4. Analyze findings and draw insights
5. Make recommendations
6. Extract requirements

**What's missing:** A structured step to identify, evaluate, and disposition existing tools/frameworks that may solve the same problem. This would prevent reinventing the wheel and ensure we make deliberate "build vs adopt" decisions.

---

## 💡 Proposed Improvement

### Add "Prior Art / Existing Solutions Audit" to Research Conduct Mode

**Where in the workflow:** Between steps 2 (web searches) and 3 (document findings) -- or as a dedicated finding category within step 3.

**Template addition for each research topic document:**

```markdown
### Finding N: Existing Solutions Audit

**Search queries used:**
- "[problem domain] open source tool"
- "[specific capability] framework"
- "alternative to [what we're building]"

**Tools/frameworks evaluated:**

| Tool | Overlap with Our Needs | Fit Assessment | Verdict |
|------|----------------------|----------------|---------|
| [Tool 1] | [What overlaps] | [How well it fits] | Adopt / Adapt patterns / Inform design / Not applicable |
| [Tool 2] | [What overlaps] | [How well it fits] | Adopt / Adapt patterns / Inform design / Not applicable |

**Verdict options:**
- **Adopt** -- Use this tool directly; stop building custom
- **Adapt patterns** -- Don't adopt the tool, but incorporate specific patterns/formats from it
- **Inform design** -- Use as reference/inspiration; our needs differ enough to build custom
- **Not applicable** -- Tool solves a different problem despite surface similarity

**Decision rationale:** [Why we chose this verdict]
```

### Changes Required

- [ ] **Update `/research` command** (`.cursor/commands/research.md`)
  - Add "Existing Solutions Audit" to Conduct Mode step 3 template
  - Add search query suggestions for finding existing tools
  - Add verdict options (Adopt / Adapt patterns / Inform design / Not applicable)
  - **Location:** "### 3. Fill In Research Document" section
  - **Priority:** MEDIUM
  - **Effort:** LOW (~30 min)

- [ ] **Update research document template** in `/research` command
  - Add `### Finding N: Existing Solutions Audit` template to the findings section
  - Include the evaluation table format
  - **Location:** Research document template in step 3
  - **Priority:** MEDIUM
  - **Effort:** LOW (~15 min)

- [ ] **Update template copies** (both `standard-project` and `learning-project`)
  - Sync updated `/research` command to both templates
  - **Location:** `templates/*/cursor/commands/research.md`
  - **Priority:** MEDIUM (follows from above)
  - **Effort:** LOW (~10 min, just copy)

- [ ] **Retroactively add to Topic 3** (optional)
  - Add a formal "Existing Solutions Audit" finding to `topic-3-transition-plan-output-format.md`
  - Document SpecWeave, TODO.md, Openverse as evaluated tools with verdicts
  - **Priority:** LOW (the research is done; this is polish)
  - **Effort:** LOW (~15 min)

---

## 📊 Impact Assessment

**Prevents:**
- Accidentally rebuilding what already exists
- Missing integration opportunities with established tools
- Narrowing solution space by only considering custom approaches

**Enables:**
- Deliberate "build vs adopt" decisions at research time
- Better-informed architecture decisions
- Faster delivery when adoption is the right choice
- Richer research findings (existing tools provide real-world validation)

**Evidence from this session:**
- SpecWeave's `tasks.md` format validated our Format B design choice
- TODO.md format (261 stars) confirmed GFM checkbox patterns as industry standard
- Openverse template showed real-world usage of step-by-step plans at WordPress/Automattic scale
- All three were discovered *accidentally* while searching for format examples

**Risk if not addressed:**
- LOW -- we'll still find tools occasionally through general research
- But systematic discovery would improve research quality consistently

---

## 🔗 Related

- **[Topic 3: Transition Plan Output Format](../../../../research/workflow-simplification/topic-3-transition-plan-output-format.md)** -- Where this gap was discovered
- **[`/research` command](../../../../.cursor/commands/research.md)** -- Target for improvement
- **[SpecWeave tasks.md](https://spec-weave.com/docs/glossary/terms/tasks-md/)** -- Example of existing tool with overlap

---

**Last Updated:** 2026-02-14  
**Status:** 🔴 Not Started  
**Priority:** MEDIUM  
**Effort:** LOW (~1 hour total)
