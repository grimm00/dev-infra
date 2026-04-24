# Decisions Summary - Worktree Feature Workflow

**Purpose:** Summary of all decisions for the worktree feature workflow  
**Status:** ✅ Accepted  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 📋 Decisions Overview

Four key decisions define the refined git worktree workflow for feature development.

**Decision Points:** 4 decisions  
**Status:** ✅ All Accepted

---

## 🎯 Key Decisions

### Decision 1: Worktree Location and Naming

**Decision:** Use a `worktrees/` directory with names that mirror branch names (slash → hyphen).

**Example:**
- Branch: `feat/my-feature`
- Directory: `worktrees/feat-my-feature`

**Key Points:**
- `worktrees/` is gitignored
- Avoids Cursor confirmation prompts
- Predictable 1:1 mapping
- Window titles provide context

**Status:** ✅ Accepted

**ADR:** [adr-001-worktree-location-and-naming.md](adr-001-worktree-location-and-naming.md)

---

### Decision 2: Self-Contained Feature Branches

**Decision:** ALL feature-specific documentation lives on the feature branch.

**What goes on feature branch:**
- Exploration, research, decisions, planning
- Code and tests
- Everything merges atomically

**What stays on develop:**
- Global rules, commands, templates
- User documentation
- Cross-feature content

**Key Points:**
- Clean abandonment (no orphan docs)
- Holistic review (full context)
- Atomic merge (complete feature)

**Status:** ✅ Accepted

**ADR:** [adr-002-self-contained-feature-branches.md](adr-002-self-contained-feature-branches.md)

---

### Decision 3: Draft PR Review Workflow

**Decision:** Use draft PRs for continuous Sourcery feedback throughout feature development.

**Workflow:**
```
First commit → Push → Open Draft PR → Continuous feedback → Mark Ready → Merge
```

**Key Points:**
- Single PR per feature
- Open after first meaningful commit
- Sourcery reviews on every push
- Merge only when complete

**Status:** ✅ Accepted

**ADR:** [adr-003-draft-pr-review-workflow.md](adr-003-draft-pr-review-workflow.md)

---

### Decision 4: Sourcery Configuration

**Decision:** Create `.sourcery.yaml` that ignores process documentation.

**Configuration:**
```yaml
ignore:
  - admin/**
  - tmp/**
```

**Key Points:**
- Focuses reviews on code
- Reduces noise from doc comments
- No impact on code analysis
- Include in templates

**Status:** ✅ Accepted

**ADR:** [adr-004-sourcery-configuration.md](adr-004-sourcery-configuration.md)

---

## 📋 Requirements Impact

These decisions address the following key requirements:

| Requirement | Decision | Status |
|-------------|----------|--------|
| FR-1 to FR-4 (Naming) | ADR-001 | ✅ |
| FR-8 to FR-13 (Self-Contained) | ADR-002 | ✅ |
| FR-20 to FR-22 (Draft PR) | ADR-003 | ✅ |
| FR-14 to FR-17 (Sourcery) | ADR-004 | ✅ |

**See:** [requirements.md](../../research/worktree-feature-workflow/requirements.md) for complete requirements

---

## 🚀 Implementation Summary

### Immediate Actions

1. **Add to `.gitignore`:**
   ```gitignore
   worktrees/
   tmp/
   ```

2. **Create `.sourcery.yaml`:**
   ```yaml
   ignore:
     - admin/**
     - tmp/**
   ```

3. **Update `/pr` command:** Add `--draft` flag support

4. **Update templates:** Include `.sourcery.yaml` in both templates

### Workflow Changes

1. Create worktrees in `worktrees/` directory
2. Name mirrors branch (e.g., `feat-my-feature`)
3. All feature docs on feature branch
4. Open draft PR after first commit
5. Push frequently for feedback
6. Mark ready and merge when complete

---

## 🚀 Next Steps

1. Use `/transition-plan --from-adr` to create implementation plan
2. Implement changes in phases
3. Document new workflow in commands

---

**Last Updated:** 2026-01-09
