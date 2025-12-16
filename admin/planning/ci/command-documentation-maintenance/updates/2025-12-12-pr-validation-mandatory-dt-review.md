# Command Update: PR Validation - Mandatory dt-review

**Date:** 2025-12-12  
**Command:** `/pr-validation`  
**Type:** Bug Fix / Clarification  
**Status:** ✅ Complete

---

## Issue

During PR #47 validation, the `dt-review` command was not run initially because:

1. The GitHub Sourcery integration check showed "pass" in the PR checks
2. The command documentation had language like "Missing reviews are acceptable - workflow continues"
3. The AI assistant incorrectly assumed the GitHub check was sufficient

This resulted in missing the detailed Sourcery review file and priority matrix assessment until the user pointed out the oversight.

---

## Root Cause

The command documentation had too many "skip if not available" and "optional" notes around the Sourcery review step, which led to confusion about when `dt-review` should be run.

**GitHub Sourcery Check vs dt-review:**
- **GitHub Sourcery Check:** Indicates if Sourcery found issues (pass/fail), does NOT generate review file
- **`dt-review` command:** Extracts and saves Sourcery comments to a review file for priority matrix assessment

These are two different things, and both are needed for proper PR validation.

---

## Changes Made

### Configuration Section

- Changed from "if available from dev-toolkit" to "(REQUIRED - always run this tool)"
- Added explicit note: "Always run `dt-review` explicitly - do NOT assume GitHub's Sourcery integration check is sufficient"
- Removed "Missing reviews are acceptable" note

### Step 4: Run Sourcery Review

- Changed title to "Run Sourcery Review (dt-review) - REQUIRED"
- Added prominent "IMPORTANT" note explaining why this step is required
- Removed "If review fails or is not available" section that allowed skipping
- Updated checklist to mark `dt-review` as "(REQUIRED)"

### Step 5: Fill Out Priority Matrix

- Changed title to "Fill Out Priority Matrix - REQUIRED"
- Removed "Skip this step if" section
- Made it clear this step always follows dt-review

### Options Section

- Removed `--skip-review` option mention
- Added note: "There is no `--skip-review` option. Sourcery review via `dt-review` is REQUIRED."

### Checklist Summary

- Changed "if available" / "if review available" to "(REQUIRED)"
- Updated "Before running command" to note dev-toolkit is REQUIRED

### Summary Report Template

- Changed "Code Review" section to "Code Review (Sourcery - REQUIRED)"
- Removed "(or ⚠️ Review not available - skipped)" alternatives

### Tips Section

- Added explicit note: "ALWAYS run `dt-review` - do NOT assume GitHub's Sourcery check is sufficient"

---

## Files Modified

- `.cursor/commands/pr-validation.md`

---

## Testing

- Verified changes don't break command flow
- Next PR validation should correctly run `dt-review` as a required step

---

## Related

- **PR #47:** CI Git Configuration - where issue was discovered
- **Sourcery Review:** `admin/feedback/sourcery/pr47.md` - example of properly generated review

---

**Last Updated:** 2025-12-12  
**Status:** ✅ Complete

