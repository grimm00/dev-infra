# Research Command

Conduct structured research following standardized workflow. Creates research documents for each research topic/question and extracts requirements discovered during research.

---

## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Dev-Infra Structure (default):**
   - Research: `admin/research/[topic]/`
   - Requirements: `admin/research/[topic]/requirements.md`
   - Explorations: `admin/explorations/[topic]/`

2. **Template Structure (for generated projects):**
   - Research: `docs/maintainers/research/[topic]/`
   - Requirements: `docs/maintainers/research/[topic]/requirements.md`
   - Explorations: `docs/maintainers/planning/explorations/[topic]/`

3. **Project-Wide Structure:**
   - Research: `docs/maintainers/research/[topic]/`
   - Requirements: `docs/maintainers/research/[topic]/requirements.md`
   - Explorations: `docs/maintainers/planning/explorations/[topic]/`

**Topic Detection:**
- Use `--topic` option if provided
- Otherwise, auto-detect from input source
- Sanitize topic name (kebab-case, no spaces)

---

## Workflow Overview

**When to use:**

- After exploration identifies research topics
- When reflect artifacts identify opportunities needing research
- To conduct structured research on a specific topic

**Key principle:** Follow standardized research workflow, create documents for each research topic, extract requirements discovered during research.

**Workflow:**
```
/research [topic] --from-explore [topic]
  → Reads research topics from exploration
  → Creates research hub
  → Creates research document for each topic
  → Extracts requirements
  → Outputs: Research documents + requirements.md
```

---

## Usage

**Command:** `/research [topic] [--from-explore|--from-reflect|--topic] [options]`

**Examples:**

- `/research auth-system --from-explore new-authentication-system` - Research topics from exploration
- `/research ci-optimization --from-reflect reflection-project-2025-12-07.md` - Research opportunities from reflection
- `/research database-choice --topic "PostgreSQL vs MongoDB"` - Direct research topic
- `/research --dry-run` - Show what would be created without creating files

**Options:**

- `--from-explore [explore-topic]` - Read research topics from exploration document
- `--from-reflect [reflection-file]` - Read opportunities from reflection artifacts
- `--topic [topic]` - Direct topic specification (if not using --from-explore or --from-reflect)
- `--dry-run` - Show what would be created without creating files

---

## Step-by-Step Process

### 1. Identify Research Source

**Determine input source:**

1. **From Exploration (`--from-explore`):**
   - **Dev-Infra:** Read `admin/explorations/[explore-topic]/research-topics.md`
   - **Template Structure:** Read `docs/maintainers/planning/explorations/[explore-topic]/research-topics.md`
   - Extract research topics/questions
   - Use explore-topic as research topic name (or use --topic to override)

2. **From Reflection (`--from-reflect`):**
   - Read reflection document
   - Extract "Actionable Suggestions" or "Opportunities for Improvement"
   - Convert suggestions to research topics
   - Use topic from command or prompt user

3. **Direct Topic (`--topic` or no flag):**
   - Use provided topic
   - Prompt user for research questions if needed

**Checklist:**

- [ ] Research source identified
- [ ] Research topics extracted
- [ ] Topic name determined

---

### 2. Create Research Hub

**Location Detection:**

- **Dev-Infra:** `admin/research/[topic]/`
- **Template Structure:** `docs/maintainers/research/[topic]/`
- **Project-Wide:** `docs/maintainers/research/[topic]/`

**Auto-detection:**
- Check if `admin/research/` exists → use dev-infra structure
- Check if `docs/maintainers/research/` exists → use template structure
- Otherwise → use project-wide structure

**Directory structure:**

```
research/[topic]/
├── README.md                    # Research hub
├── research-[question-1].md     # Research document for question 1
├── research-[question-2].md     # Research document for question 2
├── research-summary.md          # Summary of all research
└── requirements.md              # Requirements discovered during research
```

**Create research hub:**

**File:** `docs/maintainers/research/[topic]/README.md`

```markdown
# [Topic Name] - Research Hub

**Purpose:** Research for [topic description]  
**Status:** 🔴 Research  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## 📋 Quick Links

- **[Research Summary](research-summary.md)** - Summary of all research findings
- **[Requirements](requirements.md)** - Requirements discovered during research
- **[Research Documents](research-*.md)** - Individual research documents

### Research Documents

- **[Research: Question 1](research-[question-1].md)** - [Question description]
- **[Research: Question 2](research-[question-2].md)** - [Question description]

---

## 🎯 Research Overview

[Brief description of research goals]

**Research Topics:** [N] topics  
**Status:** 🔴 Research

---

## 📊 Research Status

| Research Topic | Status | Document |
|----------------|--------|----------|
| [Question 1] | 🔴 Not Started | [research-[question-1].md](research-[question-1].md) |
| [Question 2] | 🔴 Not Started | [research-[question-2].md](research-[question-2].md) |

---

## 🚀 Next Steps

1. Complete research documents for each topic
2. Review requirements in `requirements.md`
3. Use `/decision [topic] --from-research` to make decisions

---

**Last Updated:** YYYY-MM-DD
```

**Checklist:**

- [ ] Research directory created
- [ ] Research hub created
- [ ] Research topics listed in hub

---

### 3. Create Research Documents

**For each research topic/question:**

**File:** `docs/maintainers/research/[topic]/research-[question-name].md`

```markdown
# Research: [Question Name]

**Research Topic:** [Topic Name]  
**Question:** [Specific research question]  
**Status:** 🔴 Research  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## 🎯 Research Question

[What specific question is this research addressing?]

---

## 🔍 Research Goals

- [ ] Goal 1: [What do we need to understand?]
- [ ] Goal 2: [What information is needed?]
- [ ] Goal 3: [What comparisons are needed?]

---

## 📚 Research Methodology

[How will this research be conducted?]

**Sources:**
- [ ] Source 1: [Description]
- [ ] Source 2: [Description]
- [ ] Source 3: [Description]

---

## 📊 Findings

### Finding 1: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]

---

### Finding 2: [Title]

[Description of finding]

**Source:** [Source reference]

**Relevance:** [Why this finding matters]

---

## 🔍 Analysis

[Analysis of findings]

**Key Insights:**
- [ ] Insight 1: [Description]
- [ ] Insight 2: [Description]

---

## 💡 Recommendations

- [ ] Recommendation 1: [Description]
- [ ] Recommendation 2: [Description]

---

## 📋 Requirements Discovered

[Any requirements discovered during this research]

- [ ] Requirement 1: [Description]
- [ ] Requirement 2: [Description]

---

## 🚀 Next Steps

1. [Next action]
2. [Next action]

---

**Last Updated:** YYYY-MM-DD
```

**Checklist:**

- [ ] Research document created for each topic
- [ ] Research documents linked in hub
- [ ] Status tracking initialized

---

### 4. Create Research Summary

**File:** `docs/maintainers/research/[topic]/research-summary.md`

```markdown
# Research Summary - [Topic Name]

**Purpose:** Summary of all research findings  
**Status:** 🔴 Research  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## 📋 Research Overview

[Brief summary of research conducted]

**Research Topics:** [N] topics  
**Research Documents:** [N] documents  
**Status:** 🔴 Research

---

## 🔍 Key Findings

### Finding 1: [Title]

[Summary of finding]

**Source:** [research-[question].md](research-[question].md)

---

### Finding 2: [Title]

[Summary of finding]

**Source:** [research-[question].md](research-[question].md)

---

## 💡 Key Insights

- [ ] Insight 1: [Description]
- [ ] Insight 2: [Description]

---

## 📋 Requirements Summary

[Summary of requirements discovered]

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations

- [ ] Recommendation 1: [Description]
- [ ] Recommendation 2: [Description]

---

## 🚀 Next Steps

1. Review requirements in `requirements.md`
2. Use `/decision [topic] --from-research` to make decisions
3. Decisions will create ADR documents

---

**Last Updated:** YYYY-MM-DD
```

**Checklist:**

- [ ] Research summary created
- [ ] Key findings documented
- [ ] Requirements referenced

---

### 5. Create Requirements Document

**File:** `docs/maintainers/research/[topic]/requirements.md`

```markdown
# Requirements - [Topic Name]

**Source:** Research on [topic]  
**Status:** [Draft | Final]  
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD

---

## 📋 Overview

This document captures requirements discovered during research on [topic].

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: [Requirement Name]

**Description:** [Requirement description]

**Source:** [research-[question].md](research-[question].md)

**Priority:** [High | Medium | Low]

**Status:** 🔴 Pending

---

### FR-2: [Requirement Name]

**Description:** [Requirement description]

**Source:** [research-[question].md](research-[question].md)

**Priority:** [High | Medium | Low]

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: [Requirement Name]

**Description:** [Requirement description]

**Source:** [research-[question].md](research-[question].md)

**Priority:** [High | Medium | Low]

**Status:** 🔴 Pending

---

### NFR-2: [Requirement Name]

**Description:** [Requirement description]

**Source:** [research-[question].md](research-[question].md)

**Priority:** [High | Medium | Low]

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: [Constraint Name]

**Description:** [Constraint description]

**Source:** [research-[question].md](research-[question].md)

---

## 💭 Assumptions

### A-1: [Assumption Name]

**Description:** [Assumption description]

**Source:** [research-[question].md](research-[question].md)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Documents](README.md)

---

## 🚀 Next Steps

1. Review and refine requirements
2. Use `/decision [topic] --from-research` to make decisions
3. Decisions may refine requirements

---

**Last Updated:** YYYY-MM-DD
```

**Checklist:**

- [ ] Requirements document created
- [ ] Requirements extracted from research documents
- [ ] Requirements categorized (functional, non-functional, constraints, assumptions)

---

### 6. Update Research Hub

**Update research hub:**

**File location (auto-detected):**
- **Dev-Infra:** `admin/research/README.md`
- **Template Structure:** `docs/maintainers/research/README.md`
- **Project-Wide:** `docs/maintainers/research/README.md`

```markdown
# Research Hub

**Purpose:** Research documents and analysis  
**Status:** ✅ Active  
**Last Updated:** YYYY-MM-DD

---

## 📋 Quick Links

### Active Research

- **[Topic 1]([topic-1]/README.md)** - [Description] (🔴 Research)
- **[Topic 2]([topic-2]/README.md)** - [Description] (🟡 Analysis)

---

## 🎯 Overview

This directory contains research documents supporting exploration and decision-making.

**Workflow:**
1. `/explore [topic]` - Start exploration
2. `/research [topic] --from-explore [topic]` - Conduct research
3. `/decision [topic] --from-research` - Make decisions
4. `/transition-plan --from-adr` - Transition to planning

---

**Last Updated:** YYYY-MM-DD
```

**Checklist:**

- [ ] Research hub created/updated
- [ ] New research added to quick links

---

### 7. Commit and Push Changes

**IMPORTANT:** Always commit work before completing command.

**Reference:** [Commit Workflow](../../docs/COMMIT-WORKFLOW.md) - Central commit workflow documentation, especially [Documentation/Chore Branches](../../docs/COMMIT-WORKFLOW.md#documentationchore-branches) section

**Since research is documentation-only, use docs-only workflow:**

**Branch naming:**

- Format: `docs/research-[topic]` (e.g., `docs/research-template-generation-testing-automation`)

**Steps:**

1. **Check current branch:**

   ```bash
   git branch --show-current
   ```

2. **Create docs branch (if not already on one):**

   ```bash
   git checkout -b docs/research-[topic]
   ```

3. **Stage all changes:**

   ```bash
   git add admin/research/[topic]/  # or docs/maintainers/research/[topic]/
   ```

4. **Commit with proper message:**

   ```bash
   git commit -m "docs(research): add [topic] research

   Created research documents:
   - Research hub with [N] research topics
   - [Research document 1]
   - [Research document 2]
   - Requirements document ([N] FRs, [N] NFRs)

   Related: [Context]"
   ```

5. **Push branch:**

   ```bash
   git push origin docs/research-[topic]
   ```

6. **Merge directly to develop (docs-only, no PR needed):**

   ```bash
   git checkout develop
   git pull origin develop
   git merge docs/research-[topic] --no-edit
   git push origin develop
   ```

7. **Clean up branch:**
   ```bash
   git branch -d docs/research-[topic]
   git push origin --delete docs/research-[topic]
   ```

8. **Verify no uncommitted changes:**
   ```bash
   git status --short
   ```

---

## Integration with Other Commands

### Research → Decision → Planning Flow

1. **`/research [topic] --from-explore [topic]`** - Conduct research
   - Reads research topics from exploration
   - Creates research documents
   - Outputs: Research documents + `requirements.md`

2. **`/research [topic] --from-reflect [reflection-file]`** - Research from reflection
   - Reads opportunities from reflection
   - Creates research documents
   - Outputs: Research documents + `requirements.md`

3. **`/decision [topic] --from-research`** - Make decisions
   - Reads research documents
   - Reads requirements document
   - Creates ADR documents
   - Outputs: ADR documents

4. **`/transition-plan --from-adr`** - Transition to planning
   - Reads ADR documents
   - Automatically reads requirements if they exist
   - Creates feature plan and phase documents
   - Outputs: Transition plan + Feature plan + Phase documents

---

## Common Scenarios

### Scenario 1: Research from Exploration

**Situation:** Exploration identified research topics

**Action:**
```bash
/research auth-system --from-explore new-authentication-system
```

**Output:**
- Research hub created
- Research documents created for each topic
- Requirements document created
- Ready for decision phase

---

### Scenario 2: Research from Reflection

**Situation:** Reflection identified opportunities needing research

**Action:**
```bash
/research ci-optimization --from-reflect reflection-project-2025-12-07.md
```

**Output:**
- Research hub created
- Research documents created for opportunities
- Requirements document created
- Ready for decision phase

---

## Tips

### When to Use

- **After exploration** - Research topics identified in exploration
- **After reflection** - Opportunities identified in reflection
- **Before decisions** - Research informs decisions

### Best Practices

- **Follow workflow** - Use standardized research template
- **Document sources** - Track where information comes from
- **Extract requirements** - Capture requirements as you research
- **Update summary** - Keep research summary current

---

## Reference

**Research Structure:**

- **Dev-Infra:** `admin/research/[topic]/`
- **Template Structure:** `docs/maintainers/research/[topic]/`
- **Project-Wide:** `docs/maintainers/research/[topic]/`
- Requirements: `[research-path]/[topic]/requirements.md`

**Related Commands:**

- `/explore` - Start exploration and identify research topics
- `/decision` - Make decisions based on research
- `/transition-plan` - Transition to feature planning

---

**Last Updated:** 2025-12-07  
**Status:** ✅ Active  
**Next:** Use to conduct structured research following standardized workflow

