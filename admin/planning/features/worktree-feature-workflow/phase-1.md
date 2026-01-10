# Worktree Feature Workflow - Phase 1: Configuration

**Phase:** 1 - Configuration  
**Duration:** ~30 minutes  
**Status:** ✅ Complete  
**Completed:** 2026-01-09  
**Prerequisites:** None

---

## 📋 Overview

Set up `.gitignore` and `.sourcery.yaml` in dev-infra root to enable the worktree workflow.

**Success Definition:** Dev-infra has proper gitignore entries and Sourcery configuration that prevents process documentation noise in PRs.

---

## 🎯 Goals

1. **Add gitignore entries** - Exclude `worktrees/` and `tmp/` from git tracking
2. **Create .sourcery.yaml** - Configure Sourcery to ignore process documentation

---

## 📝 Tasks

### Task 1: Update .gitignore

**Purpose:** Add entries to prevent tracking of worktree directories and temporary files.

**Implementation Steps:**

1. **Read current .gitignore:**

   - [x] Check existing entries
   - [x] Identify appropriate section for new entries

2. **Add worktrees entry:**

   - [x] Add comment header: `# Git worktrees`
   - [x] Add entry: `worktrees/`

3. **Add tmp entry:**
   - [x] Add comment header: `# Temporary files (handoff docs, scratch)`
   - [x] Add entry: `tmp/`

**Content to Add:**

```gitignore
# Git worktrees (created with `git worktree add`)
worktrees/

# Temporary files (handoff docs, scratch)
tmp/
```

**Requirements Addressed:**

- FR-3: Gitignore Configuration
- FR-2: Project-Relative Location (worktrees/ needs to exist but not be tracked)

**Checklist:**

- [x] Existing .gitignore reviewed
- [x] `worktrees/` entry added
- [x] `tmp/` entry added
- [x] Comments explain purpose

---

### Task 2: Create .sourcery.yaml

**Purpose:** Configure Sourcery to ignore process documentation for cleaner code reviews.

**Implementation Steps:**

1. **Create .sourcery.yaml in root:**

   - [x] Create new file: `.sourcery.yaml`
   - [x] Add ignore patterns from ADR-004

2. **Configure ignore patterns:**
   - [x] Ignore `admin/**` (explorations, research, decisions, planning)
   - [x] Ignore `tmp/**` (temporary files, handoff docs)

**Content to Create:**

```yaml
# Sourcery Configuration
# Ignore process documentation to focus code review on actual code
# See: admin/decisions/worktree-feature-workflow/adr-004-sourcery-configuration.md

ignore:
  - admin/** # Process docs (explorations, research, decisions, planning)
  - tmp/** # Temporary files (handoff docs, scratch)
```

**Requirements Addressed:**

- FR-14: Create .sourcery.yaml
- FR-15: Sourcery Ignore admin/\*\*
- NFR-5: Sourcery Ignore Process Docs
- NFR-8: No Code Analysis Impact

**Checklist:**

- [x] `.sourcery.yaml` created in root
- [x] `admin/**` ignore pattern added
- [x] `tmp/**` ignore pattern added
- [x] Comment references ADR-004

---

### Task 3: Verify Configuration

**Purpose:** Confirm both configuration files are correct and functional.

**Verification Steps:**

1. **Verify .gitignore:**

   - [x] Run `git status` - should not show worktrees/ or tmp/
   - [x] Create test directory: `mkdir -p tmp/test` (should be ignored)
   - [x] Verify: `git check-ignore -v tmp/test` (should show .gitignore rule)
   - [x] Clean up: `rm -r tmp/test`

2. **Verify .sourcery.yaml:**

   - [x] Confirm file exists: `ls -la .sourcery.yaml`
   - [x] Validate YAML syntax: `cat .sourcery.yaml`
   - [x] Check patterns are correct

3. **Document verification:**
   - [x] Update task status
   - [x] Note any issues found

**Commands to Run:**

```bash
# Verify gitignore is working
git check-ignore -v worktrees/test-dir 2>/dev/null || echo "Pattern should match when worktrees/ exists"
git check-ignore -v tmp/handoff.md 2>/dev/null || echo "Pattern should match when tmp/ exists"

# Verify sourcery.yaml exists and is valid
cat .sourcery.yaml

# Show what would be ignored
git status --ignored
```

**Checklist:**

- [x] .gitignore patterns verified
- [x] .sourcery.yaml syntax validated
- [x] Both files committed

---

## 📊 Progress Tracking

| Task                          | Status      | Notes                                          |
| ----------------------------- | ----------- | ---------------------------------------------- |
| Task 1: Update .gitignore     | ✅ Complete | Updated worktrees/ path, enhanced tmp/ comment |
| Task 2: Create .sourcery.yaml | ✅ Complete | Created with admin/** and tmp/** ignore        |
| Task 3: Verify Configuration  | ✅ Complete | Both patterns verified working                 |

---

## ✅ Completion Criteria

- [x] `.gitignore` includes `worktrees/` entry
- [x] `.gitignore` includes `tmp/` entry
- [x] `.sourcery.yaml` exists in root
- [x] `.sourcery.yaml` ignores `admin/**`
- [x] `.sourcery.yaml` ignores `tmp/**`
- [x] Verification commands pass
- [x] Changes committed

---

## 📦 Deliverables

- Updated `.gitignore` file with worktree/tmp entries
- New `.sourcery.yaml` file with ignore patterns
- Verification that patterns work correctly

---

## 💡 Implementation Notes

### Sourcery YAML Format

Sourcery uses a simple `ignore` list with glob patterns:

- `admin/**` - matches all files under admin/ recursively
- `tmp/**` - matches all files under tmp/ recursively

### Gitignore Pattern Notes

- Trailing `/` means "directory only" (not files named worktrees or tmp)
- These patterns apply from the repo root

### Why These Specific Paths?

| Path         | Reason                                                     |
| ------------ | ---------------------------------------------------------- |
| `worktrees/` | Git worktree directories (ADR-001)                         |
| `tmp/`       | Handoff docs and scratch files (FR-19)                     |
| `admin/**`   | Process documentation that shouldn't be reviewed (ADR-004) |

---

## 🔗 Dependencies

### Prerequisites

- None (first phase)

### Blocks

- Phase 2 (Template Updates) - needs `.sourcery.yaml` as reference

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Next Phase: Phase 2](phase-2.md)
- [ADR-001: Worktree Location](../../decisions/worktree-feature-workflow/adr-001-worktree-location-and-naming.md)
- [ADR-004: Sourcery Configuration](../../decisions/worktree-feature-workflow/adr-004-sourcery-configuration.md)
- [Requirements Document](../../research/worktree-feature-workflow/requirements.md)

---

**Last Updated:** 2026-01-09  
**Status:** ✅ Complete  
**Next:** Phase 2 - Template Updates
