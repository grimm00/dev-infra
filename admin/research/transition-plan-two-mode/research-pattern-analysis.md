# Research: Two-Mode Pattern Analysis

**Research Topic:** Transition-Plan Two-Mode Pattern  
**Question:** How does the `/research` command implement its two-mode pattern, and what patterns should we adopt?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29  
**Completed:** 2025-12-29

---

## 🎯 Research Question

How does the `/research` command implement its two-mode pattern (Setup vs Conduct), and what patterns should we adopt for `/transition-plan`?

**Sub-questions:**
- What triggers the switch between modes?
- How does the command detect existing structure?
- What metadata (if any) tracks mode state?
- How does it handle partial completion?

---

## 🔍 Research Goals

- [x] Goal 1: Understand the `/research` command's two-mode implementation
- [x] Goal 2: Identify the key architectural patterns used
- [x] Goal 3: Determine what triggers mode switching
- [x] Goal 4: Document how state/progress is tracked
- [x] Goal 5: Extract patterns applicable to `/transition-plan`

---

## 📚 Research Methodology

**Primary Source:** Existing `/research` command implementation in dev-infra

**Sources:**
- [x] `/research` command: `.cursor/commands/research.md` (1070 lines analyzed)
- [x] `/explore` command: `.cursor/commands/explore.md` (comparison - single mode)
- [x] `/decision` command: `.cursor/commands/decision.md` (comparison - single mode)
- [x] Web search: Two-mode CLI patterns and best practices

---

## 📊 Findings

### Finding 1: Flag-Based Mode Switching

The `/research` command uses a **flag-based approach** to switch between modes. The `--conduct` flag triggers Conduct Mode; absence of the flag defaults to Setup Mode.

```markdown
**Setup Mode (Default):**
/research [topic] --from-explore [topic]

**Conduct Mode:**
/research [topic] --conduct [--topic-num N]
```

**Source:** `/research` command lines 49-70

**Relevance:** This is the proven pattern we should adopt. For `/transition-plan`:
- Default = Setup Mode (creates scaffolding)
- `--expand` flag = Expand Mode (fills in details)

---

### Finding 2: No Explicit Metadata for State Tracking

The `/research` command does **NOT** use separate metadata files or headers to track mode state. Instead, it relies on:

1. **Document existence:** If research documents exist, setup is assumed complete
2. **Status indicators:** Documents use `🔴 Not Started`, `🟡 In Progress`, `✅ Complete` 
3. **Content inspection:** Can check if findings sections are filled vs. placeholder

**Source:** `/research` command structure and research document templates

**Relevance:** `/transition-plan` should follow the same approach:
- Check if `phase-N.md` files exist → setup was done
- Check if task sections are placeholders vs. detailed → expansion needed
- Use status indicators for human-readable tracking

---

### Finding 3: Incremental Progress Support

The `/research` command supports **incremental progress** through topic-specific flags:

```markdown
--topic-num [N]    # Research specific topic by number
--topic-name [name] # Research specific topic by name
```

This allows users to research one topic at a time rather than all at once.

**Source:** `/research` command lines 97-98

**Relevance:** `/transition-plan --expand` should support:
- `--phase N` to expand specific phase
- `--all` to expand all phases at once
- Default could expand next unexpanded phase

---

### Finding 4: Clear Workflow Separation in Documentation

The `/research` command maintains **completely separate documentation sections** for each mode:

1. **Setup Mode** has its own step-by-step process (Steps 1-7)
2. **Conduct Mode** has a separate workflow section with its own steps (Steps 1-7)

This separation makes the command documentation clear and prevents mode confusion.

**Source:** `/research` command structure - "Step-by-Step Process" vs "Conduct Mode Workflow"

**Relevance:** `/transition-plan` documentation should be restructured with:
- "Setup Mode Workflow" section
- "Expand Mode Workflow" section
- Clear separation between the two

---

### Finding 5: Comparison with Single-Mode Commands

Both `/explore` and `/decision` commands are **single-mode commands**:
- `/explore` creates exploration documents directly
- `/decision` creates ADR documents directly

Neither has a setup+conduct pattern because their workflows don't benefit from human review between phases.

**Source:** `/explore` and `/decision` command analysis

**Relevance:** The two-mode pattern is appropriate when:
- Human review is valuable between phases
- Output quality depends on incremental refinement
- The initial structure is simple but expansion is complex

All three criteria apply to `/transition-plan`.

---

### Finding 6: Command Pattern Best Practices (Industry)

Industry best practices for two-mode CLI patterns include:

1. **Terraform-style plan/apply:** Preview changes before applying
2. **Command encapsulation:** Each mode is self-contained
3. **Mode-specific behavior:** Clear separation of concerns
4. **State management:** Document-based rather than hidden state files
5. **Undo capability:** Ability to re-run modes if output is wrong

**Source:** Web search: CLI command patterns, Command design pattern literature

**Relevance:** The `/transition-plan` two-mode pattern aligns with established industry patterns, particularly the terraform plan/apply model.

---

## 🔍 Analysis

Based on the findings, the `/research` command's two-mode implementation uses these key patterns:

| Pattern | Implementation | Apply to `/transition-plan` |
|---------|----------------|----------------------------|
| **Mode Trigger** | `--conduct` flag | `--expand` flag |
| **Default Mode** | Setup (structure creation) | Setup (scaffolding) |
| **State Tracking** | Document existence + status indicators | Same approach |
| **Incremental Progress** | `--topic-num N` | `--phase N` |
| **Documentation** | Separate sections per mode | Same structure |

**Key Insights:**
- [x] Insight 1: Flag-based mode switching is simple and proven
- [x] Insight 2: Document-based state tracking avoids metadata complexity
- [x] Insight 3: Incremental progress support is essential for large plans
- [x] Insight 4: Clear documentation separation prevents user confusion
- [x] Insight 5: The pattern works because human review between modes adds value

---

## 💡 Recommendations

- [x] Recommendation 1: Use `--expand` flag to trigger expand mode (mirrors `--conduct`)
- [x] Recommendation 2: Use `--phase N` for incremental expansion (mirrors `--topic-num`)
- [x] Recommendation 3: Add `--all` flag to expand all phases at once
- [x] Recommendation 4: Track state via document existence and status indicators (no metadata files)
- [x] Recommendation 5: Restructure command documentation with separate mode sections
- [x] Recommendation 6: Default expand mode behavior should be single phase (like `--topic-num` default)

---

## 📋 Requirements Discovered

- [x] FR-5: Mode Switching via `--expand` Flag
  - Setup mode (default) creates scaffolding
  - Expand mode (with `--expand`) fills in details
  
- [x] FR-6: Phase-Specific Expansion via `--phase N`
  - Allow expanding specific phases incrementally
  - Track which phases have been expanded via content inspection
  
- [x] FR-7: Expand All via `--all` Flag
  - Support batch expansion of all phases
  - Useful when human review is complete

- [x] NFR-4: Document-Based State Tracking
  - Use document existence for setup state
  - Use status indicators for expansion state
  - No separate metadata files required

- [x] NFR-5: Clear Documentation Separation
  - Setup Mode Workflow section
  - Expand Mode Workflow section
  - Mode-specific checklists and examples

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with Topic 2: Scaffolding Content Design
3. Apply findings to command restructuring in implementation phase

---

**Last Updated:** 2025-12-29
