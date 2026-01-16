# Template Doc Infrastructure - Phase 1: Template Creation

**Phase:** 1 - Template Creation  
**Duration:** 6-8 hours  
**Status:** ✅ Complete  
**Completed:** 2026-01-16  
**Prerequisites:** ADRs complete

---

## 📋 Overview

Create all 17 template files organized by workflow category, following the structure defined in ADR-002.

**Success Definition:** All templates created and matching current command output.

---

## 🎯 Goals

1. **Create exploration templates** - README, exploration.md, research-topics.md
2. **Create research templates** - README, research-topic.md, summary, requirements
3. **Create decision templates** - README, adr-NNN.md, summary
4. **Create planning templates** - README, feature-plan.md, phase-N.md, status
5. **Create other templates** - Handoff, fix-batch, reflection

---

## 📝 Tasks

### Task 1: Create Directory Structure

**Purpose:** Set up the template directory hierarchy per ADR-002.

- [ ] Create `scripts/doc-gen/templates/` root directory
- [ ] Create `scripts/doc-gen/templates/exploration/` subdirectory
- [ ] Create `scripts/doc-gen/templates/research/` subdirectory
- [ ] Create `scripts/doc-gen/templates/decision/` subdirectory
- [ ] Create `scripts/doc-gen/templates/planning/` subdirectory
- [ ] Create `scripts/doc-gen/templates/other/` subdirectory

**Commands:**

```bash
mkdir -p scripts/doc-gen/templates/{exploration,research,decision,planning,other}
```

**Checklist:**

- [ ] All directories created
- [ ] Directory structure matches ADR-002

---

### Task 2: Create Exploration Templates (3 files)

**Purpose:** Templates for `/explore` command workflow.

**Reference:** Read `.cursor/commands/explore.md` for current format.

#### 2.1: Exploration Hub Template

**File:** `scripts/doc-gen/templates/exploration/README.md.tmpl`

- [ ] Read current exploration README format from existing docs
- [ ] Create template with `${VAR}` for topic, date, status
- [ ] Include Quick Links section pattern
- [ ] Include Status Table for research topics
- [ ] Add `<!-- AI: -->` markers for descriptions

**Key sections:**

```markdown
# Exploration: ${TOPIC_TITLE}

**Purpose:** ${PURPOSE}  
**Status:** ${STATUS}  
**Created:** ${DATE}

## 📋 Quick Links

<!-- AI: Generate links based on created documents -->

## 📊 Research Topics

| Topic | Priority | Status |
| ----- | -------- | ------ |

<!-- AI: List identified research topics -->
```

#### 2.2: Main Exploration Template

**File:** `scripts/doc-gen/templates/exploration/exploration.md.tmpl`

- [ ] Read `.cursor/commands/explore.md` for scaffolding format
- [ ] Create template with 7 sections: Problem, Context, Themes, Questions, Initial Thoughts, Next Steps, Related
- [ ] Use `<!-- EXPAND: -->` for sections filled in Conduct mode
- [ ] Include status header pattern

#### 2.3: Research Topics Template

**File:** `scripts/doc-gen/templates/exploration/research-topics.md.tmpl`

- [ ] Create template for listing research topics
- [ ] Include priority/effort/status table format
- [ ] Use `<!-- AI: -->` for topic descriptions
- [ ] Link back to exploration hub

**Checklist:**

- [ ] All 3 exploration templates created
- [ ] Templates match current `/explore` output
- [ ] Placeholder conventions followed

---

### Task 3: Create Research Templates (4 files)

**Purpose:** Templates for `/research` command workflow.

**Reference:** Read `.cursor/commands/research.md` for current format.

#### 3.1: Research Hub Template

**File:** `scripts/doc-gen/templates/research/README.md.tmpl`

- [ ] Read current research README format
- [ ] Include Quick Links to topic files
- [ ] Include Status Table for all topics
- [ ] Include link to requirements and summary

#### 3.2: Research Topic Template

**File:** `scripts/doc-gen/templates/research/research-topic.md.tmpl`

- [ ] Read `.cursor/commands/research.md` for topic format
- [ ] Include sections: Question, Goals, Methodology, Findings, Analysis, Recommendations, Requirements
- [ ] Use `<!-- EXPAND: -->` for Findings, Methodology
- [ ] Use `<!-- AI: -->` for Analysis, Recommendations

#### 3.3: Research Summary Template

**File:** `scripts/doc-gen/templates/research/research-summary.md.tmpl`

- [ ] Template for aggregating findings across topics
- [ ] Include Key Findings section
- [ ] Include Insights section
- [ ] Link to individual topic files

#### 3.4: Requirements Template

**File:** `scripts/doc-gen/templates/research/requirements.md.tmpl`

- [ ] Template for capturing requirements
- [ ] Include sections: Functional, Non-Functional, Constraints, Assumptions
- [ ] Use consistent requirement format (ID, Description, Source, Priority)
- [ ] Link to research topics as sources

**Checklist:**

- [ ] All 4 research templates created
- [ ] Templates match current `/research` output
- [ ] Placeholder conventions followed

---

### Task 4: Create Decision Templates (3 files)

**Purpose:** Templates for `/decision` command workflow.

**Reference:** Read `.cursor/commands/decision.md` for current format.

#### 4.1: Decision Hub Template

**File:** `scripts/doc-gen/templates/decision/README.md.tmpl`

- [ ] Read current decision README format
- [ ] Include Quick Links to ADRs
- [ ] Include ADR status table
- [ ] Link to decisions-summary

#### 4.2: ADR Template

**File:** `scripts/doc-gen/templates/decision/adr.md.tmpl`

- [ ] Use standard ADR format: Context, Decision, Consequences, Alternatives, Rationale
- [ ] Include status header with batch number
- [ ] Use `<!-- AI: -->` for Context, Decision, Consequences
- [ ] Include Requirements Impact section
- [ ] Include References section

**Key sections:**

```markdown
# ADR-${ADR_NUMBER}: ${ADR_TITLE}

**Status:** ${STATUS}  
**Created:** ${DATE}  
**Batch:** ${BATCH_NUMBER}

## Context

<!-- AI: Describe the context and problem -->

## Decision

<!-- AI: State the decision -->

## Consequences

<!-- AI: List positive and negative consequences -->

## Alternatives Considered

<!-- EXPAND: Describe alternatives evaluated -->

## Decision Rationale

<!-- AI: Explain why this decision was made -->

## Requirements Impact

<!-- AI: Link to requirements addressed -->
```

#### 4.3: Decisions Summary Template

**File:** `scripts/doc-gen/templates/decision/decisions-summary.md.tmpl`

- [ ] Template for summarizing all decisions
- [ ] Include Key Decisions section with brief summaries
- [ ] Include Requirements Coverage table
- [ ] Include Implementation Impact section

**Checklist:**

- [ ] All 3 decision templates created
- [ ] Templates match current `/decision` output
- [ ] ADR format follows standard structure

---

### Task 5: Create Planning Templates (4 files)

**Purpose:** Templates for feature planning workflows.

**Reference:** Read `.cursor/commands/transition-plan.md` for current format.

#### 5.1: Planning Hub Template

**File:** `scripts/doc-gen/templates/planning/README.md.tmpl`

- [ ] Read current feature README format
- [ ] Include Quick Links to phases
- [ ] Include Phase Status table
- [ ] Include Success Criteria section
- [ ] Link to related research and decisions

#### 5.2: Feature Plan Template

**File:** `scripts/doc-gen/templates/planning/feature-plan.md.tmpl`

- [ ] Template for feature-plan.md
- [ ] Include Overview, Goals, Phases, Success Criteria
- [ ] Use `<!-- AI: -->` for descriptions
- [ ] Include Dependencies section

#### 5.3: Phase Template

**File:** `scripts/doc-gen/templates/planning/phase.md.tmpl`

- [ ] Template for phase-N.md documents
- [ ] Include Goals, Tasks, Completion Criteria, Deliverables, Dependencies
- [ ] Support both scaffolding (`🔴 Scaffolding`) and expanded (`✅ Expanded`) status
- [ ] Use `<!-- EXPAND: -->` for detailed tasks

#### 5.4: Status Template

**File:** `scripts/doc-gen/templates/planning/status-and-next-steps.md.tmpl`

- [ ] Template for status tracking
- [ ] Include Progress Overview table
- [ ] Include Phase Progress section
- [ ] Include Next Steps section
- [ ] Use `<!-- AI: -->` for status updates

**Checklist:**

- [ ] All 4 planning templates created
- [ ] Templates match current transition-plan output
- [ ] Phase template supports two-mode pattern

---

### Task 6: Create Other Templates (3 files)

**Purpose:** Templates for remaining workflows.

#### 6.1: Handoff Template

**File:** `scripts/doc-gen/templates/other/handoff.md.tmpl`

**Reference:** Read `.cursor/commands/handoff.md` for current format.

- [ ] Template for cross-session handoff docs
- [ ] Include sections: Current State, Key Files, Completed, Next Steps, Notes
- [ ] Use `<!-- AI: -->` for all content sections

#### 6.2: Fix Batch Template

**File:** `scripts/doc-gen/templates/other/fix-batch.md.tmpl`

**Reference:** Read `.cursor/commands/fix-plan.md` for current format.

- [ ] Template for fix batch documents
- [ ] Include Issues Table (ID, Description, Priority, File)
- [ ] Include Status tracking
- [ ] Use `<!-- AI: -->` for issue descriptions

#### 6.3: Reflection Template

**File:** `scripts/doc-gen/templates/other/reflection.md.tmpl`

**Reference:** Read `.cursor/commands/reflect.md` for current format.

- [ ] Template for reflection documents
- [ ] Include sections: Summary, What Worked, Challenges, Insights, Next Steps
- [ ] Use `<!-- AI: -->` for all reflection content

**Checklist:**

- [ ] All 3 other templates created
- [ ] Templates match current command output
- [ ] Placeholder conventions followed

---

### Task 7: Verify Template Consistency

**Purpose:** Ensure all templates follow conventions and match expected output.

- [ ] Verify all 17 templates use `${VAR}` for script variables
- [ ] Verify all templates use `<!-- AI: -->` for AI content
- [ ] Verify all templates use `<!-- EXPAND: -->` for expansion zones
- [ ] Verify status header pattern in all templates
- [ ] Verify Next Steps section in all templates
- [ ] Cross-check template output against existing generated docs

**Verification commands:**

```bash
# Check for ${VAR} usage
grep -r '\${' scripts/doc-gen/templates/

# Check for AI markers
grep -r '<!-- AI:' scripts/doc-gen/templates/

# Check for EXPAND markers
grep -r '<!-- EXPAND:' scripts/doc-gen/templates/

# Count templates
find scripts/doc-gen/templates -name "*.tmpl" | wc -l  # Should be 17
```

**Checklist:**

- [ ] All placeholder conventions verified
- [ ] All common patterns present
- [ ] Template count = 17

---

## 📊 Progress Tracking

| Task                              | Status      | Notes |
| --------------------------------- | ----------- | ----- |
| Task 1: Directory Structure       | ✅ Complete |       |
| Task 2: Exploration Templates (3) | ✅ Complete |       |
| Task 3: Research Templates (4)    | ✅ Complete |       |
| Task 4: Decision Templates (3)    | ✅ Complete |       |
| Task 5: Planning Templates (4)    | ✅ Complete |       |
| Task 6: Other Templates (3)       | ✅ Complete |       |
| Task 7: Verify Consistency        | ✅ Complete |       |

---

## ✅ Completion Criteria

- [x] 17 template files created in `scripts/doc-gen/templates/`
- [x] Templates use `${VAR}` syntax for script variables
- [x] Templates use `<!-- AI: -->` for AI content markers
- [x] Templates use `<!-- EXPAND: -->` for expansion zones
- [x] Templates match current command output format
- [x] All 5 common patterns implemented (Status Header, Quick Links, Status Tables, Next Steps, Related Links)

---

## 📦 Deliverables

**Exploration (3):**

- `scripts/doc-gen/templates/exploration/README.md.tmpl`
- `scripts/doc-gen/templates/exploration/exploration.md.tmpl`
- `scripts/doc-gen/templates/exploration/research-topics.md.tmpl`

**Research (4):**

- `scripts/doc-gen/templates/research/README.md.tmpl`
- `scripts/doc-gen/templates/research/research-topic.md.tmpl`
- `scripts/doc-gen/templates/research/research-summary.md.tmpl`
- `scripts/doc-gen/templates/research/requirements.md.tmpl`

**Decision (3):**

- `scripts/doc-gen/templates/decision/README.md.tmpl`
- `scripts/doc-gen/templates/decision/adr.md.tmpl`
- `scripts/doc-gen/templates/decision/decisions-summary.md.tmpl`

**Planning (4):**

- `scripts/doc-gen/templates/planning/README.md.tmpl`
- `scripts/doc-gen/templates/planning/feature-plan.md.tmpl`
- `scripts/doc-gen/templates/planning/phase.md.tmpl`
- `scripts/doc-gen/templates/planning/status-and-next-steps.md.tmpl`

**Other (3):**

- `scripts/doc-gen/templates/other/handoff.md.tmpl`
- `scripts/doc-gen/templates/other/fix-batch.md.tmpl`
- `scripts/doc-gen/templates/other/reflection.md.tmpl`

---

## 🔗 Dependencies

### Prerequisites

- [x] ADR-002: Template Structure Standard (defines templates)
- [x] Research: Template Inventory (identifies 17 templates)

### Blocks

- Phase 2: Format Specification (needs templates to reference)
- Phase 3: Validation Rules (needs templates to validate)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Phase 2: Format Specification](phase-2.md)
- [ADR-002: Template Structure Standard](../../../decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [Research: Template Inventory](../../../research/template-doc-infrastructure/research-template-inventory.md)

---

**Last Updated:** 2026-01-16  
**Status:** ✅ Complete  
**Next:** Phase 2: Format Specification
