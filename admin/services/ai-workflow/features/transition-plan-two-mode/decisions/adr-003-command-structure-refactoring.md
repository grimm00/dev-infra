# ADR-003: Command Structure Refactoring

**Status:** Proposed  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29  
**Research Source:** [research-command-structure.md](../../research/transition-plan-two-mode/research-command-structure.md)

---

## Context

With the two-mode pattern (ADR-001) and scaffolding boundaries (ADR-002) decided, we need to decide **how to restructure the command documentation** to support two modes.

**Research Question:** What structural changes to the command file are needed to support two modes?

**Key Research Findings:**

1. Current `/transition-plan` is 1095 lines with 60 sections, treats "modes" as input sources
2. `/research` command (1070 lines, 83 sections) provides proven two-mode structure
3. Key differences: Workflow Overview subsections, separate mode workflows, mode-specific scenarios
4. Estimated effort: 4-6 hours, ~+160 lines net change

---

## Decision

**Refactor command documentation to mirror the `/research` command structure**, with clear separation between Setup Mode and Expand Mode workflows.

### New Structure

```
# Transition Plan Command

## Configuration                              # Keep existing
## Workflow Overview                          # REFACTOR
  ### Setup Mode (Default)                    # NEW
  ### Expand Mode (`--expand`)                # NEW
## Usage                                      # REFACTOR with mode examples
## Step-by-Step Process (Setup Mode)          # RENAME + SIMPLIFY
  ### Steps 1-6: Create scaffolding           # Simplified
## Expand Mode Workflow (`--expand`)          # NEW SECTION
  ### Steps 1-7: Expand with detail           # NEW
## Input Mode Details                         # Keep (Reflection, ADR, Artifact)
## Common Scenarios                           # REFACTOR
  ### Scenario 1: Setup Scaffolding Only      # NEW
  ### Scenario 2: Expand Single Phase         # NEW
  ### Scenario 3: Expand All Phases           # NEW
  ### Scenario 4: Full Workflow               # NEW
## Tips                                       # REFACTOR
  ### When to Use Each Mode                   # NEW
## Reference                                  # Keep
```

### Workflow Overview Changes

```markdown
## Workflow Overview

### Setup Mode (Default)

Creates scaffolding documents (~60-80 lines per phase) with structure but not detail.

**When to use:**
- First run on a new transition
- To review phase breakdown before adding detail

**Output:** transition-plan.md + phase-N.md scaffolding files

### Expand Mode (`--expand`)

Fills scaffolding with detailed TDD tasks, code examples, and implementation notes.

**When to use:**
- After reviewing scaffolding structure
- When ready to add implementation detail

**Flags:**
- `--phase N` - Expand specific phase
- `--all` - Expand all phases
```

### New Expand Mode Workflow Section

```markdown
## Expand Mode Workflow (`--expand`)

### 1. Identify Phase to Expand
### 2. Read Phase Scaffolding
### 3. Determine TDD vs Non-TDD
### 4. Expand Tasks with Detail
### 5. Update Phase Status
### 6. Update Hub Status
### 7. Commit Changes
```

---

## Consequences

### Positive

- **Proven pattern:** Mirrors successful `/research` command structure
- **Clear organization:** Mode workflows are clearly separated
- **User guidance:** "When to Use Each Mode" helps users choose
- **Consistent ecosystem:** All two-mode commands follow same pattern
- **Maintainable:** Structure is logical and navigable

### Negative

- **Larger document:** ~1250 lines (from 1095), +160 net
- **Refactoring effort:** 4-6 hours to implement
- **Content duplication:** Some content appears in both mode sections

### Neutral

- **Input modes preserved:** Reflection, ADR, Artifact sections remain

---

## Alternatives Considered

### Alternative 1: Minimal Changes

**Description:** Add `--expand` flag but don't restructure documentation.

**Pros:**
- Faster to implement
- Less disruption

**Cons:**
- Confusing mixed structure
- Doesn't follow ecosystem patterns
- Harder for users to understand

**Why not chosen:** Would create inconsistent user experience.

---

### Alternative 2: Single Linear Flow

**Description:** Keep single Step-by-Step section with conditional branches.

**Pros:**
- Shorter document
- Single narrative

**Cons:**
- Complex conditional logic
- Hard to follow
- Doesn't scale well

**Why not chosen:** Two separate workflows are clearer than one with branches.

---

### Alternative 3: Separate Command Files

**Description:** Split into `transition-plan-setup.md` and `transition-plan-expand.md`.

**Pros:**
- Complete separation
- Shorter individual files

**Cons:**
- File proliferation
- Breaks convention
- Harder to maintain

**Why not chosen:** Single file with clear sections is standard practice.

---

## Decision Rationale

The `/research` command structure was chosen because:

1. **Proven:** Already works well for `/research --conduct`
2. **Clear:** Users can quickly find their mode's workflow
3. **Consistent:** Enables pattern across all two-mode commands
4. **Maintainable:** Logical organization aids updates

**Research Support:**

| Finding | Application |
|---------|-------------|
| Finding 1: Current structure | Modes are input sources, need change |
| Finding 2: `/research` structure | Provides proven template |
| Finding 3: Key differences | Workflow Overview, separate workflows |
| Finding 4: Proposed structure | Blueprint for refactoring |
| Finding 5: Effort estimate | 4-6 hours, manageable |

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-11: Separate Setup Workflow | Rename + simplify Step-by-Step |
| FR-12: Expand Mode Workflow | New section with steps 1-7 |
| FR-13: Mode-Specific Overview | Workflow Overview subsections |
| FR-14: Mode-Specific Examples | Usage section updates |
| FR-15: Mode-Specific Scenarios | Common Scenarios updates |
| NFR-8: Follows Proven Pattern | Mirrors `/research` structure |

---

## Implementation Notes

### Phase 1: Workflow Overview (~30 min)

1. Add Setup Mode subsection
2. Add Expand Mode subsection
3. Document when to use each

### Phase 2: Setup Mode Workflow (~1-2 hours)

1. Rename "Step-by-Step Process" to "Setup Mode Workflow"
2. Simplify steps to scaffolding creation only
3. Remove detailed task expansion content
4. Update step numbering (6 steps)

### Phase 3: Expand Mode Workflow (~2 hours)

1. Create new "Expand Mode Workflow" section
2. Add steps 1-7 with full detail
3. Include TDD ordering logic
4. Add status update procedures

### Phase 4: Supporting Content (~1 hour)

1. Update Usage section with mode examples
2. Add mode-specific scenarios
3. Add "When to Use Each Mode" to Tips
4. Update Common Issues for two-mode workflow

### Estimated Total: 4-6 hours

---

## References

- [Research: Command Structure](../../research/transition-plan-two-mode/research-command-structure.md)
- [/research Command](../../../.cursor/commands/research.md) - Pattern source
- [ADR-001: Flag-Based Mode Switching](adr-001-flag-based-mode-switching.md)
- [ADR-002: Scaffolding Content Boundaries](adr-002-scaffolding-content-boundaries.md)
- [Requirements Document](../../research/transition-plan-two-mode/requirements.md)

---

**Last Updated:** 2025-12-29

