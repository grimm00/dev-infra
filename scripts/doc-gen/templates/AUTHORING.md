# Template Authoring Guide

**Purpose:** Guide for creating, modifying, and testing templates in `dev-infra`.  
**Target Audience:** Template authors, contributors, maintainers  
**Status:** 🟠 In Progress  
**Created:** 2026-01-16  
**Last Updated:** 2026-01-16

---

## 📋 Overview

This guide provides everything you need to create new templates or modify existing ones. Templates are the foundation of the documentation infrastructure, enabling consistent document generation across workflows.

---

## 🚀 Quick Start

**Create a new template in 5 steps:**

1. **Identify the document type** - What kind of document are you creating?
2. **Choose the category** - exploration, research, decision, planning, or other
3. **Create the template file** - `category/document-name.md.tmpl`
4. **Add the standard patterns** - Status header, quick links, etc.
5. **Test with envsubst** - Verify variables expand correctly

**Example:**

```bash
# Create a new template
touch scripts/doc-gen/templates/research/new-topic.md.tmpl

# Test variable expansion
export DATE=$(date +%Y-%m-%d)
export STATUS="🔴 Scaffolding"
export TOPIC_TITLE="My Topic"
envsubst < scripts/doc-gen/templates/research/new-topic.md.tmpl
```

---

## 📁 Directory Structure

Templates are organized by workflow category:

```
scripts/doc-gen/templates/
├── FORMAT.md           # Placeholder specification
├── VARIABLES.md        # Variable reference
├── AUTHORING.md        # This guide
├── exploration/        # Exploration workflow templates
│   ├── README.md.tmpl
│   ├── exploration.md.tmpl
│   └── research-topics.md.tmpl
├── research/           # Research workflow templates
│   ├── README.md.tmpl
│   ├── research-topic.md.tmpl
│   ├── research-summary.md.tmpl
│   └── requirements.md.tmpl
├── decision/           # Decision workflow templates
│   ├── README.md.tmpl
│   ├── adr.md.tmpl
│   └── decisions-summary.md.tmpl
├── planning/           # Planning workflow templates
│   ├── README.md.tmpl
│   ├── feature-plan.md.tmpl
│   ├── phase.md.tmpl
│   └── status-and-next-steps.md.tmpl
└── other/              # Cross-workflow templates
    ├── handoff.md.tmpl
    ├── fix-batch.md.tmpl
    └── reflection.md.tmpl
```

### Category Guidelines

| Category | Purpose | When to Use |
|----------|---------|-------------|
| `exploration/` | Initial discovery and problem framing | `/explore` command |
| `research/` | Structured investigation and analysis | `/research` command |
| `decision/` | Architectural decisions (ADRs) | `/decision` command |
| `planning/` | Feature planning and tracking | `/transition-plan` command |
| `other/` | Cross-workflow utilities | Various commands |

---

## 📝 File Naming Conventions

### Template Files

| Convention | Example | Notes |
|------------|---------|-------|
| Extension | `.md.tmpl` | Always use `.tmpl` extension |
| Case | `lowercase-with-hyphens` | No underscores or camelCase |
| Output match | `README.md.tmpl` → `README.md` | Template name matches output |
| Descriptive | `research-topic.md.tmpl` | Clear purpose from name |

### Hub vs. Spoke Documents

| Type | Filename | Purpose |
|------|----------|---------|
| Hub | `README.md.tmpl` | Navigation entry point |
| Spoke | `[document-name].md.tmpl` | Specific content document |

### Examples

```
✅ Good:
  - README.md.tmpl
  - feature-plan.md.tmpl
  - research-topic.md.tmpl
  - adr.md.tmpl

❌ Bad:
  - FeaturePlan.md.tmpl    # No camelCase
  - feature_plan.md.tmpl   # No underscores
  - plan.tmpl              # Missing .md
  - feature-plan.md        # Missing .tmpl
```

---

## 🔄 Two-Mode Support

Templates support two generation modes to enable efficient workflows where structure can be reviewed before content is generated.

### Why Two Modes?

**Problem:** Generating complete documents in one step can waste AI tokens if the structure isn't right.

**Solution:** Two-mode generation separates structure creation from content filling:

1. **Setup Mode** - Create structure quickly, human reviews
2. **Conduct Mode** - AI fills content after structure is approved

**Benefits:**

- ⚡ Fast scaffolding (minimal AI tokens)
- 👀 Human review before content investment
- 🎯 Better final documents (structure validated first)
- 💰 Token efficiency (no wasted AI on wrong structure)

### Setup Mode (Scaffolding)

**Purpose:** Create document structure quickly for human review.

**Behavior:**

| Placeholder Type | Behavior in Setup Mode |
|-----------------|------------------------|
| `${VAR}` | ✅ Expanded by envsubst |
| `<!-- AI: -->` | ⏸️ Preserved (not filled) |
| `<!-- EXPAND: -->` | ⏸️ Preserved (not filled) |

**Status:** `🔴 Scaffolding`

**When to Use:**

- Starting new workflows (`/explore`, `/research`, `/transition-plan`)
- Creating multiple related documents
- Need to validate structure before content
- Want human review of approach

**Example Output:**

```markdown
# Feature Plan: Auth System

**Status:** 🔴 Scaffolding
**Created:** 2026-01-16

## 🎯 Goals

<!-- AI: List feature goals based on research findings -->

## 📅 Implementation Phases

<!-- EXPAND: Break down into 3-5 phases with tasks and estimates -->
```

### Conduct Mode (Full Expansion)

**Purpose:** AI fills all content markers for complete documents.

**Behavior:**

| Placeholder Type | Behavior in Conduct Mode |
|-----------------|--------------------------|
| `${VAR}` | ✅ Expanded by envsubst |
| `<!-- AI: -->` | ✅ Filled with AI-generated content |
| `<!-- EXPAND: -->` | ✅ Expanded with detailed content |

**Status:** `✅ Expanded` (or workflow-specific status)

**When to Use:**

- After human reviews scaffolding
- Ready for complete document
- Command includes `--expand` or `--conduct` flag
- Decision workflows (usually always full)

**Example Output:**

```markdown
# Feature Plan: Auth System

**Status:** ✅ Expanded
**Created:** 2026-01-16

## 🎯 Goals

1. Implement secure user authentication with JWT tokens
2. Support multiple authentication providers (local, OAuth)
3. Provide role-based access control (RBAC)
4. Ensure compliance with security best practices

## 📅 Implementation Phases

### Phase 1: Foundation (2-3 days)

- [ ] Set up authentication middleware
- [ ] Implement JWT token generation
- [ ] Create user model with password hashing

### Phase 2: Core Auth (3-4 days)

- [ ] Implement login/logout endpoints
- [ ] Add refresh token support
- [ ] Create session management

### Phase 3: Advanced Features (2-3 days)

- [ ] Add OAuth provider support
- [ ] Implement RBAC
- [ ] Add audit logging
```

### Designing Templates for Two-Mode

**When creating templates, ensure they work well in both modes:**

#### 1. Use Clear Section Headers

```markdown
## 🎯 Goals

<!-- AI: List 3-5 goals as numbered items -->
```

Scaffolding shows: header + marker (reviewable structure)
Full shows: header + generated content

#### 2. Provide Detailed AI Instructions

```markdown
<!-- AI: List key findings. For each finding include:
- Finding title
- Brief description
- Source reference
-->
```

Better instructions → better AI output in conduct mode.

#### 3. Choose Marker Type Appropriately

| Content Size | Marker Type | Example Use |
|--------------|-------------|-------------|
| Brief (1-3 sentences) | `<!-- AI: -->` | Summaries, descriptions |
| Moderate (1-3 paragraphs) | `<!-- AI: -->` | Analysis, recommendations |
| Detailed (sections) | `<!-- EXPAND: -->` | Findings, methodology, phases |

#### 4. Design for Progressive Disclosure

```markdown
## Overview

<!-- AI: Brief 2-3 sentence overview -->

## Details

<!-- EXPAND: Comprehensive details with subsections -->
```

In scaffolding, humans see structure.
In full mode, AI fills appropriate detail levels.

### Two-Mode Workflow Example

**Typical workflow using two modes:**

```
Step 1: Create Scaffolding
$ dt-doc-gen explore "User Auth" --setup
→ Creates admin/explorations/user-auth/
→ All documents have 🔴 Scaffolding status
→ AI/EXPAND markers preserved

Step 2: Human Review
Developer reviews:
- Is the structure right?
- Are the sections appropriate?
- Should anything be added/removed?

Step 3: Expand Content
$ dt-doc-gen explore "User Auth" --expand
→ AI fills all markers
→ Status changes to ✅ Expanded
→ Complete documents generated
```

### Testing Two-Mode Behavior

**Verify template works in setup mode:**

```bash
# Export variables
export DATE=$(date +%Y-%m-%d)
export STATUS="🔴 Scaffolding"
export TOPIC_TITLE="Test Topic"

# Generate scaffolding
envsubst < template.md.tmpl

# Verify:
# ✅ ${VAR} placeholders expanded
# ✅ <!-- AI: --> markers preserved
# ✅ <!-- EXPAND: --> zones preserved
```

**See:** [FORMAT.md](FORMAT.md#-two-mode-generation) for complete two-mode specification.

---

## 🎨 Common Patterns

All templates should use these 5 standard patterns for consistency.

### Pattern 1: Status Header Block

**Every template starts with:**

```markdown
# Document Title: ${TOPIC_TITLE}

**Purpose:** ${PURPOSE}  
**Status:** ${STATUS}  
**Created:** ${DATE}  
**Last Updated:** ${DATE}

---
```

**Variables:**
- `${TOPIC_TITLE}` or `${FEATURE_NAME}` - Document subject
- `${PURPOSE}` - One-line purpose statement
- `${STATUS}` - Status indicator (🔴, 🟠, ✅)
- `${DATE}` - YYYY-MM-DD format

### Pattern 2: Quick Links Section

**For hub documents (README.md.tmpl):**

```markdown
## 📋 Quick Links

<!-- AI: Generate links based on created documents -->
- **[Document 1](document-1.md)** - Brief description
- **[Document 2](document-2.md)** - Brief description
```

**For spoke documents:**

```markdown
## 🔗 Related Documents

- [Hub](README.md) - Return to hub
- [Related Doc](related.md) - Description
```

### Pattern 3: Status Tables

**For tracking multiple items:**

```markdown
## 📊 Status

| Item | Status | Notes |
| ---- | ------ | ----- |
<!-- AI: Generate status rows -->
```

**Status indicators:**
- 🔴 Not Started
- 🟡 Planned
- 🟠 In Progress
- ✅ Complete

### Pattern 4: Next Steps Section

**At the end of every document:**

```markdown
## 🚀 Next Steps

<!-- AI: List immediate next actions -->

---

**Next:** [Specific action or command]
```

### Pattern 5: Related Links Section

**For cross-referencing:**

```markdown
## 🔗 Related Documents

- [Parent Hub](../README.md)
- [Related Feature](../other-feature/README.md)
- [ADR Reference](../../decisions/adr-001.md)
```

---

## 📋 Template Creation Checklist

Use this checklist when creating new templates:

### Structure

- [ ] File in correct category directory
- [ ] Filename follows conventions (`lowercase-hyphen.md.tmpl`)
- [ ] Status header block at top
- [ ] Sections use consistent heading levels
- [ ] Document ends with Next Steps or Related Links

### Placeholders

- [ ] All dynamic values use `${VAR}` syntax
- [ ] Variables documented in VARIABLES.md
- [ ] AI markers have clear instructions
- [ ] EXPAND zones have defined scope
- [ ] No hardcoded values that should be variables

### Two-Mode Support

- [ ] Document works in scaffolding mode (AI markers preserved)
- [ ] Document works in full mode (AI markers filled)
- [ ] Status variable supports both modes

### Testing

- [ ] Tested with `envsubst` (variables expand correctly)
- [ ] No syntax errors in markdown
- [ ] Links are relative and correct
- [ ] Tables render properly

---

## 🛠️ Step-by-Step: Creating a New Template

### Step 1: Identify Document Type

**Questions to ask:**
- What workflow does this document support?
- Is it a hub (navigation) or spoke (content)?
- What information does it need to capture?
- Who will read this document?

### Step 2: Choose Category

| If the document is for... | Use category... |
|---------------------------|-----------------|
| Initial discovery | `exploration/` |
| Structured investigation | `research/` |
| Architectural decisions | `decision/` |
| Feature planning | `planning/` |
| Cross-workflow utility | `other/` |

### Step 3: Create Template File

```bash
# Create the file
touch scripts/doc-gen/templates/[category]/[document-name].md.tmpl

# Open for editing
code scripts/doc-gen/templates/[category]/[document-name].md.tmpl
```

### Step 4: Add Standard Patterns

**Start with the status header:**

```markdown
# [Document Type]: ${TOPIC_TITLE}

**Purpose:** ${PURPOSE}  
**Status:** ${STATUS}  
**Created:** ${DATE}

---
```

**Add sections with AI markers:**

```markdown
## 🎯 Section Name

<!-- AI: Instruction for what AI should generate -->
```

**End with navigation:**

```markdown
---

**Next:** [Action or command]
```

### Step 5: Add Variables

**Identify what needs to be dynamic:**
- Dates → `${DATE}`
- Names/titles → `${TOPIC_TITLE}`, `${FEATURE_NAME}`
- Status → `${STATUS}`
- Paths → `${TOPIC_NAME}` (kebab-case for paths)

**Update VARIABLES.md if adding new variables.**

### Step 6: Test the Template

```bash
# Set test variables
export DATE="2026-01-16"
export STATUS="🔴 Scaffolding"
export TOPIC_TITLE="Test Topic"
export PURPOSE="Testing template creation"

# Run envsubst
envsubst < scripts/doc-gen/templates/[category]/[document].md.tmpl

# Verify output looks correct
```

### Step 7: Document and Commit

```bash
# Update VARIABLES.md if new variables added
# Commit with descriptive message
git add scripts/doc-gen/templates/
git commit -m "feat(templates): add [document-name] template

- Add [category]/[document-name].md.tmpl
- Supports [workflow] workflow
- [Any other notes]"
```

---

## 🧪 Testing Templates

### Manual Testing with envsubst

**Basic test:**

```bash
# Export required variables
export DATE=$(date +%Y-%m-%d)
export STATUS="🔴 Scaffolding"
export TOPIC_TITLE="Test Topic"

# Run envsubst and inspect output
envsubst < scripts/doc-gen/templates/exploration/README.md.tmpl
```

**Test all variables expand:**

```bash
# Check for unexpanded variables in output
envsubst < template.md.tmpl | grep -E '\$\{[A-Z_]+\}'
# Should return nothing if all variables are set
```

### Validation Checks

**Check for common issues:**

```bash
# Find all variables used in a template
grep -o '\${[A-Z_]*}' scripts/doc-gen/templates/exploration/README.md.tmpl | sort -u

# Find all AI markers
grep '<!-- AI:' scripts/doc-gen/templates/exploration/README.md.tmpl

# Find all EXPAND zones
grep '<!-- EXPAND:' scripts/doc-gen/templates/exploration/README.md.tmpl
```

### Integration Testing

When `dt-doc-gen` is available:

```bash
# Test template generation
dt-doc-gen explore "Test Topic" --dry-run

# Validate generated output
dt-doc-validate admin/explorations/test-topic/
```

---

## 📤 Contribution Guidelines

### Before Contributing

1. **Check existing templates** - Avoid duplication
2. **Review FORMAT.md** - Understand placeholder conventions
3. **Review VARIABLES.md** - Use existing variables when possible
4. **Follow this guide** - Use standard patterns

### Contribution Process

1. **Create feature branch:**
   ```bash
   git checkout -b feat/template-[name]
   ```

2. **Create/modify template** following this guide

3. **Update documentation:**
   - Add new variables to VARIABLES.md
   - Update category README if needed

4. **Test thoroughly:**
   - Manual envsubst testing
   - Verify two-mode support
   - Check all links

5. **Submit PR:**
   - Clear description of changes
   - Reference any related issues
   - Include testing notes

### Review Criteria

Templates are reviewed for:

- [ ] Follows naming conventions
- [ ] Uses standard patterns
- [ ] Variables documented
- [ ] Two-mode support works
- [ ] Testing completed
- [ ] No hardcoded values

---

## 🔗 References

- [FORMAT.md](FORMAT.md) - Placeholder specification
- [VARIABLES.md](VARIABLES.md) - Variable reference
- [ADR-002: Template Structure Standard](../../../admin/decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [ADR-003: Generation Architecture](../../../admin/decisions/template-doc-infrastructure/adr-003-generation-architecture.md)

---

**Last Updated:** 2026-01-16
