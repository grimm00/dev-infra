# ADR-002: Template Structure Standard

**Status:** ✅ Accepted  
**Created:** 2026-01-14  
**Last Updated:** 2026-01-14  
**Batch:** 1 (Foundation)

---

## Context

Documentation infrastructure requires standardized templates for all document types. Research identified 17 distinct document types across 6 workflows and 5 common structural patterns. We need to decide on the template structure standard including document types, common patterns, and placeholder conventions.

**Related Research:**
- [Research: Template Inventory](../../research/template-doc-infrastructure/research-template-inventory.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [Research Summary](../../research/template-doc-infrastructure/research-summary.md) - Findings 1, 2, 11

**Related Requirements:**
- FR-1: Templates for all 17 doc types
- FR-2: Required sections with placeholder markers
- FR-3: Version header for template schema
- FR-4: Section markers for content generation
- FR-5: Optional sections clearly marked
- FR-34: envsubst-compatible `${VAR}` format
- FR-35: Distinguishable placeholder types
- FR-36: Placeholder convention documentation
- NFR-1: Template structure parseable for validation
- NFR-2: Templates readable without pre-processing
- NFR-3: Templates work with current sed-based generation
- NFR-17: Readable templates without processing
- NFR-18: Minimal learning curve for authors

---

## Decision

**Decision:** Adopt a hybrid template structure with:
1. **17 template files** organized by workflow category
2. **5 common patterns** standardized across all templates
3. **3 placeholder types** for script, AI, and expansion zones
4. **envsubst-compatible** `${VAR}` syntax for script variables

Templates define complete structure with clearly marked zones for different types of content expansion.

---

## Consequences

### Positive

- **Consistent structure:** All docs follow predictable patterns
- **Validation-ready:** Structure can be validated programmatically
- **Clear authoring:** Placeholder types tell authors what goes where
- **AI-compatible:** Expansion zones work with current two-mode commands
- **Simple tooling:** envsubst is simple and universally available
- **Readable:** Templates are valid markdown without processing

### Negative

- **Template maintenance:** 17 templates to maintain
- **Learning curve:** Authors must learn 3 placeholder types
- **Migration effort:** Existing docs may need updating to match templates
- **Rigidity:** Less flexibility for unique documents

---

## Alternatives Considered

### Alternative 1: Minimal Structure (Just Headings)

**Description:** Templates define only section headings, no content guidance.

**Pros:**
- Maximum flexibility
- Simple templates
- Easy to maintain

**Cons:**
- No guidance for content
- Inconsistent outputs
- Hard to validate

**Why not chosen:** Doesn't solve the format drift problem. AI would still generate inconsistent content within sections.

---

### Alternative 2: Rigid Templates (Full Content)

**Description:** Templates include all content with only variable placeholders.

**Pros:**
- Maximum consistency
- Easy to validate
- Predictable output

**Cons:**
- No flexibility for AI expansion
- Templates become stale quickly
- Doesn't support two-mode pattern
- Every change requires template update

**Why not chosen:** Too restrictive. Removes the value of AI for creative content generation.

---

### Alternative 3: Hybrid (Structure + Expansion Zones)

**Description:** Templates define structure with three placeholder types:
- `${VAR}` for script-time variables
- `<!-- AI: instruction -->` for AI content
- `<!-- EXPAND: scope -->` for AI expansion zones

**Pros:**
- Clear structure for validation
- Flexibility for AI content
- Supports two-mode pattern
- Distinguishable placeholder types

**Cons:**
- More complex templates
- Multiple placeholder types to learn

**Why chosen:** Best balance of consistency (structure) and flexibility (AI content). Supports the two-mode generation pattern already established in `/explore` and `/research` commands.

---

## Decision Rationale

**Key Factors:**

1. **Two-mode pattern is established:** `/explore` and `/research` already use scaffolding + expansion
2. **Validation is critical:** Need to detect format drift before it breaks tooling
3. **AI adds value in content, not structure:** Scripts should generate structure, AI fills content
4. **Readability matters:** Templates must be valid markdown for human review

**Research Support:**

| Finding | Implication |
|---------|-------------|
| Finding 1: 17 doc types | Need templates for all of them |
| Finding 2: 5 common patterns | Standardize across all templates |
| Finding 6: Command-generated docs | Two modes: scaffolding and full |
| Finding 11: envsubst | Simple, portable variable expansion |

---

## Template Categories

| Category | Count | Doc Types |
|----------|-------|-----------|
| **Hub Templates** | 4 | README.md (exploration), README.md (research), README.md (decision), README.md (feature) |
| **Exploration** | 2 | exploration.md, research-topics.md |
| **Research** | 3 | research-[topic].md, research-summary.md, requirements.md |
| **Decision** | 3 | adr-NNN-[name].md, decisions-summary.md, transition-plan.md |
| **Planning** | 3 | feature-plan.md, phase-N.md, status-and-next-steps.md |
| **Other** | 2 | handoff.md, fix-review-report.md |
| **Total** | **17** | |

---

## Five Common Patterns

### Pattern 1: Status Header Block

**Definition:** Metadata block at top of every document.

```markdown
**Purpose:** ${PURPOSE}  
**Status:** ${STATUS}  
**Created:** ${DATE}  
**Last Updated:** ${DATE}
```

**Used in:** All 17 doc types (required)

---

### Pattern 2: Quick Links Section

**Definition:** Navigation section in hub documents.

```markdown
## 📋 Quick Links

- **[Document 1](doc1.md)** - Description
- **[Document 2](doc2.md)** - Description ⭐ **NEW**
```

**Used in:** README.md hub documents (4 templates)

---

### Pattern 3: Status Tables

**Definition:** Tabular progress tracking.

```markdown
| Topic | Priority | Status | Notes |
|-------|----------|--------|-------|
| ${TOPIC_1} | 🔴 High | 🔴 Not Started | - |
| ${TOPIC_2} | 🟡 Medium | ✅ Complete | Key finding |
```

**Used in:** Research hubs, decision hubs, feature hubs

---

### Pattern 4: Next Steps Section

**Definition:** Actionable next actions at document end.

```markdown
## 🚀 Next Steps

1. <!-- AI: First recommended action -->
2. <!-- AI: Second recommended action -->
```

**Used in:** All 17 doc types (required at end)

---

### Pattern 5: Related Links Section

**Definition:** Cross-references to related documents.

```markdown
## 🔗 Related

- [Related Research](../research/${TOPIC}/README.md)
- [Requirements](../research/${TOPIC}/requirements.md)
```

**Used in:** Exploration, research, decision docs

---

## Placeholder Convention

| Type | Syntax | Expanded By | When | Example |
|------|--------|-------------|------|---------|
| **Script variable** | `${VAR}` | dt-doc-gen (envsubst) | Generation time | `${DATE}`, `${TOPIC}`, `${STATUS}` |
| **AI content** | `<!-- AI: instruction -->` | AI during workflow | Command execution | `<!-- AI: Summarize key findings -->` |
| **Expansion zone** | `<!-- EXPAND: scope -->` | AI in Conduct mode | Two-mode expansion | `<!-- EXPAND: Research methodology -->` |

### Script Variables

Used for values known at generation time:

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${DATE}` | Current date | `2026-01-14` |
| `${TOPIC}` | Topic/feature name | `template-doc-infrastructure` |
| `${STATUS}` | Initial status | `🔴 Research` |
| `${PURPOSE}` | Document purpose | `Research for template infrastructure` |

### AI Content Markers

Used for content AI should fill:

```markdown
<!-- AI: Provide a brief summary of the research findings -->
<!-- AI: List 3-5 key insights from the analysis -->
<!-- AI: Recommend next steps based on findings -->
```

### Expansion Zones

Used for sections AI expands in Conduct mode:

```markdown
## 📊 Findings

<!-- EXPAND: Add findings for each research goal. Each finding should include:
- Title
- Description
- Source reference
- Relevance to research question
-->
```

---

## Template Structure Example

**Example: `research-topic.md.tmpl`**

```markdown
# Research: ${TOPIC_TITLE}

**Research Topic:** ${PARENT_TOPIC}  
**Question:** ${RESEARCH_QUESTION}  
**Status:** ${STATUS}  
**Created:** ${DATE}  
**Last Updated:** ${DATE}

---

## 🎯 Research Question

<!-- AI: Elaborate on the specific research question -->

---

## 🔍 Research Goals

<!-- EXPAND: List 3-5 research goals as checkboxes -->

---

## 📚 Research Methodology

<!-- EXPAND: Describe methodology and sources to investigate -->

---

## 📊 Findings

<!-- EXPAND: Document findings with sources and relevance -->

---

## 🔍 Analysis

<!-- AI: Analyze findings and draw key insights -->

---

## 💡 Recommendations

<!-- AI: Provide recommendations based on analysis -->

---

## 📋 Requirements Discovered

<!-- AI: Extract functional and non-functional requirements -->

---

## 🚀 Next Steps

<!-- AI: List next steps for this research -->

---

**Last Updated:** ${DATE}
```

---

## Indicator Standards

### Priority Indicators

| Indicator | Meaning | Used For |
|-----------|---------|----------|
| 🔴 High | Critical/blocking | Research topics, tasks, requirements |
| 🟡 Medium | Important but not blocking | Research topics, requirements |
| 🟢 Low | Nice-to-have | Research topics, requirements |

### Status Indicators

| Indicator | Meaning | Used For |
|-----------|---------|----------|
| 🔴 Not Started / Scaffolding | Work hasn't begun | Phases, research topics |
| 🟠 In Progress | Work underway | Phases, features |
| 🟡 Analysis / Review | Needs review | Research |
| ✅ Complete / Expanded | Work finished | All docs |

---

## Requirements Impact

**Requirements Addressed:**

| Requirement | How Addressed |
|-------------|---------------|
| FR-1 | 17 templates defined by category |
| FR-2 | Placeholder markers for all section types |
| FR-3 | Status header at top of every template |
| FR-4 | AI and EXPAND markers for content |
| FR-5 | Optional sections use EXPAND zones |
| FR-34 | envsubst-compatible `${VAR}` format |
| FR-35 | Three distinct placeholder types |
| FR-36 | Convention documented in this ADR |
| NFR-1 | Structure uses markdown headings (parseable) |
| NFR-2 | Valid markdown without processing |
| NFR-17 | Readable as plain markdown |
| NFR-18 | Simple conventions, documented examples |

---

## References

- [Research: Template Inventory](../../research/template-doc-infrastructure/research-template-inventory.md)
- [Research: Template Format](../../research/template-doc-infrastructure/research-template-format.md)
- [Requirements Document](../../research/template-doc-infrastructure/requirements.md)

---

**Last Updated:** 2026-01-14
