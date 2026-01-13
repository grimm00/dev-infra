# Explore Two-Mode - Phase 4: Template & Documentation

**Phase:** 4 - Template & Documentation  
**Duration:** ~1.5 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phases 1-3 complete
**Last Updated:** 2026-01-13

---

## 📋 Overview

Update templates with enhanced `/explore` command and create documentation for the two-mode pattern and command pipeline.

**Success Definition:** Templates synced with new explore.md; documentation explains two-mode pattern and pipeline position.

**ADR References:**

- [ADR-001: Two-Mode Pattern](../../../decisions/explore-two-mode/adr-001-two-mode-pattern.md)
- [ADR-002: Input Sources](../../../decisions/explore-two-mode/adr-002-input-sources.md)
- [ADR-003: Worktree Integration](../../../decisions/explore-two-mode/adr-003-worktree-integration.md)
- [ADR-004: Scaffolding Boundaries](../../../decisions/explore-two-mode/adr-004-scaffolding-boundaries.md)

---

## 🎯 Goals

1. **Template Updates** - Sync explore.md to both templates
2. **Template Validation** - Ensure template sync passes
3. **Two-Mode Documentation** - Create shared pattern documentation
4. **Pipeline Documentation** - Document command flow
5. **Release Preparation** - Update CHANGELOG

---

## 📝 Tasks

### Task 1: Copy explore.md to Standard Template

**Purpose:** Update the standard-project template with the enhanced explore.md.

**Steps:**

- [ ] Copy `.cursor/commands/explore.md` to `templates/standard-project/.cursor/commands/explore.md`
- [ ] Verify file copied successfully
- [ ] Check file size and content match

**Commands:**

```bash
# Copy the enhanced explore.md
cp .cursor/commands/explore.md templates/standard-project/.cursor/commands/explore.md

# Verify content
diff .cursor/commands/explore.md templates/standard-project/.cursor/commands/explore.md
```

**Checklist:**

- [ ] File copied to standard-project template
- [ ] Content verified with diff
- [ ] No modifications needed (templates use same file)

---

### Task 2: Copy explore.md to Learning Template

**Purpose:** Update the learning-project template with the enhanced explore.md.

**Steps:**

- [ ] Copy `.cursor/commands/explore.md` to `templates/learning-project/.cursor/commands/explore.md`
- [ ] Verify file copied successfully
- [ ] Check file size and content match

**Commands:**

```bash
# Copy the enhanced explore.md
cp .cursor/commands/explore.md templates/learning-project/.cursor/commands/explore.md

# Verify content
diff .cursor/commands/explore.md templates/learning-project/.cursor/commands/explore.md
```

**Checklist:**

- [ ] File copied to learning-project template
- [ ] Content verified with diff
- [ ] No modifications needed

---

### Task 3: Validate Template Sync

**Purpose:** Ensure template sync validation passes.

**Steps:**

- [ ] Run template sync validation script
- [ ] Verify explore.md is in sync across templates
- [ ] Check for any other drift

**Commands:**

```bash
# Run validation
./scripts/validate-template-sync.sh

# Should show: explore.md in sync
```

**Expected Output:**

```
Validating template sync...
✅ .cursor/commands/explore.md: in sync
...
All synced files validated successfully!
```

**Checklist:**

- [ ] Template sync validation passes
- [ ] No drift detected for explore.md
- [ ] All other synced files still valid

---

### Task 4: Update Template Sync Manifest (if needed)

**Purpose:** Ensure explore.md is in the sync manifest.

**Steps:**

- [ ] Check if `explore.md` is listed in `scripts/template-sync-manifest.txt`
- [ ] If not listed, add it
- [ ] Verify manifest update

**Content to check/add:**

```txt
# Commands
.cursor/commands/explore.md
```

**Checklist:**

- [ ] Manifest checked for explore.md entry
- [ ] Entry exists (or added if missing)
- [ ] Manifest validated

---

### Task 5: Create Two-Mode Pattern Documentation

**Purpose:** Document the two-mode pattern for use in other commands.

**Location:** `docs/TWO-MODE-PATTERN.md`

**Content to create:**

```markdown
# Two-Mode Pattern for Cursor Commands

**Purpose:** Document the setup/conduct pattern used in `/explore` and applicable to other commands  
**Status:** ✅ Active  
**Last Updated:** 2026-01-13

---

## Overview

The two-mode pattern separates commands into lightweight setup and detailed conduct phases, with human review in between.

**Pattern:**
```

/command [topic] ← Setup: scaffolding (~60-80 lines)
↓ human review ← KEY CHECKPOINT
/command [topic] --conduct ← Conduct: full output (~200-300 lines)

```

---

## Why Two Modes?

### Problem

Commands that produce large outputs (~200-300 lines) waste time when:
- The direction is wrong
- The topic is unclear
- The user changes their mind

### Solution

**Setup Mode (default):**
- Creates lightweight scaffolding (~60-80 lines)
- Organizes input into themes/structure
- Identifies key questions/topics
- Low investment, acceptable to abandon

**Conduct Mode (`--conduct`):**
- Requires existing scaffolding
- Expands with detailed analysis (~200-300 lines)
- Adds connections, implications, context
- Higher investment, justified by human review

---

## Key Benefits

| Benefit | Setup Mode | Conduct Mode |
|---------|------------|--------------|
| Time Investment | ~5-10 min | ~20-30 min |
| Output Size | ~60-80 lines | ~200-300 lines |
| Abandonment Cost | Low | Higher |
| Human Review | After | Before |

---

## Commands Using This Pattern

| Command | Setup Output | Conduct Output |
|---------|--------------|----------------|
| `/explore` | Exploration scaffolding | Full exploration |
| `/research` | Research scaffolding | Full research |

---

## Integration with Worktree Workflow

The two-mode pattern integrates with lazy worktree creation:

- **Setup Mode:** Stay on develop (lightweight)
- **Conduct Mode:** Prompt for worktree (serious investment)

See [Worktree Workflow](WORKTREE-WORKFLOW.md) for details.

---

## Status Indicators

| Status | Meaning |
|--------|---------|
| `🔴 Scaffolding (needs expansion)` | Setup mode output |
| `✅ Expanded` | Conduct mode output |

---

**Last Updated:** 2026-01-13
**Related:** [ADR-001: Two-Mode Pattern](../admin/decisions/explore-two-mode/adr-001-two-mode-pattern.md)
```

**Checklist:**

- [ ] Two-mode pattern documentation created
- [ ] Pattern explained clearly
- [ ] Benefits documented
- [ ] Integration with worktree documented
- [ ] Links to ADR included

---

### Task 6: Update Command Pipeline Documentation

**Purpose:** Update docs to show `/explore`'s position in command pipeline.

**Location:** Update `docs/GLOBAL-COMMANDS.md` (if exists) or create pipeline section.

**Content to add (to explore section):**

```markdown
### Pipeline Position

`/explore` is the entry point for the ideation pipeline:
```

/explore [topic] ← Setup: scaffolding
↓ human review
/explore [topic] --conduct ← Conduct: full exploration
↓
/research --from-explore ← Research: investigate topics
↓
/decision --from-research ← Decisions: create ADRs
↓
/transition-plan --from-adr ← Planning: create phases
↓
/task-phase 1 1 ← Implementation: execute phases

```

**Key Points:**
- Only command handling unstructured input
- Natural entry point for new ideas
- Human review gate between setup and conduct
```

**Checklist:**

- [ ] Pipeline documentation updated
- [ ] /explore position clear
- [ ] Flow diagram included
- [ ] Key points documented

---

### Task 7: Update CHANGELOG

**Purpose:** Document the feature in CHANGELOG.md.

**Location:** `CHANGELOG.md`

**Content to add (under next version or Unreleased):**

```markdown
### Added

- **`/explore` Two-Mode Pattern** - Setup mode creates scaffolding (~60-80 lines) for human review; conduct mode expands to full exploration (~200-300 lines)
- **Input Sources** - Raw text (`--input`), start.txt (`--from-start`), and reflections (`--from-reflect`) as explicit input sources
- **Worktree Integration** - Lazy worktree creation prompts on conduct mode; `--worktree` and `--no-worktree` flags for explicit control
- **Scaffolding Boundaries** - Clear line count guidance for consistent AI output quality
- **Two-Mode Pattern Documentation** - `docs/TWO-MODE-PATTERN.md` documents the pattern for other commands

### Changed

- **`/explore` command** - Reorganized into two modes with explicit human review checkpoint
- **Command pipeline** - `/explore` now documented as ideation pipeline entry point
```

**Checklist:**

- [ ] CHANGELOG updated with feature
- [ ] Added section lists new capabilities
- [ ] Changed section notes modifications
- [ ] Version/date appropriate

---

## ✅ Completion Criteria

- [ ] `templates/standard-project/.cursor/commands/explore.md` updated
- [ ] `templates/learning-project/.cursor/commands/explore.md` updated
- [ ] `./scripts/validate-template-sync.sh` passes
- [ ] `docs/TWO-MODE-PATTERN.md` created
- [ ] Command pipeline documentation updated
- [ ] `CHANGELOG.md` updated with feature

---

## 📊 Progress Tracking

| Task                             | Status         | Notes               |
| -------------------------------- | -------------- | ------------------- |
| Task 1: Standard Template Update | ✅ Complete    | Copied and verified |
| Task 2: Learning Template Update | ✅ Complete    | Copied and verified |
| Task 3: Template Sync Validation | ✅ Complete    | All synced          |
| Task 4: Sync Manifest Check      | ✅ Complete    | Already in manifest |
| Task 5: Two-Mode Pattern Docs    | ✅ Complete    | Created + linked    |
| Task 6: Pipeline Documentation   | 🔴 Not Started |                     |
| Task 7: CHANGELOG Update         | 🔴 Not Started |                     |

---

## 📦 Deliverables

- Updated template explore.md files (2 files)
- Two-mode pattern documentation (`docs/TWO-MODE-PATTERN.md`)
- Pipeline documentation update
- CHANGELOG update

---

## 🔗 Dependencies

### Prerequisites

- Phase 1-3: Complete (all command changes done)

### Blocks

- None (final phase)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 3](phase-3.md)
- [Template Sync Guide](../../../../docs/TEMPLATE-SYNC.md)
- [All ADRs](../../../decisions/explore-two-mode/)

---

**Last Updated:** 2026-01-13  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
