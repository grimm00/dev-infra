# Research: Templates as Structural Schemas

**Research Topic:** Agentic Workflow Modernization
**Question:** How do existing doc-gen templates become structural schemas that agents validate, fill, and extend?
**Status:** ✅ Complete
**Priority:** Medium-High
**Created:** 2026-03-25
**Completed:** 2026-03-25

---

## 🎯 Research Question

Dev-infra already ships 17+ doc-gen templates. Can these be elevated from "AI fill-in-the-blank helpers" to structural schemas -- formal contracts for document structure that agents validate, diff, and enforce?

---

## 🔍 Research Goals

- [x] Audit existing doc-gen templates for schema-like properties (required fields, typed sections, validation rules)
- [x] Research AI document validation patterns: what does "structural schema for a document" look like in practice?
- [x] Determine what metadata would make a template a schema (required vs optional sections, field types, content rules)
- [x] Assess whether living schemas within skill `assets/` is the right packaging (vs standalone schema files)
- [x] Explore agent-driven validation: "does this document conform to the schema?" as an agentic check

---

## 📚 Research Methodology

**Sources:**
- [x] Audited dev-infra's 19 `.tmpl` files in `scripts/doc-gen/templates/`
- [x] Reviewed ADR-002 (Template Structure Standard) -- 3 placeholder types, 5 common patterns, 17 doc types
- [x] Reviewed ADR-004 (Validation Architecture) -- layered validation with on-demand CLI
- [x] Web search: markdown schema validation tools (mdschema, tiredize, contextlint, doc-structure-lint)
- [x] Web search: AI structured output validation and prompt contracts
- [x] Reviewed agentskills.io spec for assets/ and references/ loading behavior
- [x] Cross-referenced with Topic 3 Finding 4 (doc-gen templates belong in `assets/`)

---

## 📊 Findings

### Finding 1: Dev-Infra Already Has Structural Schemas -- They're Just Not Labeled as Such

The `template-doc-infrastructure` feature (v0.9.0, ADRs 001-004, January 2026) already designed a complete structural schema system:

**ADR-002 defines:**
- 17 document types across 5 categories (exploration, research, decision, planning, other)
- 5 common patterns required across all types (status header, quick links, status tables, next steps, related links)
- 3 placeholder types: `${VAR}` (script-time), `<!-- AI: instruction -->` (AI content), `<!-- EXPAND: scope -->` (expansion zones)
- Type-specific required sections (e.g., exploration requires `## 🎯 What We're Exploring`, `## 🔍 Themes`, `## ❓ Key Questions`)

**ADR-004 defines:**
- Validation rules per type (required sections, status header format, date format)
- CLI tool spec (`dt-doc-validate`) with error messages, JSON output, exit codes
- Common validation functions (`check_status_header()`, `check_required_sections()`)

The templates themselves in `scripts/doc-gen/templates/` encode the canonical structure with explicit markers for required vs expandable content. The `exploration.md.tmpl` file distinguishes:
- `<!-- AI: -->` -- content the agent must fill (required)
- `<!-- EXPAND: -->` -- content the agent fills during conduct mode (expansion zone)
- `<!-- REQUIRED: -->` -- inline annotations noting minimum content requirements (e.g., "At least 2 themes")

**What's missing is not the schema -- it's the packaging.** The schemas exist as `.tmpl` files in a dev-infra-internal directory that no other tool or agent can consume. They're not portable, not colocated with the skills that generate the documents, and not machine-validatable without the planned `dt-doc-validate` CLI.

**Source:** Direct audit of `scripts/doc-gen/templates/`, ADR-002, ADR-004

---

### Finding 2: Markdown Schema Validation Tools Have Matured in 2025-2026

Several tools now support the pattern dev-infra needs:

| Tool | Language | Approach | Key Feature |
|------|----------|----------|-------------|
| **mdschema** (v0.12.7, Mar 2026) | Go | YAML schema → validate markdown | Hierarchical structure, template generation, frontmatter validation |
| **tiredize** | Python | Schema-driven parsing and linting | Section ordering, optional/repeating sections, heading-level enforcement |
| **contextlint** (v0.8.1, Mar 2026) | TypeScript | Rule-based structural linting | Cross-file integrity, missing sections, broken references, deterministic (no AI) |
| **doc-structure-lint** | Node.js | YAML template → validate markdown | Section structure, paragraph counts, list requirements, template dereferencing |

The convergent pattern across all tools: **define expected structure in YAML or a template file, then validate markdown against it deterministically.** This maps directly to what ADR-004 designed -- the tools just didn't exist when the ADR was written.

**OpenClaw's approach (March 2026)** is particularly relevant: opt-in frontmatter declarations in markdown files link them to their schema. Only files that declare a schema are validated. This is the pattern that would connect skills to their canonical document structure.

**Source:** Web search; GitHub repos for mdschema, contextlint, doc-structure-lint; OpenClaw issue #37469

---

### Finding 3: In the Skills World, Templates-as-Schemas Live in `assets/` and Validate via `references/`

Topic 3 established that doc-gen templates belong in `assets/` (static resources the agent fills in). The structural schema question adds a second layer:

**The template in `assets/` IS the schema.** It defines:
- Required sections (headings present in the template)
- Required metadata (frontmatter variables)
- Content guidance (AI/EXPAND markers)
- Structural constraints (section ordering, nesting)

**The validation guidance can live in `references/`.** A `references/validation-rules.md` in a skill can describe:
- Which sections are required vs optional
- What constitutes valid content for each section
- When the agent should self-validate output

**The progressive loading model supports this split:**

| Tier | Content | When | Purpose |
|------|---------|------|---------|
| Catalog | Skill name + description | Always | Routing |
| SKILL.md | Workflow instructions + asset references | On activation | Execution |
| `assets/` template | Canonical document structure | When creating/updating docs | Structure contract |
| `references/` validation | Self-check rules | After doc generation | Quality gate |

The agent creates a document from `assets/template.md`, fills it following SKILL.md instructions, then self-validates by comparing its output against the structural expectations in `references/validation-rules.md`. This is a lighter-weight version of ADR-004's `dt-doc-validate` -- the agent performs the validation inline, during the workflow, without needing external tooling.

**Source:** agentskills.io spec (progressive disclosure); Topic 3 Finding 4

---

### Finding 4: Structured Output Contracts Apply to Documents, Not Just JSON

The "structured output" pattern from the LLM ecosystem (Pydantic models, JSON Schema validation) has a direct analog for markdown documents:

| JSON Pattern | Markdown Analog | Dev-Infra Implementation |
|--------------|----------------|--------------------------|
| JSON Schema defines field types | Template defines section structure | `exploration.md.tmpl` headings |
| Required fields | Required sections | `<!-- REQUIRED: -->` annotations |
| Enum constraints | Status indicator set | `🔴 🟠 🟡 🟢 ✅` |
| Validation on output | Agent self-check after generation | Skill references/validation-rules.md |
| Retry on failure | Agent fixes document if self-check fails | Skill instruction: "verify output matches template structure" |

The key insight from the structured output research: **downstream logic becomes trivial when the contract is explicit.** When an `explore-conduct` skill produces an exploration document, every downstream consumer (`research`, `research-conduct`, `decision`, etc.) knows exactly what sections exist and where to find content. The template is the interface contract between skills in the pipeline.

**Source:** Web search; "Structured Outputs Are the Contract Your AI Agent Is Missing" (dev.to); "Prompt Contracts v2"

---

### Finding 5: The Migration Path Is Template Relocation, Not Redesign

The existing `.tmpl` files don't need fundamental changes to become structural schemas in skills. The migration is primarily relocation and annotation:

**Current state:**
```
scripts/doc-gen/templates/
├── exploration/
│   ├── README.md.tmpl
│   ├── exploration.md.tmpl       ← canonical exploration structure
│   └── research-topics.md.tmpl
├── research/
│   ├── README.md.tmpl
│   ├── research-topic.md.tmpl    ← canonical research doc structure
│   ├── research-summary.md.tmpl
│   └── requirements.md.tmpl
...
```

**Target state (in skills):**
```
.agents/skills/
├── explore/
│   └── assets/
│       ├── exploration-scaffold.md    ← renamed from exploration.md.tmpl
│       └── research-topics.md         ← renamed from research-topics.md.tmpl
├── explore-conduct/
│   ├── assets/
│   │   └── exploration-full.md        ← expanded template for conduct mode
│   └── references/
│       └── section-guidance.md        ← what belongs in each section
├── research/
│   └── assets/
│       ├── research-hub.md
│       ├── research-topic.md
│       ├── research-summary.md
│       └── requirements.md
...
```

**What changes:**
1. File extension: `.tmpl` → `.md` (templates are valid markdown, the extension was for tooling differentiation)
2. Location: `scripts/doc-gen/templates/` → `assets/` within each skill
3. Placeholder syntax: `${VAR}` stays for values known at generation time; `<!-- AI: -->` and `<!-- EXPAND: -->` become implicit (the skill instructions tell the agent what to fill, the template shows where)
4. Annotation: add `<!-- REQUIRED: -->` markers more consistently for self-validation

**What stays the same:**
- The structural patterns (status header, quick links, etc.)
- The section hierarchy per document type
- The 17 document type taxonomy

**Source:** Direct comparison of current templates with Topic 3 skill directory layout

---

### Finding 6: Agent Self-Validation Is the Realistic First Step; External Tooling Is Optional

ADR-004 designed a comprehensive external validation system (`dt-doc-validate`, shared library, CI integration). In the skills world, there's a lighter-weight path that achieves most of the value:

**Agent self-validation pattern:**
1. Skill SKILL.md instructs: "After creating the document, verify it contains all required sections from the template"
2. Agent reads the template from `assets/`, reads its generated output, and checks section presence
3. Agent fixes any missing sections before committing

This is imprecise compared to `dt-doc-validate` (the agent may miss structural errors it would catch), but it's:
- Zero-tooling (works on any platform that supports skills)
- Portable (no dependency on dev-toolkit installation)
- Progressive (agents improve at self-validation as models improve)

**External tooling (`dt-doc-validate`) remains the right enforcement layer for CI.** The agent self-validates during workflow; the CI validates on PR. The layered architecture from ADR-004 still holds -- the difference is that the agent is now an additional validation layer, not a substitute.

**Source:** ADR-004 architecture; structured output validation patterns

---

## 🔍 Analysis

### The Structural Schema Question Is Already Answered -- It's a Packaging Problem

Dev-infra's `template-doc-infrastructure` feature (v0.9.0) designed the structural schema system in full: 17 document types, validation rules per type, a three-placeholder-type convention, and a layered validation architecture. The question "can templates become structural schemas?" has already been answered with "yes, and here's the spec."

What Topic 4 adds is the **packaging answer**: where do these schemas live in a skills-based architecture, and how do agents consume them?

The answer: templates move to `assets/` within the owning skill. They serve two roles simultaneously:
1. **Generation guidance** -- the agent reads the template to know what structure to create
2. **Interface contract** -- downstream skills know what sections to expect in the generated document

This dual role is natural. A template that says "this exploration has a `## 🔍 Themes` section" is simultaneously telling the creating skill "put themes here" and telling the consuming skill "expect themes here." No separate schema file is needed.

### The Validation Story Has Three Layers

| Layer | Mechanism | When | Strength |
|-------|-----------|------|----------|
| Agent self-validation | SKILL.md instruction + template comparison | During workflow | Convenient, portable, zero-tooling |
| External CLI (`dt-doc-validate`) | Bash script with regex rules | On-demand or in-command | Precise, deterministic, fast |
| CI enforcement | GitHub Action calling CLI | On PR | Guaranteed, gate for quality |

Agent self-validation is the new layer that skills introduce. It doesn't replace the others -- it supplements them. The decision about whether to invest in `dt-doc-validate` (which is a dev-toolkit feature, not a dev-infra one) is independent of the skills migration.

### Templates as Inter-Skill Interface Contracts

The most architecturally significant insight: when skills generate and consume documents in a pipeline (`explore` → `research` → `decision`), the templates define the **interface between skills**. The `research` skill's SKILL.md can say "read the exploration document; expect sections: `## 🎯 What We're Exploring`, `## 🔍 Themes`, `## ❓ Key Questions`, `## 🧪 Spike Determination`." It knows what to expect because the `explore-conduct` skill generated the document from a known template.

This is the structural schema insight in its most useful form: templates are not just generation helpers, they're the **contract language** of the skill pipeline. If a template changes, downstream skills' expectations may break -- the same way a code API change can break callers. Template sync validation (FR-13 from Topic 3) is the mechanism that catches this.

**Key Insights:**
- [x] Insight 1: The structural schema system already exists (ADR-002 + ADR-004); the gap is packaging, not design
- [x] Insight 2: Templates in `assets/` serve dual roles: generation guidance AND interface contract for downstream skills
- [x] Insight 3: Agent self-validation is a new, lightweight layer that supplements (not replaces) external tooling
- [x] Insight 4: Markdown schema validation tools have matured (mdschema, contextlint) and could replace custom `dt-doc-validate`
- [x] Insight 5: Template changes are API changes -- template sync and versioning protect pipeline integrity

---

## 💡 Recommendations

- [x] **Relocate templates to skill `assets/`**: Move `scripts/doc-gen/templates/*.tmpl` to `assets/` within the owning skill during skills migration. Rename `.tmpl` → `.md`. The templates are valid markdown and work without preprocessing.
- [x] **Add `<!-- REQUIRED: -->` annotations consistently**: Currently sporadic in templates. Make them systematic so agent self-validation has explicit markers to check against.
- [x] **Add agent self-validation instructions to procedural skills**: Each procedural skill that generates documents should include a "verify output" step: compare generated document against the template structure in `assets/`.
- [x] **Evaluate `mdschema` or `contextlint` as `dt-doc-validate` replacement**: These tools are purpose-built for what ADR-004 designed from scratch. If they fit dev-infra's needs, they save the custom implementation effort.
- [x] **Treat template changes as API changes**: When modifying a template in a skill's `assets/`, check whether downstream skills depend on the section being changed. This is the "templates as interface contracts" discipline.

---

## 📋 Requirements Discovered

- [x] **FR-14: Templates Must Be Relocated to Skill `assets/` During Migration** -- the 19 `.tmpl` files in `scripts/doc-gen/templates/` must be moved to `assets/` within the skill that owns the document type. Files are renamed from `.tmpl` to `.md`. The original `scripts/doc-gen/templates/` directory is retained as a compatibility layer until `dt-doc-gen` is updated.
  - Source: Finding 1, Finding 5
  - Priority: Medium (required during migration, not before)

- [x] **FR-15: Procedural Skills Must Include Agent Self-Validation Step** -- skills that generate or modify structured documents must include a verification step in SKILL.md: compare the output against the template structure in `assets/`, verify all required sections are present, and fix any structural gaps before committing.
  - Source: Finding 6, Finding 4
  - Priority: Medium

- [x] **NFR-1: Template Changes Must Be Treated as Interface Contract Changes** -- modifications to a template in a skill's `assets/` directory must be assessed for downstream impact on consuming skills. Template sync validation (FR-13) is the enforcement mechanism. Breaking changes to a template's required sections must be communicated to downstream skill authors.
  - Source: Analysis (inter-skill interface contracts)
  - Priority: High (architectural principle)

---

**Last Updated:** 2026-03-25
