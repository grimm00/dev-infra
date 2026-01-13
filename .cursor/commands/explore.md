# Explore Command

Initiate exploration cycles for proof of concepts or abstract ideas. Creates exploration documents and identifies research topics/questions that need investigation.

---

## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Dev-Infra Structure (default):**
   - Explorations: `admin/explorations/[topic]/`

2. **Template Structure (for generated projects):**
   - Explorations: `docs/maintainers/planning/explorations/[topic]/`

3. **Project-Wide Structure:**
   - Explorations: `docs/maintainers/planning/explorations/[topic]/`

**Topic Detection:**
- Use `--topic` option if provided
- Otherwise, prompt user for topic name
- Sanitize topic name (kebab-case, no spaces)

---

## Workflow Overview

**When to use:**

- When you have a new idea or proof of concept
- To organize abstract thoughts before research
- When you need to identify what questions need answering
- Before starting research on a topic

**Key principle:** Start with exploration to identify research topics, then move to research phase. Use Setup Mode for quick ideation, then Conduct Mode for detailed exploration after human review.

**Two Modes:**

### Setup Mode (Default)

Creates lightweight scaffolding (~60-80 lines) for human review before investing in detailed exploration.

```
/explore [topic]
  → Creates exploration scaffolding (~60-80 lines)
  → Organizes thoughts into themes
  → Extracts key questions
  → Creates research-topics.md
  → Outputs: Scaffolding ready for human review
```

**When to use Setup Mode:**

- Starting a new exploration
- Quick ideation without committing to full exploration
- When you want to validate direction before deep dive

### Conduct Mode (`--conduct`)

Expands existing scaffolding with detailed analysis (~200-300 lines).

```
/explore [topic] --conduct
  → Reads existing scaffolding
  → Expands themes with detailed analysis
  → Adds connections, implications, concerns
  → Refines research topics with context
  → Outputs: Full exploration (~200-300 lines)
```

**When to use Conduct Mode:**

- After reviewing scaffolding and validating direction
- When ready to invest in detailed exploration
- Before moving to formal research phase

**Workflow with Human Review:**

```
/explore [topic]           ← Setup: scaffolding (~60-80 lines)
    ↓ human review         ← Key checkpoint
/explore [topic] --conduct ← Conduct: full exploration (~200-300 lines)
    ↓
/research --from-explore   ← Research: investigate topics
```

---

## Usage

**Command:** `/explore [topic] [options]`

**Setup Mode Examples (default):**

- `/explore new-authentication-system` - Create exploration scaffolding
- `/explore "improve ci pipeline"` - Topic sanitized to `improve-ci-pipeline`
- `/explore --topic database-choice` - Specify topic explicitly
- `/explore --dry-run` - Show what would be created without creating files

**Conduct Mode Examples:**

- `/explore new-authentication-system --conduct` - Expand existing scaffolding
- `/explore improve-ci-pipeline --conduct` - Fill in detailed exploration

**Options:**

- `--topic [name]` - Specify topic name (overrides prompt)
- `--conduct` - Expand scaffolding with detailed exploration (requires existing scaffolding)
- `--dry-run` - Show what would be created without creating files
- `--force` - Overwrite existing scaffolding (setup) or re-expand (conduct)

**Input Source Options:**

- `--input [text|file]` - Raw text inline or from file (primary input source)
- `--from-start` - Read project's start.txt as input
- `--from-reflect [file]` - Read reflection document for actionable suggestions

**Input Source Examples:**

- `/explore "I've been thinking about improving our auth system..."` - Inline raw text
- `/explore --input thoughts.txt` - Read from file
- `/explore --from-start` - Use project's start.txt
- `/explore --from-reflect reflection-2026-01-10.md` - Extract from reflection

**Note:** Input sources are mutually exclusive. If multiple specified, command errors. If none specified, prompts for topic interactively.

---

## Input Sources

`/explore` is the pipeline entry point - the only command that handles **unstructured input**. This makes it the "thought organizer" that transforms raw ideas into structured exploration.

### Source Priority

| Priority | Source | Flag | Use Case |
|----------|--------|------|----------|
| 1 (Primary) | Raw text | `--input [text\|file]` | Brain dumps, ideas, thoughts |
| 2 | start.txt | `--from-start` | Project initialization context |
| 3 | Reflections | `--from-reflect [file]` | Actionable suggestions from reflection |
| 4 | Interactive | (no flag) | Prompt for topic when no input provided |

### Raw Text Input (Primary)

**When to use:** You have unstructured thoughts, ideas, or a brain dump you want organized.

**Inline text:**

```
/explore "I've been thinking about how we handle authentication.
The current system is too rigid. Maybe we need roles? Or tokens?
What about SSO? Users keep asking about Google login..."
```

**From file:**

```
/explore --input ~/thoughts/auth-ideas.txt
```

**What happens:**

1. Input parsed for themes and patterns
2. Related thoughts grouped together
3. Questions extracted for research topics
4. Scaffolding created with organized structure

### start.txt Input

**When to use:** Starting a new project or exploring project initialization notes.

**Command:**

```
/explore --from-start
```

**Auto-detection:**

- Searches for `start.txt` in current directory
- Falls back to project root
- Error if not found

**What happens:**

1. start.txt content parsed
2. Project goals extracted as themes
3. Open questions identified
4. Exploration scaffolding reflects project context

### Reflection Input

**When to use:** You have actionable suggestions from a `/reflect` output.

**Command:**

```
/explore --from-reflect admin/planning/notes/reflection-2026-01-10.md
```

**What happens:**

1. Reads "Actionable Suggestions" section from reflection
2. Converts suggestions into exploration themes
3. Preserves suggestion context in output
4. Creates bridge between `/reflect` → `/explore` pipeline

### Interactive Mode (Default)

**When to use:** Quick exploration when you just have a topic name.

**What happens when no input source specified:**

1. Prompts: "What topic would you like to explore?"
2. Uses topic name only (no additional context)
3. Generates exploration based on topic

**Note:** Interactive mode produces less context-rich scaffolding than raw text input.

### Theme Extraction

When processing unstructured input, `/explore` organizes content into themes:

**Extraction Process:**

1. **Parse input** for distinct ideas, concerns, or topics
2. **Group related thoughts** into thematic clusters
3. **Name themes** with descriptive, concise titles
4. **Preserve context** - original thoughts appear under themes

**Example Transformation:**

**Input (raw text):**

```
I've been thinking about improving our auth system. The current JWT approach
is okay but tokens expire too quickly. Users complain about re-logging in.
Maybe we need refresh tokens? Also thinking about adding Google SSO -
users keep asking. Security audit mentioned we need MFA too.
```

**Output (themes in scaffolding):**

```markdown
## 🔍 Themes

### Theme 1: Token Expiration & User Experience
- JWT tokens expire too quickly
- Users complain about re-logging in
- Consider refresh token pattern

### Theme 2: Third-Party Authentication
- Google SSO requested by users
- Reduces password fatigue
- OAuth2 integration needed

### Theme 3: Security Enhancement
- Security audit requires MFA
- Compliance consideration
- User friction vs security tradeoff
```

**Theme Naming Conventions:**

- Use descriptive nouns/noun phrases
- Avoid generic names like "Issue 1" or "Topic A"
- Capture the essence of grouped thoughts
- Keep names concise (2-5 words)

### Question Extraction

`/explore` identifies questions from input and generates `research-topics.md`:

**Extraction Process:**

1. **Identify explicit questions** - Text ending in "?"
2. **Identify implicit questions** - Statements implying uncertainty ("maybe", "not sure", "consider")
3. **Convert to research questions** - Rephrase as investigable questions
4. **Prioritize** - Order by apparent importance in input

**Question Markers:**

| Marker | Example | Conversion |
|--------|---------|------------|
| Explicit "?" | "Should we use JWTs?" | Direct research question |
| "Maybe" | "Maybe we need refresh tokens" | "Should we implement refresh tokens?" |
| "Not sure" | "Not sure about OAuth scope" | "What OAuth scopes are appropriate?" |
| "Consider" | "Consider MFA options" | "What MFA options exist?" |
| "What about" | "What about SSO?" | "Should we implement SSO?" |

**Example:**

**Input:**

```
Maybe we need refresh tokens? What about Google SSO? 
Not sure how MFA would affect user experience.
```

**Output (research-topics.md):**

```markdown
### Topic 1: Refresh Token Implementation

**Question:** Should we implement refresh tokens for better user experience?
**Priority:** High

### Topic 2: SSO Integration

**Question:** Should we implement Google SSO?
**Priority:** Medium

### Topic 3: MFA User Impact

**Question:** How would MFA affect user experience?
**Priority:** Medium
```

---

## Setup Mode Output

**Output Size:** ~60-80 lines total

Setup Mode creates lightweight scaffolding documents for human review before investing in detailed exploration.

**Creates:**

```
explorations/[topic]/
├── README.md           (~20 lines) - Hub with quick links
├── exploration.md      (~40-50 lines) - Scaffolding with placeholders
└── research-topics.md  (~20-30 lines) - Prioritized questions
```

### exploration.md Scaffolding Template

**File:** `explorations/[topic]/exploration.md`

```markdown
# Exploration: [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 🎯 What We're Exploring

[2-3 sentence summary extracted from input]

---

## 🔍 Initial Themes

### Theme 1: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

### Theme 2: [Name]
<!-- PLACEHOLDER: Expand with detailed analysis in conduct mode -->

---

## ❓ Key Questions

1. [Question extracted from input]
2. [Question extracted from input]

---

## 🚀 Next Steps

Run `/explore [topic] --conduct` to expand this exploration.
```

### research-topics.md Scaffolding Template

**File:** `explorations/[topic]/research-topics.md`

```markdown
# Research Topics - [Topic]

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 📋 Topics Identified

### Topic 1: [Name]

**Question:** [Core question to investigate]
**Priority:** [High | Medium | Low]

### Topic 2: [Name]

**Question:** [Core question to investigate]
**Priority:** [High | Medium | Low]

---

## 🚀 Next Steps

Run `/explore [topic] --conduct` to expand these topics with context and rationale.
```

### README.md Hub Template

**File:** `explorations/[topic]/README.md`

```markdown
# [Topic] - Exploration Hub

**Status:** 🔴 Scaffolding (needs expansion)
**Created:** YYYY-MM-DD

---

## 📋 Quick Links

- **[Exploration](exploration.md)** - Main exploration document
- **[Research Topics](research-topics.md)** - Topics to investigate

---

## 🎯 Overview

[1-2 sentence summary]

---

**Next:** Run `/explore [topic] --conduct` to expand this exploration.
```

---

## Conduct Mode Output

**Output Size:** ~200-300 lines total

Conduct Mode expands existing scaffolding with detailed analysis, connections, and context.

**Expands existing scaffolding with:**

- Themes with detailed analysis, connections, implications
- Questions with context, sub-questions, research approach
- Initial thoughts with evidence, concerns, opportunities
- research-topics.md with full descriptions and priority rationale

**Status Transition:**

```
🔴 Scaffolding (needs expansion) → ✅ Expanded
```

### exploration.md After Conduct

**File:** `explorations/[topic]/exploration.md`

```markdown
# Exploration: [Topic]

**Status:** ✅ Expanded
**Created:** YYYY-MM-DD
**Expanded:** YYYY-MM-DD

---

## 🎯 What We're Exploring

[Expanded description with context, background, and motivation - 2-3 paragraphs]

---

## 🔍 Themes

### Theme 1: [Name]

[Detailed analysis of theme - 3-5 paragraphs]

**Connections:**
- [Connection to other themes or concepts]
- [Connection to existing patterns or decisions]

**Implications:**
- [What this means for the exploration]
- [Impact on related areas]

**Concerns:**
- [Potential issues or risks]
- [Open questions]

### Theme 2: [Name]

[Similar detailed structure...]

---

## ❓ Key Questions

### Question 1: [Question]

**Context:** [Why this question matters - 2-3 sentences]

**Sub-questions:**
- [Related question 1]
- [Related question 2]
- [Related question 3]

**Research Approach:** [How to investigate - suggested methods]

### Question 2: [Question]

[Similar structure...]

---

## 💡 Initial Thoughts

[Detailed initial thinking with evidence - 2-3 paragraphs]

**Opportunities:**
- [Opportunity 1 with brief explanation]
- [Opportunity 2 with brief explanation]

**Concerns:**
- [Concern 1 with brief explanation]
- [Concern 2 with brief explanation]

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research [topic] --from-explore [topic]` to conduct research
3. After research, use `/decision [topic] --from-research` to make decisions

---

**Last Updated:** YYYY-MM-DD
```

### research-topics.md After Conduct

**File:** `explorations/[topic]/research-topics.md`

```markdown
# Research Topics - [Topic]

**Status:** ✅ Expanded
**Created:** YYYY-MM-DD
**Expanded:** YYYY-MM-DD

---

## 📋 Research Topics

### Topic 1: [Name]

**Question:** [Core question to investigate]

**Context:** [Why this research is needed - 2-3 sentences]

**Priority:** [High | Medium | Low]

**Rationale:** [Why this priority - 1-2 sentences]

**Suggested Approach:**
- [Research method 1]
- [Research method 2]

### Topic 2: [Name]

[Similar detailed structure...]

---

## 🎯 Research Workflow

1. Use `/research [topic] --from-explore [topic]` to start research
2. Research will create documents in research directory
3. After research complete, use `/decision [topic] --from-research`

---

**Last Updated:** YYYY-MM-DD
```

---

## Step-by-Step Process

### 1. Identify Topic

**Default behavior:**

- If topic provided, use it
- Otherwise, prompt user: "What topic would you like to explore?"
- Sanitize topic name:
  - Convert to kebab-case
  - Remove special characters
  - Replace spaces with hyphens

**Checklist:**

- [ ] Topic identified
- [ ] Topic name sanitized
- [ ] Topic doesn't already exist (check existing explorations)

---

### 2. Determine Mode

**Mode Detection Logic:**

The command detects which mode to use based on flags and existing content.

**Setup Mode (default):**

1. Check if topic directory exists
2. If exists, check exploration.md status
3. If status is `🔴 Scaffolding`, suggest using `--conduct`
4. If status is `✅ Expanded`, warn about overwriting
5. If doesn't exist, proceed with setup

**Conduct Mode (`--conduct`):**

1. Check if topic directory exists
2. If doesn't exist, error: "No scaffolding found. Run setup first."
3. Check exploration.md status
4. If status is `✅ Expanded`, warn and require `--force` to re-expand
5. If status is `🔴 Scaffolding`, proceed with conduct

**Error Messages:**

| Situation | Message |
|-----------|---------|
| `--conduct` with no scaffolding | "No exploration scaffolding found for [topic]. Run `/explore [topic]` first." |
| `--conduct` on already expanded | "Exploration already expanded. Use `--force` to re-expand." |
| Setup on existing scaffolding | "Scaffolding exists. Use `--conduct` to expand, or `--force` to overwrite." |

**Force Flag Behavior:**

- `--force` with Setup Mode: Overwrites existing scaffolding (creates fresh)
- `--force` with Conduct Mode: Re-expands even if already expanded

**Checklist:**

- [ ] Check if `--conduct` flag provided
- [ ] Check if topic directory exists
- [ ] Check exploration.md status (if exists)
- [ ] Handle error cases appropriately
- [ ] Apply `--force` logic if needed

---

### 3. Setup Mode: Create Scaffolding

**Use when:** Mode detection indicates Setup Mode (no `--conduct` flag, no existing exploration or `--force` used).

**Location Detection:**

- **Dev-Infra:** `admin/explorations/[topic]/`
- **Template Structure:** `docs/maintainers/planning/explorations/[topic]/`
- **Project-Wide:** `docs/maintainers/planning/explorations/[topic]/`

**Auto-detection:**
- Check if `admin/explorations/` exists → use dev-infra structure
- Check if `docs/maintainers/planning/explorations/` exists → use template structure
- Otherwise → use project-wide structure

**Creates:** See [Setup Mode Output](#setup-mode-output) for templates (~60-80 lines total)

**Process:**

1. Create exploration directory: `explorations/[topic]/`
2. Create `README.md` hub (~20 lines) with quick links
3. Create `exploration.md` scaffolding (~40-50 lines) with placeholders
4. Create `research-topics.md` scaffolding (~20-30 lines) with prioritized questions
5. Update explorations hub with new exploration link

**Setup Mode Checklist:**

- [ ] Exploration directory created
- [ ] Exploration hub created (~20 lines)
- [ ] Exploration scaffolding created (~40-50 lines)
- [ ] Research topics scaffolding created (~20-30 lines)
- [ ] Status set to `🔴 Scaffolding (needs expansion)`
- [ ] Explorations hub updated

**Commit (docs can push directly):**

```bash
git add explorations/[topic]/
git commit -m "docs(explore): create [topic] exploration scaffolding"
git push origin develop
```

---

### 4. Conduct Mode: Expand Scaffolding

**Use when:** Mode detection indicates Conduct Mode (`--conduct` flag provided, scaffolding exists).

**Reads:** Existing scaffolding from `explorations/[topic]/`

**Creates:** See [Conduct Mode Output](#conduct-mode-output) for expanded templates (~200-300 lines total)

**Process:**

1. Read existing `exploration.md` scaffolding
2. Expand themes with detailed analysis, connections, implications, concerns
3. Expand questions with context, sub-questions, research approach
4. Add initial thoughts with evidence, opportunities, concerns
5. Update `research-topics.md` with context and rationale for each topic
6. Update status from `🔴 Scaffolding` to `✅ Expanded`

**Conduct Mode Checklist:**

- [ ] Existing scaffolding read and understood
- [ ] Themes expanded with detailed analysis
- [ ] Questions expanded with context and sub-questions
- [ ] Initial thoughts documented with evidence
- [ ] research-topics.md expanded with context
- [ ] Status updated to `✅ Expanded`

**Commit (docs can push directly):**

```bash
git add explorations/[topic]/
git commit -m "docs(explore): expand [topic] exploration with detailed analysis"
git push origin develop
```

---

### 5. Update Explorations Hub

**Update explorations hub:**

**File location (auto-detected):**
- **Dev-Infra:** `admin/explorations/README.md`
- **Template Structure:** `docs/maintainers/planning/explorations/README.md`
- **Project-Wide:** `docs/maintainers/planning/explorations/README.md`

```markdown
# Explorations Hub

**Purpose:** Active explorations and proof of concepts  
**Status:** ✅ Active  
**Last Updated:** YYYY-MM-DD

---

## 📋 Quick Links

### Active Explorations

- **[Topic 1]([topic-1]/README.md)** - [Description] (🔴 Exploration)
- **[Topic 2]([topic-2]/README.md)** - [Description] (🟡 Research)

---

## 🎯 Overview

This directory contains active explorations, proof of concepts, and abstract ideas being explored before research and decision phases.

**Workflow:**
1. `/explore [topic]` - Start exploration
2. `/research [topic] --from-explore [topic]` - Conduct research
3. `/decision [topic] --from-research` - Make decisions
4. `/transition-plan --from-adr` - Transition to planning

---

**Last Updated:** YYYY-MM-DD
```

**Checklist:**

- [ ] Explorations hub created/updated
- [ ] New exploration added to quick links

---

## Integration with Other Commands

### Command Pipeline Position

```
/explore [topic]              ← Setup: scaffolding (~60-80 lines)
    ↓ human review            ← KEY CHECKPOINT: validate direction
/explore [topic] --conduct    ← Conduct: full exploration (~200-300 lines)
    ↓
/research --from-explore      ← Research: investigate topics
    ↓
/decision --from-research     ← Decisions: create ADRs
    ↓
/transition-plan --from-adr   ← Planning: create phases
    ↓
/task-phase 1 1               ← Implementation: execute phases
```

**Note:** Human review between Setup and Conduct is the key checkpoint. This allows:
- Quick validation of exploration direction before full investment
- Course correction with minimal time spent
- Rejection of dead-end explorations without wasted effort

### Timing Guidance

| Stage | Time Investment | Output |
|-------|-----------------|--------|
| Setup Mode | ~5-10 min | Scaffolding for review (~60-80 lines) |
| Human Review | ~2-5 min | Go/no-go decision on direction |
| Conduct Mode | ~20-30 min | Full exploration (~200-300 lines) |
| Research | ~1-2 hours | Research documents + requirements |
| Decision | ~30 min | ADR documents |
| Planning | ~30 min | Feature plan + phases |

### Exploration → Research → Decision → Planning Flow

1. **`/explore [topic]`** - Start exploration (Setup Mode)
   - Creates scaffolding with placeholders
   - Organizes thoughts into themes
   - Outputs: `research-topics.md` scaffolding
   - Status: `🔴 Scaffolding (needs expansion)`

2. **`/explore [topic] --conduct`** - Expand exploration (Conduct Mode)
   - Expands scaffolding with detailed analysis
   - Adds connections, implications, concerns
   - Outputs: Full exploration (~200-300 lines)
   - Status: `✅ Expanded`

3. **`/research [topic] --from-explore [topic]`** - Conduct research
   - Reads research topics from exploration
   - Creates research documents
   - Outputs: Research documents + `requirements.md`

4. **`/decision [topic] --from-research`** - Make decisions
   - Reads research documents
   - Creates ADR documents
   - Outputs: ADR documents

5. **`/transition-plan --from-adr`** - Transition to planning
   - Reads ADR documents
   - Creates feature plan and phase documents
   - Outputs: Transition plan + Feature plan + Phase documents

---

## Common Scenarios

### Scenario 1: New Feature Idea

**Situation:** You have an idea for a new feature

**Action:**
```bash
/explore new-feature-idea
```

**Output:**
- Exploration document created
- Research topics identified
- Ready for research phase

---

### Scenario 2: Proof of Concept

**Situation:** Want to explore a proof of concept

**Action:**
```bash
/explore poc-distributed-caching
```

**Output:**
- Exploration document created
- Research topics identified
- Ready for research phase

---

## Tips

### When to Use

- **New ideas** - Start exploration before jumping to research
- **Proof of concepts** - Organize thoughts before research
- **Abstract concepts** - Structure thinking before investigation

### Best Practices

- **Be specific** - Clear topic names help organization
- **Identify questions** - Focus on what needs to be researched
- **Prioritize topics** - Mark high/medium/low priority research topics

---

## Reference

**Exploration Structure:**

- **Dev-Infra:** `admin/explorations/[topic]/`
- **Template Structure:** `docs/maintainers/planning/explorations/[topic]/`
- **Project-Wide:** `docs/maintainers/planning/explorations/[topic]/`
- Research Topics: `[explorations-path]/[topic]/research-topics.md`

**Related Commands:**

- `/research` - Conduct research on topics identified in exploration
- `/decision` - Make decisions based on research
- `/transition-plan` - Transition to feature planning

---

**Last Updated:** 2025-12-07  
**Status:** ✅ Active  
**Next:** Use to initiate exploration cycles for new ideas or proof of concepts

