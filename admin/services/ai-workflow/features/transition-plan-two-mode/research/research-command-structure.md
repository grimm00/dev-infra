# Research: Command Structure Refactoring

**Research Topic:** Transition-Plan Two-Mode Pattern  
**Question:** What structural changes to the command file are needed to support two modes?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2025-12-29  
**Last Updated:** 2025-12-29  
**Completed:** 2025-12-29

---

## 🎯 Research Question

What structural changes to the command file are needed to support two modes?

**Sub-questions:**
- Should setup and expand modes be in separate sections?
- How should the workflow overview change?
- What new sections are needed (mode selection, etc.)?
- Should the step-by-step process be split by mode?

---

## 🔍 Research Goals

- [x] Goal 1: Analyze current `/transition-plan` structure (1095 lines)
- [x] Goal 2: Identify sections that need refactoring
- [x] Goal 3: Document how `/research` structures its two modes
- [x] Goal 4: Define new section organization
- [x] Goal 5: Estimate effort for structural changes

---

## 📚 Research Methodology

**Sources:**
- [x] Current `/transition-plan` command: `.cursor/commands/transition-plan.md` (1095 lines, 60 sections)
- [x] `/research` command structure: `.cursor/commands/research.md` (1070 lines, 83 sections)
- [x] Section header analysis via grep
- [x] Web search: CLI documentation organization patterns

---

## 📊 Findings

### Finding 1: Current `/transition-plan` Structure Analysis

The current `/transition-plan` command (1095 lines) has this structure:

| Section | Lines | Purpose |
|---------|-------|---------|
| Configuration | ~30 | Path detection, feature detection |
| Workflow Overview | ~15 | Single combined workflow description |
| Usage | ~25 | Options and examples |
| **Step-by-Step Process** | ~500 | **ALL steps combined** |
| Mode Selection | ~30 | Input modes (Artifact, Reflection, ADR) |
| Steps 1-7 | ~400 | Create all documents at once |
| From Reflection Mode | ~60 | Separate input mode section |
| From ADR Mode | ~180 | Separate input mode section |
| Common Issues | ~30 | Troubleshooting |
| Tips | ~20 | Best practices |
| Reference | ~40 | File locations, related commands |

**Source:** `/transition-plan` command section header analysis

**Relevance:** The current structure treats "modes" as **input sources** (Artifact, Reflection, ADR), not as **output phases** (Setup, Expand). This needs to change.

---

### Finding 2: `/research` Command Two-Mode Structure

The `/research` command (1070 lines) clearly separates its two modes:

| Section | Lines | Purpose |
|---------|-------|---------|
| Configuration | ~30 | Path detection |
| **Workflow Overview** | ~35 | **Two subsections: Setup Mode + Conduct Mode** |
| Usage | ~30 | **Examples for BOTH modes** |
| **Step-by-Step Process** | ~450 | **Setup Mode only (steps 1-7)** |
| **Conduct Mode Workflow** | ~250 | **Separate section with its own steps 1-7** |
| Integration | ~30 | Flow with other commands |
| Common Scenarios | ~80 | **Mode-specific scenarios** |
| Tips | ~25 | **"When to Use Each Mode" section** |
| Reference | ~20 | File locations |

**Source:** `/research` command section header analysis

**Relevance:** This is the **proven pattern** we should follow. Key structural elements:
1. Workflow Overview has mode subsections
2. Step-by-Step is mode-specific
3. Second mode has its own complete workflow section
4. Scenarios are mode-specific
5. Tips include mode selection guidance

---

### Finding 3: Key Structural Differences

| Aspect | Current `/transition-plan` | Target (`/research` pattern) |
|--------|---------------------------|------------------------------|
| **Mode definition** | Input sources | Output phases |
| **Workflow Overview** | Single description | Two mode subsections |
| **Usage examples** | Single set | Mode-specific examples |
| **Step-by-Step** | All steps together | Setup steps only |
| **Second mode** | N/A | Separate workflow section |
| **Scenarios** | Generic | Mode-specific |
| **Tips** | Generic | "When to Use Each Mode" |

**Source:** Comparative analysis of both commands

**Relevance:** Defines the exact changes needed for refactoring.

---

### Finding 4: Proposed New Structure for `/transition-plan`

```
# Transition Plan Command

[Description - updated for two modes]

---

## Configuration                              # Keep existing
## Workflow Overview                          # REFACTOR
  ### Setup Mode (Default)                    # NEW
  ### Expand Mode (`--expand`)                # NEW
## Usage                                      # REFACTOR with mode examples
## Step-by-Step Process (Setup Mode)          # REFACTOR - rename, simplify
  ### 1. Identify Source (ADR/Artifact/etc.)  # Keep but simplify
  ### 2. Determine Transition Type            # Keep
  ### 3. Parse Source Content                 # Keep but simplify
  ### 4. Create Scaffolding Documents         # REFACTOR - scaffolding only
  ### 5. Update Planning Hubs                 # Keep
  ### 6. Commit Changes                       # Keep

---

## Expand Mode Workflow (`--expand`)          # NEW SECTION
  ### 1. Identify Phase to Expand             # NEW
  ### 2. Read Phase Scaffolding               # NEW
  ### 3. Determine TDD vs Non-TDD             # NEW
  ### 4. Expand Tasks with Detail             # NEW (moved from old step 5)
  ### 5. Update Phase Status                  # NEW
  ### 6. Update Hub Status                    # NEW
  ### 7. Commit Changes                       # NEW

---

## Input Mode Details                         # Keep but reorganize
  ### From Reflection Mode                    # Keep
  ### From ADR Mode                           # Keep
  ### From Artifacts Mode                     # Keep

---

## Common Scenarios                           # REFACTOR
  ### Scenario 1: Setup Scaffolding Only      # NEW
  ### Scenario 2: Expand Single Phase         # NEW
  ### Scenario 3: Expand All Phases           # NEW
  ### Scenario 4: Full Workflow               # NEW

## Tips                                       # REFACTOR
  ### When to Use Each Mode                   # NEW
  ### Best Practices                          # Keep

## Reference                                  # Keep
```

**Source:** Synthesis of research findings

**Relevance:** Provides the blueprint for refactoring.

---

### Finding 5: Effort Estimation

| Task | Estimated Lines | Effort |
|------|-----------------|--------|
| Update Workflow Overview | +30 | Low |
| Update Usage section | +20 | Low |
| Refactor Step-by-Step (Setup) | -200 (simplify) | Medium |
| Add Expand Mode Workflow | +200 | Medium |
| Reorganize Input Modes | ~0 (move) | Low |
| Add Mode-Specific Scenarios | +60 | Low |
| Add "When to Use Each Mode" | +30 | Low |
| Update Common Issues | +20 | Low |

**Estimated Total:**
- Lines added: ~360
- Lines removed: ~200 (simplified from setup)
- Net change: +160 lines
- **Final size: ~1250 lines** (from 1095)

**Effort: ~4-6 hours** (Medium)

**Source:** Task breakdown analysis

**Relevance:** Implementation planning and scope estimation.

---

### Finding 6: Template Content Distribution

Based on scaffolding research (Topic 2), the refactoring should move content:

**FROM Setup Mode (current Step 5 - Create Phase Documents):**
- Detailed TDD task structure
- Code examples
- Testing commands
- Implementation notes

**TO Expand Mode (new Step 4 - Expand Tasks):**
- All of the above content
- TDD RED/GREEN ordering logic
- Phase-specific expansion

**Keep in Setup Mode:**
- Phase headers and metadata
- Goals from source
- Completion criteria placeholders
- Dependencies
- Deliverables list

**Source:** Cross-reference with Topic 2 (Scaffolding Design)

**Relevance:** Defines what content moves where during refactoring.

---

## 🔍 Analysis

Based on the findings, the refactoring requires:

1. **Structural changes** following the `/research` pattern
2. **Content redistribution** per scaffolding design research
3. **New sections** for Expand Mode workflow
4. **Mode-specific** scenarios and tips

| Change Type | Sections Affected | Complexity |
|-------------|-------------------|------------|
| **Add** | Expand Mode Workflow, Mode Scenarios | Medium |
| **Refactor** | Workflow Overview, Usage, Step-by-Step | Medium |
| **Reorganize** | Input Modes (Reflection, ADR, Artifact) | Low |
| **Update** | Tips, Common Issues | Low |

**Key Insights:**
- [x] Insight 1: The `/research` command provides a proven template for two-mode structure
- [x] Insight 2: Current "modes" are input sources; new modes are output phases
- [x] Insight 3: Setup steps need simplification (scaffolding only)
- [x] Insight 4: Expand steps need to be extracted and organized separately
- [x] Insight 5: Estimated effort is 4-6 hours (Medium complexity)

---

## 💡 Recommendations

- [x] Recommendation 1: Follow `/research` command structure as template
- [x] Recommendation 2: Add "Expand Mode Workflow" as a complete new section with steps 1-7
- [x] Recommendation 3: Rename "Step-by-Step Process" to "Setup Mode Workflow"
- [x] Recommendation 4: Add Workflow Overview subsections for each mode
- [x] Recommendation 5: Add mode-specific scenarios and "When to Use Each Mode" tips
- [x] Recommendation 6: Keep input modes (Reflection, ADR, Artifact) as separate reference sections

---

## 📋 Requirements Discovered

- [x] FR-11: Separate Setup Mode Workflow Section
  - Rename current "Step-by-Step Process" to "Setup Mode Workflow"
  - Simplify to scaffolding creation only
  
- [x] FR-12: New Expand Mode Workflow Section
  - Create complete new section with steps 1-7
  - Include TDD logic, task expansion, status updates
  
- [x] FR-13: Mode-Specific Workflow Overview
  - Update Workflow Overview with two subsections
  - Clear description of when to use each mode

- [x] FR-14: Mode-Specific Usage Examples
  - Add expand mode examples to Usage section
  - Show `--expand`, `--phase N`, `--all` flags

- [x] FR-15: Mode-Specific Scenarios
  - Add scenarios for setup-only, expand-single, expand-all workflows
  - Include full workflow scenario

- [x] NFR-8: Command Structure Follows Proven Pattern
  - Structure should mirror `/research` command organization
  - Enables consistency across two-mode commands

---

## 🚀 Next Steps

1. ✅ Research complete
2. All High-priority topics now complete (3/3)
3. Ready for `/decision transition-plan-two-mode --from-research`
4. Or continue with Medium/Low priority topics

---

**Last Updated:** 2025-12-29
