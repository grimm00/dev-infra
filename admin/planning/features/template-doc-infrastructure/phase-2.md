# Template Doc Infrastructure - Phase 2: Format Specification

**Phase:** 2 - Format Specification  
**Duration:** 3-4 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Document template format, placeholder conventions, and variable definitions for tooling implementers.

**Success Definition:** dev-toolkit team can implement `dt-doc-gen` from specification.

---

## 🎯 Goals

1. **Document placeholder conventions** - ${VAR}, <!-- AI: -->, <!-- EXPAND: -->
2. **Document standard variables** - DATE, TOPIC, STATUS, FEATURE_NAME, etc.
3. **Document two-mode support** - Scaffolding vs full generation
4. **Create authoring guide** - How to create/modify templates

---

## 📝 Tasks

### Task 1: Create FORMAT.md (Placeholder Specification)

**Purpose:** Document the three placeholder types and their usage for tooling implementers.

**File:** `scripts/doc-gen/templates/FORMAT.md`

- [x] Create FORMAT.md document
- [x] Document the three placeholder types with syntax table
- [x] Add examples for each placeholder type
- [x] Document when each placeholder type is expanded
- [x] Include template rendering flow diagram
- [x] Reference ADR-002 for authoritative definitions

**Content to Include:**

```markdown
# Template Format Specification

## Placeholder Types

| Type | Syntax | Expanded By | When |
|------|--------|-------------|------|
| Script variable | `${VAR}` | dt-doc-gen (envsubst) | Generation time |
| AI content | `<!-- AI: instruction -->` | AI during workflow | Command execution |
| Expansion zone | `<!-- EXPAND: scope -->` | AI in Conduct mode | Two-mode expansion |

## Script Variables (${VAR})
[Examples and usage]

## AI Content Markers (<!-- AI: -->)
[Examples and usage]

## Expansion Zones (<!-- EXPAND: -->)
[Examples and usage]

## Rendering Flow
[Diagram showing template → envsubst → output]
```

**Checklist:**
- [ ] FORMAT.md created
- [ ] All three placeholder types documented
- [ ] Examples provided for each type
- [ ] Rendering flow explained

---

### Task 2: Create VARIABLES.md (Variable Reference)

**Purpose:** Document all standard variables used across templates for consistency.

**File:** `scripts/doc-gen/templates/VARIABLES.md`

- [ ] Create VARIABLES.md document
- [ ] Document universal variables (DATE, STATUS, etc.)
- [ ] Document workflow-specific variables by category
- [ ] Include default values where applicable
- [ ] Provide example values for each variable
- [ ] Reference actual template files for verification

**Variables to Document:**

**Universal Variables:**
| Variable | Description | Example |
|----------|-------------|---------|
| `${DATE}` | Current date (YYYY-MM-DD) | `2026-01-16` |
| `${STATUS}` | Initial status indicator | `🔴 Scaffolding` |
| `${PURPOSE}` | Document purpose statement | `Research for...` |

**Exploration Variables:**
- `${TOPIC}`, `${TOPIC_TITLE}`, `${EXPLORATION_STATUS}`

**Research Variables:**
- `${TOPIC_NAME}`, `${QUESTION}`, `${QUESTION_NAME}`, `${RESEARCH_QUESTION}`

**Decision Variables:**
- `${ADR_NUMBER}`, `${ADR_TITLE}`, `${BATCH_NUMBER}`

**Planning Variables:**
- `${FEATURE_NAME}`, `${PHASE_NUMBER}`, `${PHASE_NAME}`, `${DURATION}`

**Other Variables:**
- `${SCOPE}`, `${PERIOD}`, `${FEATURE_PATH}`, `${CURRENT_PHASE}`

**Checklist:**
- [ ] VARIABLES.md created
- [ ] Universal variables documented
- [ ] Workflow-specific variables documented by category
- [ ] Default values provided
- [ ] Examples included

---

### Task 3: Create AUTHORING.md (Template Authoring Guide)

**Purpose:** Provide complete guide for creating and modifying templates.

**File:** `scripts/doc-gen/templates/AUTHORING.md`

- [ ] Create AUTHORING.md document
- [ ] Document template file naming conventions
- [ ] Document directory structure requirements
- [ ] Explain two-mode support (setup vs full)
- [ ] Include template creation checklist
- [ ] Provide step-by-step guide for new templates
- [ ] Document testing and validation process
- [ ] Include contribution guidelines

**Sections to Include:**

```markdown
# Template Authoring Guide

## Quick Start
[Minimal steps to create a new template]

## File Naming Conventions
- Use `.tmpl` extension
- Use lowercase with hyphens
- Match output filename (e.g., `README.md.tmpl` → `README.md`)

## Directory Structure
[Where templates go, why organized by category]

## Two-Mode Support
- Setup mode: ${VAR} expanded, AI markers preserved
- Full mode: ${VAR} expanded, AI fills content

## Common Patterns
1. Status Header Block
2. Quick Links Section
3. Status Tables
4. Next Steps Section
5. Related Links Section

## Creating a New Template
1. Identify the document type
2. Choose the appropriate category
3. Create template file with .tmpl extension
4. Add status header pattern
5. Add placeholder variables
6. Add AI markers for content zones
7. Test with envsubst

## Testing Templates
[Manual testing with envsubst]

## Contribution Process
[How to submit template changes]
```

**Checklist:**
- [ ] AUTHORING.md created
- [ ] File naming conventions documented
- [ ] Directory structure explained
- [ ] Two-mode support documented
- [ ] Common patterns listed
- [ ] Template creation guide included
- [ ] Testing process documented

---

### Task 4: Add Two-Mode Documentation Section

**Purpose:** Ensure two-mode (setup vs full) support is clearly documented across all spec files.

**Files to Update:**
- `scripts/doc-gen/templates/FORMAT.md` - Add Two-Mode section
- `scripts/doc-gen/templates/AUTHORING.md` - Expand Two-Mode section

- [ ] Document setup mode behavior (scaffolding)
- [ ] Document full mode behavior (AI fills content)
- [ ] Explain when each mode is used
- [ ] Provide examples of same template in both modes
- [ ] Document expansion zones (`<!-- EXPAND: -->`) in detail

**Two-Mode Flow:**

```
Setup Mode (Scaffolding):
  Template → envsubst → Output with AI markers preserved
  Status: 🔴 Scaffolding

Full Mode (Expansion):
  Template → envsubst → AI fills markers → Final output
  Status: ✅ Expanded
```

**Checklist:**
- [ ] Setup mode documented
- [ ] Full mode documented
- [ ] Examples for both modes
- [ ] Expansion zones explained

---

### Task 5: Verify Spec Completeness

**Purpose:** Ensure all spec documents are complete and cross-referenced.

- [ ] Verify FORMAT.md has all placeholder types from ADR-002
- [ ] Verify VARIABLES.md covers all variables used in templates
- [ ] Verify AUTHORING.md includes all 5 common patterns
- [ ] Cross-reference between spec documents
- [ ] Add links to actual template files as examples
- [ ] Verify spec enables tooling implementation

**Verification Commands:**

```bash
# Check all variables used in templates
grep -rho '\${[A-Z_]*}' scripts/doc-gen/templates/*.tmpl | sort -u

# Check all AI markers
grep -rh '<!-- AI:' scripts/doc-gen/templates/*.tmpl | head -20

# Check all EXPAND zones
grep -rh '<!-- EXPAND:' scripts/doc-gen/templates/*.tmpl | head -20
```

**Checklist:**
- [ ] All placeholder types covered
- [ ] All variables documented
- [ ] Common patterns included
- [ ] Cross-references added
- [ ] Links to examples added
- [ ] Spec enables dt-doc-gen implementation

---

## 📊 Progress Tracking

| Task                              | Status         | Notes |
| --------------------------------- | -------------- | ----- |
| Task 1: FORMAT.md                 | ✅ Complete    |       |
| Task 2: VARIABLES.md              | 🔴 Not Started |       |
| Task 3: AUTHORING.md              | 🔴 Not Started |       |
| Task 4: Two-Mode Documentation    | 🔴 Not Started |       |
| Task 5: Verify Spec Completeness  | 🔴 Not Started |       |

---

## ✅ Completion Criteria

- [x] FORMAT.md documents all placeholder types ✅
- [ ] VARIABLES.md lists all standard variables
- [ ] AUTHORING.md provides complete guide
- [ ] Two-mode support clearly explained
- [ ] Examples provided for each concept
- [ ] Spec enables tooling implementation

---

## 📦 Deliverables

- `scripts/doc-gen/templates/FORMAT.md` - Format specification
- `scripts/doc-gen/templates/VARIABLES.md` - Variable definitions
- `scripts/doc-gen/templates/AUTHORING.md` - Template authoring guide

---

## 🔗 Dependencies

### Prerequisites

- [x] Phase 1: Template Creation (templates exist to reference)
- [x] ADR-002: Template Structure Standard (defines placeholders)
- [x] ADR-003: Generation Architecture (defines envsubst usage)

### Blocks

- dev-toolkit: `dt-doc-gen` implementation (needs format spec)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Phase 1: Template Creation](phase-1.md)
- [Phase 3: Validation Rules](phase-3.md)
- [ADR-002: Template Structure Standard](../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [ADR-003: Generation Architecture](../../../decisions/template-doc-infrastructure/adr-003-generation-architecture.md)

---

**Last Updated:** 2026-01-16  
**Status:** 🟠 In Progress  
**Next:** Complete Task 1: FORMAT.md
