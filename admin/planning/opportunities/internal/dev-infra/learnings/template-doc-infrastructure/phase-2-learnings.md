# Template Doc Infrastructure - Phase 2 Learnings

**Project:** dev-infra  
**Feature:** template-doc-infrastructure  
**Phase:** 2 - Format Specification  
**Date:** 2026-01-16  
**Status:** ✅ Complete  
**Last Updated:** 2026-01-16

---

## 📋 Overview

Phase 2 created the format specification documents (FORMAT.md, VARIABLES.md, AUTHORING.md) that document template conventions for tooling implementers. These spec documents enable dev-toolkit to implement `dt-doc-gen` and `dt-doc-validate` without needing to reverse-engineer the templates.

**Deliverables Created:**
- `scripts/doc-gen/templates/FORMAT.md` (~560 lines)
- `scripts/doc-gen/templates/VARIABLES.md` (~380 lines)
- `scripts/doc-gen/templates/AUTHORING.md` (~694 lines)

---

## ✅ What Worked Exceptionally Well

### Building on Phase 1 Foundation

**Why it worked:**
Having 17 actual templates from Phase 1 made documenting conventions straightforward. We could grep templates for patterns rather than designing spec in the abstract.

**What made it successful:**
- Real examples to reference throughout spec documents
- Variable extraction via `grep -ho '\${[A-Z_]*}'` was systematic
- Could verify spec completeness against actual templates

**Template implications:**
- Spec-from-implementation approach works well
- Create artifacts first, document patterns second

**Key examples:**

```bash
# Variable discovery was automated
find scripts/doc-gen/templates -name "*.tmpl" -exec grep -ho '\${[A-Z_]*}' {} \; | sort -u
# → Discovered all 29 variables systematically
```

**Benefits:**
- Spec documents are grounded in reality
- No disconnect between spec and implementation
- Easy to verify spec completeness

---

### Three-Document Structure (FORMAT/VARIABLES/AUTHORING)

**Why it worked:**
Separating concerns into three focused documents made each document coherent and navigable.

**What made it successful:**

| Document | Audience | Purpose |
|----------|----------|---------|
| FORMAT.md | Tooling implementers | Placeholder syntax, rendering flow |
| VARIABLES.md | Tooling implementers | Variable reference |
| AUTHORING.md | Template authors | How to create/modify templates |

**Template implications:**
- Spec documentation benefits from separation of concerns
- Different audiences need different documents
- Cross-references tie documents together

**Benefits:**
- Each document stays focused
- Easy to find relevant information
- Can update one without affecting others

---

### Two-Mode Documentation Depth

**Why it worked:**
Dedicating significant space to two-mode (setup/conduct) explanation ensured the pattern is well understood.

**What made it successful:**
- Complete example showing same template in both modes
- Mode comparison tables
- Practical workflow integration section
- "When to use each mode" guidance

**Template implications:**
- Complex patterns need dedicated, deep documentation
- Examples worth more than explanations
- Show before/after states

**Key examples:**
- FORMAT.md has full two-mode section with diagrams
- AUTHORING.md has practical "designing for two-mode" guidance

---

### Verification Task (Task 5)

**Why it worked:**
Systematic verification caught issues that would have caused problems for implementers.

**What made it successful:**
- Counted placeholder types (3/3 ✅)
- Counted variables documented (29/29 ✅)
- Verified cross-references between spec files
- Added template example links

**Template implications:**
- Verification tasks are valuable for spec work
- Automated checks (grep, find) complement manual review

---

## 🟡 What Needs Improvement

### Path References Were Initially Wrong

**What the problem was:**
ADR links in FORMAT.md and VARIABLES.md used `../../admin/decisions/...` but should have been `../../../admin/decisions/...` (templates are one level deeper).

**Why it occurred:**
Copy-paste from other contexts without verifying relative paths.

**Impact:**
Broken links in spec documents would confuse implementers.

**How to prevent:**
- Always verify relative paths after creating files
- Include link validation in verification tasks
- Consider using absolute paths from repo root

**Template changes needed:**
- Add "verify relative paths" to spec verification checklists

---

### Output Directory Conventions Not Documented

**What the problem was:**
Spec documents don't clearly document where generated documents go (e.g., `admin/explorations/[topic]/` for exploration templates).

**Why it occurred:**
Output paths are determined by the tooling, not the templates. We deferred this to dev-toolkit.

**Impact:**
dev-toolkit will need to define and document output paths during implementation.

**How to prevent:**
- Note deferral explicitly in spec documents
- Create placeholder section for output conventions
- Document the feedback loop (dev-toolkit → dev-infra)

**Template changes needed:**
- Consider adding PATHS.md or output convention section

---

### Variable Naming Inconsistencies

**What the problem was:**
Some inconsistency in variable naming across templates:
- `${TOPIC}` vs `${TOPIC_NAME}` vs `${TOPIC_TITLE}`
- Multiple date-related patterns

**Why it occurred:**
Templates created organically without strict naming standard upfront.

**Impact:**
VARIABLES.md had to document existing inconsistencies rather than ideal conventions.

**How to prevent:**
- Define variable naming conventions BEFORE creating templates
- Use consistent patterns from the start

**Template changes needed:**
- VARIABLES.md naming conventions section added
- Future template work should follow conventions

---

## 💡 Unexpected Discoveries

### Spec Documents Have Two Distinct Audiences

**Finding:**
FORMAT.md and VARIABLES.md are for **tooling implementers** (dev-toolkit team), while AUTHORING.md is for **template authors** (anyone creating/modifying templates).

**Why it's valuable:**
Understanding audience affects writing style, detail level, and examples included.

**How to leverage:**
- Label target audience in each spec document header
- Tailor content depth to audience needs
- FORMAT/VARIABLES: implementation-focused, precise
- AUTHORING: practical, how-to focused

---

### Cross-Repo Feedback Loop Needed

**Finding:**
When dev-toolkit implements `dt-doc-gen`, they'll discover concrete details (output paths, flags, edge cases) that need to flow back to dev-infra to update the spec.

**Why it's valuable:**
Anticipating this feedback loop prevents surprises and establishes process.

**How to leverage:**
- Use `/int-opp` in dev-toolkit to capture discoveries
- Create dev-infra PRs to update spec based on learnings
- Spec is living document, not fixed contract

---

### Table Formatting Matters for Readability

**Finding:**
User reformatted tables in AUTHORING.md for better alignment. Well-formatted tables significantly improve readability.

**Why it's valuable:**
Spec documents are reference material - readability is critical.

**How to leverage:**
- Use consistent table column widths
- Align columns for visual clarity
- Consider markdown formatters/linters

---

## ⏱️ Time Investment Analysis

**Breakdown:**

| Task | Estimated | Actual | Notes |
|------|-----------|--------|-------|
| Task 1: FORMAT.md | ~45 min | ~20 min | Foundation from ADR-002 helped |
| Task 2: VARIABLES.md | ~45 min | ~20 min | Automated variable discovery |
| Task 3: AUTHORING.md | ~45 min | ~25 min | Comprehensive guide |
| Task 4: Two-Mode | ~30 min | ~15 min | Enhancements to existing |
| Task 5: Verification | ~30 min | ~15 min | Including path fixes |
| **Total** | **3-4 hours** | **~1.5-2 hours** | |

**What took longer:**
- Nothing significantly - all tasks completed faster than estimated

**What was faster:**
- Having Phase 1 templates as reference accelerated all tasks
- ADR-002 and ADR-004 provided ready-made content
- Variable discovery was automated with grep

**Estimation lessons:**
- Spec documentation is faster when implementation exists
- ADR content can be adapted, not recreated
- Verification catches issues but is quick with automated checks

---

## 📊 Metrics & Impact

**Document metrics:**

| Document | Lines | Sections | Tables |
|----------|-------|----------|--------|
| FORMAT.md | ~560 | 8 major | 6 |
| VARIABLES.md | ~380 | 7 major | 8 |
| AUTHORING.md | ~694 | 12 major | 12 |
| **Total** | **~1,634** | 27 | 26 |

**Coverage metrics:**
- Placeholder types documented: 3/3 (100%)
- Variables documented: 29/29 (100%)
- Common patterns documented: 5/5 (100%)
- Template categories covered: 5/5 (100%)

**Quality metrics:**
- Cross-references: All spec files reference each other ✅
- Template examples: Links added to all spec files ✅
- ADR alignment: Spec matches ADR-002, ADR-003, ADR-004 ✅

**Developer experience:**
- dev-toolkit can implement dt-doc-gen from spec
- Template authors have comprehensive guide
- Two-mode pattern clearly explained

---

## 🔗 Related Documents

- [Phase 2 Document](../../../../../planning/features/template-doc-infrastructure/phase-2.md)
- [Phase 1 Learnings](phase-1-learnings.md)
- [ADR-002: Template Structure Standard](../../../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [FORMAT.md](../../../../../../scripts/doc-gen/templates/FORMAT.md)
- [VARIABLES.md](../../../../../../scripts/doc-gen/templates/VARIABLES.md)
- [AUTHORING.md](../../../../../../scripts/doc-gen/templates/AUTHORING.md)

---

**Last Updated:** 2026-01-16
