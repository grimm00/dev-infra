# Explore Two-Mode - Phase 2: Input Sources

**Phase:** 2 - Input Sources  
**Duration:** ~2 hours  
**Status:** 🟠 In Progress  
**Prerequisites:** Phase 1 complete, ADR-002 approved

---

## 📋 Overview

Implement multiple input sources with raw text as primary, enabling `/explore` to serve as the "thought organizer" entry point for the ideation pipeline.

**Success Definition:** `/explore` accepts raw text, start.txt, and reflection documents as input sources.

---

## 🎯 Goals

1. **Raw Text Input** - Accept inline text or file as primary input
2. **start.txt Integration** - Add `--from-start` flag
3. **Reflection Integration** - Add `--from-reflect` flag
4. **Theme Organization** - Extract themes from unstructured input
5. **Question Extraction** - Identify research questions from input

---

## 📝 Tasks

### Task 1: Update Usage Section with Input Source Flags

**Purpose:** Add input source flags (`--input`, `--from-start`, `--from-reflect`) to the Usage section.

**Steps:**

- [x] Read current Usage section in explore.md
- [x] Add input source flags to Options list
- [x] Add examples for each input source
- [x] Document flag interactions (which flags are mutually exclusive)

**Content to Add:**

```markdown
**Input Source Options:**

- `--input [text|file]` - Raw text inline or from file (primary)
- `--from-start` - Read project's start.txt as input
- `--from-reflect [file]` - Read reflection document for actionable suggestions

**Input Source Examples:**

- `/explore "I've been thinking about improving our auth system..."` - Inline raw text
- `/explore --input thoughts.txt` - Read from file
- `/explore --from-start` - Use project's start.txt
- `/explore --from-reflect reflection-2026-01-10.md` - Extract from reflection

**Note:** Input sources are mutually exclusive. If none specified, prompts for topic interactively.
```

**Checklist:**

- [x] Input source flags documented
- [x] Examples for each source type
- [x] Mutual exclusivity noted

---

### Task 2: Add Input Sources Section

**Purpose:** Create a new section documenting input source handling and priority.

**Steps:**

- [x] Add "Input Sources" section after Usage
- [x] Document source priority order (raw text > start.txt > reflections > interactive)
- [x] Add detailed description for each source type
- [x] Include use case guidance

**Content to Add:**

```markdown
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
```

**Checklist:**

- [x] Source priority table added
- [x] Each source type documented
- [x] Use cases explained
- [x] Auto-detection logic documented

---

### Task 3: Add Theme Extraction Section

**Purpose:** Document how themes are extracted from unstructured input.

**Steps:**

- [x] Add "Theme Extraction" subsection
- [x] Explain extraction logic
- [x] Show before/after example
- [x] Document theme naming conventions

**Content to Add:**

```markdown
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
```

**Checklist:**

- [x] Extraction process documented
- [x] Before/after example included
- [x] Naming conventions specified

---

### Task 4: Add Question Extraction Section

**Purpose:** Document how research questions are extracted to research-topics.md.

**Steps:**

- [x] Add "Question Extraction" subsection
- [x] Explain question identification logic
- [x] Show how questions map to research topics
- [x] Document question formatting

**Content to Add:**

```markdown
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
```

**Checklist:**

- [x] Extraction process documented
- [x] Question markers table added
- [x] Example transformation included

---

### Task 5: Update Mode Detection for Input Sources

**Purpose:** Update the Mode Detection section to handle input source flags.

**Steps:**

- [x] Add input source detection to mode detection logic
- [x] Document error cases for input sources
- [x] Update error table with input-related errors

**Content to Add:**

Update "2. Determine Mode" section:

```markdown
### Input Source Validation

Before mode detection, validate input source:

1. **Check for mutually exclusive flags:**
   - `--input` + `--from-start` → Error
   - `--input` + `--from-reflect` → Error
   - `--from-start` + `--from-reflect` → Error

2. **Validate source exists:**
   - `--input file.txt` → Check file exists
   - `--from-start` → Check start.txt exists
   - `--from-reflect [file]` → Check reflection file exists

3. **Validate source format:**
   - Reflection file must have "Actionable Suggestions" section
   - start.txt must not be empty
```

**Error Table (append to existing):**

| Scenario | Error Message |
|----------|---------------|
| Multiple input sources | "Error: --input, --from-start, and --from-reflect are mutually exclusive" |
| Input file not found | "Error: Input file '[path]' not found" |
| start.txt not found | "Error: start.txt not found in current directory or project root" |
| Reflection file missing | "Error: Reflection file '[path]' not found" |
| Reflection missing section | "Warning: No 'Actionable Suggestions' section found in reflection" |
| Empty start.txt | "Error: start.txt is empty" |

**Checklist:**

- [x] Input validation logic documented
- [x] Error cases added
- [x] Error table updated

---

### Task 6: Update Common Scenarios Section

**Purpose:** Add scenarios demonstrating input source usage.

**Steps:**

- [x] Add "Raw Text Brain Dump" scenario
- [x] Add "New Project from start.txt" scenario
- [x] Add "Reflection to Exploration" scenario

**Content to Add:**

```markdown
### Scenario: Raw Text Brain Dump

**Situation:** You have unstructured thoughts about a feature idea.

**Action:**
```bash
/explore "I want to add a notification system. Users should get
alerts for important events. Maybe email? Push notifications?
What about in-app badges? Need to think about user preferences too."
```

**Output:**
- Exploration scaffolding with 3-4 themes (notification channels, user preferences, etc.)
- research-topics.md with prioritized questions
- Status: `🔴 Scaffolding (needs expansion)`

---

### Scenario: New Project from start.txt

**Situation:** Starting a new project with initialization notes in start.txt.

**Action:**
```bash
/explore --from-start
```

**Output:**
- Exploration based on project goals from start.txt
- Themes organized around project objectives
- Questions extracted from open items in start.txt

---

### Scenario: Reflection to Exploration

**Situation:** You ran `/reflect` and want to explore the actionable suggestions.

**Action:**
```bash
/explore --from-reflect admin/planning/notes/reflection-2026-01-10.md
```

**Output:**
- Exploration themes from reflection's "Actionable Suggestions"
- research-topics.md populated from suggestions
- Bridges reflection → exploration → research pipeline
```

**Checklist:**

- [x] Brain dump scenario added
- [x] start.txt scenario added
- [x] Reflection pipeline scenario added

---

### Task 7: Update Integration Section

**Purpose:** Show input sources in the pipeline context.

**Steps:**

- [x] Update pipeline diagram to show input sources
- [x] Add input source timing to timing table
- [x] Document pipeline connections

**Content to Add:**

Update Command Pipeline Position:

```markdown
### Input Sources in Pipeline

```
Raw thoughts → /explore --input "..."   ← Primary entry point
start.txt   → /explore --from-start     ← Project initialization
/reflect    → /explore --from-reflect   ← Reflection pipeline
    ↓
/explore [topic]              ← Setup: scaffolding (~60-80 lines)
    ↓ human review
/explore [topic] --conduct    ← Conduct: full exploration (~200-300 lines)
    ↓
/research --from-explore      ← Research: investigate topics
```

**Input Source → Output Quality:**

| Input Source | Output Quality | Notes |
|--------------|----------------|-------|
| Raw text (rich) | High | Themes and questions from user context |
| start.txt | Medium-High | Project-focused exploration |
| Reflection | Medium-High | Suggestion-focused exploration |
| Topic only | Medium | AI-generated without user context |
```

**Checklist:**

- [x] Pipeline diagram updated with input sources
- [x] Output quality guidance added

---

## ✅ Completion Criteria

- [ ] `/explore "raw thoughts..."` processes inline text
- [ ] `/explore --input file.txt` reads from file
- [ ] `/explore --from-start` reads project's start.txt
- [ ] `/explore --from-reflect [file]` reads reflection suggestions
- [ ] Themes organized in scaffolding output
- [ ] Questions extracted to research-topics.md

---

## 📦 Deliverables

- Input source handling in explore.md
- Theme extraction logic documentation
- Question extraction logic documentation
- Updated command documentation with all input sources

---

## 🔗 Dependencies

### Prerequisites

- Phase 1: Command Structure (complete)
- ADR-002: Input Sources (approved)

### Blocks

- Phase 4: Template Updates (needs input source logic)

---

## 📊 Progress Tracking

| Task                            | Status      | Notes                                   |
| ------------------------------- | ----------- | --------------------------------------- |
| Task 1: Usage Section Updates   | ✅ Complete | Added input source flags and examples   |
| Task 2: Input Sources Section   | ✅ Complete | Added priority table and all source types |
| Task 3: Theme Extraction        | ✅ Complete | Added extraction process and examples   |
| Task 4: Question Extraction     | ✅ Complete | Added markers table and examples        |
| Task 5: Mode Detection Updates  | ✅ Complete | Added validation logic and error table  |
| Task 6: Common Scenarios        | ✅ Complete | Added 3 input source scenarios          |
| Task 7: Integration Updates     | 🔴 Pending  |                                         |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [ADR-002](../../../decisions/explore-two-mode/adr-002-input-sources.md)

---

**Last Updated:** 2026-01-13  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1
