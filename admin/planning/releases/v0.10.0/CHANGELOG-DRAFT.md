# CHANGELOG Draft - v0.10.0

**Draft Created:** 2026-02-27  
**Status:** 🔴 Draft - Needs Review

---

## [0.10.0] - 2026-02-28

### Added

- **Uniform Planning Structure** - Replace phase-based planning with a single `implementation-plan.md` + `tasks/` layout for every feature. Simplifies feature planning from multi-file phase structure to one index file with grouped task files. (PR #68)
- **`/task` command** - New task implementation command replacing `/task-phase`. Supports hybrid interface: `next` (pick next unchecked task), `N` (specific task number), or bare (show status). Works with the uniform planning structure. (PR #68)
- **`/plan-review` command** - New plan review command replacing `/pre-phase-review`. Reviews implementation plans before work begins to catch issues early. (PR #68)
- **`/discuss` command** - Read-only structured conversations for exploring ideas without making changes. Useful for design discussions and brainstorming.
- **`/explore --amend` mode** - Feedback loop for refining exploration scaffolding before conducting full exploration.
- **`/research --add-topic` mode** - Add new research topics to an existing research structure.
- **`/research --consolidate` mode** - Consolidate research findings into a requirements review document.
- **Uniform planning doc-gen templates** - Document generation templates for `implementation-plan.md` and task group files matching the new structure. (PR #68)
- **`implementation_plan` and `task_group` validation types** - New document type validation rules in `planning.yaml` for the uniform structure. (PR #68)
- **Planning structure specification** - Single source of truth for the uniform layout contract in `planning.yaml`. (PR #68)
- **Migration guide** - `docs/MIGRATION-v0.10.md` covering old vs new structure, adoption strategy, and command dual-path support. (PR #68)
- **Deprecation stubs** - `/task-phase` and `/pre-phase-review` commands replaced with stubs that redirect to `/task` and `/plan-review`. (PR #68)

### Changed

- **`/transition-plan` rewritten** - Updated for uniform planning output. Two-mode pattern (setup + expand) preserved, but output now generates `implementation-plan.md` + `tasks/` instead of phase files. (PR #68)
- **Dual-path detection** - `/pr`, `/post-pr`, and `/status` commands detect both legacy phase-based and new uniform structures for smooth migration. (PR #68)
- **Template sync manifest** - Updated from 23 to 26 commands to include `/task`, `/plan-review`, and 2 deprecation stubs. (PR #68)
- **Cursor rules** - `main.mdc` and `workflow.mdc` updated with uniform planning structure guidance and 26 command count. (PR #68)
- **`feature_plan` and `phase` validation types deprecated** - Replaced by `implementation_plan` and `task_group` types. (PR #68)

### Fixed

- **Template sync** - `explore.md --amend` mode synced to both standard and learning templates.

### Documentation

- **Workflow-simplification research** - 6 research topics conducted covering planning structure analysis, command interface design, transition plan output format, template impact assessment, and dev-infra code boundary.
- **ADR updates** - ADR-001 (Uniform Planning Structure) amended from tiered to uniform; workflow-simplification ADRs (001-004) created.
- **AI prompt lifecycle exploration** - New exploration and research scaffolding for AI prompt lifecycle topic.
- **Prior art assessment** - Strategic assessment of command system prior art captured.
- **ADR traceability** - Patched gaps and added missing decision records.

---

## PRs Included

| PR | Title | Merged |
|----|-------|--------|
| #68 | feat(workflow): uniform planning structure implementation (v0.10.0) | 2026-02-28 |

---

## Review Checklist

- [ ] All PRs listed
- [ ] Categorization correct
- [ ] Descriptions accurate
- [ ] Breaking changes noted (if any)
- [ ] Ready to merge into CHANGELOG.md
