# Template Format Specification

**Purpose:** Format specification for template-based documentation infrastructure  
**Audience:** Tooling implementers (dt-doc-gen, dt-doc-validate)  
**Status:** ✅ Active  
**Last Updated:** 2026-01-16

---

## 📋 Quick Links

- **[Variable Reference](VARIABLES.md)** - Standard and workflow-specific variables
- **[Authoring Guide](AUTHORING.md)** - How to create and modify templates
- **[ADR-002: Template Structure Standard](../../admin/decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)** - Authoritative decisions

---

## 🎯 Overview

Templates use three distinct placeholder types, each expanded at different times by different tools. This separation enables:

- **Scripts generate structure** (0 AI tokens)
- **AI fills creative content** (targeted AI tokens)
- **Two-mode generation** (scaffolding vs full)

---

## 📊 Placeholder Types

| Type | Syntax | Expanded By | When | Purpose |
|------|--------|-------------|------|---------|
| **Script Variable** | `${VAR}` | dt-doc-gen (envsubst) | Generation time | Known values (date, topic, status) |
| **AI Content** | `<!-- AI: instruction -->` | AI during workflow | Command execution | Creative content generation |
| **Expansion Zone** | `<!-- EXPAND: scope -->` | AI in Conduct mode | Two-mode expansion | Detailed content in full mode |

---

## 1️⃣ Script Variables (`${VAR}`)

Script variables are expanded at generation time using `envsubst`. These are values known when the document is created.

### Syntax

```
${VARIABLE_NAME}
```

- Use UPPERCASE with underscores
- Must be valid shell variable names
- Expanded by `envsubst` tool

### Examples

```markdown
# Research: ${TOPIC_TITLE}

**Status:** ${STATUS}  
**Created:** ${DATE}  
**Last Updated:** ${DATE}
```

**After expansion (generation time):**

```markdown
# Research: User Authentication

**Status:** 🔴 Scaffolding  
**Created:** 2026-01-16  
**Last Updated:** 2026-01-16
```

### Common Variables

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `${DATE}` | Current date (YYYY-MM-DD) | `2026-01-16` |
| `${TOPIC}` | Topic/feature name (kebab-case) | `template-doc-infrastructure` |
| `${TOPIC_TITLE}` | Topic name (Title Case) | `Template Doc Infrastructure` |
| `${STATUS}` | Initial status indicator | `🔴 Scaffolding` |
| `${PURPOSE}` | Document purpose statement | `Research for...` |

**See:** [VARIABLES.md](VARIABLES.md) for complete variable reference.

### Implementation

```bash
render_template() {
    local template="$1"
    local output="$2"
    
    # Export variables
    export DATE=$(date +%Y-%m-%d)
    export TOPIC="my-topic"
    export STATUS="🔴 Scaffolding"
    
    # Render with envsubst
    envsubst < "$template" > "$output"
}
```

---

## 2️⃣ AI Content Markers (`<!-- AI: -->`)

AI content markers indicate sections where AI should generate creative content during command execution.

### Syntax

```markdown
<!-- AI: instruction for what to generate -->
```

- Use HTML comment syntax (invisible in rendered markdown)
- Include clear instruction for AI
- Can span multiple lines for complex instructions

### Examples

**Single-line marker:**

```markdown
## 🎯 Research Question

<!-- AI: Elaborate on the specific research question being investigated -->
```

**Multi-line instruction:**

```markdown
## 📊 Findings

<!-- AI: Document key findings from the research. For each finding include:
- Finding title
- Description
- Source reference
- Relevance to research question
-->
```

### When Expanded

- **During command execution** - AI fills content when user runs workflow command
- **Preserved in setup mode** - Markers remain in scaffolding documents
- **Replaced in full mode** - AI generates content to replace markers

### Best Practices

1. **Be specific** - Include clear instructions
2. **Provide structure** - Suggest format (bullets, table, etc.)
3. **Set expectations** - Indicate quantity (3-5 items, brief summary)

**Good:**
```markdown
<!-- AI: List 3-5 key insights from the analysis, each with a brief explanation -->
```

**Avoid:**
```markdown
<!-- AI: Fill this in -->
```

---

## 3️⃣ Expansion Zones (`<!-- EXPAND: -->`)

Expansion zones mark sections that are expanded in Conduct mode but preserved as placeholders in Setup mode. This enables the two-mode generation pattern.

### Syntax

```markdown
<!-- EXPAND: scope description

Optional detailed instructions about what should be expanded here.
Can include formatting guidance and examples.
-->
```

### Examples

**Simple expansion zone:**

```markdown
## 🔍 Research Goals

<!-- EXPAND: List 3-5 research goals as checkboxes -->
```

**Detailed expansion zone:**

```markdown
## 📊 Findings

<!-- EXPAND: Document findings for each research goal. Each finding should include:
- Title
- Description with evidence
- Source reference
- Relevance to research question
- Impact assessment
-->
```

### When Expanded

| Mode | Behavior |
|------|----------|
| **Setup (Scaffolding)** | Marker preserved - creates structure placeholder |
| **Conduct (Full)** | AI expands with detailed content |

### Two-Mode Flow

```
Setup Mode:
  Template → envsubst (${VAR}) → Output with EXPAND markers preserved
  Result: Document with structure + placeholders
  Status: 🔴 Scaffolding

Conduct Mode:
  Scaffolding → AI expands EXPAND zones → Full content
  Result: Complete document with all content
  Status: ✅ Expanded
```

### Difference from AI Markers

| Aspect | `<!-- AI: -->` | `<!-- EXPAND: -->` |
|--------|----------------|-------------------|
| **Purpose** | Creative content | Detailed expansion |
| **Setup mode** | Preserved | Preserved |
| **Conduct mode** | Filled by AI | Expanded by AI |
| **Typical use** | Summaries, insights | Methodology, findings |
| **Content size** | Brief to moderate | Moderate to large |

---

## 🔄 Rendering Flow

### Complete Generation Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                        TEMPLATE FILE                             │
│  .tmpl file with all three placeholder types                    │
│  - ${VAR} script variables                                       │
│  - <!-- AI: --> content markers                                  │
│  - <!-- EXPAND: --> expansion zones                              │
└───────────────────────────────┬─────────────────────────────────┘
                                │
                    ┌───────────▼───────────┐
                    │     dt-doc-gen        │
                    │   (envsubst pass)     │
                    └───────────┬───────────┘
                                │
                    ┌───────────▼───────────┐
                    │   ${VAR} → values     │
                    │   (script expansion)  │
                    └───────────┬───────────┘
                                │
                ┌───────────────┴───────────────┐
                │                               │
        ┌───────▼───────┐               ┌───────▼───────┐
        │  Setup Mode   │               │  Conduct Mode │
        │ (Scaffolding) │               │    (Full)     │
        └───────┬───────┘               └───────┬───────┘
                │                               │
                │                               │
        ┌───────▼───────┐               ┌───────▼───────┐
        │ AI + EXPAND   │               │  AI fills     │
        │  preserved    │               │  content      │
        └───────┬───────┘               └───────┬───────┘
                │                               │
        ┌───────▼───────┐               ┌───────▼───────┐
        │  Scaffolding  │               │   Complete    │
        │   Document    │               │   Document    │
        │ 🔴 Scaffolding│               │ ✅ Expanded   │
        └───────────────┘               └───────────────┘
```

### envsubst Behavior

**What envsubst expands:**

- `${VAR}` → Variable value (if exported)
- `${VAR:-default}` → Value or default (not recommended)

**What envsubst preserves:**

- `<!-- AI: ... -->` → Passed through unchanged
- `<!-- EXPAND: ... -->` → Passed through unchanged
- `$VAR` (without braces) → Passed through unchanged

### Example Transformation

**Template (input):**

```markdown
# Research: ${TOPIC_TITLE}

**Status:** ${STATUS}  
**Created:** ${DATE}

## 🎯 Research Question

<!-- AI: Elaborate on the research question -->

## 📊 Findings

<!-- EXPAND: Document findings with sources -->
```

**After Setup Mode:**

```markdown
# Research: User Authentication

**Status:** 🔴 Scaffolding  
**Created:** 2026-01-16

## 🎯 Research Question

<!-- AI: Elaborate on the research question -->

## 📊 Findings

<!-- EXPAND: Document findings with sources -->
```

**After Conduct Mode:**

```markdown
# Research: User Authentication

**Status:** ✅ Expanded  
**Created:** 2026-01-16

## 🎯 Research Question

This research investigates how user authentication should be implemented
in the application, focusing on security best practices and user experience.

## 📊 Findings

### Finding 1: JWT is Industry Standard
- **Description:** JSON Web Tokens provide stateless authentication
- **Source:** OWASP Authentication Guidelines
- **Relevance:** Directly applicable to our API architecture

### Finding 2: Refresh Token Pattern Recommended
- **Description:** Short-lived access tokens + refresh tokens
- **Source:** OAuth 2.0 Best Practices
- **Relevance:** Balances security with user experience
```

---

## 🔀 Two-Mode Generation

Templates support two distinct generation modes, enabling efficient workflows where structure is created quickly and content is added progressively.

### Mode Comparison

| Aspect | Setup Mode (Scaffolding) | Conduct Mode (Full) |
|--------|--------------------------|---------------------|
| **Purpose** | Create structure for review | Generate complete content |
| **Status** | `🔴 Scaffolding` | `✅ Expanded` |
| **`${VAR}`** | ✅ Expanded | ✅ Expanded |
| **`<!-- AI: -->`** | ⏸️ Preserved | ✅ Filled by AI |
| **`<!-- EXPAND: -->`** | ⏸️ Preserved | ✅ Expanded by AI |
| **Use Case** | Initial creation, rapid setup | Complete document, conduct workflow |
| **Human Review** | Before expansion | After expansion |

### When to Use Each Mode

**Use Setup Mode when:**

- Starting a new exploration, research, or planning workflow
- Creating multiple documents quickly for review
- Need to validate structure before investing AI tokens
- Human wants to review approach before detailed content

**Use Conduct Mode when:**

- Human has reviewed and approved scaffolding
- Ready to generate full content
- Workflow command includes `--expand` or `--conduct` flag
- Filling in a previously scaffolded document

### Complete Example: Same Template in Both Modes

**Template File (`research-topic.md.tmpl`):**

```markdown
# Research: ${TOPIC_TITLE}

**Status:** ${STATUS}  
**Created:** ${DATE}

## 🎯 Research Question

<!-- AI: State the specific research question being investigated -->

## 📚 Research Goals

<!-- EXPAND: List 3-5 research goals with measurable outcomes -->

## 📊 Findings

<!-- EXPAND: Document findings for each research goal. Include:
- Finding title
- Description with evidence
- Source reference
- Impact assessment
-->

## 🚀 Next Steps

<!-- AI: List 2-3 immediate next steps based on findings -->
```

**After Setup Mode (Scaffolding):**

```markdown
# Research: Token Authentication

**Status:** 🔴 Scaffolding  
**Created:** 2026-01-16

## 🎯 Research Question

<!-- AI: State the specific research question being investigated -->

## 📚 Research Goals

<!-- EXPAND: List 3-5 research goals with measurable outcomes -->

## 📊 Findings

<!-- EXPAND: Document findings for each research goal. Include:
- Finding title
- Description with evidence
- Source reference
- Impact assessment
-->

## 🚀 Next Steps

<!-- AI: List 2-3 immediate next steps based on findings -->
```

**After Conduct Mode (Full):**

```markdown
# Research: Token Authentication

**Status:** ✅ Expanded  
**Created:** 2026-01-16

## 🎯 Research Question

How should the application implement token-based authentication to balance security requirements with developer experience and user convenience?

## 📚 Research Goals

- [ ] **Goal 1:** Evaluate JWT vs opaque token approaches
  - Outcome: Documented pros/cons with recommendation
- [ ] **Goal 2:** Research refresh token best practices
  - Outcome: Implementation pattern for token refresh
- [ ] **Goal 3:** Assess token storage strategies
  - Outcome: Security analysis of storage options
- [ ] **Goal 4:** Review industry standards (OAuth 2.0, OIDC)
  - Outcome: Compliance requirements documented

## 📊 Findings

### Finding 1: JWT Recommended for Stateless APIs

- **Description:** JSON Web Tokens provide self-contained authentication without server-side session storage
- **Evidence:** Industry adoption by Auth0, Firebase, AWS Cognito
- **Source:** OWASP Authentication Cheat Sheet, RFC 7519
- **Impact:** Simplifies horizontal scaling, reduces database load

### Finding 2: Short-Lived Access + Refresh Pattern

- **Description:** 15-minute access tokens with 7-day refresh tokens balance security and UX
- **Evidence:** Google, GitHub, Microsoft all use this pattern
- **Source:** OAuth 2.0 Security Best Practices (RFC 6819)
- **Impact:** Limits exposure window while reducing re-authentication friction

### Finding 3: HttpOnly Cookies for Web Storage

- **Description:** Store tokens in HttpOnly cookies to prevent XSS attacks
- **Evidence:** Prevents JavaScript access to tokens
- **Source:** OWASP Secure Cookie Attributes
- **Impact:** Significant security improvement over localStorage

## 🚀 Next Steps

1. **Create ADR** for JWT implementation decision
2. **Design token refresh flow** with sequence diagrams
3. **Evaluate libraries** (jose, jsonwebtoken, authlib)
```

### Workflow Integration

Two-mode generation integrates with workflow commands:

| Command | Default Mode | Full Mode Flag |
|---------|--------------|----------------|
| `/explore` | Setup | `--expand` or `--conduct` |
| `/research` | Setup | `--expand` or `--conduct` |
| `/decision` | Full | N/A (always full) |
| `/transition-plan` | Setup | `--expand` |

**Typical Workflow:**

```
1. /explore my-topic
   → Creates scaffolding (setup mode)
   → Human reviews structure
   
2. /explore my-topic --conduct
   → Expands all markers (conduct mode)
   → Complete document generated
```

---

## ✅ Validation Rules

### Script Variables

- Must match pattern: `${[A-Z][A-Z0-9_]*}`
- Should be documented in VARIABLES.md
- Should have defined default values

### AI Content Markers

- Must match pattern: `<!-- AI: .+ -->`
- Should include clear instruction
- Should not be empty

### Expansion Zones

- Must match pattern: `<!-- EXPAND: .+ -->`
- Should include scope description
- Can include multi-line instructions

---

## 🔗 Related Documents

**Spec Documents:**

- [Variable Reference](VARIABLES.md) - Complete variable list
- [Authoring Guide](AUTHORING.md) - Template creation guide

**Architecture Decisions:**

- [ADR-002: Template Structure Standard](../../../admin/decisions/template-doc-infrastructure/adr-002-template-structure-standard.md)
- [ADR-003: Generation Architecture](../../../admin/decisions/template-doc-infrastructure/adr-003-generation-architecture.md)

**Template Examples:**

| Category | Example Template | Demonstrates |
|----------|------------------|--------------|
| Exploration | [exploration.md.tmpl](exploration/exploration.md.tmpl) | AI markers, EXPAND zones |
| Research | [research-topic.md.tmpl](research/research-topic.md.tmpl) | All 3 placeholder types |
| Decision | [adr.md.tmpl](decision/adr.md.tmpl) | Script variables, status header |
| Planning | [phase.md.tmpl](planning/phase.md.tmpl) | Status tables, EXPAND zones |
| Other | [handoff.md.tmpl](other/handoff.md.tmpl) | Quick links, AI markers |

---

**Last Updated:** 2026-01-16  
**Status:** ✅ Active
