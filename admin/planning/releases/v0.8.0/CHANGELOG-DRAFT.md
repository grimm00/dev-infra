# CHANGELOG Draft - v0.8.0

**Draft Created:** 2026-01-10  
**Status:** 📝 Draft - Needs Review

---

## [0.8.0] - 2026-01-XX

### Added

- **Worktree Feature Workflow** - Self-contained feature development with git worktrees (PR #59)

  - `worktrees/` directory pattern for project-relative worktrees
  - `.sourcery.yaml` configuration to ignore process docs in reviews
  - `scripts/worktrees.sh` - List and open worktrees with cursor commands
  - `scripts/shell-functions.sh` - Shell functions for quick worktree access (`wt`, `cursor-wt`)
  - `docs/WORKTREE-WORKFLOW.md` - Comprehensive workflow guide
  - 4 ADRs documenting architectural decisions:
    - ADR-001: Worktree Location and Naming
    - ADR-002: Self-Contained Feature Branches
    - ADR-003: Draft PR Review Workflow
    - ADR-004: Sourcery Configuration

- **Draft PR Workflow** - New `/pr` command flags for draft PR workflow

  - `--draft` - Create draft PR for early feedback
  - `--ready` - Mark draft PR as ready for review
  - `--review` - Request Sourcery review (manual trigger for drafts)

- **Template Updates** - Both templates now include `.sourcery.yaml`
  - `templates/standard-project/.sourcery.yaml`
  - `templates/learning-project/.sourcery.yaml`

### Changed

- **Cursor Rules** - Updated with worktree feature workflow guidance
- **`.gitignore`** - Added `worktrees/` directory pattern

### Fixed

- **CI** - Install coreutils on macOS for timeout command (PR #59)

---

## PRs Included

| PR  | Title                                          | Merged     |
| --- | ---------------------------------------------- | ---------- |
| #59 | feat: worktree feature workflow implementation | 2026-01-09 |

---

## Review Checklist

- [ ] All PRs listed
- [ ] Categorization correct
- [ ] Descriptions accurate
- [ ] Breaking changes noted (if any)
- [ ] Ready to merge into CHANGELOG.md
