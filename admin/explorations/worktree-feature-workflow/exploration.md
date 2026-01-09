# Worktree Feature Workflow - Exploration

**Status:** 🔴 Exploration  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09

---

## 🎯 What Are We Exploring?

A refined git worktree workflow for feature development that:

1. **Manual worktree creation** - Meaningful names instead of Cursor's random 3-letter codes
2. **Self-contained feature branches** - ALL docs (exploration, research, decisions) live on the feature branch
3. **Review gate** - Ideas reviewed via PR before merging to develop
4. **sourcery.yml integration** - Ignore docs in PRs to enable doc commits on feature branches

---

## 🤔 Why Explore This?

### Problems Identified

| Problem | Impact |
|---------|--------|
| **Cursor random worktree names** | `wxw`, `eik`, `hyn` → impossible to know what each worktree is for |
| **Docs committed to develop prematurely** | Ideas that don't pan out pollute git history |
| **Separate doc branches** | Unnecessary complexity to push docs without breaking PRs |
| **Exploration "topics" confusion** | When working in parallel, naming collides |

### Current State

Existing `docs/WORKTREE-GUIDE.md` provides:
- ✅ Multi-agent development patterns
- ✅ Role assignments (Sonnet, Composer, Haiku)
- ✅ Basic worktree commands
- ❌ No guidance on worktree naming
- ❌ No self-contained feature workflow
- ❌ No review gate pattern

### Discovery Moment

> "When getting into naming these things 'topics', trying to explore features in parallel finally made me understand why worktrees are vitally important."

Working on multiple explorations simultaneously (`explore-two-mode`, `four-arm-architecture`) revealed:
- Each exploration needs its own isolated space
- Docs for an exploration should travel WITH the exploration
- If an idea doesn't pan out, the whole thing can be discarded

---

## 💡 Initial Thoughts

### Manual Worktree Naming

**Current (Cursor-generated):**
```
~/.cursor/worktrees/proj-cli/wxw/    # What is this?
~/.cursor/worktrees/dev-infra/eik/   # No idea
~/.cursor/worktrees/dev-infra/hyn/   # Mystery
```

**Proposed (Manual):**
```
.cursor/worktrees/dev-infra/feat-explore-two-mode/
.cursor/worktrees/dev-infra/feat-worktree-workflow/
.cursor/worktrees/proj-cli/feat-work-prod-integration/
```

**Commands:**
```bash
# Create meaningful worktree
git worktree add .cursor/worktrees/dev-infra/feat-explore-two-mode feat/explore-two-mode

# Or create new branch at same time
git worktree add -b feat/explore-two-mode .cursor/worktrees/dev-infra/feat-explore-two-mode
```

### Self-Contained Feature Branches

**Current workflow:**
```
develop
    └── feat/my-feature
            └── code changes only
                docs committed to develop separately
```

**Proposed workflow:**
```
develop
    └── feat/my-feature
            ├── code changes
            ├── admin/explorations/my-feature/
            ├── admin/research/my-feature/
            ├── admin/decisions/my-feature/
            └── admin/planning/features/my-feature/
```

**Benefits:**
- Feature is 100% self-contained
- If feature is abandoned, git history stays clean
- Review happens on entire feature (code + docs)
- Easy to see the full context of a feature

### Review Gate Pattern

**Current:**
```
1. Work on feature
2. Commit docs to develop (premature)
3. Work more
4. PR code to develop
5. Merge → docs already there, even if idea changed
```

**Proposed:**
```
1. Create feature worktree
2. All work (code + docs) on feature branch
3. PR feature branch to develop
4. Review entire feature
5. Merge only if idea pans out
6. If abandoned → delete branch, develop stays clean
```

### sourcery.yml Integration

**Problem:** Sourcery reviews docs in PRs, creating noise.

**Solution:** Configure `.sourcery.yaml` to ignore docs:

```yaml
# .sourcery.yaml
ignore:
  - admin/**
  - docs/maintainers/**
```

**This enables:**
- Docs can be committed to feature branch
- PRs to develop don't flag doc changes
- Clean code reviews focused on implementation

---

## 🔍 Key Questions

### Worktree Naming
- [ ] What naming convention? `feat-<name>` vs `<feature-name>`?
- [ ] Where should worktrees live? `.cursor/worktrees/` vs project-relative?
- [ ] How to document existing worktrees?

### Self-Contained Features
- [ ] Should ALL docs go on feature branch, or just exploration/research?
- [ ] How to handle docs that span multiple features?
- [ ] What about updates to global docs (like rules)?

### Review Gate
- [ ] What's the minimum viable feature to merge?
- [ ] How to handle long-running features with develop drift?
- [ ] Should explorations that lead to "no action" still be merged for learning?

### sourcery.yml
- [ ] What paths to ignore?
- [ ] Should this be in templates or just dev-infra?
- [ ] How does this affect Sourcery's code analysis?

### Context Switching
- [ ] How to quickly see all active worktrees?
- [ ] How to switch between worktrees in Cursor?
- [ ] Should there be a `/worktree` command?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research worktree-feature-workflow --from-explore worktree-feature-workflow` to conduct research
3. After research, use `/decision worktree-feature-workflow --from-research` to make decisions

---

## 📝 Notes

### Existing Work to Build On

The `docs/WORKTREE-GUIDE.md` already covers:
- Basic worktree structure
- Multi-agent patterns
- Role assignments

This exploration focuses on:
- **Naming** (not covered)
- **Self-contained features** (new concept)
- **Review gate** (new pattern)
- **sourcery.yml integration** (new)

### Connection to explore-two-mode

This exploration was triggered during `explore-two-mode` research when working on parallel "topics" revealed the need for better worktree workflow. The two are related:

- `explore-two-mode` → Command enhancement
- `worktree-feature-workflow` → Development workflow enhancement

Both improve how we work with explorations/features in parallel.

---

**Last Updated:** 2026-01-09
