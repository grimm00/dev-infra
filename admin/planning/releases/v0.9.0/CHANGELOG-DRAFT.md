# CHANGELOG Draft - v0.9.0

**Draft Created:** 2026-02-13
**Status:** 🔴 Draft - Needs Review

---

## [0.9.0] - 2026-02-XX

### Added

- **`/spike` command** - Time-boxed technical experiments (2-4 hours) to validate high-risk assumptions before committing to full implementation. Integrates with the explore → research → decision pipeline via spike determination tables. (PR #65)
- **`/review` command** - Stage changes, capture a diff summary, and draft a commit message without committing. Forces a deliberate pause for reviewing agentic code changes. (PR #65)
- **`/commit` command** - Second half of review-then-commit workflow: commit from review context, clean up artifacts. Supports same-session and cross-session flows. (PR #65)
- **`/handoff` command** - Session continuity: capture current work state for resuming later (`--resume`) or handing off to a teammate. Multi-path detection for project structure. (PR #65)
- **`/explore` Two-Mode Pattern** - Setup mode creates scaffolding (~60-80 lines) for human review; conduct mode expands to full exploration (~200-300 lines). (PR #61)
- **Input Sources for `/explore`** - Raw text (`--input`), start.txt (`--from-start`), and reflections (`--from-reflect`) as explicit input sources. (PR #61)
- **Worktree Integration for `/explore`** - Lazy worktree creation prompts on conduct mode; `--worktree` and `--no-worktree` flags for explicit control. (PR #61)
- **Spike Determination Tables** - `/explore` setup and conduct modes now include spike risk assessment tables to identify topics that need hands-on validation. (PR #65)
- **Doc-Gen Template Enhancements** - Exploration, research, and decision templates enhanced with structural examples and variable documentation. (PR #65, PR #63)
- **Template-Doc-Infrastructure Specifications** - FORMAT.md (placeholder specification), VARIABLES.md (variable reference), AUTHORING.md (template authoring guide), VALIDATION.md (validation rules). (PR #63)
- **17 Doc-Gen Templates** - Complete set of document generation templates for explorations, research, decisions, handoffs, fixes, and planning documents. (PR #63)
- **Validation Rules** - Type-specific YAML validation rules for exploration, research, decision, planning, fix, and handoff templates. (PR #63)
- **Two-Mode Pattern Documentation** - `docs/TWO-MODE-PATTERN.md` documents the pattern for other commands. (PR #61)
- **Scaffolding Boundaries** - Clear line count guidance for consistent AI output quality. (PR #61)

### Changed

- **Review-then-commit integration** - `/task-phase`, `/fix-implement`, `/task-release`, and `/task-improvement` now recommend `/review` for code changes before committing. Direct commit reserved for documentation-only changes. (PR #65)
- **`/explore` command** - Reorganized into two modes with explicit human review checkpoint between setup and conduct. (PR #61)
- **Sourcery configuration** - Dev-infra ignores `.cursor/**` and `docs/**`; templates ignore `.cursor/**`. Focuses Sourcery reviews on actual code. (PR #65)
- **Command pipeline** - `/explore` now documented as ideation pipeline entry point in `docs/GLOBAL-COMMANDS.md`. (PR #61)
- **Template sync manifest** - Updated from 19 to 23 commands to include spike, review, commit, and handoff. (PR #65)
- **Cursor rules** - `workflow.mdc` updated with spike workflow and review-then-commit workflow sections. `main.mdc` updated with 23 command count. (PR #65)

---

## PRs Included

| PR | Title | Merged |
|----|-------|--------|
| #61 | feat: Enhance /explore with Two-Mode Pattern | 2026-01-13 |
| #63 | feat(templates): Enhance exploration templates with structural examples (ADR-006) | 2026-01-26 |
| #65 | feat: New commands and template enhancements | 2026-02-13 |

---

## Review Checklist

- [ ] All PRs listed
- [ ] Categorization correct (Added vs Changed)
- [ ] Descriptions accurate and user-facing
- [ ] No breaking changes (confirmed additive only)
- [ ] Ready to merge into CHANGELOG.md
