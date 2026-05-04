# PR #56 - Deferred Issues

**PR:** #56 - feat(transition-plan): implement Expand Mode Workflow and Supporting Content (Phases 3 & 4)  
**Merged:** 2025-12-29  
**Review:** Sourcery AI

---

## 📋 Deferred Issues

**Date:** 2025-12-29  
**Review:** PR #56 Sourcery feedback  
**Status:** 🟡 **DEFERRED** - All MEDIUM/LOW priority, can be handled opportunistically

### Issue #1: Nested Code Blocks

**Priority:** 🟡 MEDIUM | **Impact:** 🟡 MEDIUM | **Effort:** 🟡 MEDIUM

**Description:** Several nested fenced code blocks using combinations of ` ```markdown `, ` ````markdown ` and closing fences may cause rendering issues in some IDE markdown previews.

**Location:** `.cursor/commands/transition-plan.md`, Phase 3 planning file, TDD examples

**Solution Options:**
- Use 4-backtick fences (` ```` `) for outer blocks when nesting code examples
- Render locally to ensure all blocks are closed correctly
- May explain IDE markdown rendering issues reported during PR validation

**Action Plan:** Address in future documentation cleanup PR when consolidated with other doc fixes.

---

### Issue #2: Undocumented `--force` Flag

**Priority:** 🟡 MEDIUM | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:** The troubleshooting section suggests using a `--force` flag to re-expand an already-expanded phase, but `--force` is not described in the options/flag-handling sections.

**Location:** `.cursor/commands/transition-plan.md` - Common Issues section

**Solution Options:**
- Add `--force` flag documentation to Options section
- OR adjust troubleshooting guidance to match actual interface (remove `--force` mention)

**Action Plan:** Deferred - quick fix to either add flag docs or update troubleshooting.

---

### Issue #3: `/task-phase` Example Inconsistency

**Priority:** 🟢 LOW | **Impact:** 🟢 LOW | **Effort:** 🟢 LOW

**Description:** Examples for invoking `/task-phase` are inconsistent (e.g., `/task-phase [N] 1` vs `/task-phase phase-1`).

**Location:** `.cursor/commands/transition-plan.md` - various examples

**Solution Options:**
- Standardize to single pattern: `/task-phase [phase-N] [task-N]`
- Or use feature-relative: `/task-phase phase-1 1`

**Action Plan:** Deferred - cosmetic consistency improvement, low priority.

---

## 📊 Summary

| Issue | Priority | Impact | Effort | Status |
|-------|----------|--------|--------|--------|
| #1 Nested code blocks | 🟡 MEDIUM | 🟡 MEDIUM | 🟡 MEDIUM | 🟡 Deferred |
| #2 `--force` flag undocumented | 🟡 MEDIUM | 🟢 LOW | 🟢 LOW | 🟡 Deferred |
| #3 `/task-phase` examples | 🟢 LOW | 🟢 LOW | 🟢 LOW | 🟡 Deferred |

**Recommendation:** These can be handled opportunistically during future documentation updates or bundled into a dedicated "docs cleanup" PR.

---

**Last Updated:** 2025-12-29

