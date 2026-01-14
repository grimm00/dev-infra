# Research: Command Integration

**Research Topic:** Template Doc Infrastructure  
**Question:** How do templates integrate with existing commands (/explore, /research, /handoff)?  
**Status:** ✅ Complete  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-14

---

## 🎯 Research Question

How do templates integrate with existing commands? Commands currently describe output format inline. Switching to templates requires updating commands to invoke generation scripts and rely on templated structure.

---

## 🔍 Research Goals

- [x] Goal 1: Audit command definitions to identify doc generation points
- [x] Goal 2: Design invocation pattern (how commands call generation scripts)
- [x] Goal 3: Define how AI-generated sections work within templates
- [x] Goal 4: Plan migration path for existing command outputs

---

## 📚 Research Methodology

**Sources:**
- [x] Source 1: Audit `.cursor/commands/` for doc generation patterns
- [x] Source 2: Identify which commands generate which doc types
- [x] Source 3: Understand Cursor command → shell script integration
- [x] Source 4: Review how commands currently define output format

---

## 📊 Findings

### Finding 1: Commands Embed Templates Inline

**Audit of `.cursor/commands/` directory:**

| Statistic | Value |
|-----------|-------|
| Total commands | 23 |
| Commands with inline templates | 23 |
| Inline template occurrences | 154 (across all files) |

**Pattern observed:** Commands use markdown code blocks to define output format:

```markdown
**File:** `explorations/[topic]/exploration.md`

\`\`\`markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD
...
\`\`\`
```

**Source:** Grep of `.cursor/commands/` for "\`\`\`markdown"

**Relevance:** This is the problem - format is duplicated 154 times across commands, causing drift.

---

### Finding 2: Command-to-DocType Mapping

Analysis of commands reveals which commands generate which doc types:

| Command | Doc Type Generated | Mode | Notes |
|---------|-------------------|------|-------|
| `/explore` | exploration.md, research-topics.md, README.md | Setup + Conduct | Two-mode pattern |
| `/research` | research-*.md, research-summary.md, requirements.md | Setup + Conduct | Two-mode pattern |
| `/decision` | adr-NNN.md, decisions-summary.md, README.md | Single | Multiple ADRs per topic |
| `/transition-plan` | transition-plan.md, feature-plan.md, phase-N.md | Single | Planning docs |
| `/handoff` | handoff.md | Single | Cross-session context |
| `/fix-plan` | fix-batch-N.md | Single | Fix management |
| `/fix-implement` | Updates existing fix batches | N/A | No new docs |
| `/post-pr` | Updates status docs | N/A | Updates existing |
| `/reflect` | reflection-*.md | Single | Reflection docs |

**Source:** Audit of `.cursor/commands/` directory

**Relevance:** Identifies which commands need template integration.

---

### Finding 3: Two-Mode Commands Need Special Handling

Two commands (`/explore`, `/research`) use the two-mode pattern:

**Setup Mode:**
- Creates scaffolding (~60-80 lines)
- Minimal AI content
- Human review checkpoint

**Conduct Mode:**
- Expands scaffolding (~200-300 lines)
- Significant AI content
- Fills placeholders

**Template implication:**

| Mode | Script Role | AI Role |
|------|-------------|---------|
| Setup | Generate full scaffolding | Minimal (variable substitution only) |
| Conduct | Read scaffolding, prepare expansion zones | Fill expansion zones with analysis |

**Source:** `/explore` and `/research` command definitions

**Relevance:** Templates need to support both modes with clear expansion zones.

---

### Finding 4: Current Command → Shell Integration Pattern

Commands can invoke shell scripts via terminal commands:

```markdown
**Commit (docs can push directly):**

\`\`\`bash
git add explorations/[topic]/
git commit -m "docs(explore): create [topic] exploration scaffolding"
git push origin develop
\`\`\`
```

**Existing patterns:**
- Commands describe bash commands in markdown code blocks
- AI executes commands via `run_terminal_cmd` tool
- No abstraction layer between command and script

**Integration approach:**

```markdown
**Generate scaffolding:**

\`\`\`bash
dt-doc-gen exploration my-topic --mode setup
\`\`\`

**Validate before commit:**

\`\`\`bash
dt-doc-validate exploration admin/explorations/my-topic/
\`\`\`
```

**Source:** Command workflow sections

**Relevance:** Defines how commands will invoke generation/validation scripts.

---

### Finding 5: Placeholder Conventions for AI Content

Current commands use comments as placeholders:

```markdown
### Theme 1: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->
```

**Proposed standardization:**

| Placeholder Type | Format | AI Action |
|------------------|--------|-----------|
| Variable | `{{VAR}}` | Script replaces before AI sees |
| AI Required | `<!-- AI: [instruction] -->` | AI fills with content |
| AI Optional | `<!-- AI-OPTIONAL: [instruction] -->` | AI may fill or leave |
| Expansion Zone | `<!-- EXPAND: [scope] -->` | AI expands in Conduct mode |

**Example template with zones:**

```markdown
# Exploration: {{TOPIC}}

**Status:** 🔴 Scaffolding
**Created:** {{DATE}}

---

## 🎯 What We're Exploring

<!-- AI: Write 2-3 sentence summary based on input -->

---

## 🔍 Initial Themes

### Theme 1: {{THEME_1_NAME}}

<!-- EXPAND: Add detailed analysis, connections, implications in conduct mode -->

---
```

**Source:** Pattern analysis of existing commands

**Relevance:** Defines how AI and scripts collaborate on doc content.

---

### Finding 6: Migration Path for Existing Commands

Commands need to be migrated from inline templates to external templates:

**Phase 1: Extract Templates (No Command Changes)**
- Create template files in `scripts/doc-gen/templates/`
- Validate templates match current command output
- No changes to commands yet

**Phase 2: Add Script Invocation (Incremental)**
- Update commands one at a time
- Replace inline templates with script invocation
- Keep inline template as fallback initially

**Phase 3: Remove Inline Templates (Cleanup)**
- After validation, remove inline templates from commands
- Commands only reference external templates
- Commands become orchestrators, not template holders

**Migration per command:**

```markdown
# Before (inline template)
**Create scaffolding:**
\`\`\`markdown
# Exploration: [Topic]
...
\`\`\`

# After (script invocation)
**Generate scaffolding:**
\`\`\`bash
dt-doc-gen exploration my-topic --mode setup
\`\`\`
```

**Source:** Analysis of command structure

**Relevance:** Defines incremental migration approach.

---

### Finding 7: Command-Script Responsibility Split

Clear separation of concerns:

| Responsibility | Owner | Notes |
|---------------|-------|-------|
| Workflow orchestration | Command | "/explore → setup → human review → conduct" |
| User prompts/decisions | Command | "Create worktree? [Y/n]" |
| Structure generation | Script (`dt-doc-gen`) | Deterministic, 0 tokens |
| Content generation | AI via command | Creative, targeted tokens |
| Validation | Script (`dt-doc-validate`) | Deterministic, 0 tokens |
| Commit/push | Command (via bash) | "git add/commit/push" |

**Command remains the orchestrator**, scripts are tools it invokes.

**Source:** Architectural analysis

**Relevance:** Clarifies what changes in commands vs. what stays the same.

---

## 🔍 Analysis

**Key Insights:**
- [x] **Insight 1:** 154 inline templates across 23 commands confirms duplication problem
- [x] **Insight 2:** Two-mode commands need scaffolding + expansion zone templates
- [x] **Insight 3:** Commands can invoke scripts via bash code blocks (existing pattern)
- [x] **Insight 4:** Migration can be incremental (one command at a time)
- [x] **Insight 5:** Commands remain orchestrators; scripts are just tools

**Integration Pattern:**

```
┌──────────────────────────────────────────────────────────┐
│  Command (e.g., /explore)                                │
│  - Orchestrates workflow                                  │
│  - Handles user prompts                                   │
│  - Invokes scripts for structure                          │
│  - Generates AI content for placeholders                  │
│  - Validates output                                       │
│  - Commits changes                                        │
└──────────────────────────────────────────────────────────┘
                          │
          ┌───────────────┴───────────────┐
          ▼                               ▼
┌─────────────────────┐     ┌─────────────────────────────┐
│  dt-doc-gen          │     │  AI (Cursor)                 │
│  - Generate structure│     │  - Fill placeholders         │
│  - Variable expansion│     │  - Creative content          │
│  - Mode handling     │     │  - Analysis/insights         │
└─────────────────────┘     └─────────────────────────────┘
          │                               │
          └───────────────┬───────────────┘
                          ▼
┌──────────────────────────────────────────────────────────┐
│  dt-doc-validate                                          │
│  - Check structure compliance                             │
│  - Verify required sections                               │
│  - Report issues                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 💡 Recommendations

- [x] **R1:** Commands invoke `dt-doc-gen` for structure, not inline templates
- [x] **R2:** Commands invoke `dt-doc-validate` before commit
- [x] **R3:** Standardize placeholder format (`{{VAR}}`, `<!-- AI: -->`, `<!-- EXPAND: -->`)
- [x] **R4:** Migrate commands incrementally (Phase 1-3 approach)
- [x] **R5:** Two-mode templates with clear expansion zones
- [x] **R6:** Commands remain workflow orchestrators (no change to orchestration logic)
- [x] **R7:** Start with `/explore` and `/research` (most complex, highest value)

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-26:** Commands must invoke `dt-doc-gen` for structure generation instead of inline templates
- **FR-27:** Commands must invoke `dt-doc-validate` before committing generated docs
- **FR-28:** Templates must support three placeholder types: variable (`{{VAR}}`), AI-required (`<!-- AI: -->`), expansion (`<!-- EXPAND: -->`)
- **FR-29:** Two-mode templates must have clear expansion zones for Conduct mode
- **FR-30:** Migration must be incremental (one command at a time, fallback to inline)

### Non-Functional Requirements

- **NFR-13:** Command migration must not break existing workflows (backwards compatible)
- **NFR-14:** Script invocation must be faster than AI template generation

### Constraints

- **C-13:** Commands must remain workflow orchestrators (no change to orchestration logic)
- **C-14:** AI must not generate document structure, only fill placeholders

---

## 🚀 Next Steps

1. Add FR-26 through FR-30 to requirements.md
2. Add NFR-13, NFR-14 to requirements.md
3. Add C-13, C-14 to requirements.md
4. Update research summary with command integration findings
5. Proceed to `/decision` phase to formalize architecture

---

**Last Updated:** 2026-01-14
