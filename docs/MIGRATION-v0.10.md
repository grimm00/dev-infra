# Migration Guide: v0.10.0 — Uniform Planning Structure

**Purpose:** Guide for projects upgrading from phase-based planning to the uniform `implementation-plan.md` + `tasks/` structure  
**Status:** 🟠 Draft  
**Last Updated:** 2026-02-19

---

## What Changed

v0.10.0 replaces the phase-based planning structure with a uniform layout that every feature uses regardless of size.

| Aspect | Before (v0.9.x) | After (v0.10.0) |
|--------|-----------------|-----------------|
| Plan entry point | `feature-plan.md` | `implementation-plan.md` |
| Task breakdown | `phase-1.md`, `phase-2.md`, ... | `tasks/group-name.md` |
| Progress tracking | `status-and-next-steps.md` | `status-and-next-steps.md` (retained) |
| Task format | Prose/bullet lists in phase files | GFM checkboxes (`- [ ] Task N: ...`) |
| Metadata | None | YAML frontmatter (task count, groups, files) |
| Command | `/task-phase N` | `/task next`, `/task N`, `/task` |

---

## Directory Layout Comparison

**Old structure (v0.9.x):**

```
features/my-feature/
├── README.md
├── feature-plan.md              # Overview + phase references
├── status-and-next-steps.md     # Phase-based progress table
├── phase-1.md                   # Tasks for phase 1
├── phase-2.md                   # Tasks for phase 2
└── phase-3.md                   # Tasks for phase 3
```

**New structure (v0.10.0):**

```
features/my-feature/
├── README.md                    # (optional) Feature hub
├── implementation-plan.md       # Task index + YAML frontmatter
├── status-and-next-steps.md     # Group-based progress table
└── tasks/                       # Task details (always present)
    ├── 01-authentication.md     # Tasks for authentication group
    ├── 02-api-endpoints.md      # Tasks for API group
    └── 03-testing.md            # Tasks for testing group
```

Numeric prefixes ensure filesystem sort matches execution order.

---

## Adoption Strategy: "New Features Only"

**You do NOT need to migrate existing features.** The adoption strategy is:

- **New features** created after upgrading use the new structure automatically. `/transition-plan` generates the uniform layout.
- **Existing features** with `phase-N.md` files continue to work. Commands detect which structure is present and handle both.
- **In-progress features** are not affected. Continue using `/task-phase` for features that have phase files.

There is no "flag day" where everything must change at once.

---

## How Commands Handle Both Structures

Updated commands detect the planning structure by checking which files exist:

| Detection | Structure | Command Behavior |
|-----------|-----------|-----------------|
| `implementation-plan.md` exists | New (v0.10.0) | Read from `implementation-plan.md` + `tasks/` |
| `feature-plan.md` + `phase-*.md` exist | Legacy (v0.9.x) | Read from phase files (unchanged behavior) |

Commands affected:
- `/task` (new) — reads `implementation-plan.md` and `tasks/`
- `/task-phase` (deprecated) — still works for legacy features; stub file points to `/task`
- `/pr` — detects structure and formats PR description accordingly
- `/post-pr` — updates status in whichever format is present
- `/transition-plan` — generates the new uniform structure for new features

---

## What You Need to Do

### If You Have an Existing Project (generated from v0.9.x or earlier)

1. **Update your templates** — Pull the latest dev-infra templates (commands, rules, etc.)
2. **Use `/task` for new features** — When you start a new feature, `/transition-plan` will generate the new structure
3. **Keep using `/task-phase` for existing features** — No changes needed for in-progress work
4. **No file renaming required** — Old phase files are valid indefinitely

### If You Are Starting a New Project

No action needed. `new-project.sh` generates the new structure by default.

---

## Validation Rules

The `planning.yaml` validation rules accept both structures during the transition period:

| Document Type | Status | Path Pattern |
|---------------|--------|-------------|
| `implementation_plan` | **New** | `**/planning/features/*/implementation-plan.md` |
| `task_group` | **New** | `**/planning/features/*/tasks/*.md` |
| `feature_plan` | Deprecated | `**/planning/features/*/feature-plan.md` |
| `phase` | Deprecated | `**/planning/features/*/phase-*.md` |
| `status_and_next_steps` | Updated | `**/planning/features/*/status-and-next-steps.md` |

Deprecated types will be removed in a future major version.

---

## YAML Frontmatter

The new `implementation-plan.md` includes machine-readable frontmatter:

```yaml
---
task_count: 18
groups:
  - name: "Foundation & Specs"
    file: "tasks/01-foundation-and-specs.md"
    tasks: [1, 2, 3]
  - name: "Command Infrastructure"
    file: "tasks/02-command-infrastructure.md"
    tasks: [4, 5, 6, 7]
tasks_files:
  - "tasks/01-foundation-and-specs.md"
  - "tasks/02-command-infrastructure.md"
---
```

This frontmatter is the contract between `/transition-plan` (producer) and `/task` (consumer). Commands read it to locate task files without scanning the filesystem.

---

## FAQ

**Q: Do I have to rename `feature-plan.md` to `implementation-plan.md` for existing features?**  
A: No. Existing features keep their current structure. Only new features use the new layout.

**Q: Can I manually migrate an existing feature?**  
A: Yes, but it's not required or recommended unless the feature has significant remaining work. If you do, rename `feature-plan.md` to `implementation-plan.md`, move phase content into `tasks/` files, add YAML frontmatter, and update `status-and-next-steps.md`.

**Q: What happens to `/task-phase`?**  
A: It becomes a deprecation stub that displays a message pointing to `/task`. It still works for legacy features during the transition period.

**Q: Will old and new features coexist in the same project?**  
A: Yes. Each feature directory is independent. You can have some features with `phase-N.md` files and others with `tasks/` directories in the same project.

---

## Related

- [ADR-001: Uniform Planning Structure](../admin/decisions/workflow-simplification/adr-001-tiered-planning-structure.md)
- [ADR-004: Migration Strategy](../admin/decisions/workflow-simplification/adr-004-migration-strategy.md)

---

**Last Updated:** 2026-02-19
