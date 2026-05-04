# Release Notes - v0.10.0

**Version:** v0.10.0  
**Release Date:** 2026-02-28  
**Status:** ✅ Published (GitHub Release)

---

## 🎉 Highlights

**Workflow Simplification** — v0.10.0 replaces the phase-based planning structure with a uniform `implementation-plan.md` + `tasks/` layout. Every feature now follows the same structure: one index file with grouped task files. New `/task` and `/plan-review` commands replace their phase-based predecessors, and all existing commands support both old and new structures during migration.

---

## ✨ New Features

### Uniform Planning Structure

The core change in v0.10.0. Instead of separate phase files (`phase-1.md`, `phase-2.md`, ...), features now use:

```
feature-name/
├── implementation-plan.md    # Single index with all tasks
├── status-and-next-steps.md  # Progress tracking
└── tasks/
    ├── 01-foundation.md      # Task group files
    ├── 02-commands.md
    └── 03-verification.md
```

**Benefits:**
- Simpler structure — one index file instead of multiple phase documents
- Grouped tasks instead of rigid phases
- Easier for AI assistants to navigate and update
- Clear specification as single source of truth

### `/task` Command

Replaces `/task-phase` with a cleaner hybrid interface:

- `/task next` — Pick the next unchecked task automatically
- `/task 5` — Work on task #5 specifically
- `/task` — Show current status and progress

### `/plan-review` Command

Replaces `/pre-phase-review`. Reviews implementation plans before work begins to catch gaps, missing dependencies, and unclear requirements early.

### `/discuss` Command

New read-only structured conversation mode for exploring ideas, design discussions, and brainstorming without making changes to the codebase.

### Command Feedback Loops

- `/explore --amend` — Refine exploration scaffolding before conducting
- `/research --add-topic` — Add topics to existing research structures
- `/research --consolidate` — Consolidate findings into requirements review

---

## 🔧 Improvements

- **`/transition-plan` rewritten** — Generates uniform `implementation-plan.md` + `tasks/` output. Two-mode pattern (setup + expand) preserved.
- **Dual-path detection** — `/pr`, `/post-pr`, and `/status` detect both legacy phase-based and new uniform structures for smooth migration.
- **Doc-gen templates** — New templates for `implementation-plan.md` and task group files.
- **Validation rules** — `implementation_plan` and `task_group` document types added to `planning.yaml`.
- **Planning specification** — Single source of truth for the uniform layout contract.

---

## 🔄 Migration

### Deprecation Stubs

`/task-phase` and `/pre-phase-review` are now deprecation stubs that redirect to `/task` and `/plan-review`. Existing projects using these commands will see a migration notice.

### Dual-Path Support

Commands automatically detect which planning structure a feature uses (phase-based or uniform) and adapt accordingly. No immediate migration required for existing features.

### Migration Guide

See `docs/MIGRATION-v0.10.md` for complete details on:
- Old vs new structure comparison
- Adoption strategy
- Command mapping table
- FAQ

---

## 🐛 Bug Fixes

- **Template sync** — `explore.md --amend` mode synced to both standard and learning templates.

---

## 📚 Documentation

- Workflow-simplification research (6 topics)
- 4 ADRs for workflow-simplification decisions
- ADR-001 amended from tiered to uniform planning
- AI prompt lifecycle exploration scaffolding
- Command system prior art assessment
- ADR traceability gap patches

---

## 📊 Statistics

| Metric | Value |
|--------|-------|
| PRs Merged | 1 (PR #68) |
| Commits | 39 |
| Files Changed | 102 |
| Lines Added | ~17,100 |
| Lines Removed | ~7,700 |
| Commands (in templates) | 26 (including 2 deprecation stubs) |
| Commands (dev-infra total) | 30 |

---

## ⚠️ Breaking Changes

None. Dual-path detection ensures backward compatibility with existing phase-based features.

---

**Full Changelog:** [v0.9.0...v0.10.0](https://github.com/grimm00/dev-infra/compare/v0.9.0...v0.10.0)
