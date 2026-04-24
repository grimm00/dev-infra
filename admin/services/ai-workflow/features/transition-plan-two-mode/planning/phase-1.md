# Transition-Plan Two-Mode - Phase 1: Workflow Overview

**Phase:** 1 - Workflow Overview  
**Duration:** ~30 min  
**Status:** ✅ Complete  
**Completed:** 2025-12-29  
**Merged:** PR #55 (2025-12-29)  
**Prerequisites:** ADRs reviewed

---

## 📋 Overview

Update the Workflow Overview section with mode subsections, documenting Setup Mode and Expand Mode.

**Success Definition:** Workflow Overview clearly describes both modes and when to use each.

**Target File:** `.cursor/commands/transition-plan.md`  
**Target Section:** Lines ~40-48 (current "Workflow Overview")

---

## 🎯 Goals

1. **Add Setup Mode subsection** - Document default scaffolding behavior
2. **Add Expand Mode subsection** - Document `--expand` flag behavior
3. **Document mode selection** - Guide users on when to use each mode

---

## 📝 Tasks

### Task 1: Read Current Workflow Overview

**Purpose:** Understand current structure before modifying.

- [ ] Read lines 40-48 of `transition-plan.md`
- [ ] Note current "When to use" section
- [ ] Note current "Key principle" section
- [ ] Review `/research` command Workflow Overview as pattern (lines 37-71)

**Current Content (Lines 40-48):**

```markdown
## Workflow Overview

**When to use:**

- After creating reflection artifacts with `/reflection-artifacts`
- To plan transition to next stage (feature, release, infrastructure)
- When ready to move from reflection to implementation planning

**Key principle:** Transform reflection artifacts into actionable transition plans...
```

---

### Task 2: Write Setup Mode Subsection

**Purpose:** Document default (scaffolding) behavior.

- [ ] Add `**Two Modes:**` header after "Key principle" (matches `/research` pattern)
- [ ] Add `### Setup Mode (Default)` heading after "Two Modes:"
- [ ] Document what setup mode creates (scaffolding ~60-80 lines)
- [ ] Document when to use setup mode
- [ ] Document output (transition-plan.md + phase-N.md scaffolds)

**Content to Add:**

```markdown
**Two Modes:**

### Setup Mode (Default)

Creates scaffolding documents (~60-80 lines per phase) with structure but not detail.

**When to use:**

- First run on a new transition
- After creating ADRs with `/decision`
- To review phase breakdown before adding detail

**Output:**

- `transition-plan.md` - Transition overview
- `phase-N.md` files - Phase scaffolding (goals, criteria, dependencies)

**Status Indicator:** Phase documents show `🔴 Scaffolding (needs expansion)`
```

---

### Task 3: Write Expand Mode Subsection

**Purpose:** Document `--expand` flag behavior.

- [ ] Add `### Expand Mode (\`--expand\`)` heading after Setup Mode
- [ ] Document what expand mode does (fills TDD detail)
- [ ] Document when to use expand mode
- [ ] Document flags (`--phase N`, `--all`)

**Content to Add:**

```markdown
### Expand Mode (`--expand`)

Fills scaffolding with detailed TDD tasks, code examples, and implementation notes.

**When to use:**

- After reviewing scaffolding structure
- When ready to add implementation detail
- Before starting `/task-phase` implementation

**Flags:**

- `--phase N` - Expand specific phase only
- `--all` - Expand all phases at once

**Output:**

- Updated `phase-N.md` files (~200-300 lines with TDD detail)

**Status Indicator:** Phase documents show `✅ Expanded`
```

---

### Task 4: Update "When to use" Section

**Purpose:** Clarify two-mode workflow in introduction.

- [ ] Update bullet points to mention both modes
- [ ] Add note about human review between modes

**Updated Content:**

```markdown
**When to use:**

- After creating reflection artifacts with `/reflection-artifacts`
- After creating ADRs with `/decision` command
- To plan transition to next stage (feature, release, infrastructure)
- When ready to move from reflection to implementation planning

**Workflow:** Setup → Human Review → Expand → Implement
```

---

### Task 5: Verify Changes Against Criteria

**Purpose:** Confirm all completion criteria met.

- [ ] Verify "**Two Modes:**" header exists after "Key principle"
- [ ] Verify "### Setup Mode (Default)" subsection exists
- [ ] Verify "### Expand Mode (`--expand`)" subsection exists
- [ ] Verify when to use each mode is documented
- [ ] Verify flags (`--phase N`, `--all`) are documented
- [ ] Review overall flow and clarity

---

## ✅ Completion Criteria

- [ ] Workflow Overview has "**Two Modes:**" header after "Key principle"
- [ ] Workflow Overview has "### Setup Mode (Default)" subsection
- [ ] Workflow Overview has "### Expand Mode (`--expand`)" subsection
- [ ] When to use each mode is documented
- [ ] Flags (`--phase N`, `--all`) are documented
- [ ] Status indicators (`🔴 Scaffolding`, `✅ Expanded`) mentioned

---

## 📦 Deliverables

- Updated Workflow Overview section in `.cursor/commands/transition-plan.md`
- ~30-40 lines added to Workflow Overview section

---

## 🔗 Dependencies

### Prerequisites

- [x] ADR-001, ADR-002, ADR-003 reviewed
- [x] `/research` command reviewed as pattern source

### Blocks

- Phase 2 (Setup Mode Workflow)

---

## 📊 Progress Tracking

| Task                         | Status      | Notes                       |
| ---------------------------- | ----------- | --------------------------- |
| Task 1: Read Current         | ✅ Complete | Lines 40-50 analyzed        |
| Task 2: Write Setup Mode     | ✅ Complete | Added lines 55-78           |
| Task 3: Write Expand Mode    | ✅ Complete | Added lines 80-108          |
| Task 4: Update "When to use" | ✅ Complete | Added ADR bullet + Workflow |
| Task 5: Verify Changes       | ✅ Complete | All 6 criteria verified     |

---

## 💡 Implementation Notes

### Pattern Reference

The `/research` command (lines 37-71) shows the target pattern:

```markdown
## Workflow Overview

**When to use:**
...

**Key principle:** ...

**Two Modes:**

### Setup Mode (Default)
```

/research [topic] --from-explore [topic]
→ Creates research structure ready for conducting

```

### Conduct Mode (`--conduct`)
```

/research [topic] --conduct [--topic-num N]
→ Actually performs research, fills in findings

```

```

### Key Differences from /research

| Aspect       | /research          | /transition-plan  |
| ------------ | ------------------ | ----------------- |
| Setup output | Research templates | Phase scaffolding |
| Expand flag  | `--conduct`        | `--expand`        |
| Incremental  | `--topic-num N`    | `--phase N`       |
| Batch        | (all topics)       | `--all`           |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Next Phase: Phase 2](phase-2.md)
- [ADR-001: Mode Switching](../../../decisions/transition-plan-two-mode/adr-001-flag-based-mode-switching.md)
- [ADR-003: Command Structure](../../../decisions/transition-plan-two-mode/adr-003-command-structure-refactoring.md)
- [/research Command](../../../../.cursor/commands/research.md) - Pattern source

---

**Last Updated:** 2025-12-29  
**Status:** ✅ Complete  
**Completed:** 2025-12-29  
**Next:** Continue with Phase 2 (Setup Mode Workflow)
