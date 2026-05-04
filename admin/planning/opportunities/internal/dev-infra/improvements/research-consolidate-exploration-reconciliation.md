# Dev-Infra Improvement: Exploration Reconciliation in `/research --consolidate`

**Source:** Agentic Workflow Modernization research session (Topics 1-4 conducted, exploration amended retroactively)
**Target:** `/research` command (`.cursor/commands/research.md`), `--consolidate` mode
**Status:** ✅ Complete
**Created:** 2026-03-25
**Last Updated:** 2026-03-25

---

## 📋 Overview

After conducting Topics 1-4, the exploration document (`exploration.md`) still described Strategy A decomposition in Theme 3, treated structural schemas as an open question in Theme 4, listed "simple triggers" as a command category in Theme 1, and lacked the `disable-model-invocation` portability finding in Theme 9. The spike determination table still showed completed spikes as pending. All of this was stale -- contradicted or refined by the research findings.

The user noticed this and suggested `/explore --amend` to integrate research findings back into the exploration. The amendment was valuable: it updated 4 themes, replaced the spike table, added cross-references to related explorations, and ensured the exploration accurately reflects the current understanding before decisions are made.

**The gap:** There is no formal step in the workflow that prompts for this reconciliation. It happened because the user had the judgment to suggest it. Without that prompt, the decision phase would have inherited stale exploration framing.

**Origin:** User observation during `/discuss` session: "The thought of retroactively editing and adding themes based on current research is a great practice. What would be a pathway to make sure this is captured at decision time?"

---

## 🎯 Problem Statement

The current `/research --consolidate` workflow:
1. Validates all topics are complete
2. Reads all requirements (FRs, NFRs, Constraints, Assumptions)
3. Cross-references against research findings and recommendations
4. Identifies redundancies, superseded items, gaps, stale descriptions
5. Presents analysis for human review
6. After approval: merges, removes, adds, modifies, renumbers
7. Updates research summary and requirements status

**What's missing:** Step 0 -- before cleaning up requirements, check whether the *exploration* that motivated the research is still accurate. Research often overturns, refines, or answers the exploration's open questions. If the exploration isn't updated, the decision phase inherits framing that doesn't reflect the current understanding.

---

## 💡 Proposed Solution

Add an **Exploration Reconciliation** sub-step to `--consolidate`, between pre-condition validation and requirements analysis.

### Reconciliation Categories

Each exploration theme/question is assessed with a severity level:

| Severity | Meaning | Action |
|----------|---------|--------|
| **Mandatory** | Theme contradicted or overturned by research (e.g., Theme 3's Strategy A superseded by FR-10) | Must amend before proceeding to decisions |
| **Recommended** | Theme significantly refined but not contradicted (e.g., Theme 4's schema question answered) | Should amend for accuracy; skippable if time-constrained |
| **Deferred** | Theme partially informed but still open (e.g., Theme 5's orchestration not yet researched) | Note for future; no action needed now |

### Proposed Workflow Addition

After `--consolidate` validates pre-conditions (Step 1) and before reading all artifacts (Step 2):

```
Step 1.5: Exploration Reconciliation

1. Read exploration.md themes and key questions
2. Cross-reference each theme against research findings:
   - Is the theme's framing still accurate?
   - Has research answered the theme's open questions?
   - Are the theme's concerns addressed?
   - Is the spike determination table current?
3. Categorize findings by severity (mandatory / recommended / deferred)
4. Present reconciliation report:

## Exploration Reconciliation

### Mandatory (N items)
| Theme | Finding | Research Source |
|-------|---------|---------------|
| Theme 3: Strategy A | Overturned by FR-10 (one skill, one workflow) | Topic 3 |

### Recommended (N items)
| Theme | Finding | Research Source |
|-------|---------|---------------|
| Theme 4: Schemas open question | Answered: schema system exists (ADR-002/004) | Topic 4 |

### Deferred (N items)
| Theme | Status | Reason |
|-------|--------|--------|
| Theme 5: Orchestration | Topics 7-8 not yet researched | Wait for remaining research |

### Spike Table
- N spikes completed since last exploration update
- N new spike candidates identified

5. STOP and wait for human review
6. User approves which items to amend:
   - Mandatory: run /explore --amend for each (or batch)
   - Recommended: user decides
   - Deferred: noted, no action
7. Continue to requirements consolidation (existing Step 2)
```

### Key Design Principles

- **Not a blocker:** The reconciliation report is presented, but the user can skip all amendments and proceed to requirements. The value is in the prompt, not the enforcement.
- **Mandatory items are strong recommendations, not hard gates:** Even "mandatory" items can be skipped with acknowledgment. The categories express severity, not enforcement.
- **Lightweight:** The reconciliation reads what's already loaded (exploration + research). No additional file creation or web search.
- **Composable:** The reconciliation can be run independently if needed: `/research --consolidate --reconcile-only` could present the report without proceeding to requirements cleanup.

---

## 🔧 Implementation

### Changes Required

1. **`.cursor/commands/research.md`** -- Add Step 1.5 to Consolidate Mode Workflow section
   - Add reconciliation categories table
   - Add workflow sub-steps
   - Add reconciliation report template
   - Add `--reconcile-only` flag documentation (optional)
   - Priority: MEDIUM
   - Effort: LOW (~30 min to update the command doc)

2. **Template sync** -- Update in both `standard-project` and `learning-project` templates
   - Same change as #1, applied to template copies
   - Priority: MEDIUM (at sync time)
   - Effort: LOW (manifest-driven)

### Files to Modify

| File | Change | Priority |
|------|--------|----------|
| `.cursor/commands/research.md` | Add Step 1.5 to Consolidate Mode | MEDIUM |
| `templates/standard-project/.cursor/commands/research.md` | Template sync | MEDIUM |
| `templates/learning-project/.cursor/commands/research.md` | Template sync | MEDIUM |

---

## ✅ Definition of Done

- [ ] Consolidate Mode in `/research` includes exploration reconciliation step
- [ ] Reconciliation report template defined with mandatory/recommended/deferred categories
- [ ] Templates synced
- [ ] Tested on next `--consolidate` invocation (agentic-workflow-modernization is the natural test case)

---

## 📊 Impact Assessment

**Priority:** MEDIUM -- valuable for quality of decisions, but ad hoc `/explore --amend` is a viable fallback

**Effort:** LOW (~30 min) -- this is a command documentation update, not code

**Risk of not doing this:** Decisions based on stale exploration framing. Research may overturn assumptions that the exploration baked in. The decision phase inherits contradictions that could have been resolved.

**Risk of doing this:** One more step in an already multi-step workflow. Mitigated by making it non-blocking and allowing the user to skip.

---

**Last Updated:** 2026-03-25
