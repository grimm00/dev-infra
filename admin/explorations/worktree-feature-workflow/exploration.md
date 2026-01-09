# Worktree Feature Workflow - Exploration

**Status:** 🔴 Exploration  
**Created:** 2026-01-09  
**Last Updated:** 2026-01-09 (Session 2)

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
worktrees/feat-explore-two-mode/
worktrees/feat-worktree-workflow/
worktrees/feat-work-prod-integration/
```

> **Note:** Using `worktrees/` (project-relative) instead of `.cursor/worktrees/` to avoid Cursor confirmation prompts.

**Commands:**
```bash
# Create meaningful worktree (existing branch)
git worktree add worktrees/feat-explore-two-mode feat/explore-two-mode

# Or create new branch at same time
git worktree add -b feat/explore-two-mode worktrees/feat-explore-two-mode
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
- [ ] What naming convention? `feat-<name>` vs `<feature-name>` vs `<type>-<name>`?
- [x] Where should worktrees live? → **`worktrees/` (project-relative)** - avoids Cursor confirmation prompts
- [ ] Should directory name mirror branch name? (e.g., `feat-foo` ↔ `feat/foo`)
- [ ] How to document existing worktrees?
- [ ] How does naming affect window title identification?

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
- [ ] How to integrate `cursor` CLI for automatic opening?

---

## 💡 Session Insights (2026-01-09)

### Per-Window Focus is Optimal

**Evaluated approaches:**

| Approach | Best For | Pain Points |
|----------|----------|-------------|
| **Per-window** (one worktree each) | Deep focus work, clear AI context | Window switching, losing track |
| **Multi-root workspace** (all worktrees) | Overview, quick status checks | File list overload, confused AI |

**Conclusion:** Per-window is optimal for actual work. Workspaces are only useful for read-only overview.

**Why this matters:**
- One feature = one mental context
- Cursor AI works best with focused workspace
- Shorter file tree = faster navigation

### Window Titles as Primary Identifiers

Since per-window is optimal, **window titles become the primary way to identify worktrees**:

```
# Good: Window title shows "feat-explore-two-mode"
# Bad: Window title shows "wxw"
```

This strongly reinforces the importance of meaningful worktree naming.

### `cursor` CLI Integration

The `cursor` command can open directories directly:

```bash
cursor /path/to/worktree
```

**Opportunity:** Commands like `/explore` could:
1. Create the worktree with meaningful name
2. Provide copy/paste command to open it:

```
✅ Worktree created: feat-explore-two-mode

To open in new Cursor window:
cursor worktrees/feat-explore-two-mode
```

Or even automatically open it (with user confirmation).

### Workflow Vision

```
/explore my-new-feature --worktree
    │
    ├── Creates branch: feat/my-new-feature
    ├── Creates worktree: worktrees/feat-my-new-feature
    ├── Scaffolds exploration docs IN the worktree
    │
    └── Outputs: "cursor worktrees/feat-my-new-feature"
```

User copies command → new focused window opens → ready to work.

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
