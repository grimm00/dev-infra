# Worktree Feature Workflow - Feature Learnings

**Project:** Dev-Infra  
**Feature:** Worktree Feature Workflow  
**Date:** 2026-01-09  
**Status:** ✅ Complete  
**Last Updated:** 2026-01-09

---

## 📋 Overview

This feature implemented a refined git worktree workflow with 4 key innovations:
1. Worktree naming conventions (ADR-001)
2. Self-contained feature branches (ADR-002)
3. Draft PR workflow with continuous Sourcery feedback (ADR-003)
4. Sourcery configuration to reduce review noise (ADR-004)

**Unique aspect:** This feature "dogfooded" its own workflow - we used draft PRs and the "fix before re-review" pattern while building the documentation for it.

---

## ✅ What Worked Exceptionally Well

### 1. Dogfooding the Draft PR Workflow

**Why it worked:**
- Discovered Sourcery doesn't auto-review draft PRs (had to manually trigger)
- Validated the "fix before re-review" pattern through actual use
- Found the real PR count reduction (1 PR vs 3-5 PRs per feature)

**What made it successful:**
- Real-world testing while building
- Immediate feedback loop on documentation accuracy
- Authentic examples to include in guides

**Template implications:**
- Draft PR workflow should be documented with the manual trigger step
- Include `gh pr comment [PR] --body "@sourcery-ai review"` command

**Key examples:**
- PR #59 used as draft PR throughout development
- Triggered 4 Sourcery reviews across all phases
- Fixed issues between reviews (validated pattern)

**Benefits:**
- Documentation is accurate because we tested it
- Examples are real, not hypothetical
- Confidence in workflow recommendations

---

### 2. Self-Contained Feature Branch Pattern

**Why it worked:**
- All feature artifacts (exploration, research, ADRs, planning, code) on one branch
- Single atomic merge brings everything together
- Easy to abandon without polluting develop

**What made it successful:**
- Clear separation between feature-specific and global docs
- No need to coordinate multiple PRs for docs vs code
- Feature branch is the single source of truth

**Template implications:**
- Encourage all feature work on feature branch
- Document the pattern in workflow guides
- Include in cursor rules for AI guidance

**Benefits:**
- Reduced merge coordination overhead
- Cleaner develop branch (no orphaned docs from abandoned features)
- Better traceability (all context merges together)

---

### 3. Lightweight Fix Workflow for Draft PRs

**Why it worked:**
- Opted for Option 2 (direct fixes) instead of full `/fix-plan` workflow
- Quick turnaround: see issue → fix → commit → push
- Appropriate for draft PR iteration cycle

**What made it successful:**
- Recognized that `/fix-plan` is for post-merge deferred issues
- Draft PRs need lightweight, immediate fixes
- No overhead of creating batch files for 2-3 issues

**Template implications:**
- Document when to use `/fix-plan` vs direct fixes
- Draft PR fixes are lightweight by design
- Full fix workflow for accumulated issues after merge

**Key insight:**
```
/fix-plan → Post-merge deferred issues (heavyweight)
Direct fixes → Draft PR iteration (lightweight)
```

---

### 4. Sourcery Configuration for Process Docs

**Why it worked:**
- `.sourcery.yaml` ignoring `admin/**` eliminated review noise
- Code reviews now focus on actual code
- Process documentation changes don't trigger comments

**What made it successful:**
- Clear decision documented in ADR-004
- Simple implementation (just ignore patterns)
- Included in templates for consistency

**Template implications:**
- All templates should have `.sourcery.yaml`
- Standard ignore patterns: `admin/**`, `tmp/**`, `docs/maintainers/**`
- Added to template sync manifest

---

## 🟡 What Needs Improvement

### 1. Sourcery Review Behavior Documentation

**What the problem was:**
- Initially assumed Sourcery auto-reviews draft PRs
- Had to discover manually that `@sourcery-ai review` is required

**Why it occurred:**
- Sourcery behavior for draft PRs wasn't documented in our workflow
- Assumed draft = regular PR for review purposes

**Impact:**
- Initial confusion about why review didn't appear
- Required updating ADR-003 and all related docs

**How to prevent:**
- Document platform behaviors early in research phase
- Test assumptions before documenting workflows

**Template changes needed:**
- Clear statement: "Sourcery does NOT auto-review draft PRs"
- Include manual trigger command in workflow docs

---

### 2. Incremental Review Strategy Research

**What the problem was:**
- Initial thought that `dt-review` deduplication would solve duplicate comments
- Research revealed it's a workflow issue, not a tooling issue

**Why it occurred:**
- Didn't fully understand Sourcery's review scope (entire PR diff each time)
- Tried to solve with automation before understanding root cause

**Impact:**
- Created temporary handoff doc that was later deleted
- Extra research cycle needed

**How to prevent:**
- Understand tool behavior deeply before proposing solutions
- Root cause analysis before jumping to fixes

**Lesson:**
- Sourcery reviews entire PR diff each time = expected behavior
- "Fix before re-review" is the correct pattern, not deduplication

---

### 3. Status Document Consistency

**What the problem was:**
- Sourcery flagged inconsistencies (phase checkboxes not marked complete)
- Status counts didn't match actual content

**Why it occurred:**
- Status updates during rapid iteration can drift
- Easy to mark phase complete but forget task checkboxes

**Impact:**
- Required fix commits to address review feedback
- Adds noise to PR history

**How to prevent:**
- `/task-phase` command should auto-mark checkboxes
- Verification step before PR creation
- Linting for status document consistency

---

## 💡 Unexpected Discoveries

### 1. PR Count Reduction is Significant

**Finding:**
Old workflow: 3-5 PRs per feature (one per phase)
New workflow: 1 PR per feature (single draft PR)

**Why it's valuable:**
- Less PR overhead and review coordination
- Cleaner Git history
- Easier to track feature progress

**How to leverage:**
- Emphasize this benefit in workflow documentation
- Use as selling point for draft PR adoption

---

### 2. "Fix Before Re-Review" is a Discipline, Not a Tool

**Finding:**
The solution to duplicate Sourcery comments isn't deduplication - it's developer discipline to fix issues before requesting another review.

**Why it's valuable:**
- Simpler than building tooling
- Reinforces good development habits
- Natural extension of TDD mindset

**How to leverage:**
- Document as a core principle, not optional
- Include in cursor rules for AI guidance
- Emphasize in onboarding/training

---

### 3. Sub-PRs as Escape Hatch for Large Features

**Finding:**
For very large features (8+ phases), sub-PRs targeting the feature branch can provide incremental reviews without duplicate comments.

**Why it's valuable:**
- Provides option for edge cases
- Doesn't complicate standard workflow
- GitHub natively supports PRs to non-default branches

**How to leverage:**
- Document as escape hatch, not primary workflow
- Reserve for exceptionally large features
- Don't over-engineer for rare cases

---

## ⏱️ Time Investment Analysis

**Breakdown:**
- Phase 1 (Configuration): ~30 min
- Phase 2 (Template Updates): ~30 min
- Phase 3 (Command Updates): ~1 hour
- Phase 4 (Documentation): ~2 hours
- Sourcery fix cycle: ~30 min

**Total:** ~4.5 hours (within estimate of 3-4 hours + buffer)

**What took longer:**
- Phase 4 Documentation: Creating comprehensive WORKTREE-WORKFLOW.md
- Incremental review research: Understanding Sourcery behavior

**What was faster:**
- Phase 1-2: Simple configuration changes
- Fix cycle: Lightweight direct fixes

**Estimation lessons:**
- Documentation phases often take longer than estimated
- Research discoveries can extend timeline
- Dogfooding adds value but also time

---

## 📊 Metrics & Impact

**Code metrics:**
- Files created: ~15 (research, ADRs, planning, docs)
- Files modified: ~10 (templates, commands, cursor rules)
- Test coverage: N/A (documentation feature)

**Quality metrics:**
- Sourcery reviews: 4 (across all phases)
- Issues identified: ~8 (all fixed)
- Final review: Clean

**Developer experience improvements:**
- Single PR per feature (vs 3-5)
- Clear workflow documentation
- AI guidance in cursor rules
- Reduced review noise with .sourcery.yaml

---

## 🎯 Template Implications

### For Standard Project Template

1. **Add `.sourcery.yaml`** ✅ (Done)
   - Ignore `docs/maintainers/**` and `tmp/**`

2. **Update `/pr` command** ✅ (Done)
   - Include `--draft`, `--ready`, `--review` flags

3. **Add workflow documentation**
   - Link to WORKTREE-WORKFLOW.md pattern
   - Include in project README or contributing guide

### For Learning Project Template

1. **Add `.sourcery.yaml`** ✅ (Done)
   - Same patterns as standard project

### For Cursor Rules

1. **Add worktree workflow section** ✅ (Done)
   - In workflow.mdc
   - Include draft PR guidance
   - Document fix-before-re-review pattern

---

## 🚀 Recommendations for Future Features

1. **Use draft PR workflow from start**
   - Open draft PR after first meaningful commit
   - Request Sourcery reviews at phase boundaries

2. **Fix before requesting next review**
   - Address all Sourcery issues before next phase
   - Keeps review history clean

3. **Keep feature self-contained**
   - All exploration, research, ADRs, planning on feature branch
   - Single atomic merge

4. **Dogfood new workflows**
   - Best way to validate documentation
   - Reveals gaps in instructions

---

**Last Updated:** 2026-01-09
