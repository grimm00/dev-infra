# Research: Explore Input Sources

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** What explicit input sources should `/explore` accept?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Last Updated:** 2026-01-09

---

## 🎯 Research Question

What explicit input sources should `/explore` accept?

**Context:** Unlike `/research --from-explore`, the `/explore` command has no `--from-*` options. Adding input sources would improve workflow by bootstrapping explorations from existing context.

---

## 🔍 Research Goals

- [x] Goal 1: Analyze `start.txt` content and structure for exploration seeding
- [x] Goal 2: Identify other documents that could seed explorations (reflections, feature plans, ADRs)
- [x] Goal 3: Define how command extracts exploration context from each source type
- [x] Goal 4: Determine flag naming (`--from-start`, `--from-project-init`, etc.)
- [x] Goal 5: **NEW** Define how command handles raw/unstructured text input

---

## 💡 Pre-Research Insight: Raw Thoughts Input

**Added:** 2025-12-31 (during research pivot)

**Insight:** Unlike other commands that expect structured input, `/explore` could uniquely accept **raw, unstructured thoughts** as input. This positions `/explore` as the entry point for the ideation pipeline.

**Input Structure Comparison:**

| Command | Expected Input | Structure Level |
|---------|----------------|-----------------|
| `/research` | Research topics from exploration | 🟢 Organized |
| `/decision` | Research findings | 🟢 Organized |
| `/transition-plan` | ADRs (structured decisions) | 🟢 Organized |
| `/reflect` | Project state (automated) | 🟢 Organized |
| **`/explore`** | Raw thoughts, ideas, brain dumps | 🔴 **Unstructured** |

**Two-Mode Value for Unstructured Input:**

- **Setup Mode** becomes a "thought organizer" - takes chaos, outputs structure
- **Conduct Mode** then expands the organized scaffold

**Example transformation:**
```
Input: "I've been thinking about how our CLI could maybe talk to the 
API but also maybe it should be more standalone and there's this 
pattern I saw in terraform where you have state files and..."

Output: Organized exploration scaffold with:
- Key themes identified
- Questions extracted  
- Research topics suggested
- Structure imposed on chaos
```

**Input Source Types to Research:**

| Input Source | Structure | Two-Mode Value |
|--------------|-----------|----------------|
| `start.txt` | Semi-structured | Extract and organize |
| Reflection artifacts | Structured | Reference and expand |
| **Raw thoughts/text** | Unstructured | **Organize then expand** |

**Impact:** This insight suggests `/explore` should support both `--from-*` flags for structured input AND direct text/stdin for unstructured input

---

## 📚 Research Methodology

**Sources:**
- [x] `start.txt` template analysis (dev-infra and templates)
- [x] Reflection document structure analysis
- [x] Feature plan structure analysis
- [x] ADR document structure analysis
- [x] User insight: Worktree files as untracked project context

**Sub-questions to investigate:**
- What content does `start.txt` provide that's useful for exploration?
- What other documents could seed explorations (reflections, feature plans, ADRs)?
- How should the command extract exploration context from each source type?
- Should there be a `--from-start` or `--from-project-init` flag?

---

## 📊 Findings

### Finding 1: start.txt Contains Rich Project Context

The `start.txt` template provides structured project initialization context:

| Section | Content | Exploration Value |
|---------|---------|-------------------|
| Problem Statement | What problem project solves | Core exploration focus |
| Project Type | Regular vs Learning | Scope boundaries |
| Scope | Core features, MVP, out-of-scope | Exploration boundaries |
| Structure Preferences | Backend, frontend, database choices | Technical constraints |
| Version Control | Branching, CI/CD | Workflow context |
| Additional Notes | Special requirements, timeline | Constraints |

**Source:** Template analysis - `templates/standard-project/start.txt`, `templates/learning-project/start.txt`

**Relevance:** start.txt is the most natural input source for `/explore` - it's the project's initial "brain dump"

---

### Finding 2: Reflection Documents Provide Exploration Seeds

Reflections have an "Actionable Suggestions" section that can seed explorations:

```markdown
## 💡 Actionable Suggestions

### High Priority
#### [Suggestion Title]
**Category:** [Category]
**Suggestion:** [Detailed suggestion]
**Benefits:** [Benefits list]
**Next Steps:** [Actions]
```

**Source:** `/reflect` command documentation

**Relevance:** Suggestions from reflections are natural exploration candidates - already identified as opportunities

---

### Finding 3: Worktree Files Could Provide Project Context

**NEW INSIGHT (2026-01-09):** Worktree information stored as an untracked file at project root (e.g., `worktree.txt`) could provide context about:

- Feature branch focus
- Development context
- Related issues/PRs
- Current work in progress

**Source:** User insight during research session

**Relevance:** A worktree file could be another input source for `/explore`, providing development context

---

### Finding 4: Different Input Sources Require Different Processing

| Input Source | Structure Level | Processing Needed |
|--------------|-----------------|-------------------|
| **start.txt** | Semi-structured (checkboxes, sections) | Extract checked items, parse sections |
| **Reflection** | Structured (markdown sections) | Extract suggestions section |
| **Worktree file** | Semi-structured | Parse key-value pairs |
| **Raw text/stdin** | Unstructured | Organize into themes, extract questions |
| **Feature plans** | Structured | Extract open questions, follow-ups |
| **ADR documents** | Structured | Extract consequences, follow-up decisions |

**Source:** Document structure analysis

**Relevance:** Command needs different extraction logic per source type

---

### Finding 5: Two-Mode Particularly Valuable for Unstructured Input

Per pre-research insight:

- **Setup Mode** as "thought organizer": Takes unstructured input → outputs organized scaffold
- **Conduct Mode** as "thought expander": Takes scaffold → produces detailed exploration

This differentiates `/explore` from other commands - it uniquely handles raw, unstructured thoughts.

**Source:** Pre-research insight (2025-12-31)

**Relevance:** Two-mode pattern is especially valuable for `/explore` due to unstructured input support

---

## 🔍 Analysis

The analysis reveals a hierarchy of input sources by structure level and use case:

**Primary Input Sources (Implement First):**
1. **Raw text** - Unstructured thoughts, ideas, brain dumps
2. **start.txt** - Project initialization context

**Secondary Input Sources (Future Enhancement):**
3. **Reflection documents** - Actionable suggestions
4. **Worktree file** - Development context (new pattern)

**Tertiary Input Sources (Nice-to-have):**
5. **Feature plans** - Follow-up explorations
6. **ADR documents** - Decision consequence exploration

**Key Insights:**
- [x] Insight 1: `/explore` uniquely handles unstructured input - other commands expect structure
- [x] Insight 2: start.txt is the most natural structured input - it's the project's initial brain dump
- [x] Insight 3: Two-mode is especially valuable for `/explore` - Setup Mode organizes chaos
- [x] Insight 4: Worktree files (untracked at project root) could provide development context
- [x] Insight 5: Different sources need different extraction logic

---

## 💡 Recommendations

- [x] Recommendation 1: Support raw text input (stdin or inline) as primary mode - unique to `/explore`
- [x] Recommendation 2: Add `--from-start` flag for start.txt input
- [x] Recommendation 3: Add `--from-reflect` flag for reflection suggestions
- [x] Recommendation 4: Consider `--from-worktree` for worktree context (new pattern)
- [x] Recommendation 5: Setup Mode should focus on organizing input into themes and questions
- [x] Recommendation 6: Document that `/explore` is the ideation entry point - handles unstructured → structured

---

## 📋 Requirements Discovered

**Functional Requirements:**

- [x] FR-IS-1: `/explore` MUST accept unstructured text input (stdin, inline, or file)
- [x] FR-IS-2: `/explore` SHOULD support `--from-start` flag to read start.txt
- [x] FR-IS-3: `/explore` MAY support `--from-reflect` flag to read reflection suggestions
- [x] FR-IS-4: Setup Mode MUST organize unstructured input into themed sections
- [x] FR-IS-5: Setup Mode MUST extract questions from unstructured input

**Non-Functional Requirements:**

- [x] NFR-IS-1: Input processing SHOULD be source-agnostic (common output format)
- [x] NFR-IS-2: Error messages SHOULD guide users to correct input format

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with Topic 4 (Scaffolding Boundaries)
3. After all research, use `/decision explore-two-mode --from-research`

---

**Last Updated:** 2026-01-09

