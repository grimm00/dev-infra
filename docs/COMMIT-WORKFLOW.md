# Commit Workflow

**Purpose:** Central reference for commit patterns and workflows  
**Status:** ✅ Active  
**Last Updated:** 2025-12-08

---

## 📋 Quick Links

- **[Workflow Rules](../.cursor/rules/workflow.mdc)** - Complete workflow documentation
- **[Git Flow Workflow](../.cursor/rules/workflow.mdc#git-flow-workflow)** - Branch strategy and commit requirements

---

## 🎯 Overview

This document provides a central reference for commit patterns and workflows used across all commands. Commands should reference this document instead of duplicating commit instructions.

**Key Principle:** Commit frequently with small, logical commits. Always commit work before moving to next task or stopping.

---

## 📝 Commit Message Format

**Standard Format:**

```
type(scope): brief description

Longer explanation if needed

Related: [Context]
```

**Types:**

- `feat` - New feature/functionality
- `fix` - Bug fix
- `docs` - Documentation only
- `test` - Adding tests
- `refactor` - Code improvement
- `chore` - Maintenance
- `ci` - CI/CD changes

**Examples:**

- `feat(phase-3): implement DELETE endpoint`
- `docs(ci/status-tracking-automation): add status update reminders`
- `test(phase-3): add DELETE endpoint tests`
- `refactor(scripts): improve template generation script`

---

## 🔄 Commit Workflows by Branch Type

### Feature/Fix/CI Branches

**Workflow:**

- Create feature branch: `feat/[feature-name]`, `fix/[bug-name]`, `ci/[improvement-name]`
- Commit frequently with small commits
- Push to remote regularly
- Create PR when phase/tasks complete
- **DO NOT merge directly** - requires PR review

**Commit Pattern:**

- Commit after each logical unit (test file, implementation, documentation section)
- Small commits are better than large commits
- Commit message should clearly describe what changed

**Examples:**

```bash
git commit -m "test(phase-3): add DELETE endpoint tests"
git commit -m "feat(phase-3): implement DELETE endpoint"
git commit -m "docs(phase-3): update API documentation"
```

---

### Documentation/Chore Branches

**Workflow:**

- Create docs branch: `docs/[topic]` or `chore/[topic]`
- Commit frequently
- **CAN merge directly to develop** (no PR required)
- Use fast-forward merge

**Commit Pattern:**

- Same as feature branches (small, logical commits)
- Can merge directly after commits complete
- No PR review required

**Examples:**

```bash
git commit -m "docs(learnings): capture dev-infra learnings - Phase 4"
git commit -m "docs(reflection): create templates-enhancement reflection"
git commit -m "chore(ci): update Docker test image"
```

**Direct Merge Workflow:**

```bash
git checkout develop
git pull origin develop
git merge --ff-only docs/[topic] --no-edit
git push origin develop
git branch -d docs/[topic]
git push origin --delete docs/[topic]
```

---

## ⚠️ When to Commit

### Always Commit Before:

- Moving to next task group
- Stopping work (even if incomplete)
- Switching context
- Creating PR
- Merging branches

### Commit After:

- Each logical unit completed (test file, implementation, documentation section)
- Each task group completed
- Each phase completed
- Each fix batch completed

### Never Skip Commits:

- Even if work seems small
- Even if only documentation
- Even if only one file changed
- **Always commit before stopping**

---

## 🚨 Common Issues

### Issue: Work Not Committed

**Symptoms:**

- Uncommitted changes when command completes
- Work lost between sessions
- Git status shows modified files

**Solution:**

- **Always commit before stopping**
- Check `git status` before completing command
- Commit even if work seems incomplete
- Use descriptive commit messages

**Prevention:**

- Reference this workflow document
- Include commit step in command workflow
- Verify commits before completing command

---

### Issue: Large Commits

**Symptoms:**

- Single commit with many changes
- Hard to review
- Hard to revert specific changes

**Solution:**

- Break into smaller commits
- One commit per logical unit
- Commit frequently during work

**Prevention:**

- Commit after each logical unit
- Don't accumulate changes
- Reference commit patterns in this document

---

### Issue: Missing Commit Messages

**Symptoms:**

- Generic commit messages
- No context about what changed
- Hard to understand commit history

**Solution:**

- Use standard commit message format
- Include scope and description
- Add "Related:" line for context

**Prevention:**

- Reference commit message format
- Use examples from this document
- Include context in commit message

---

## 📚 Command-Specific Patterns

### `/task-phase` Command

**Commit Pattern:**

- Commit after each task group (RED + GREEN pair)
- Commit message: `feat(phase-N): implement [task description]` or `test(phase-N): add [test description]`
- Commit before stopping (even if more tasks remain)

**Example:**

```bash
git commit -m "test(phase-3): add DELETE endpoint tests"
git commit -m "feat(phase-3): implement DELETE endpoint"
```

---

### `/task-improvement` Command

**Commit Pattern:**

- Commit after each logical unit (documentation section, process improvement)
- Commit message: `docs(ci/[improvement-name]): [description]` or `feat(ci/[improvement-name]): [description]`
- Commit before stopping

**Example:**

```bash
git commit -m "docs(ci/status-tracking-automation): add status update reminders to task-phase command"
git commit -m "feat(ci/status-tracking-automation): integrate status checks into PR workflow"
```

---

### `/int-opp` Command

**Commit Pattern:**

- Create docs branch: `docs/int-opp-[project]-[topic]`
- Commit learnings document and hub updates
- Merge directly to develop (docs-only workflow)

**Example:**

```bash
git checkout -b docs/int-opp-dev-infra-phase-5
git add admin/planning/opportunities/internal/
git commit -m "docs(learnings): capture dev-infra learnings - Phase 5

Created learnings document for Phase 5:
- What worked well: Comprehensive workflow documentation
- What needs improvement: Template generation testing
- Time analysis: ~85 minutes

Updated learnings hub.

Related: Phase 5"
# Then merge directly to develop
```

---

### `/reflect` Command

**Commit Pattern:**

- Create docs branch: `docs/reflect-[feature]-[date]`
- Commit reflection document
- Merge directly to develop (docs-only workflow)

**Example:**

```bash
git checkout -b docs/reflect-templates-enhancement-2025-12-08
git add admin/planning/notes/reflections/
git commit -m "docs(reflection): create templates-enhancement feature reflection

Created comprehensive reflection document:
- Analyzed all 5 phases
- Identified patterns and opportunities
- Provided actionable suggestions

Related: Templates Enhancement Feature"
# Then merge directly to develop
```

---

### `/research` Command

**Commit Pattern:**

- Create docs branch: `docs/research-[topic]`
- Commit research documents and requirements
- Merge directly to develop (docs-only workflow)

**Example:**

```bash
git checkout -b docs/research-template-generation-testing-automation
git add admin/research/template-generation-testing-automation/
git commit -m "docs(research): add template generation testing automation research

Created research documents:
- Research hub with 2 research topics
- Non-interactive mode research
- Template validation test suite research
- Requirements document

Related: Template Generation Testing Automation"
# Then merge directly to develop
```

---

### `/decision` Command

**Commit Pattern:**

- Create docs branch: `docs/decision-[topic]`
- Commit ADR documents
- Merge directly to develop (docs-only workflow)

**Example:**

```bash
git checkout -b docs/decision-template-generation-testing-automation
git add admin/decisions/template-generation-testing-automation/
git commit -m "docs(decisions): add template generation testing automation decisions

Created ADR documents:
- ADR-001: Non-Interactive Mode Implementation
- ADR-002: Template Validation Test Suite

Related: Template Generation Testing Automation"
# Then merge directly to develop
```

---

## ✅ Commit Checklist

**Before Completing Any Command:**

- [ ] All changes staged (`git add`)
- [ ] Commit message follows format
- [ ] Commit made (`git commit`)
- [ ] Changes pushed if on feature branch (`git push`)
- [ ] Direct merge completed if docs-only branch
- [ ] Branch cleaned up if merged

**Verification:**

```bash
# Check for uncommitted changes
git status

# Verify last commit
git log -1

# Verify branch is clean
git status --short
```

---

## 🔗 Related Documentation

- **[Workflow Rules](../.cursor/rules/workflow.mdc)** - Complete workflow documentation including Git Flow
- **[Status Update Workflow](STATUS-UPDATE-WORKFLOW.md)** - Status update patterns (if exists)
- **[PR Workflow](../.cursor/commands/pr.md)** - PR creation workflow
- **[Worktree Feature Workflow](WORKTREE-WORKFLOW.md)** - Feature development with draft PRs (includes commit patterns for draft PR workflow)

---

**Last Updated:** 2025-12-08  
**Status:** ✅ Active  
**Next:** Commands should reference this document instead of duplicating commit instructions
