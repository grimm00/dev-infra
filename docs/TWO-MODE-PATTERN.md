# Two-Mode Pattern for Cursor Commands

**Purpose:** Document the setup/conduct pattern used in `/explore` and applicable to other commands  
**Status:** ✅ Active  
**Last Updated:** 2026-01-13

---

## Overview

The two-mode pattern separates commands into lightweight setup and detailed conduct phases, with human review in between.

**Pattern:**

```
/command [topic]              ← Setup: scaffolding (~60-80 lines)
    ↓ human review            ← KEY CHECKPOINT
/command [topic] --conduct    ← Conduct: full output (~200-300 lines)
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
