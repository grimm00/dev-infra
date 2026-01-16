# Template Variable Reference

**Purpose:** Complete reference for all template variables  
**Audience:** Template authors, tooling implementers  
**Status:** ✅ Active  
**Last Updated:** 2026-01-16

---

## 📋 Quick Links

- **[Format Specification](FORMAT.md)** - Placeholder types and rendering
- **[Authoring Guide](AUTHORING.md)** - How to create templates
- **[ADR-002: Template Structure Standard](../../admin/decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)** - Authoritative decisions

---

## 🎯 Overview

This document lists all variables used in template files. Variables follow the `${VAR_NAME}` syntax and are expanded by `envsubst` at generation time.

**Total Variables:** 29  
**Categories:** 7 (Universal, Exploration, Research, Decision, Planning, Fix/Handoff, Metrics)

---

## 📊 Universal Variables

These variables are used across multiple template categories.

| Variable | Description | Example Value | Used In |
|----------|-------------|---------------|---------|
| `${DATE}` | Current date (YYYY-MM-DD format) | `2026-01-16` | All templates |
| `${STATUS}` | Initial status indicator | `🔴 Scaffolding` | All templates |
| `${PURPOSE}` | Document purpose statement | `Research for template infrastructure` | Hub templates |

### Usage Example

```markdown
**Status:** ${STATUS}  
**Created:** ${DATE}  
**Last Updated:** ${DATE}
```

### Default Values

| Variable | Default Value |
|----------|---------------|
| `${DATE}` | `$(date +%Y-%m-%d)` |
| `${STATUS}` | `🔴 Scaffolding` |
| `${PURPOSE}` | (Required - no default) |

---

## 🔍 Exploration Variables

Variables for exploration workflow templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${TOPIC_NAME}` | Topic identifier (kebab-case) | `template-doc-infrastructure` |
| `${TOPIC_TITLE}` | Topic display name (Title Case) | `Template Doc Infrastructure` |
| `${TOPIC_COUNT}` | Number of research topics identified | `7` |

### Templates Using These Variables

- `exploration/README.md.tmpl` - Exploration hub
- `exploration/exploration.md.tmpl` - Main exploration document
- `exploration/research-topics.md.tmpl` - Topic listing

### Usage Example

```markdown
# Exploration: ${TOPIC_TITLE}

**Purpose:** Initial exploration of ${TOPIC_NAME}  
**Topics Identified:** ${TOPIC_COUNT}
```

---

## 📚 Research Variables

Variables for research workflow templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${TOPIC_NAME}` | Research topic identifier | `template-doc-infrastructure` |
| `${TOPIC_TITLE}` | Research topic display name | `Template Doc Infrastructure` |
| `${QUESTION}` | Research question text | `How should templates be structured?` |
| `${QUESTION_NAME}` | Question identifier (kebab-case) | `template-structure` |
| `${TOPIC_COUNT}` | Number of topics in research | `7` |

### Templates Using These Variables

- `research/README.md.tmpl` - Research hub
- `research/research-topic.md.tmpl` - Individual research topic
- `research/research-summary.md.tmpl` - Summary of findings
- `research/requirements.md.tmpl` - Requirements document

### Usage Example

```markdown
# Research: ${QUESTION_NAME}

**Research Topic:** ${TOPIC_NAME}  
**Question:** ${QUESTION}  
**Status:** ${STATUS}
```

---

## ⚖️ Decision Variables

Variables for decision (ADR) workflow templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${TOPIC_NAME}` | Decision topic identifier | `template-doc-infrastructure` |
| `${ADR_NUMBER}` | ADR number (zero-padded) | `001` |
| `${DECISION_TITLE}` | ADR title | `Architectural Placement` |
| `${BATCH_NUMBER}` | Decision batch number | `1` |
| `${DECISION_COUNT}` | Total ADRs in topic | `5` |

### Templates Using These Variables

- `decision/README.md.tmpl` - Decision hub
- `decision/adr.md.tmpl` - Individual ADR document
- `decision/decisions-summary.md.tmpl` - Summary of all decisions

### Usage Example

```markdown
# ADR-${ADR_NUMBER}: ${DECISION_TITLE}

**Status:** ${STATUS}  
**Created:** ${DATE}  
**Batch:** ${BATCH_NUMBER}
```

---

## 📋 Planning Variables

Variables for planning and feature workflow templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${FEATURE_NAME}` | Feature identifier (kebab-case) | `template-doc-infrastructure` |
| `${FEATURE_PATH}` | Path to feature directory | `admin/planning/features/template-doc-infrastructure` |
| `${FEATURE_STATUS}` | Current feature status | `🟠 In Progress` |
| `${PHASE_NUMBER}` | Current phase number | `2` |
| `${PHASE_NAME}` | Phase name/description | `Format Specification` |
| `${ESTIMATED_TIME}` | Estimated duration | `3-4 hours` |
| `${EFFORT}` | Effort level | `Medium` |
| `${PRIORITY}` | Priority level | `High` |

### Templates Using These Variables

- `planning/README.md.tmpl` - Feature hub
- `planning/feature-plan.md.tmpl` - Feature planning document
- `planning/phase.md.tmpl` - Phase document
- `planning/status-and-next-steps.md.tmpl` - Status tracking

### Usage Example

```markdown
# ${FEATURE_NAME} - Phase ${PHASE_NUMBER}: ${PHASE_NAME}

**Phase:** ${PHASE_NUMBER} - ${PHASE_NAME}  
**Duration:** ${ESTIMATED_TIME}  
**Status:** ${STATUS}
```

---

## 🔧 Fix & Handoff Variables

Variables for fix batch and handoff templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${BATCH_ID}` | Fix batch identifier | `PR58-B1` |
| `${BATCH_NAME}` | Fix batch name | `Batch 1: Critical Fixes` |
| `${ISSUE_COUNT}` | Number of issues in batch | `5` |
| `${BRANCH_NAME}` | Git branch name | `feat/template-doc-infrastructure` |
| `${WORKTREE_NAME}` | Worktree directory name | `feat-template-doc-infrastructure` |
| `${CURRENT_PHASE}` | Current phase reference | `phase-2.md` |

### Templates Using These Variables

- `other/fix-batch.md.tmpl` - Fix batch document
- `other/handoff.md.tmpl` - Session handoff document

### Usage Example

```markdown
# Fix Batch: ${BATCH_NAME}

**Batch ID:** ${BATCH_ID}  
**Issues:** ${ISSUE_COUNT}  
**Branch:** ${BRANCH_NAME}
```

---

## 📈 Reflection Variables

Variables for reflection templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${SCOPE}` | Reflection scope | `Full Project` |
| `${PERIOD}` | Time period analyzed | `2026-01-01 to 2026-01-16` |
| `${FEATURE_NAME}` | Feature being reflected on | `template-doc-infrastructure` |
| `${FEATURE_STATUS}` | Feature status at reflection | `🟠 In Progress` |
| `${FEATURE_PATH}` | Path to feature docs | `admin/planning/features/...` |
| `${CURRENT_PHASE}` | Current phase at reflection | `phase-2.md` |

### Templates Using These Variables

- `other/reflection.md.tmpl` - Project reflection document

### Usage Example

```markdown
# Project Reflection - ${DATE}

**Scope:** ${SCOPE}  
**Period:** ${PERIOD}  
**Feature:** ${FEATURE_NAME} (${FEATURE_STATUS})
```

---

## 📊 Metrics Variables

Variables for counts and metrics in hub templates.

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${TOPIC_COUNT}` | Number of topics | `7` |
| `${DECISION_COUNT}` | Number of decisions | `5` |
| `${DOC_COUNT}` | Number of documents | `17` |
| `${ISSUE_COUNT}` | Number of issues | `5` |

### Usage Example

```markdown
## 📊 Summary

**Research Topics:** ${TOPIC_COUNT}  
**Decisions Made:** ${DECISION_COUNT}  
**Documents Created:** ${DOC_COUNT}
```

---

## 🔄 Variable Naming Conventions

### Rules

1. **UPPERCASE** with underscores: `${FEATURE_NAME}`
2. **Descriptive names**: Prefer `${TOPIC_TITLE}` over `${TITLE}`
3. **Consistent suffixes**:
   - `*_NAME` - Identifier (kebab-case): `template-doc-infrastructure`
   - `*_TITLE` - Display name (Title Case): `Template Doc Infrastructure`
   - `*_COUNT` - Numeric count: `7`
   - `*_PATH` - File/directory path: `admin/planning/...`
   - `*_STATUS` - Status indicator: `🟠 In Progress`

### Adding New Variables

When adding a new variable:

1. Use consistent naming convention
2. Add to appropriate category in this document
3. Provide example value
4. List which templates use it
5. Update the total count at the top

---

## 🛠️ Implementation Reference

### Setting Variables (dt-doc-gen)

```bash
# Universal
export DATE=$(date +%Y-%m-%d)
export STATUS="🔴 Scaffolding"

# Topic-based
export TOPIC_NAME="my-topic"
export TOPIC_TITLE="My Topic"

# Feature-based
export FEATURE_NAME="my-feature"
export PHASE_NUMBER="1"
export PHASE_NAME="Foundation"

# Render template
envsubst < template.md.tmpl > output.md
```

### Validation

```bash
# Find all variables in a template
grep -o '\${[A-Z_]*}' template.md.tmpl | sort -u

# Verify all variables are set
envsubst -v '${TOPIC_NAME} ${DATE}' < /dev/null
```

---

## 📋 Complete Variable List

**Quick reference of all 29 variables:**

| Variable | Category |
|----------|----------|
| `${ADR_NUMBER}` | Decision |
| `${BATCH_ID}` | Fix/Handoff |
| `${BATCH_NAME}` | Fix/Handoff |
| `${BATCH_NUMBER}` | Decision |
| `${BRANCH_NAME}` | Fix/Handoff |
| `${CURRENT_PHASE}` | Planning/Reflection |
| `${DATE}` | Universal |
| `${DECISION_COUNT}` | Metrics |
| `${DECISION_TITLE}` | Decision |
| `${DOC_COUNT}` | Metrics |
| `${EFFORT}` | Planning |
| `${ESTIMATED_TIME}` | Planning |
| `${FEATURE_NAME}` | Planning |
| `${FEATURE_PATH}` | Planning |
| `${FEATURE_STATUS}` | Planning |
| `${ISSUE_COUNT}` | Metrics |
| `${PERIOD}` | Reflection |
| `${PHASE_NAME}` | Planning |
| `${PHASE_NUMBER}` | Planning |
| `${PRIORITY}` | Planning |
| `${PURPOSE}` | Universal |
| `${QUESTION}` | Research |
| `${QUESTION_NAME}` | Research |
| `${SCOPE}` | Reflection |
| `${STATUS}` | Universal |
| `${TOPIC_COUNT}` | Metrics |
| `${TOPIC_NAME}` | Exploration/Research |
| `${TOPIC_TITLE}` | Exploration/Research |
| `${WORKTREE_NAME}` | Fix/Handoff |

---

## 🔗 Related Documents

**Spec Documents:**

- [Format Specification](FORMAT.md) - Placeholder types and rendering
- [Authoring Guide](AUTHORING.md) - Template creation guide

**Architecture Decisions:**

- [ADR-002: Template Structure Standard](../../../admin/decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)

**Template Examples by Variable Category:**

| Variable Category | Example Template | Key Variables |
|-------------------|------------------|---------------|
| Exploration | [README.md.tmpl](exploration/README.md.tmpl) | `${TOPIC_TITLE}`, `${TOPIC_COUNT}` |
| Research | [research-topic.md.tmpl](research/research-topic.md.tmpl) | `${QUESTION}`, `${QUESTION_NAME}` |
| Decision | [adr.md.tmpl](decision/adr.md.tmpl) | `${ADR_NUMBER}`, `${DECISION_TITLE}` |
| Planning | [phase.md.tmpl](planning/phase.md.tmpl) | `${PHASE_NUMBER}`, `${PHASE_NAME}` |
| Fix/Handoff | [fix-batch.md.tmpl](other/fix-batch.md.tmpl) | `${BATCH_ID}`, `${BRANCH_NAME}` |
| Reflection | [reflection.md.tmpl](other/reflection.md.tmpl) | `${SCOPE}`, `${PERIOD}` |

---

**Last Updated:** 2026-01-16  
**Status:** ✅ Active
