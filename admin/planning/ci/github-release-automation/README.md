# GitHub Release Automation

**Purpose:** Automatically create GitHub Releases from tags  
**Status:** ✅ Complete  
**Priority:** 🔴 HIGH  
**Created:** 2025-12-12  
**Completed:** 2026-02-28  
**Source:** [Release Automation v2 Reflection](../../notes/reflections/reflection-release-automation-v2-2025-12-12.md)

---

## 📋 Quick Links

- **[Improvement Plan](improvement-plan.md)** - Detailed implementation plan
- **[Related Workflow](.github/workflows/create-release-tag.yml)** - Current tag creation workflow
- **[Release Distribution](.github/workflows/release-distribution.yml)** - Triggered by GitHub Releases

---

## 🎯 Overview

**Problem:**
The `create-release-tag.yml` workflow creates a Git tag but not a GitHub Release. The `release-distribution.yml` workflow triggers on `release: [published]`, not tag push. This creates a manual gap in the release process.

**Discovered:** v0.5.0 release (2025-12-12) - required manual `gh release create` command

**Impact:**
- Manual step required to create GitHub Release after tag
- Risk of forgetting the step in future releases
- Release distribution doesn't trigger automatically

**Solution:**
Update the tag creation workflow to also create a GitHub Release using `gh release create`.

---

## 📊 Priority Assessment

| Metric | Value |
|--------|-------|
| Priority | 🔴 HIGH |
| Impact | 🟠 HIGH |
| Effort | 🟢 LOW (30 minutes) |

---

## 📅 Timeline

**Target:** Before v0.6.0 release

---

## 🔗 Related

- **[Improvement Plan](improvement-plan.md)** - Implementation details
- **[v0.5.0 Release Learnings](../../opportunities/internal/dev-infra/learnings/release-automation-v2/v0.5.0-release-learnings.md)**
- **[Release Automation v2 Reflection](../../notes/reflections/reflection-release-automation-v2-2025-12-12.md)**

---

**Last Updated:** 2026-02-28  
**Status:** ✅ Complete

