# Research: Explore Input Sources

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** What explicit input sources should `/explore` accept?  
**Status:** 🔴 Research  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30

---

## 🎯 Research Question

What explicit input sources should `/explore` accept?

**Context:** Unlike `/research --from-explore`, the `/explore` command has no `--from-*` options. Adding input sources would improve workflow by bootstrapping explorations from existing context.

---

## 🔍 Research Goals

- [ ] Goal 1: Analyze `start.txt` content and structure for exploration seeding
- [ ] Goal 2: Identify other documents that could seed explorations (reflections, feature plans, ADRs)
- [ ] Goal 3: Define how command extracts exploration context from each source type
- [ ] Goal 4: Determine flag naming (`--from-start`, `--from-project-init`, etc.)
- [ ] Goal 5: **NEW** Define how command handles raw/unstructured text input

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
- [ ] `start.txt` template analysis (dev-infra and templates)
- [ ] Reflection document structure analysis
- [ ] Feature plan structure analysis
- [ ] ADR document structure analysis
- [ ] Web search: Best practices for context-driven exploration workflows

**Sub-questions to investigate:**
- What content does `start.txt` provide that's useful for exploration?
- What other documents could seed explorations (reflections, feature plans, ADRs)?
- How should the command extract exploration context from each source type?
- Should there be a `--from-start` or `--from-project-init` flag?

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

1. Conduct research with `/research explore-two-mode --conduct --topic-num 3`
2. Document findings
3. Update requirements

---

**Last Updated:** 2025-12-30

