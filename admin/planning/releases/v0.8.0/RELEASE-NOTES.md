# Release Notes - v0.8.0

**Version:** v0.8.0  
**Release Date:** 2026-01-XX  
**Status:** 📝 Draft - Needs Review

---

## 🎉 Highlights

**Worktree Feature Workflow** - A refined git worktree workflow for self-contained feature development with built-in review gates.

This release introduces a new way to develop features using git worktrees that keeps all feature content (code, docs, explorations, research, decisions) on the feature branch until reviewed and merged. Key benefits:

- **Self-contained features** - Everything travels together
- **Review gates** - Ideas reviewed before polluting develop
- **Meaningful worktree names** - No more random 3-letter codes
- **Sourcery integration** - Process docs ignored in code reviews

---

## ✨ New Features

### Worktree Feature Workflow

A complete workflow for developing features in isolated worktrees:

```bash
# Create a worktree for your feature
git worktree add worktrees/feat-my-feature -b feat/my-feature

# Open in Cursor
cursor worktrees/feat-my-feature

# All work (code + docs) on feature branch
# When done: PR to develop with review gate
```

**Key Decisions (ADRs):**

| ADR     | Decision                                             |
| ------- | ---------------------------------------------------- |
| ADR-001 | Use `worktrees/` at project root (not `.cursor/`)    |
| ADR-002 | Self-contained branches (all docs on feature branch) |
| ADR-003 | Draft PR workflow for continuous feedback            |
| ADR-004 | Sourcery ignores `admin/**` in reviews               |

### Worktree Discovery Scripts

New scripts for managing worktrees:

```bash
# List all worktrees with cursor commands
./scripts/worktrees.sh

# Open worktree by index
./scripts/worktrees.sh open 1

# View handoff summaries
./scripts/worktrees.sh handoff
```

Shell functions for quick access (add to `~/.zshrc`):

```bash
source ~/Projects/dev-infra/scripts/shell-functions.sh

wt           # List worktrees
wt 1         # Open worktree 1
wt handoff   # Show handoffs
```

### Draft PR Workflow

New `/pr` command flags for working with draft PRs:

```bash
/pr --draft    # Create draft PR for early feedback
/pr --review   # Request Sourcery review
/pr --ready    # Mark draft PR as ready for review
```

---

## 🔧 Improvements

- **`.sourcery.yaml` in templates** - Both project templates now include Sourcery configuration
- **Updated cursor rules** - Worktree workflow guidance added to project rules
- **CI macOS fix** - Install coreutils for timeout command compatibility

---

## 📚 Documentation

- **[WORKTREE-WORKFLOW.md](docs/WORKTREE-WORKFLOW.md)** - Complete workflow guide
- **4 ADRs** - Architectural decisions documented in `admin/decisions/worktree-feature-workflow/`
- **Updated cursor rules** - Workflow guidance in `.cursor/rules/workflow.mdc`

---

## ⚠️ Breaking Changes

None in this release.

---

## 🔄 Migration Guide

No migration required. To adopt the worktree workflow:

1. Add `worktrees/` to your `.gitignore` (already in templates)
2. Copy `.sourcery.yaml` to your project root (already in templates)
3. Start using worktrees for new features

---

## 📊 Statistics

| Metric           | Value |
| ---------------- | ----- |
| PRs Merged       | 1     |
| New Files        | 10+   |
| ADRs Created     | 4     |
| Templates Updated| 2     |

---

## 🙏 Acknowledgments

Thanks to all contributors and the insights from dogfooding this workflow during its own development!

---

**Full Changelog:** [v0.7.0...v0.8.0](https://github.com/grimm00/dev-infra/compare/v0.7.0...v0.8.0)
