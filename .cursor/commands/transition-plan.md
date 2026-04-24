# Transition Plan Command

Creates implementation planning documents from ADRs, reflection artifacts, or reflection documents. Produces the uniform planning structure (`implementation-plan.md` + `tasks/`) ready for `/task` command execution.

---

## Configuration

**Plan Path Detection:**

This command writes to the uniform planning structure:

1. **Dev-Infra Structure:**
   - Output: `admin/services/[service]/features/[topic]/planning/`
   - Creates: `implementation-plan.md`, `status-and-next-steps.md`, `tasks/`

2. **Template Project Structure (generated projects):**
   - Output: `docs/maintainers/planning/features/[feature-name]/`
   - Creates: `implementation-plan.md`, `status-and-next-steps.md`, `tasks/`

**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if planning features directory exists (dev-infra or template project)
  - If single feature exists, use that feature name
  - If multiple features exist, prompt user to select
  - If no features exist, create new feature directory

**Source Paths:**

- **ADR Documents:** `admin/decisions/[topic]/` or `docs/maintainers/decisions/[topic]/`
- **Requirements:** `admin/research/[topic]/requirements.md` or `docs/maintainers/research/[topic]/requirements.md`
- **Reflection Artifacts:** `admin/planning/features/[feature]/` or `docs/maintainers/planning/features/[feature]/`
- **Reflection Files:** `admin/planning/notes/reflections/` or `docs/maintainers/planning/notes/reflections/`

---

## Workflow Overview

**When to use:**

- After creating ADRs with `/decision` command
- After creating reflection artifacts with `/reflection-artifacts`
- To plan transition from decisions/research to implementation
- When ready to create actionable task plans

**Workflow:** Setup → Human Review → Expand → Implement

**Two Modes:**

### Setup Mode (Default)

Creates scaffolding: `implementation-plan.md` (YAML frontmatter + task titles as GFM checkboxes) + `status-and-next-steps.md` (group-based progress table) + `tasks/` directory with scaffolded group files (~60-80 lines each).

**When to use:**

- First run on a new feature
- After creating ADRs with `/decision`
- To review group/task breakdown before adding detail

**Output:**

- `implementation-plan.md` — Task index with YAML frontmatter
- `status-and-next-steps.md` — Progress tracking
- `tasks/01-group-name.md`, `tasks/02-group-name.md`, etc. — Scaffolded group files

**Status Indicator:** Group files show `🔴 Scaffolding (needs expansion)`

```
/transition-plan --from-adr decisions/[topic]/
  → Reads ADR and requirements documents
  → Creates implementation-plan.md with frontmatter
  → Creates status-and-next-steps.md
  → Creates tasks/ directory with scaffolded group files
  → Outputs: Scaffolding ready for human review
```

### Expand Mode (`--expand`)

Fills scaffolded group files with detailed TDD tasks, code examples, and implementation notes.

**When to use:**

- After reviewing scaffolding structure
- When ready to add implementation detail to a group
- Before starting `/task next` for that group

**Flags:**

- `--group N` — Expand specific group by index (1-based)
- `--group "Group Name"` — Expand specific group by name
- `--all` — Expand all groups at once (context-heavy, use sparingly)

**Output:**

- Updated `tasks/NN-group-name.md` files (~200-300 lines with detailed tasks)

**Status Indicator:** Group files show `✅ Expanded`

```
/transition-plan [feature] --expand --group 1
  → Reads existing group scaffolding from tasks/01-group-name.md
  → Fills in detailed tasks, TDD steps, implementation notes
  → Updates group status to Expanded
  → Commits changes
```

---

## Usage

**Command:** `/transition-plan [--from-artifacts|--from-reflection|--from-adr] [options]`

**Setup Mode Examples (default):**

- `/transition-plan --from-adr decisions/auth-system/` — Create scaffolding from ADRs
- `/transition-plan --from-artifacts releases/v0.1.0/checklist.md` — Create from artifact
- `/transition-plan --from-reflection reflection-2026-01-15-mvp-complete.md` — Create from reflection
- `/transition-plan --dry-run` — Preview scaffolding without creating files
- `/transition-plan --type release` — Force release transition type
- `/transition-plan --feature my-feature` — Specify feature name

**Expand Mode Examples:**

- `/transition-plan my-feature --expand --group 1` — Expand group 1
- `/transition-plan my-feature --expand --group "Command Infrastructure"` — Expand by name
- `/transition-plan my-feature --expand --all` — Expand all groups (use sparingly)

**Setup Mode Options:**

- `--from-reflection FILE` — Use reflection file (auto-generates artifacts first)
- `--from-artifacts PATH` — Use specific artifact file
- `--from-adr PATH` — Use ADR document(s)
- `--requirements PATH` — Use requirements document (optional, auto-detected)
- `--feature [name]` — Specify feature name (overrides auto-detection)
- `--type TYPE` — Force transition type (`feature`, `release`, `ci-cd`, `auto`)
- `--dry-run` — Show plan without creating files

**Expand Mode Options:**

- `--expand` — Enter expand mode (fill scaffolding with detail)
- `--group N` — Expand specific group by index, 1-based (use with `--expand`)
- `--group "Name"` — Expand specific group by name (use with `--expand`)
- `--all` — Expand all scaffolded groups (use with `--expand`)

---

## Setup Mode Workflow

Creates the uniform planning structure. For detailed expansion, use `--expand` (see Expand Mode Workflow).

### Input Sources

All input sources produce the same uniform output structure.

1. **ADR Mode:** `/transition-plan --from-adr decisions/[topic]/`
   - Reads ADR documents from `/decision` command
   - Auto-detects requirements in research directory
   - Most common input source

2. **Artifact Mode:** `/transition-plan --from-artifacts [path]`
   - Reads artifact files created by `/reflection-artifacts`

3. **Reflection Mode:** `/transition-plan --from-reflection [file]`
   - Reads reflection document
   - Internally calls `/reflection-artifacts` first
   - Then creates plan from generated artifacts

---

### Step 1: Load Source Documents

**For ADR Mode:**

1. Locate ADR file(s) at the provided path
2. Extract topic from path: `decisions/[topic]/adr-001-*.md` → topic
3. Auto-detect requirements: check `research/[topic]/requirements.md`
4. Read all ADR documents in the directory (there may be multiple)
5. Read requirements document (if found)

**For Artifact Mode:**

1. Locate artifact file at the provided path
2. Read artifact content

**For Reflection Mode:**

1. Locate reflection file
2. Internally generate artifacts (call `/reflection-artifacts` workflow)
3. Use generated artifacts as input

**Extract from sources:**

- Decision statements and rationale (from ADRs)
- Functional requirements (from requirements doc)
- Non-functional requirements and constraints
- Implementation guidance and consequences
- Success criteria

**Checklist:**

- [ ] Source documents located and readable
- [ ] Requirements auto-detected (if ADR mode)
- [ ] Key content extracted

---

### Step 2: Determine Transition Type

**Auto-detection logic:**

- **Feature Transition (default):** Most ADRs and artifacts lead to feature planning
- **Release Transition:** Source path contains `releases/`, or mentions version/release
- **CI/CD Transition:** Source mentions CI/CD, pipeline, automation

**Manual override:** Use `--type` to force a specific type.

---

### Step 3: Organize into Task Groups

**Parse source content into logical groups and tasks.**

**Grouping principles:**

- Group related tasks by component, concern, or dependency
- Aim for 2-8 tasks per group
- Groups should be executable somewhat independently
- Earlier groups should have fewer external dependencies

**Global task numbering:** Tasks are numbered 1 to N across ALL groups. Numbers never restart per group.

**Group naming:** Use descriptive kebab-case names for file paths:
- "Foundation & Specs" → `01-foundation-and-specs.md`
- "Command Infrastructure" → `02-command-infrastructure.md`

**Checklist:**

- [ ] Tasks extracted from source
- [ ] Tasks organized into logical groups
- [ ] Global numbering assigned (1 to N)
- [ ] Group names and file names determined
- [ ] Group ordering reflects dependency flow

---

### Step 4: Create `implementation-plan.md`

**The central plan file with YAML frontmatter (the contract between `/transition-plan` and `/task`).**

**Template:**

```markdown
---
task_count: [N]
groups:
  - name: "[Group 1 Name]"
    file: "tasks/01-group-name.md"
    tasks: [1, 2, 3]
  - name: "[Group 2 Name]"
    file: "tasks/02-group-name.md"
    tasks: [4, 5, 6, 7]
tasks_files:
  - "tasks/01-group-name.md"
  - "tasks/02-group-name.md"
---
# Implementation Plan - [Feature Name]

**Status:** 🔴 Not Started
**Created:** YYYY-MM-DD
**Last Updated:** YYYY-MM-DD
**Source:** [source path or description]

---

## 📋 Overview

[2-4 sentences describing the feature and what it achieves]

**Key Changes:**
- [Change 1]
- [Change 2]

---

## 🎯 Goals

1. **[Goal 1]** — [description]
2. **[Goal 2]** — [description]

---

## 📝 Implementation Plan

### [Group 1 Name]
- [ ] Task 1: [Task title]
- [ ] Task 2: [Task title]
- [ ] Task 3: [Task title]

### [Group 2 Name]
- [ ] Task 4: [Task title]
- [ ] Task 5: [Task title]

[... continue for all groups ...]

---

## ✅ Definition of Done

- [ ] All tasks complete
- [ ] CI/CD passing
- [ ] Documentation updated
- [ ] Templates synced
```

**YAML frontmatter rules (per structure specification):**

- `task_count` must equal the total number of `- [ ]` checkboxes
- `groups[].tasks[]` arrays must partition 1..task_count without gaps or overlap
- `groups[].file` must match the corresponding entry in `tasks_files[]`
- File paths use the `{NN}-{group-name}.md` naming pattern

**Checklist:**

- [ ] YAML frontmatter is valid and internally consistent
- [ ] Checkbox list matches task_count
- [ ] Group sections match frontmatter groups
- [ ] Source attribution included

---

### Step 5: Create `status-and-next-steps.md`

**Template:**

```markdown
# Status & Next Steps - [Feature Name]

**Status:** 🔴 Not Started
**Last Updated:** YYYY-MM-DD

---

## 📊 Progress Summary

**Overall:** 0/[N] tasks complete

| Group | Status | Progress | Notes |
|-------|--------|----------|-------|
| [Group 1] | 🔴 Not Started | 0/[X] tasks | |
| [Group 2] | 🔴 Not Started | 0/[Y] tasks | |

---

## 🚀 Next Steps

1. Review scaffolding — verify group/task breakdown.
2. Expand groups — `/transition-plan [feature] --expand --group 1`.
3. Start implementation — `/task next`.

---

## 📝 Notes

- Plan generated from [source] on YYYY-MM-DD.

---

**Last Updated:** YYYY-MM-DD
```

---

### Step 6: Create Task Group Scaffolding Files

**Create `tasks/` directory and one file per group.**

**Scaffolding template (~60-80 lines per file):**

```markdown
# [Group Name]

**Feature:** [Feature Name]
**Group:** [Group Name]
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** YYYY-MM-DD

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan [feature] --expand --group [N]` to add detailed implementation notes.

- [ ] Task [X]: [Title]
  - [1-2 sentence description from source]
  - [Key deliverable or acceptance criterion]

- [ ] Task [Y]: [Title]
  - [1-2 sentence description from source]
  - [Key deliverable or acceptance criterion]

---

## 🎯 Goals

1. [Goal extracted from source]
2. [Goal extracted from source]

---

## ✅ Completion Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]

---

## 🔗 Dependencies

- [Dependency on prior group or task, if any]

---

**Last Updated:** YYYY-MM-DD
```

**File naming:** `tasks/{NN}-{group-name}.md` where NN is zero-padded (01, 02, ...).

**Target:** ~60-80 lines per file. Include task titles, brief descriptions, goals, criteria, and dependencies — but NOT detailed TDD steps, code examples, or implementation notes (those are added in Expand Mode).

**Checklist:**

- [ ] `tasks/` directory created
- [ ] One file per group with proper naming
- [ ] Task titles match `implementation-plan.md` checkboxes
- [ ] Status indicator: `🔴 Scaffolding (needs expansion)`
- [ ] NO detailed TDD tasks (reserved for Expand Mode)

---

### Step 7: Commit and Present Summary

**Commit scaffolding:**

```bash
git add [feature-directory]/implementation-plan.md
git add [feature-directory]/status-and-next-steps.md
git add [feature-directory]/tasks/
git commit -m "docs([feature]): create implementation plan scaffolding

Generate uniform planning structure from [source]:
- implementation-plan.md ([N] tasks in [M] groups)
- status-and-next-steps.md
- tasks/ directory with [M] scaffolded group files

Source: [ADR/artifact/reflection path]"
```

**Present summary:**

```
📋 Setup Complete — [Feature Name]

   Source: [ADR/artifact/reflection path]
   Tasks: [N] tasks in [M] groups
   Status: 🔴 Scaffolding (needs expansion)

   Files Created:
   - implementation-plan.md (frontmatter + task index)
   - status-and-next-steps.md (progress tracking)
   - tasks/01-group-name.md (scaffolding)
   - tasks/02-group-name.md (scaffolding)
   ...

   Next Steps:
   1. Review scaffolding — verify group/task breakdown
   2. Expand groups: /transition-plan [feature] --expand --group 1
   3. Start implementation: /task next
```

---

## Expand Mode Workflow (`--expand`)

**When to use:** After scaffolding is created (Setup Mode) and reviewed, use Expand Mode to fill in detailed implementation guidance.

**Prerequisite:** Group scaffolding files must exist with status `🔴 Scaffolding`.

---

### Step 1: Identify Group(s) to Expand

**Determine scope:**

1. **Specific Group by index** (`--group N`):
   - Expand group N (1-based, matches the order in frontmatter)
   - Example: `/transition-plan my-feature --expand --group 2`

2. **Specific Group by name** (`--group "Name"`):
   - Expand the group matching the provided name
   - Example: `/transition-plan my-feature --expand --group "Command Infrastructure"`

3. **All Groups** (`--all`):
   - Expand all scaffolded groups at once
   - Use sparingly — context-heavy
   - Example: `/transition-plan my-feature --expand --all`

**Read group scaffolding:**

1. Parse `implementation-plan.md` frontmatter to locate the group file
2. Read the group file from `tasks/`
3. Verify status is `🔴 Scaffolding`

**Error cases:**

- Group already expanded (`✅ Expanded` or `✅ Complete`) → Skip or warn
- Group file not found → Error with path suggestion
- No scaffolding groups found → Suggest running setup mode first

**Checklist:**

- [ ] Group(s) to expand identified
- [ ] Group file(s) exist
- [ ] Group status is `🔴 Scaffolding`

---

### Step 2: Determine TDD vs Non-TDD

**TDD ordering applies when:**
- Group involves code implementation (scripts, modules, APIs)
- Group involves testable functionality

**Non-TDD ordering for:**
- Documentation-only groups
- Configuration groups
- Planning/research groups

| Group Type | Task Order | Example |
|------------|------------|---------|
| **Code + Tests (TDD)** | Tests → Implementation → Docs | Write tests, implement code, document |
| **Scripts (TDD)** | Tests → Script → Integration | Write bats tests, create script, integrate |
| **Documentation Only** | Create → Link → Verify | Create docs, add links, verify links work |
| **Configuration** | Plan → Implement → Validate | Define config, apply changes, verify |

---

### Step 3: Expand Tasks with Detail

**Transform task scaffolding into detailed, actionable task descriptions.**

**For TDD tasks (code/scripts):**

```markdown
- [ ] Task N: [Title]
  - **Purpose:** [Why this task exists]
  - **TDD Flow:**
    1. **RED:** Write failing test(s) for [specific behavior]
    2. **GREEN:** Implement minimum code to pass
    3. **REFACTOR:** Clean up while tests pass
  - **Files:** [Expected files to create/modify]
  - **Acceptance:** [How to verify this task is done]
```

**For documentation tasks:**

```markdown
- [ ] Task N: [Title]
  - **Purpose:** [Why this task exists]
  - **Steps:**
    1. [Step 1]
    2. [Step 2]
  - **Files:** [Expected files to create/modify]
  - **Acceptance:** [How to verify this task is done]
```

**For command tasks (Cursor commands):**

```markdown
- [ ] Task N: [Title]
  - **Purpose:** [Why this task exists]
  - **Key behaviors:** [What the command must do]
  - **Porting from:** [Existing command to port logic from, if any]
  - **Files:** [Command file path]
  - **Acceptance:** [How to verify — manual test scenarios]
```

**Expansion adds:**

| Section | Scaffolding | After Expansion |
|---------|-------------|-----------------|
| Tasks | Titles + 1-2 line description | Full detail with steps, files, acceptance |
| Implementation Notes | None | Patterns, tips, porting guidance |
| Dependencies | Brief | Specific task-level dependencies |

**Target expansion:**
- Scaffolding: ~60-80 lines
- Expanded: ~150-300 lines
- Added: ~100-200 lines of detail

---

### Step 4: Update Group Status

**Update group file header:**

```markdown
# Before:
**Status:** 🔴 Scaffolding (needs expansion)

# After:
**Status:** ✅ Expanded
```

**Remove scaffolding placeholder:**

```markdown
# Remove this:
> ⚠️ **Scaffolding:** Run `/transition-plan [feature] --expand --group [N]` ...
```

---

### Step 5: Commit and Present Summary

**Commit expanded group:**

```bash
git add [feature-directory]/tasks/NN-group-name.md
git commit -m "docs([feature]): expand [group-name] group scaffolding

Expand [Group Name] from ~[X] to ~[Y] lines with detailed tasks:
- Task N: [title]
- Task M: [title]
..."
```

**Present summary:**

```
✅ Expand Complete — [Group Name]

   Status: 🔴 Scaffolding → ✅ Expanded
   Lines: ~[X] → ~[Y] (+[Z])
   Tasks: [N] tasks with detailed descriptions

   Next Steps:
   - Review expanded group file
   - Expand next group: /transition-plan [feature] --expand --group [N+1]
   - Or start implementation: /task next
```

---

## Input Source Details

### From ADR Mode (`--from-adr`)

1. **Load ADR document(s)** from the provided path
2. **Auto-detect requirements:** Check `research/[topic]/requirements.md`
3. **Extract:** Decision statements, consequences, rationale, requirements impact
4. **Extract from requirements (if found):** FRs, NFRs, constraints, assumptions
5. **Organize into groups** based on implementation scope

### From Artifact Mode (`--from-artifacts`)

1. **Load artifact file** from the provided path
2. **Extract:** Overview, success criteria, implementation steps
3. **Determine transition type** from artifact content/path
4. **Organize into groups** based on artifact structure

### From Reflection Mode (`--from-reflection`)

1. **Load reflection file**
2. **Internally call** `/reflection-artifacts` to generate artifacts
3. **Use generated artifacts** as input (follows Artifact Mode from here)

---

## Release Transition Type

**When `--type release` is detected or forced:**

Output structure is the same (uniform), but content is release-focused:

- Groups are release steps (e.g., "Version Updates", "Changelog", "Testing", "Distribution")
- Tasks are release checklist items
- `implementation-plan.md` source references the release version

The uniform structure works for both features and releases — the content differs, not the layout.

---

## Error Handling

**Source not found:**
```
❌ No ADR documents found at: decisions/[topic]/
   Verify the path exists and contains adr-*.md files.
```

**Feature directory already has a plan:**
```
⚠️ Feature '[name]' already has an implementation-plan.md.
   Options:
   1. Use --force to overwrite
   2. Edit the existing plan directly
   3. Use a different feature name
```

**Group already expanded:**
```
⚠️ Group [N] ([name]) is already expanded (status: ✅ Expanded).
   Use --force to re-expand (overwrites existing detail).
```

**No scaffolding found:**
```
❌ No scaffolded groups found for feature '[name]'.
   Run setup mode first: /transition-plan --from-adr [path]
```

---

## Tips

### When to Use Each Mode

**Setup Mode (default):**
- First time creating a plan from a new source
- When you want to review group/task breakdown before adding detail
- When working with unfamiliar ADRs or artifacts

**Expand Mode (`--expand`):**
- After scaffolding has been reviewed and approved
- When ready to add implementation detail to a specific group
- Before starting `/task next` for that group

**Incremental vs Batch:**

| Approach | Flag | When to Use |
|----------|------|-------------|
| **Incremental** | `--group N` | Complex features, review each group |
| **Batch** | `--all` | Simple features, already reviewed scaffolding |

**Rule of Thumb:** If unsure → Use Setup Mode first, review, then expand one group at a time.

### Expansion Best Practices

- Expand one group at a time to stay within context limits
- Review expanded content before moving to the next group
- Use `--all` only for small features (≤3 groups, ≤10 tasks)

---

## Common Scenarios

### Scenario 1: ADR → Scaffolding → Expand → Implement

```bash
# Step 1: Create scaffolding from ADRs
/transition-plan --from-adr decisions/auth-system/

# Step 2: Human review — verify group/task breakdown

# Step 3: Expand group 1
/transition-plan auth-system --expand --group 1

# Step 4: Implement group 1
/task next
/task next
...

# Step 5: Expand group 2
/transition-plan auth-system --expand --group 2

# Step 6: Implement group 2
/task next
...
```

### Scenario 2: Quick Feature (Small Scope)

```bash
# Scaffold + expand all at once
/transition-plan --from-adr decisions/small-fix/
/transition-plan small-fix --expand --all

# Implement
/task next
```

### Scenario 3: Reflection → Plan

```bash
# One command: generates artifacts internally, then scaffolds
/transition-plan --from-reflection reflection-2026-01-15-sprint-review.md

# Review and expand as usual
/transition-plan my-feature --expand --group 1
```

---

## Related Commands

- `/task` — Implement tasks from the plan (reads `implementation-plan.md`)
- `/plan-review` — Review plan before implementation
- `/decision` — Create ADR documents (common input source)
- `/research` — Research topics and extract requirements
- `/explore` — Explore topics and identify research needs
- `/reflection-artifacts` — Generate artifacts from reflections
- `/reflect` — Create reflection documents

---

**Last Updated:** 2026-02-19
**Status:** ✅ Active
**Next:** Use after `/decision` to create implementation plans from ADRs (uniform structure, two-mode: setup + expand)
