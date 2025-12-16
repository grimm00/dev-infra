# Experimental Template Learnings - Phase 3

**Project:** dev-infra  
**Feature:** Experimental Template  
**Phase:** 3 - CI Drift Detection  
**Date:** 2025-12-15  
**Status:** ✅ Complete  
**PR:** #49

---

## 📋 Overview

Phase 3 implemented CI-based drift detection to automatically catch when shared files diverge between `standard-project` and `experimental-project` templates. This ensures templates stay in sync without manual verification.

**Deliverables:**
- `scripts/template-sync-manifest.txt` - Machine-readable shared files list
- `scripts/validate-template-sync.sh` - Drift detection script
- `tests/unit/validate-template-sync.bats` - 10 comprehensive tests
- CI integration in `.github/workflows/test.yml`
- `docs/TEMPLATE-SYNC.md` - Comprehensive sync documentation

---

## ✅ What Worked Exceptionally Well

### Manifest-Based Shared Files Definition

**Why it worked:**
A simple text file listing shared files is more maintainable than hardcoded paths in scripts.

**What made it successful:**
- Easy to read and modify
- Supports comments for context
- Supports directory markers (trailing `/`)
- CI-readable without parsing code
- Documents "intentionally different" files via comments

**Template implications:**
Consider manifest pattern for any multi-template sync requirements.

**Key examples:**

```txt
# scripts/template-sync-manifest.txt
# Infrastructure
.gitignore
.editorconfig
# CI Workflows
.github/workflows/test.yml
# Stable Commands (18 total)
.cursor/commands/fix-plan.md
...
```

**Benefits:**
- Single source of truth for sync requirements
- Easy auditing of shared vs unique files
- Self-documenting through comments

---

### TDD with Bats for Shell Scripts

**Why it worked:**
Writing tests before implementing the script caught edge cases early and provided confidence in the implementation.

**What made it successful:**
- 10 comprehensive tests covering happy path, error cases, and edge cases
- Tests documented expected behavior clearly
- Red-Green-Refactor cycle worked naturally with shell scripting
- Edge cases like empty manifest, missing directories, whitespace differences covered

**Template implications:**
TDD for bash scripts should be the standard pattern for any new scripts.

**Key examples:**

```bash
@test "validate-template-sync.sh fails when shared file differs" {
  echo "modified content" > "$TEMP_DIR/$STANDARD/test.txt"
  run "$SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "DRIFT DETECTED" ]]
}
```

**Benefits:**
- Reliable script behavior
- Regression protection
- Documentation through tests

---

### Comprehensive Documentation (`docs/TEMPLATE-SYNC.md`)

**Why it worked:**
Created documentation that answers all potential user questions about template sync.

**What made it successful:**
- Explains WHY sync matters (context)
- Shows shared file categories (reference)
- Explains intentionally different files (clarity)
- Provides step-by-step fix instructions (actionable)
- Includes workflow diagram (visual)
- Has troubleshooting section (self-service)

**Template implications:**
Complex features should have dedicated documentation files, not just inline code comments.

**Benefits:**
- Self-service for developers
- Reduces support questions
- Onboards new team members

---

## 🟡 What Needs Improvement

### Manifest Validation at Creation Time

**What the problem was:**
The initial manifest included `.cursor/rules/` which doesn't exist in the templates, causing validation errors.

**Why it occurred:**
Manifest was created based on expected structure, not actual directory contents.

**Impact:**
CI failed until manifest was corrected.

**How to prevent:**
- Add pre-commit hook to validate manifest against actual template structure
- Script should warn about non-existent paths in manifest
- Consider generating manifest from actual templates then editing

**Template changes needed:**
Add manifest validation logic to drift detection script.

---

### Manual Testing Guide Gap

**What the problem was:**
During PR validation, the manual testing guide was treated as an AI checklist rather than human documentation.

**Why it occurred:**
`/pr-validation` command didn't clearly distinguish between AI test execution and human-facing documentation.

**Impact:**
Manual testing guide wasn't created for Phase 3, requiring post-PR documentation work.

**How to prevent:**
- Updated `/pr-validation` to enforce guide creation for feature PRs
- Added clear purpose statement in command documentation
- Added guide template for creating new guides

**Template changes needed:**
Enhanced `/pr-validation` command already applied (2025-12-15).

---

### Directory vs File Comparison Logic

**What the problem was:**
Initial script implementation treated directories differently than expected.

**Why it occurred:**
`diff` behaves differently for directories vs files; needed `-r` flag for recursive comparison.

**Impact:**
Required refactoring the comparison logic during implementation.

**How to prevent:**
- Document expected `diff` behavior in test cases
- Include directory-specific test cases early

**Template changes needed:**
None - already handled in implementation.

---

## 💡 Unexpected Discoveries

### CI Speed is More Than Acceptable

**Finding:**
The drift detection script runs in under 2 seconds, even comparing all 20+ shared files.

**Why it's valuable:**
No need for optimization or caching strategies - simple `diff` is fast enough.

**How to leverage:**
Can add more comprehensive checks without performance concerns.

---

### Manifest Comments as Documentation

**Finding:**
Comments in the manifest file serve dual purpose: documentation for developers AND context for debugging CI failures.

**Why it's valuable:**
When CI fails, the manifest helps understand WHY a file should be in sync.

**How to leverage:**
Encourage detailed comments in manifest, especially for non-obvious files.

---

### Template Sync Reveals Architecture Decisions

**Finding:**
The process of categorizing files (shared vs unique) forced documentation of architectural decisions about what makes experimental "experimental."

**Why it's valuable:**
Creates explicit record of template differentiation strategy.

**How to leverage:**
Reference manifest and `docs/TEMPLATE-SYNC.md` when making future template decisions.

---

## ⏱️ Time Investment Analysis

**Breakdown:**

| Activity | Estimated | Actual |
|----------|-----------|--------|
| Task 1: Define categories | 15 min | 10 min |
| Task 2: Create manifest | 15 min | 20 min |
| Task 3: Create script | 45 min | 60 min |
| Task 4: Write tests | 30 min | 45 min |
| Task 5: CI integration | 15 min | 20 min |
| Task 6: Documentation | 30 min | 40 min |
| **Total** | 2.5 hrs | 3.25 hrs |

**What took longer:**
- Task 2 (manifest): Identifying all 18 stable commands
- Task 3 (script): Directory comparison edge cases
- Task 4 (tests): Comprehensive edge case coverage

**What was faster:**
- Task 1 (categories): Clear requirements from research phase

**Estimation lessons:**
- TDD adds ~20% time but saves debugging time
- Documentation always takes longer than estimated
- Shell scripting edge cases add complexity

---

## 📊 Metrics & Impact

**Code metrics:**
- New script: ~100 lines (validate-template-sync.sh)
- Test file: ~180 lines (10 tests)
- Manifest: 30 entries
- Documentation: ~200 lines (TEMPLATE-SYNC.md)

**Quality metrics:**
- Test coverage: 10 tests covering all paths
- Sourcery review: Clean (few minor suggestions)
- CI integration: Working

**Developer experience:**
- Clear error messages when drift detected
- Self-fixing guidance in CI output
- Comprehensive documentation for understanding sync

---

## 🎯 Key Takeaways

1. **Manifest pattern is reusable** - Consider for other multi-resource sync scenarios
2. **TDD works well for bash scripts** - Bats makes it accessible
3. **Documentation is essential for complex features** - `docs/TEMPLATE-SYNC.md` will save future questions
4. **CI feedback should be actionable** - Error messages include fix instructions
5. **Manual testing guides need enforcement** - Updated `/pr-validation` accordingly

---

## 🔗 Related Documents

- **Phase Document:** [phase-3.md](../../../features/experimental-template/phase-3.md)
- **Sync Documentation:** [docs/TEMPLATE-SYNC.md](../../../../docs/TEMPLATE-SYNC.md)
- **Command Update:** [pr-validation update](../../../ci/command-documentation-maintenance/updates/2025-12-15-pr-validation-manual-testing-guide-enforcement.md)

---

**Last Updated:** 2025-12-15

