# Explore Two-Mode - Phase 3: Worktree Integration

**Phase:** 3 - Worktree Integration  
**Duration:** ~1.5 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 2 complete, ADR-003 approved
**Last Updated:** 2026-01-13

---

## 📋 Overview

Document lazy worktree creation that prompts on conduct mode, aligning with ADR-002 (self-contained feature branches) while keeping setup mode lightweight.

**Success Definition:** Setup mode stays on develop; conduct mode prompts for worktree creation with override flags documented.

**ADR Reference:** [ADR-003: Worktree Integration](../../../decisions/explore-two-mode/adr-003-worktree-integration.md)

---

## 🎯 Goals

1. **Lazy Creation Docs** - Document that setup mode does NOT create worktree
2. **Conduct Prompt Docs** - Document prompt behavior on `--conduct`
3. **Explicit Flags Docs** - Document `--worktree` (auto) and `--no-worktree` (skip)
4. **Flow Diagram** - Add worktree decision flow to Integration section
5. **Script Reference** - Reference existing `scripts/worktrees.sh` integration

---

## 📝 Tasks

### Task 1: Add Worktree Flags to Usage Section

**Purpose:** Document the worktree-related flags in the Usage/Options section.

**Steps:**

- [x] Add `--worktree` flag to Options list
- [x] Add `--no-worktree` flag to Options list
- [x] Add worktree flag examples
- [x] Document flag mutual exclusivity

**Content to Add:**

Update "Options" list:

```markdown
**Worktree Options (Conduct Mode only):**

- `--worktree` - Create worktree automatically (skip prompt)
- `--no-worktree` - Skip worktree prompt, stay on current branch

**Worktree Examples:**

- `/explore my-idea --conduct` - Prompts "Create worktree?"
- `/explore my-idea --conduct --worktree` - Auto-creates worktree
- `/explore my-idea --conduct --no-worktree` - Skips prompt, stays on current branch

**Note:** Worktree flags only apply to Conduct Mode. Setup Mode always stays on current branch.
```

**Checklist:**

- [x] Flags added to Options
- [x] Examples provided
- [x] Note about mode applicability added

---

### Task 2: Add Worktree Behavior Section

**Purpose:** Create dedicated section explaining worktree integration behavior.

**Steps:**

- [x] Add "Worktree Integration" section after "Input Sources"
- [x] Document Setup Mode behavior (no worktree)
- [x] Document Conduct Mode behavior (prompt)
- [x] Document explicit flag overrides

**Content to Add:**

```markdown
## Worktree Integration

`/explore` implements lazy worktree creation aligned with [ADR-002 Self-Contained Feature Branches](../../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md).

### Setup Mode (No Worktree)

Setup mode stays on current branch (typically `develop`):

- Creates lightweight scaffolding (~60-80 lines)
- Low investment, acceptable to abandon on develop
- **No worktree prompt** - keeps exploration friction low

**Why:** Quick explorations shouldn't require worktree overhead.

### Conduct Mode (Worktree Prompt)

Conduct mode prompts for worktree creation:
```

/explore my-idea --conduct

Create worktree for this exploration? [Y/n]

```

**If Yes:**
- Creates directory: `worktrees/feat-my-idea`
- Creates branch: `feat/my-idea`
- Continues exploration on feature branch

**If No:**
- Stays on current branch
- Continues exploration without worktree

**Why:** Conduct mode represents real investment; prompts at natural decision point.

### Explicit Control Flags

For automation and scripting, use explicit flags:

| Flag | Behavior | Use Case |
|------|----------|----------|
| `--worktree` | Creates worktree without prompting | CI/automation, scripting |
| `--no-worktree` | Skips prompt, stays on current branch | Quick explorations, existing worktree |

**Naming Convention:**

| Element | Pattern | Example |
|---------|---------|---------|
| Directory | `worktrees/feat-[topic]` | `worktrees/feat-auth-system` |
| Branch | `feat/[topic]` | `feat/auth-system` |

### ADR-002 Alignment

This pattern aligns with the worktree feature workflow:

- **Setup on develop:** Scaffolding is lightweight, acceptable on develop
- **Conduct on feature branch:** Serious investment is self-contained
- **Natural gate:** Setup → Conduct transition is meaningful commitment point
```

**Checklist:**

- [x] Section header added
- [x] Setup mode behavior documented
- [x] Conduct mode behavior documented
- [x] Explicit flags documented
- [x] Naming conventions documented
- [x] ADR-002 alignment explained

---

### Task 3: Update Mode Detection for Worktree

**Purpose:** Update Mode Detection section to include worktree prompt logic.

**Steps:**

- [x] Add worktree prompt to Conduct Mode flow
- [x] Document flag interaction with worktree prompt
- [x] Add error cases for worktree flags in Setup Mode

**Content to Add:**

Update "2. Determine Mode" section with worktree logic:

```markdown
### Conduct Mode Worktree Prompt

After mode validation, if entering Conduct Mode:

1. **Check worktree flags:**

   - `--worktree` present → Create worktree automatically
   - `--no-worktree` present → Skip prompt, continue on current branch
   - Neither → Prompt user

2. **Prompt flow (if no flag):**
```

Create worktree for this exploration? [Y/n]

```
- Default: Yes (press Enter)
- Creates worktree and switches to feature branch

3. **Worktree creation:**
- Directory: `worktrees/feat-[topic]`
- Branch: `feat/[topic]`
- Uses `scripts/worktrees.sh` if available
```

**Error Table (append):**

| Situation                      | Message                                                      |
| ------------------------------ | ------------------------------------------------------------ |
| `--worktree` in Setup Mode     | "Warning: --worktree flag ignored in Setup Mode"             |
| `--no-worktree` in Setup Mode  | "Warning: --no-worktree flag ignored in Setup Mode"          |
| `--worktree` + `--no-worktree` | "Error: --worktree and --no-worktree are mutually exclusive" |
| Worktree already exists        | "Worktree exists at [path]. Switching to existing worktree." |
| Branch already exists          | "Branch [name] exists. Use existing branch? [Y/n]"           |

**Checklist:**

- [x] Worktree prompt logic added
- [x] Flag interaction documented
- [x] Error cases added

---

### Task 4: Update Step-by-Step Process for Worktree

**Purpose:** Add worktree creation to Conduct Mode process steps.

**Steps:**

- [x] Add worktree step to "4. Conduct Mode: Expand Scaffolding"
- [x] Document worktree checklist items
- [x] Add commit guidance for worktree changes

**Content to Add:**

Update Conduct Mode process:

```markdown
### Worktree Creation (Conduct Mode Only)

**After mode detection, before expanding scaffolding:**

1. **Check worktree flags:**

   - If `--worktree`: Proceed to step 2
   - If `--no-worktree`: Skip to scaffolding expansion
   - If neither: Prompt user

2. **Create worktree (if applicable):**

   - Directory: `worktrees/feat-[topic]`
   - Branch: `feat/[topic]` from current HEAD
   - Switch to worktree directory

3. **Verify worktree:**
   - Check branch is correct: `git branch --show-current`
   - Check working directory: `pwd`

**Worktree Checklist:**

- [ ] Worktree prompt handled (flag or user response)
- [ ] Worktree created (if applicable)
- [ ] Branch verified
- [ ] Working directory is worktree (if created)

**Commit Guidance:**

- If worktree created: First commit on feature branch
- If no worktree: Commit to current branch
```

**Checklist:**

- [x] Worktree step added to Conduct Mode
- [x] Checklist items added
- [x] Commit guidance included

---

### Task 5: Add Worktree Scenario

**Purpose:** Add common scenario demonstrating worktree workflow.

**Steps:**

- [x] Add "Scenario: Exploration to Feature Branch" scenario
- [x] Show setup → conduct → worktree flow
- [x] Document expected output

**Content to Add:**

````markdown
### Scenario 6: Exploration to Feature Branch

**Situation:** You've validated an exploration in Setup Mode and want to fully develop it.

**Action:**

```bash
# Step 1: Setup mode on develop (quick scaffolding)
/explore notification-system

# Step 2: Review scaffolding, decide to proceed
# ...

# Step 3: Conduct mode (prompts for worktree)
/explore notification-system --conduct

# Output:
# Create worktree for this exploration? [Y/n] y
# Creating worktree: worktrees/feat-notification-system
# Creating branch: feat/notification-system
# Switched to worktree directory
```
````

**Result:**

- Full exploration (~200-300 lines) on feature branch
- Self-contained per ADR-002
- Ready for `/research` phase

---

### Scenario 7: Quick Exploration (No Worktree)

**Situation:** You want to quickly expand an exploration without worktree overhead.

**Action:**

```bash
/explore quick-idea --conduct --no-worktree
```

**Result:**

- Full exploration on current branch
- Skips worktree prompt
- Useful for explorations that may not become features

````

**Checklist:**

- [x] Worktree flow scenario added
- [x] No-worktree scenario added
- [x] Expected output documented

---

### Task 6: Update Integration Section with Worktree Flow

**Purpose:** Add worktree integration to the command pipeline.

**Steps:**

- [x] Update pipeline diagram with worktree creation point
- [x] Add worktree timing guidance
- [x] Document worktree in flow steps

**Content to Add:**

Update "Integration with Other Commands" section:

```markdown
### Worktree in Pipeline

````

/explore [topic] ← Setup on develop (no worktree)
↓ human review
/explore [topic] --conduct ← Prompt: "Create worktree?"
├─ --worktree → Auto-create worktree
├─ --no-worktree → Skip, stay on branch
└─ [Y/n] → User decides
↓
worktrees/feat-[topic]/ ← Feature branch (if created)
↓
/research --from-explore ← Research on feature branch
↓
/decision → /transition-plan → /task-phase

```

**Worktree Decision Point:**

| Stage | Branch | Notes |
|-------|--------|-------|
| Setup Mode | develop | Lightweight scaffolding, no worktree |
| Conduct Mode | develop OR feat/* | Depends on prompt response |
| Research onwards | feat/* | Should be on feature branch |
```

**Checklist:**

- [x] Pipeline diagram updated
- [x] Worktree timing table added
- [x] Branch guidance documented

---

## ✅ Completion Criteria

- [x] Worktree flags documented in Usage section
- [x] Worktree Integration section created
- [x] Mode Detection updated with worktree logic
- [x] Step-by-Step Process includes worktree steps
- [x] Common scenarios include worktree examples
- [x] Integration section shows worktree in pipeline

---

## 📊 Progress Tracking

| Task                              | Status      | Notes                                      |
| --------------------------------- | ----------- | ------------------------------------------ |
| Task 1: Worktree Flags in Usage   | ✅ Complete | Added flags, examples, and mode note       |
| Task 2: Worktree Behavior Section | ✅ Complete | Added ~60 line section after Input Sources |
| Task 3: Mode Detection Update     | ✅ Complete | Added worktree prompt logic and errors     |
| Task 4: Step-by-Step Process      | 🔴 Pending  |                                            |
| Task 5: Worktree Scenarios        | 🔴 Pending  |                                            |
| Task 6: Integration Update        | 🔴 Pending  |                                            |

---

## 📦 Deliverables

- Worktree integration documentation in `explore.md`
- Updated Usage section with worktree flags
- Worktree Integration section (~60 lines)
- Updated Mode Detection with worktree logic
- Updated Step-by-Step Process with worktree steps
- 2 new worktree scenarios
- Updated Integration pipeline diagram

---

## 🔗 Dependencies

### Prerequisites

- Phase 2: Input Sources (complete) - needs conduct mode documented
- ADR-003: Worktree Integration (approved)
- Worktree Feature Workflow (v0.8.0)

### Blocks

- Phase 4: Template Updates (needs worktree logic documented)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 2](phase-2.md)
- [Next Phase: Phase 4](phase-4.md)
- [ADR-003: Worktree Integration](../../../decisions/explore-two-mode/adr-003-worktree-integration.md)
- [Worktree Workflow ADR-002](../../../decisions/worktree-feature-workflow/adr-002-self-contained-feature-branches.md)

---

**Last Updated:** 2026-01-13  
**Status:** ✅ Expanded  
**Next:** Continue with Task 4
