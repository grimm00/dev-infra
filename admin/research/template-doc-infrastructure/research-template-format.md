# Research: Template Format

**Research Topic:** Template Doc Infrastructure  
**Question:** What format should templates use (markdown with placeholders, bash heredocs, template engine)?  
**Status:** ✅ Complete  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-14

---

## 🎯 Research Question

What format should templates use for variable expansion? Options include simple markdown with placeholders (`{{DATE}}`), bash heredocs in scripts, or a template engine (envsubst, jinja2).

---

## 🔍 Research Goals

- [x] Goal 1: Survey template approaches in existing dev-infra scripts
- [x] Goal 2: Evaluate simplicity vs power tradeoffs
- [x] Goal 3: Consider consistency with existing patterns
- [x] Goal 4: Document format choice for template authors

---

## 📚 Research Methodology

**Sources:**
- [x] Source 1: Review existing scripts for template patterns
- [x] Source 2: Analyze envsubst capabilities and limitations
- [x] Source 3: Review bash heredoc patterns
- [x] Source 4: Consider learning curve for template authors

---

## 📊 Findings

### Finding 1: Current Pattern Uses sed with Bracket Placeholders

**Existing approach in `new-project.sh`:**

```bash
# Current placeholder format: [Project Name], [Date], [Brief description]
sed -i '' "s/\[Project Name\]/$project_name/g" "$full_project_path/README.md"
sed -i '' "s/\[Date\]/$current_date/g" "$full_project_path/README.md"
sed -i '' "s/\[Brief description of what this project does\]/$description/g" "$full_project_path/README.md"
```

**Template format:**

```markdown
# [Project Name]

**Purpose:** [Brief description of what this project does]  
**Last Updated:** [Date]
```

**Observations:**
- Bracket placeholders are human-readable in templates
- sed handles replacement at generation time
- Platform-specific sed syntax (GNU vs BSD) requires handling
- No conditionals, loops, or complex logic supported

**Source:** `scripts/new-project.sh` lines 299-310

**Relevance:** Establishes existing pattern we should maintain or evolve from.

---

### Finding 2: Template Engine Options Have Different Tradeoffs

| Approach | Complexity | Features | Dependencies | Portability |
|----------|------------|----------|--------------|-------------|
| **sed** | Simple | Replace only | None (built-in) | Requires GNU/BSD handling |
| **envsubst** | Simple | `$VAR` and `${VAR}` | gettext (usually installed) | High (POSIX) |
| **bash heredoc** | Simple | Shell variables | None (built-in) | High |
| **jinja2/j2cli** | Complex | Conditionals, loops, filters | Python/pip | Medium |
| **gomplate** | Complex | Conditionals, loops, datasources | Single binary | High |
| **mustache** | Medium | Conditionals, sections | Various implementations | Medium |

**Source:** Template engine documentation review

**Relevance:** Need to balance simplicity with future needs.

---

### Finding 3: envsubst Provides Middle Ground

**envsubst capabilities:**

```bash
# Template file: template.md
# Hello, ${USER}!
# Today is ${DATE}.

# Generation:
export DATE=$(date +%Y-%m-%d)
envsubst < template.md > output.md
```

**Advantages:**
- Simple variable substitution (`$VAR` or `${VAR}`)
- No complex syntax to learn
- Available on most systems (part of gettext)
- Selective expansion: `envsubst '$VAR1 $VAR2'` expands only those variables
- Works with any file format (markdown, yaml, json)

**Limitations:**
- No conditionals (if/else)
- No loops
- No default values (must be handled in shell)
- No includes/partials

**Source:** envsubst documentation, gettext package

**Relevance:** Sufficient for document template expansion; keeps templates simple.

---

### Finding 4: Cursor Commands Use Inline Markdown Heredocs

**From Topic 4 research:** Commands currently embed templates as heredocs:

```markdown
# In command file
Create a document with this structure:

## Section 1
<!-- AI: Fill this section -->

## Section 2  
<!-- AI: Fill this section -->
```

This pattern suggests:
- **Templates should remain readable markdown**
- **Placeholders should be human-understandable**
- **AI expansion zones distinct from variable placeholders**

**Source:** [research-command-integration.md](research-command-integration.md)

**Relevance:** External templates must be compatible with this pattern.

---

### Finding 5: Placeholder Convention Analysis

**Three placeholder types needed (from Topic 4):**

| Type | Format | Expanded By | Example |
|------|--------|-------------|---------|
| Script variables | `{{VAR}}` or `${VAR}` | Generation script | `{{DATE}}`, `${TOPIC}` |
| AI content | `<!-- AI: instruction -->` | AI during workflow | `<!-- AI: Summarize findings -->` |
| Expansion zones | `<!-- EXPAND: scope -->` | AI in Conduct mode | `<!-- EXPAND: Research methodology -->` |

**Key insight:** Script placeholders must be visually distinct from AI placeholders.

**Recommendation:** Use `${VAR}` (envsubst-compatible) for script variables.

**Source:** Command audit (Topic 4)

**Relevance:** Format must distinguish script-time vs AI-time expansion.

---

### Finding 6: Migration Path from sed to envsubst

**Current (sed-based):**

```markdown
# [Project Name]
**Last Updated:** [Date]
```

```bash
sed -i '' "s/\[Project Name\]/$project_name/g" file.md
```

**Proposed (envsubst-based):**

```markdown
# ${PROJECT_NAME}
**Last Updated:** ${DATE}
```

```bash
export PROJECT_NAME="My Project"
export DATE=$(date +%Y-%m-%d)
envsubst < template.md > output.md
```

**Advantages of migration:**
- Standard POSIX variable syntax
- No regex escaping issues
- Selective variable expansion possible
- Easier to maintain

**Migration considerations:**
- Existing templates use `[...]` format
- New templates can use `${...}` format
- Both can coexist during transition

**Source:** Architecture analysis

**Relevance:** Provides evolution path for template format.

---

### Finding 7: No Need for Complex Template Engine

**Evaluation of features needed:**

| Feature | Needed? | Reasoning |
|---------|---------|-----------|
| Variable substitution | ✅ Yes | Core functionality |
| Conditionals | ❌ No | Document structure is fixed; AI fills content |
| Loops | ❌ No | Templates don't iterate; AI expands sections |
| Includes/partials | 🟡 Maybe | Could help with common headers/footers |
| Filters | ❌ No | Keep simple; scripts can pre-process |
| Default values | 🟡 Maybe | Can handle in shell: `${VAR:-default}` |

**Conclusion:** envsubst or sed is sufficient. Complex engines (jinja2, gomplate) add unnecessary dependencies and learning curve.

**Source:** Requirements analysis

**Relevance:** Keeps tooling simple and accessible.

---

## 🔍 Analysis

**Key comparison:**

| Criterion | sed | envsubst | jinja2/complex |
|-----------|-----|----------|----------------|
| Learning curve | Low | Low | High |
| Dependencies | None | gettext (common) | Python/binary |
| Template readability | Medium | High | Medium |
| Platform portability | Medium (GNU/BSD) | High | Medium |
| Future extensibility | Low | Low | High |
| Team adoption | Easy | Easy | Requires training |

**Key Insights:**
- [x] Insight 1: Current sed pattern works but has platform issues (GNU vs BSD)
- [x] Insight 2: envsubst provides cleaner syntax with similar simplicity
- [x] Insight 3: Complex template engines (jinja2) are overkill for our needs
- [x] Insight 4: Template format must distinguish script vs AI placeholders
- [x] Insight 5: Migration can be gradual - both formats can coexist
- [x] Insight 6: Keep templates as plain markdown for readability

---

## 💡 Recommendations

- [x] **R1:** Use `${VAR}` format for script-time variable expansion (envsubst-compatible)
- [x] **R2:** Use `<!-- AI: instruction -->` for AI content placeholders
- [x] **R3:** Use `<!-- EXPAND: scope -->` for AI expansion zones
- [x] **R4:** Keep envsubst as primary engine (simple, portable)
- [x] **R5:** Support gradual migration from current `[...]` format
- [x] **R6:** Document placeholder conventions for template authors
- [x] **R7:** Avoid complex template engines unless clear need emerges

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-34:** Templates must support variable expansion via envsubst-compatible `${VAR}` format
- **FR-35:** Placeholder types must be visually distinguishable (script vs AI vs expansion)
- **FR-36:** Template documentation must clearly define placeholder conventions

### Non-Functional Requirements

- **NFR-17:** Templates must remain readable markdown without pre-processing
- **NFR-18:** Template format must have minimal learning curve for authors

### Constraints

- **C-17:** Avoid introducing Python/binary dependencies for template rendering
- **C-18:** Script placeholders must not conflict with markdown or shell syntax

---

## 🚀 Next Steps

1. Add FR-34 through FR-36 to requirements.md
2. Add NFR-17, NFR-18 to requirements.md
3. Add C-17, C-18 to requirements.md
4. Create placeholder convention documentation during implementation
5. Consider migration utility for existing templates (if needed)

---

**Last Updated:** 2026-01-14
