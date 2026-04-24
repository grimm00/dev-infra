# Research: Architectural Placement (Four-Arm Question)

**Research Topic:** Template Doc Infrastructure  
**Question:** Where should this tooling live in the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod)?  
**Status:** ✅ Complete  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13  
**Completed:** 2026-01-13

---

## 🎯 Research Question

Where should the workflow orchestration tooling (doc generation, validation, context gathering, model selection) live within the four-arm architecture? This is a strategic decision that affects versioning, distribution, and how projects consume the tooling.

---

## 🔍 Research Goals

- [x] Goal 1: Understand the four-arm architecture and each arm's responsibilities
- [x] Goal 2: Evaluate which arm best fits workflow orchestration tooling
- [x] Goal 3: Determine distribution mechanism for projects consuming this tooling
- [x] Goal 4: Analyze versioning implications for template vs tooling changes

---

## 📚 Research Methodology

**Sources investigated:**

- [x] Four-arm architecture exploration (`admin/explorations/four-arm-architecture/`)
- [x] Four-arm architecture decisions (`admin/decisions/four-arm-architecture/`)
- [x] ADR-001: Project Identity (dev-infra = template factory)
- [x] ADR-001: Command Distribution Ownership (source vs distribution)
- [x] Dev-toolkit analysis (where does dt-review live?)

---

## 🏗️ Four-Arm Architecture Context

**The Arms:**

| Arm             | Identity              | Purpose                                       | Examples                                 |
| --------------- | --------------------- | --------------------------------------------- | ---------------------------------------- |
| **dev-infra**   | Template Factory      | Templates, patterns, shared contracts         | project templates, Cursor commands       |
| **dev-toolkit** | Developer CLI         | Bash utilities for daily development          | dt-review, dt-git-safety, dt-config      |
| **proj-cli**    | Project Management    | Python CLI for project lifecycle              | proj plan, proj apply, proj init         |
| **work-prod**   | Data API              | Flask backend for centralized data            | Project registry, REST API               |

**Key Design Principle:** Each project can stand alone for external users, but shared business logic is coordinated through dev-infra.

---

## 📊 Findings

### Finding 1: Dev-Infra Identity is "Template Factory" (ADR-001)

**Description:** ADR-001 (Project Identity) established that dev-infra's primary role is as a "template factory":

> "Dev-infra's primary identity is 'template factory.' Internal tooling and workflow experimentation are secondary concerns that should not automatically become template features."

**Key implications:**
- Templates are products
- Internal tooling stays internal
- Workflow scripts that USE templates don't belong in dev-infra
- dev-infra should focus on WHAT to generate, not HOW to orchestrate

**Source:** `admin/decisions/dev-infra-identity-and-focus/adr-001-project-identity.md`

**Relevance:** This establishes that workflow orchestration tooling should NOT live in dev-infra. dev-infra provides the templates; other arms provide the tooling to use them.

---

### Finding 2: Command Distribution Precedent (Source vs Distribution)

**Description:** ADR-001 (Four-Arm Architecture) established a precedent for source vs distribution ownership:

| Role                   | Project     | Responsibility                              |
| ---------------------- | ----------- | ------------------------------------------- |
| **Source Owner**       | dev-infra   | Maintains content, versions with releases   |
| **Distribution Owner** | dev-toolkit | Provides installation, handles mechanics    |

**Application to doc generation:**

| Role                   | Project     | Responsibility                              |
| ---------------------- | ----------- | ------------------------------------------- |
| **Template Source**    | dev-infra   | Doc templates, structure definitions        |
| **Tooling Owner**      | dev-toolkit | gen-doc, validate-doc, context gathering    |

**Source:** `admin/decisions/four-arm-architecture/adr-001-command-distribution-ownership.md`

**Relevance:** The same separation pattern applies. dev-infra owns templates; dev-toolkit owns tooling that uses templates.

---

### Finding 3: dt-review Lives in dev-toolkit (Existing Precedent)

**Description:** The `dt-review` tool (which processes PR reviews into structured markdown) lives in dev-toolkit, not dev-infra.

**Why this is relevant:**
- `dt-review` is a workflow tool that produces documentation
- It uses patterns/formats defined elsewhere
- It lives in dev-toolkit alongside other `dt-*` commands

**Pattern established:**
```
Pattern/Format Definition  → dev-infra (templates)
Tool that uses Pattern     → dev-toolkit (scripts)
```

**Applying to doc generation:**
```
Doc templates              → dev-infra/scripts/doc-gen/templates/
gen-doc.sh, validate.sh    → dev-toolkit/bin/dt-doc-gen, dt-doc-validate
```

**Source:** `admin/research/ci-cd-workflow-improvements/pr-feedback-automation.md`, Four-arm exploration

**Relevance:** Clear precedent for where workflow tooling belongs.

---

### Finding 4: dev-toolkit Has Mature Installation Infrastructure

**Description:** dev-toolkit already has:
- `install.sh` for global installation
- `dt-*` command naming pattern
- Config directory management (`~/.dev-toolkit`)
- Dependency checking
- Help documentation

**Current commands:** `dt-config`, `dt-git-safety`, `dt-install-hooks`, `dt-review`, `dt-setup-sourcery`, `dt-sourcery-parse`

**Source:** `admin/research/four-arm-architecture/research-command-distribution-ownership.md`

**Relevance:** Adding doc generation tooling (`dt-doc-gen`, `dt-doc-validate`) would fit naturally into dev-toolkit's existing infrastructure.

---

### Finding 5: Versioning Implications

**Description:** Separating templates from tooling affects versioning semantics:

| Change Type | Where | Version Bump |
|-------------|-------|--------------|
| New doc template | dev-infra | Minor (template structure) |
| New section in template | dev-infra | Patch |
| New gen-doc feature | dev-toolkit | Minor |
| Bug fix in validation | dev-toolkit | Patch |
| Model selection logic | dev-toolkit | Minor |

**Benefits of separation:**
1. Template structure changes don't require tooling releases
2. Tooling bug fixes don't require template version bumps
3. Clear changelog ownership
4. Independent release cadence

**Source:** Analysis of versioning patterns across four-arm architecture

**Relevance:** Separation enables cleaner versioning and release management.

---

### Finding 6: Placement Option Analysis

**Option A: dev-infra (Templates + Tooling)**

| Pros | Cons |
|------|------|
| Single source | Violates "Template Factory" identity |
| Simpler dependency | Conflates templates with tooling |
| - | Templates + scripts in same release |

**Verdict:** ❌ Violates ADR-001 (Project Identity)

---

**Option B: dev-toolkit (Tooling Only)**

| Pros | Cons |
|------|------|
| Follows precedent (dt-review) | Templates must be fetched |
| Fits existing dt-* pattern | Cross-repo dependency |
| Independent versioning | - |
| Mature install infrastructure | - |

**Verdict:** ✅ **Recommended** - Aligns with all ADRs and precedents

---

**Option C: New Repository (workflow-tools)**

| Pros | Cons |
|------|------|
| Clean separation | Yet another repo |
| Independent evolution | Fragments ecosystem |
| - | No existing infrastructure |

**Verdict:** ❌ Unnecessary complexity

---

**Option D: proj-cli (Project Management)**

| Pros | Cons |
|------|------|
| Python ecosystem | Different language (Python vs Bash) |
| Rich CLI library | proj-cli is for project lifecycle |
| - | Not a good fit conceptually |

**Verdict:** ❌ Wrong domain (project lifecycle ≠ doc workflow)

---

## 🔍 Analysis

**Key Insights:**

- [x] **Insight 1:** ADR-001 (Project Identity) explicitly excludes workflow tooling from dev-infra's scope
- [x] **Insight 2:** ADR-001 (Command Distribution) established the source/distribution separation pattern
- [x] **Insight 3:** dt-review is a clear precedent for workflow tooling in dev-toolkit
- [x] **Insight 4:** dev-toolkit has mature infrastructure (install.sh, dt-* pattern)
- [x] **Insight 5:** Separation enables independent versioning of templates vs tooling

**Placement Decision:**

```
┌─────────────────────────────────────────────────────────────────┐
│                         dev-infra                                │
│                   (Template Factory - SOURCE)                    │
│                                                                  │
│  scripts/doc-gen/templates/                                      │
│  ├── exploration/                                                │
│  │   ├── README.md.tmpl                                         │
│  │   ├── exploration.md.tmpl                                    │
│  │   └── research-topics.md.tmpl                                │
│  ├── research/                                                   │
│  │   └── ...                                                    │
│  └── ...                                                        │
│                                                                  │
│  (Templates ONLY - no tooling scripts)                          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Fetch templates
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        dev-toolkit                               │
│                   (Developer CLI - TOOLING)                      │
│                                                                  │
│  bin/                                                            │
│  ├── dt-doc-gen          # Generate docs from templates          │
│  ├── dt-doc-validate     # Validate doc structure                │
│  ├── dt-cursor-run       # Invoke Cursor with model selection    │
│  └── lib/                                                        │
│      ├── doc-common.sh   # Shared functions                      │
│      ├── doc-render.sh   # Template rendering                    │
│      └── doc-context.sh  # Context gathering                     │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 💡 Recommendations

- [x] **R1:** Place doc templates in dev-infra (`scripts/doc-gen/templates/`)
- [x] **R2:** Place tooling scripts in dev-toolkit (`bin/dt-doc-gen`, `bin/dt-doc-validate`)
- [x] **R3:** Follow existing dt-* naming pattern for consistency
- [x] **R4:** Tooling fetches templates from dev-infra releases (like dt-cursor-install)
- [x] **R5:** Version templates and tooling independently
- [x] **R6:** Document the separation in both repos

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-15:** Doc templates must be stored in dev-infra (`scripts/doc-gen/templates/`)
- **FR-16:** Doc generation tooling must be in dev-toolkit (`bin/dt-doc-gen`)
- **FR-17:** Tooling must fetch templates from dev-infra releases or local clone
- **FR-18:** Tooling must follow dt-* naming convention

### Non-Functional Requirements

- **NFR-9:** Template and tooling versions should be independent
- **NFR-10:** Tooling should work with template versions from dev-infra releases

### Constraints

- **C-8:** Tooling must not duplicate templates (fetch from source)
- **C-9:** dev-infra must not contain workflow orchestration scripts

---

## 🚀 Next Steps

1. Create ADR documenting placement decision
2. Update requirements.md with new requirements
3. Update research summary with findings
4. Plan implementation phases (dev-infra templates, dev-toolkit tooling)

---

**Last Updated:** 2026-01-13
