# Improvement: Add Worktree Support to /post-pr Command

**Source:** Worktree Feature Workflow (PR #59)  
**Target:** Dev-infra /post-pr command  
**Status:** 🟡 Planned  
**Created:** 2026-01-09  
**Priority:** MEDIUM

---

## 📋 Overview

The `/post-pr` command needs worktree awareness to handle the new draft PR workflow properly.

---

## 🎯 Improvements Needed

### Detection

- [ ] **Detect worktree context**
  - Check if current directory is inside a worktree
  - Use `git worktree list` and compare paths
  - Adapt behavior based on context

### Safety Checks

- [ ] **Check for uncommitted changes**
  - Before cleanup, verify no uncommitted work
  - Warn and provide options if changes exist
  
- [ ] **Check for unpushed commits**
  - Verify all commits are pushed
  - Warn if local commits would be lost

### Cleanup Guidance

- [ ] **Provide cleanup commands**
  - Show worktree removal command
  - Show branch deletion commands
  - Only auto-cleanup if verified safe

### Documentation

- [ ] **Update /post-pr command docs**
  - Add worktree section
  - Document adapted behavior
  - Include cleanup examples

---

## 📝 Example Workflow

```bash
# If in worktree:
/post-pr 59

# Output:
# ⚠️ You're in a worktree: worktrees/feat-my-feature
# 
# PR #59 is merged. Cleanup steps:
# 
# 1. Exit worktree:
#    cd /path/to/main/repo
# 
# 2. Remove worktree:
#    git worktree remove worktrees/feat-my-feature
# 
# 3. Delete local branch:
#    git branch -d feat/my-feature
# 
# 4. Remote branch auto-deleted on merge (or):
#    git push origin --delete feat/my-feature
```

---

## 🔗 Related

- **Source Feature:** Worktree Feature Workflow
- **Command:** `.cursor/commands/post-pr.md`
- **ADR:** `admin/decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md`

---

**Last Updated:** 2026-01-09
