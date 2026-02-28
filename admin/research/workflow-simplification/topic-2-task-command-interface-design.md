# Topic 2: Task Command Interface Design - Research Document

**Purpose:** Design the interface for `/task` to replace `/task-phase` while remaining useful for both simple and complex features  
**Status:** ✅ Complete  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14

---

## 📋 Quick Links

- **[Workflow Simplification Research Hub](README.md)** - Parent research hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 5 topics
- **[Topic 1: Feature Plan Structure Usage](topic-1-feature-plan-usage.md)** - Foundation for simplification
- **[Topic 5: Command Dependency Analysis](topic-5-command-dependency-analysis.md)** - Phase concept embedding

---

## 🎯 Research Question

What interface would `/task` need to replace `/task-phase` while remaining useful for both simple and complex features?

---

## 🔍 Research Goals

- [x] Goal 1: Analyze `/task-phase` internals -- what depends on "phase" vs. what's task-generic?
- [x] Goal 2: Prototype 2-3 interface options against real features
- [x] Goal 3: Determine if `/task next` loses important context vs. `/task 7`
- [x] Goal 4: Check if backward compatibility (`/task-phase` as alias) is feasible in Cursor commands

---

## 📚 Research Methodology

**Sources:**

- [x] Codebase analysis: `.cursor/commands/task-phase.md` (927 lines)
- [x] Codebase analysis: Completed features (command-simplification, worktree, release-readiness)
- [x] Web search: CLI task runner interface design patterns (Cobra, oclif, Taskfile, Taskwarrior)
- [x] Web search: Cursor IDE custom command aliasing and backward compatibility
- [x] Web search: Flat task list vs. hierarchical phases in project management CLIs

---

## 📊 Findings

### Finding 1: `/task-phase` Has a Clear Phase-Dependent / Task-Generic Split

Analysis of the 927-line `/task-phase` command reveals two distinct layers:

**Phase-dependent parts (would need replacement):**

| Part | Lines | What it does |
|------|-------|-------------|
| Phase path detection | ~40 | Finds `phase-N.md` in feature-specific or project-wide paths |
| Branch naming | ~20 | Creates `feat/phase-N-[desc]` or `feat/[feature]-phase-N-[desc]` |
| Branch validation | ~35 | Validates current branch matches `feat/*-phase-N-*` pattern |
| Phase status updates | ~60 | Reads/writes `phase-N.md` status fields (In Progress, Complete) |
| Feature status updates | ~40 | Updates `status-and-next-steps.md` with phase progress |
| Commit message format | ~10 | Uses `docs(phase-N): ...` and `feat(phase-N): ...` |
| PR integration | ~15 | References `/pr --phase [N]` and `/post-pr --phase N` |
| Pre-phase-review | ~15 | Integration with `/pre-phase-review` and `/address-review` |
| **Subtotal** | **~235** | **~25% of command** |

**Task-generic parts (survive renaming):**

| Part | Lines | What it does |
|------|-------|-------------|
| TDD workflow (RED/GREEN/REFACTOR) | ~80 | Core implementation pattern |
| Task grouping (RED+GREEN pairs) | ~40 | Groups related TDD cycles |
| Task detection logic | ~30 | Finds numbered tasks in document |
| Commit strategy (/review + /commit) | ~50 | Review-then-commit pattern |
| Docs-only detection | ~40 | Determines if phase is docs-only vs code |
| One-task-group-at-a-time pattern | ~30 | Stop after each group, wait for user |
| Common patterns (model, API, CLI, frontend) | ~120 | Language-agnostic implementation patterns |
| Error handling | ~30 | Tests fail, migration fail, linter errors |
| Completion checklist | ~40 | Pre-PR validation |
| Configuration section | ~50 | Feature detection, phase structure support |
| **Subtotal** | **~510** | **~55% of command** |

**Key insight:** ~75% of the command's value (TDD, task grouping, commit strategy, patterns) is already task-generic and doesn't depend on "phase" concepts at all. The phase-dependent 25% is mostly path resolution and naming conventions.

**Source:** Codebase analysis of `.cursor/commands/task-phase.md`

**Relevance:** The rename is less risky than expected. Most of the command's logic survives unchanged.

---

### Finding 2: Industry CLI Patterns Favor Named Tasks Over Numbered Hierarchies

Modern CLI task runners use three primary patterns:

| Pattern | Example Tools | Interface | When it works |
|---------|--------------|-----------|---------------|
| **Named tasks** | Taskfile, Make, Invoke | `task build`, `task test` | Well-defined, stable task names |
| **Numbered IDs** | Taskwarrior | `task 7 done` | Dynamic task lists, many items |
| **Priority-based** | Taskwarrior `next` | `task next` | When urgency matters more than order |

**Key findings from web research:**

1. **Cobra/oclif philosophy:** Commands should form "a natural conversation" -- `task 3` is less conversational than `task next` or `task "add-auth-endpoint"` (Source: Cobra philosophy docs)
2. **Taskwarrior's `next`:** Shows "most urgent pending tasks" -- a priority filter, not sequential execution (Source: Taskwarrior docs)
3. **Taskfile's model:** Tasks are named, not numbered. Users run `task test lint` not `task 1 2` (Source: Taskfile CLI reference)
4. **Flat vs hierarchical:** Flat lists offer speed and low friction; hierarchical structures help long-horizon projects. Optional grouping (sections within flat list) is the emerging compromise (Source: Claude Code issue #14728, TaskFalcon)

**Relevance:** Our use case is closest to Taskwarrior's numbered ID pattern (tasks come from a planning document with numbered items), but with the sequential nature of `next` (tasks are usually done in order). A hybrid approach (`/task 7` or `/task next`) gives the best of both.

---

### Finding 3: Cursor Commands Cannot Be Aliased

Cursor custom commands are individual `.md` files in `.cursor/commands/`. There is no aliasing mechanism:

- Each command = one file
- No `aliases:` metadata or redirect capability
- Cursor v1.7.52+ requires commands at workspace root level (no subdirectories)
- No built-in versioning or deprecation support

**Backward compatibility options:**

| Option | Feasibility | Tradeoff |
|--------|-------------|----------|
| Keep both files (`task.md` + `task-phase.md`) | ✅ Feasible | Maintenance burden of 2 files, potential drift |
| Symlink `task-phase.md` → `task.md` | ⚠️ Risky | Git tracks symlinks inconsistently; template sync may break |
| Stub `task-phase.md` that says "use /task" | ✅ Feasible | One-line deprecation notice; zero logic duplication |
| Remove `task-phase.md` outright | ✅ Feasible | Clean break; users must learn new name |

**Source:** Cursor IDE documentation, web search for custom command aliasing

**Note on programmatic command support:** There is active work to make commands programmatic via dev-toolkit (turning `.md` commands into actual scripts). However, this effort is being restarted based on the [workflow evolution reflection](../../planning/notes/reflections/reflection-new-commands-workflow-evolution-2026-02-13.md), which identified a philosophical shift: commands are evolving from "automate a process" to "enforce a practice." The reflection's insights (reactive-to-proactive review posture, bootstrapping transition, front-loaded discovery) apply to dev-toolkit's approach as well. This means the current lack of aliasing is an acceptable gap -- when dev-toolkit provides programmatic support, it can handle aliasing, deprecation notices, and version migration natively. The stub approach is the right interim solution.

**Relevance:** The cleanest approach is: create `/task`, create stub `/task-phase` with deprecation notice, remove stub in next major version. Dev-toolkit's eventual programmatic support will supersede the stub pattern.

---

### Finding 4: Interface Options Tested Against Real Features

Prototyped 3 interface options against the **command-simplification** feature (which had no phase files, just inline phases in feature-plan.md with 4 phases / ~8 tasks):

#### Option A: Numbered (`/task 7`)

```
/task 1          → Implement Task 1 (create ADR)
/task 2          → Implement Task 2 (update templates)
/task 3          → Implement Task 3 (remove experimental)
/task 4          → Implement Task 4 (update sync manifest)
```

**Pros:** Simple, direct, unambiguous. Works well for small features.  
**Cons:** User must know task number. For large features (15+ tasks), numbers lose meaning without context.

#### Option B: Sequential (`/task next`)

```
/task next       → Finds first unchecked task, implements it
/task next       → Finds next unchecked task, implements it
/task next       → ...
```

**Pros:** Zero friction. Don't need to know numbers. Progressive discovery.  
**Cons:** Can't skip tasks. Can't jump ahead. Loses explicit intent ("I want task 7, not whatever's next"). Harder to resume after interruption.

#### Option C: Hybrid (`/task 7` or `/task next`)

```
/task next       → Implements next unchecked task (default mode)
/task 3          → Implements specific task 3 (explicit mode)
/task            → Shows task list with status (no arg = list mode)
```

**Pros:** Flexible. `next` for sequential flow, numbered for jumping/resuming. Bare `/task` shows progress.  
**Cons:** Two modes to learn (but both are intuitive).

**Tested against release-readiness (large feature, 5 phases, 15+ tasks):**

- Option A works fine -- tasks were already numbered in each phase
- Option B would struggle with the "resume from handoff" scenario (user picks up from Task 11 after a break)
- Option C handles both: `next` for flow, `11` for resume

**Source:** Prototyping against admin/planning/features/command-simplification/ and admin/planning/features/release-readiness/

**Relevance:** Option C (hybrid) is the clear winner. It's the most flexible without being complex.

---

### Finding 5: Task Source Document Replaces Phase Document

With a flat planning document (from FR-1), the `/task` command needs a different path resolution:

**Current (`/task-phase`):**
```
/task-phase 3 2
  → Find phase-3.md
  → Find Task 2 in phase-3.md
  → Implement
```

**Proposed (`/task`):**
```
/task next
  → Find planning document (implementation-plan.md or feature-plan.md)
  → Find first unchecked task (- [ ])
  → Implement

/task 7
  → Find planning document
  → Find Task 7 (by number/order in document)
  → Implement
```

**Path resolution simplifies:**

| Current | Proposed |
|---------|----------|
| 2 args required (phase + task) | 0-1 args (optional task number) |
| 3 path patterns (feature, project-wide, CI) | 1-2 path patterns (feature, project-wide) |
| Phase number selects file, task number selects item | Single file, task number selects item |

**Task detection in flat document:**

```markdown
## Work Breakdown

### Foundation (optional group heading)
- [ ] Task 1: Set up database schema
- [x] Task 2: Create base API models  ← completed

### Core Implementation
- [ ] Task 3: Implement CRUD endpoints  ← /task next finds this
- [ ] Task 4: Add authentication middleware
```

The command parses checkboxes (`- [ ]` / `- [x]`) to find task status. Group headings (###) are optional context, not required structure.

**Source:** Extrapolation from FR-1, FR-4, FR-5 requirements

**Relevance:** The new interface is actually simpler than the old one -- fewer args, fewer paths, one file instead of multiple.

---

## 🔍 Analysis

### Key Insights

- [x] **Insight 1: 75% of `/task-phase` is already task-generic.** The TDD workflow, task grouping, commit strategy, and common patterns don't depend on phase concepts. The rename is primarily a path resolution and naming update, not a logic rewrite.

- [x] **Insight 2: Hybrid interface (`/task next` + `/task N`) is optimal.** Sequential mode covers the common case (work through tasks in order); numbered mode covers resume-from-handoff and skip scenarios. Bare `/task` as a status/list view is a natural addition.

- [x] **Insight 3: Cursor has no alias mechanism.** Backward compatibility requires a stub file. The stub approach (deprecation notice in `task-phase.md`) is clean and zero-maintenance.

- [x] **Insight 4: Path resolution simplifies dramatically.** Going from 2 required args + 3 path patterns to 0-1 args + 1-2 path patterns. The new interface is objectively simpler.

- [x] **Insight 5: Optional group headings preserve phase value without mandating it.** Complex features can use `### Foundation`, `### Core`, `### Cleanup` headings in the flat document. The `/task` command ignores these (just parses checkboxes), but humans get context.

---

## 💡 Recommendations

- [x] **Recommendation 1: Use Option C (hybrid) interface.** `/task next` for sequential, `/task N` for explicit, `/task` for status. This covers all use cases with minimal complexity.

- [x] **Recommendation 2: Create `/task` as new command, stub `/task-phase` with deprecation notice.** No logic duplication. Stub file says "This command has been renamed to `/task`. Use `/task N` instead of `/task-phase N M`."

- [x] **Recommendation 3: Simplify branch naming.** Drop phase from branch names: `feat/[feature]-[desc]` instead of `feat/[feature]-phase-N-[desc]`. With 1-PR-per-feature, the branch is the feature branch, not a phase branch.

- [x] **Recommendation 4: Simplify commit messages.** Drop `phase-N` from scope: `feat(auth): implement CRUD endpoints` instead of `feat(phase-3): implement CRUD endpoints`. The task context comes from the planning document, not the commit scope.

- [x] **Recommendation 5: Keep TDD and task-grouping behaviors unchanged.** These are the command's core value and don't depend on phases. RED+GREEN pairing, one-group-at-a-time, /review integration all carry forward.

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-10: Hybrid task selection interface.** `/task` must support three modes: `next` (sequential), `N` (explicit numbered), and bare (status/list). All modes read from the same flat planning document.
- [x] **FR-11: Flat planning document as task source.** `/task` reads tasks from a single planning document (implementation-plan.md or similar) using checkbox parsing (`- [ ]` / `- [x]`). No `phase-N.md` dependency.
- [x] **FR-12: Deprecation stub for `/task-phase`.** Create `task-phase.md` as a stub pointing users to `/task`. Remove in next major version.
- [x] **FR-13: Simplified branch naming.** Branch names should be `feat/[feature]-[desc]` (no phase number). One branch per feature.
- [x] **FR-14: Simplified commit scope.** Commit messages should use feature/component scope (`feat(auth): ...`) not phase scope (`feat(phase-3): ...`).

### Non-Functional Requirements

- [x] **NFR-5: 75% of command logic is reusable.** TDD workflow, task grouping, commit strategy, common patterns, error handling all carry forward unchanged. Only path resolution and naming conventions need updating.

### Constraints

- [x] **C-5: Cursor has no command aliasing.** Backward compatibility must use a stub file, not a redirect or alias.

---

## 🔗 Related

- **[Topic 1: Feature Plan Structure Usage](topic-1-feature-plan-usage.md)** — Validates that phase files are write-once under 1-PR workflow
- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** — Defines the flat document format that `/task` will parse
- **[Topic 5: Command Dependency Analysis](topic-5-command-dependency-analysis.md)** — Maps the 9 commands that need updating

---

**Last Updated:** 2026-02-14  
**Status:** ✅ Complete  
**Next:** Topic 3 (Transition Plan Output Format) -- defines the document structure `/task` will consume
