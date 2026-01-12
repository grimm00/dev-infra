# Explore Two-Mode - Phase 1: Command Structure

**Phase:** 1 - Command Structure  
**Duration:** ~2 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** ADR-001, ADR-004 approved

---

## 📋 Overview

Implement the two-mode pattern (Setup + Conduct) in the `/explore` command with consistent scaffolding boundaries.

**Success Definition:** `/explore` creates scaffolding by default; `--conduct` expands with detail.

---

## 🎯 Goals

1. **Two-Mode Structure** - Implement Setup (default) and Conduct (`--conduct`) modes
2. **Scaffolding Template** - Create ~60-80 line exploration scaffolding
3. **Conduct Template** - Create ~200-300 line expanded exploration
4. **Status Indicators** - `🔴 Scaffolding` → `✅ Expanded`

---

## 📝 Tasks

### Task 1: Add Two-Mode Workflow Overview

**Purpose:** Update the Workflow Overview section to document both modes.

**Steps:**

- [x] Read existing Workflow Overview section in explore.md
- [x] Add "Two Modes" subsection explaining Setup vs Conduct
- [x] Add workflow diagram showing both modes
- [x] Update "When to use" with mode-specific guidance

**Content to Add:**

```markdown
**Two Modes:**

### Setup Mode (Default)
```
/explore [topic]
  → Creates exploration scaffolding (~60-80 lines)
  → Organizes thoughts into themes
  → Extracts key questions
  → Creates research-topics.md
  → Outputs: Scaffolding ready for human review
```

### Conduct Mode (`--conduct`)
```
/explore [topic] --conduct
  → Reads existing scaffolding
  → Expands themes with detailed analysis
  → Adds connections, implications, concerns
  → Refines research topics with context
  → Outputs: Full exploration (~200-300 lines)
```
```

**Checklist:**
- [x] Workflow Overview updated
- [x] Two modes clearly explained
- [x] Diagrams added

---

### Task 2: Update Usage Section with --conduct Flag

**Purpose:** Add `--conduct` flag to usage examples and options.

**Steps:**

- [ ] Add `--conduct` to Options list
- [ ] Add conduct mode examples to Examples section
- [ ] Update command signature

**Content to Add:**

```markdown
**Command:** `/explore [topic] [options]`

**Setup Mode Examples (default):**

- `/explore new-authentication-system` - Create exploration scaffolding
- `/explore "improve ci pipeline"` - Topic sanitized to `improve-ci-pipeline`
- `/explore --dry-run` - Show what would be created without creating files

**Conduct Mode Examples:**

- `/explore new-authentication-system --conduct` - Expand existing scaffolding
- `/explore improve-ci-pipeline --conduct` - Fill in detailed exploration

**Options:**

- `--topic [name]` - Specify topic name (overrides prompt)
- `--conduct` - Expand scaffolding with detailed exploration (requires existing scaffolding)
- `--dry-run` - Show what would be created without creating files
```

**Checklist:**
- [ ] --conduct flag documented
- [ ] Examples show both modes
- [ ] Options list updated

---

### Task 3: Create Setup Mode Output Section

**Purpose:** Document the scaffolding output structure (~60-80 lines).

**Steps:**

- [ ] Create "Setup Mode Output" section
- [ ] Document exploration.md scaffolding template
- [ ] Document research-topics.md scaffolding template
- [ ] Add line count guidance

**Content to Add (exploration.md scaffolding):**

```markdown
### Setup Mode Output (~60-80 lines total)

**Creates:**
```
explorations/[topic]/
├── README.md           (~20 lines) - Hub with quick links
├── exploration.md      (~40-50 lines) - Scaffolding with placeholders
└── research-topics.md  (~20-30 lines) - Prioritized questions
```

**exploration.md Scaffolding Template:**

```markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 🎯 What We're Exploring

[2-3 sentence summary extracted from input]

---

## 🔍 Initial Themes

### Theme 1: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

### Theme 2: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

---

## ❓ Key Questions

1. [Question extracted from input]
2. [Question extracted from input]

---

## 🚀 Next Steps

Run `/explore [topic] --conduct` to expand this exploration.
```
```

**Checklist:**
- [ ] Setup mode output documented
- [ ] Scaffolding template created
- [ ] Line count guidance included
- [ ] Placeholder message shows conduct command

---

### Task 4: Create Conduct Mode Output Section

**Purpose:** Document the expanded output structure (~200-300 lines).

**Steps:**

- [ ] Create "Conduct Mode Output" section
- [ ] Document expanded exploration.md template
- [ ] Document expanded research-topics.md template
- [ ] Show status transition

**Content to Add:**

```markdown
### Conduct Mode Output (~200-300 lines total)

**Expands existing scaffolding with:**

- Themes with detailed analysis, connections, implications
- Questions with context, sub-questions, research approach
- Initial thoughts with evidence, concerns, opportunities
- research-topics.md with full descriptions and priority rationale

**Status Update:**
```markdown
**Status:** ✅ Expanded
```

**exploration.md After Conduct:**

```markdown
# Exploration: [Topic]

**Status:** ✅ Expanded
**Created:** YYYY-MM-DD
**Expanded:** YYYY-MM-DD

---

## 🎯 What We're Exploring

[Expanded description with context, background, and motivation]

---

## 🔍 Themes

### Theme 1: [Name]

[Detailed analysis of theme]

**Connections:**
- [Connection to other themes or concepts]

**Implications:**
- [What this means for the exploration]

**Concerns:**
- [Potential issues or risks]

### Theme 2: [Name]

[Detailed analysis...]

---

## ❓ Key Questions

### Question 1: [Question]

**Context:** [Why this question matters]

**Sub-questions:**
- [Related question 1]
- [Related question 2]

**Research Approach:** [How to investigate]

### Question 2: [Question]

[Similar structure...]

---

## 💡 Initial Thoughts

[Detailed initial thinking with evidence]

**Opportunities:**
- [Opportunity 1]

**Concerns:**
- [Concern 1]

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research [topic] --from-explore [topic]` to conduct research

---

**Last Updated:** YYYY-MM-DD
```
```

**Checklist:**
- [ ] Conduct mode output documented
- [ ] Expanded template created
- [ ] Status transition shown
- [ ] Line count guidance included

---

### Task 5: Add Mode Detection Logic

**Purpose:** Document how to detect existing scaffolding and handle mode transitions.

**Steps:**

- [ ] Add "Mode Detection" section to Step-by-Step Process
- [ ] Document scaffolding detection logic
- [ ] Document error handling for missing scaffolding
- [ ] Add validation checklist

**Content to Add:**

```markdown
### Mode Detection

**Setup Mode (default):**

1. Check if topic directory exists
2. If exists, check exploration.md status
3. If status is `🔴 Scaffolding`, suggest using `--conduct`
4. If status is `✅ Expanded`, warn about overwriting
5. If doesn't exist, proceed with setup

**Conduct Mode (`--conduct`):**

1. Check if topic directory exists
2. If doesn't exist, error: "No scaffolding found. Run setup first."
3. Check exploration.md status
4. If status is `✅ Expanded`, warn and require `--force` to re-expand
5. If status is `🔴 Scaffolding`, proceed with conduct

**Error Messages:**

| Situation | Message |
|-----------|---------|
| `--conduct` with no scaffolding | "No exploration scaffolding found for [topic]. Run `/explore [topic]` first." |
| `--conduct` on already expanded | "Exploration already expanded. Use `--force` to re-expand." |
| Setup on existing scaffolding | "Scaffolding exists. Use `--conduct` to expand, or `--force` to overwrite." |
```

**Checklist:**
- [ ] Mode detection documented
- [ ] Error handling documented
- [ ] Validation logic clear

---

### Task 6: Update Step-by-Step Process

**Purpose:** Reorganize step-by-step process for two-mode pattern.

**Steps:**

- [ ] Add "1. Determine Mode" step
- [ ] Split "2. Create Exploration Document" into Setup vs Conduct
- [ ] Update checklists for each mode
- [ ] Add commit guidance for each mode

**Process Structure:**

```markdown
### 1. Determine Mode

- [ ] Check if `--conduct` flag provided
- [ ] If conduct: verify scaffolding exists
- [ ] If setup: check for existing exploration

### 2. Setup Mode: Create Scaffolding

[Existing content with scaffolding templates]

**Checklist:**
- [ ] Exploration directory created
- [ ] Exploration hub created (~20 lines)
- [ ] Exploration scaffolding created (~40-50 lines)
- [ ] Research topics scaffolding created (~20-30 lines)
- [ ] Status: `🔴 Scaffolding (needs expansion)`

### 3. Conduct Mode: Expand Scaffolding

[New content with expansion templates]

**Checklist:**
- [ ] Existing scaffolding read
- [ ] Themes expanded with analysis
- [ ] Questions expanded with context
- [ ] research-topics.md expanded
- [ ] Status updated: `✅ Expanded`
```

**Checklist:**
- [ ] Step-by-step reorganized
- [ ] Both modes documented
- [ ] Checklists updated

---

### Task 7: Update Integration Section

**Purpose:** Show how two-mode `/explore` fits in the command pipeline.

**Steps:**

- [ ] Update "Integration with Other Commands" section
- [ ] Show pipeline with mode annotations
- [ ] Add timing guidance

**Content to Add:**

```markdown
### Command Pipeline Position

```
/explore [topic]           ← Setup: scaffolding (~60-80 lines)
    ↓ human review
/explore [topic] --conduct ← Conduct: full exploration (~200-300 lines)
    ↓
/research --from-explore   ← Research: investigate topics
    ↓
/decision --from-research  ← Decisions: create ADRs
    ↓
/transition-plan --from-adr ← Planning: create phases
```

**Note:** Human review between Setup and Conduct is the key checkpoint.
```

**Checklist:**
- [ ] Pipeline diagram updated
- [ ] Mode positions clear
- [ ] Human review checkpoint shown

---

## ✅ Completion Criteria

- [ ] `/explore [topic]` creates scaffolding (~60-80 lines)
- [ ] `/explore [topic] --conduct` expands to ~200-300 lines
- [ ] Status shows `🔴 Scaffolding` after setup, `✅ Expanded` after conduct
- [ ] Placeholder message guides user to conduct mode
- [ ] research-topics.md created in setup mode
- [ ] Mode detection and error handling documented
- [ ] Pipeline position documented

---

## 📦 Deliverables

- Updated `.cursor/commands/explore.md` with:
  - Two-mode workflow overview
  - --conduct flag documentation
  - Setup mode scaffolding templates
  - Conduct mode expansion templates
  - Mode detection logic
  - Updated pipeline documentation

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: Two-Mode Workflow Overview | ✅ Complete | Added two-mode structure to Workflow Overview |
| Task 2: Usage Section with --conduct | 🔴 Not Started | |
| Task 3: Setup Mode Output Section | 🔴 Not Started | |
| Task 4: Conduct Mode Output Section | 🔴 Not Started | |
| Task 5: Mode Detection Logic | 🔴 Not Started | |
| Task 6: Step-by-Step Process | 🔴 Not Started | |
| Task 7: Integration Section | 🔴 Not Started | |

---

## 🔗 Dependencies

### Prerequisites

- ADR-001: Two-Mode Pattern (approved)
- ADR-004: Scaffolding Boundaries (approved)

### Blocks

- Phase 2: Input Sources (needs command structure)
- Phase 3: Worktree Integration (needs conduct mode)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Next Phase: Phase 2](phase-2.md)
- [ADR-001](../../../decisions/explore-two-mode/adr-001-two-mode-pattern.md)
- [ADR-004](../../../decisions/explore-two-mode/adr-004-scaffolding-boundaries.md)
- [Current explore.md](../../../../.cursor/commands/explore.md)

---

**Last Updated:** 2026-01-12  
**Status:** 🟠 In Progress  
**Next:** Continue with Task 2
