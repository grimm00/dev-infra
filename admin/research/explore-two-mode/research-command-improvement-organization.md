# Research: Command Improvement Organization

**Research Topic:** Explore Two-Mode Enhancement  
**Question:** Should command improvement features be consolidated, and what directory structure is appropriate?  
**Status:** ✅ Complete  
**Priority:** 🔴 High  
**Created:** 2025-12-30  
**Last Updated:** 2025-12-30  
**Completed:** 2025-12-30

---

## 🎯 Research Question

Should command improvement features be consolidated, and what directory structure is appropriate?

**Context:** Currently have 4 separate `*-two-mode` features:
- `transition-plan-two-mode` (✅ Complete)
- `explore-two-mode` (🟡 Planned)
- `decision-two-mode` (🟡 Planned)
- `reflect-two-mode` (🔴 Needs Evaluation)

Consolidation could reduce duplication and improve discoverability.

---

## 🔍 Research Goals

- [x] Goal 1: Determine if command improvements are "features" or "internal tooling"
- [x] Goal 2: Evaluate directory structure options (`features/`, `ci/`, `commands/improvements/`)
- [x] Goal 3: Assess impact on completed transition-plan-two-mode
- [x] Goal 4: Recommend approach for existing scattered feature directories

---

## 📚 Research Methodology

**Sources:**
- [x] Current feature directory structure analysis
- [x] CI directory structure analysis
- [x] Transition-plan-two-mode implementation review
- [x] ADR-001: Project Identity - Template Factory Focus
- [x] Commands directory analysis (`admin/planning/commands/`)

---

## 📊 Findings

### Finding 1: ADR-001 Establishes "Template Factory" Identity

Dev-infra's primary identity is **"Template Factory"** per ADR-001. This has clear implications:

- **Templates are products** - Commands are part of the template product
- **Internal tooling stays internal** - Release automation, validation scripts are dev-infra-only
- **Features must graduate** - Improvements that benefit templates are features

**Source:** `admin/decisions/dev-infra-identity-and-focus/adr-001-project-identity.md`

**Relevance:** Command improvements that affect template users ARE features, not internal tooling. The `*-two-mode` enhancements improve commands that ship in templates, making them **template features**.

---

### Finding 2: Three Distinct Planning Categories Already Exist

Current structure analysis reveals three distinct categories:

| Category | Location | Purpose | Count |
|----------|----------|---------|-------|
| **Features** | `admin/planning/features/` | Template product improvements | 13 directories |
| **CI** | `admin/planning/ci/` | Infrastructure/workflow improvements | 16 directories |
| **Commands** | `admin/planning/commands/` | Command **integration** from work-prod | 3 phases |

**Source:** Directory structure analysis

**Relevance:** The `commands/` directory is specifically for **command integration** (bringing work-prod commands to dev-infra), NOT for **command enhancement**. This distinction is important.

---

### Finding 3: CI Directory Has Classification Guidelines

The CI hub already has fix vs improvement classification:

| Classification | Criteria | Structure |
|----------------|----------|-----------|
| **Fix** | < 1 hour, single PR, resolves bug | Single file or bundled |
| **Improvement** | > 1 hour, new capability, multi-PR | Full hub directory |

**Source:** `admin/planning/ci/README.md`

**Relevance:** Command two-mode patterns are clearly **improvements** (> 1 hour, new capability, multi-phase). They don't fit CI because they're not infrastructure—they're product features.

---

### Finding 4: Current Feature Directory Has Command-Related Work

Feature directory already contains multiple command-related features:

| Feature | Type | Status |
|---------|------|--------|
| `command-adaptation-template` | Command docs | ✅ Complete |
| `command-simplification` | Command process | ✅ Complete |
| `command-testing-integration` | Command testing | ✅ Complete |
| `transition-plan-two-mode` | Command enhancement | ✅ Complete |
| `explore-two-mode` | Command enhancement | 🟡 Planned |
| `decision-two-mode` | Command enhancement | 🟡 Planned |
| `reflect-two-mode` | Command enhancement | 🔴 Needs Eval |

**Source:** `admin/planning/features/` directory listing

**Relevance:** There's already a pattern of command work in `features/`. The `*-two-mode` features follow this established pattern.

---

### Finding 5: Transition-Plan Two-Mode Successfully Used Features Structure

The completed `transition-plan-two-mode` feature demonstrates the features structure works well:

- 4 phases completed
- Hub-and-spoke pattern with fix tracking
- 3 related ADRs in `decisions/transition-plan-two-mode/`
- Learnings captured in `opportunities/internal/`

**Source:** `admin/planning/features/transition-plan-two-mode/README.md`

**Relevance:** The existing approach works. Consolidation should preserve what works while reducing duplication.

---

## 🔍 Analysis

### Question 1: Features vs Internal Tooling?

**Answer: Command improvements are FEATURES.**

Reasoning:
- Commands ship in templates → affect template users
- Per ADR-001: templates are products, internal tooling stays internal
- Command enhancements improve the product
- They follow the same pattern as other template features

### Question 2: Best Directory Structure?

**Evaluated Options:**

| Option | Pros | Cons | Verdict |
|--------|------|------|---------|
| **A) Keep in features/** | Established pattern, works | Scattered across 4+ directories | ⚠️ Current state |
| **B) Move to ci/** | Groups improvements | Wrong category (not infra) | ❌ Reject |
| **C) Move to commands/** | Groups command work | Conflicts with integration purpose | ❌ Reject |
| **D) Consolidate in features/command-two-mode-pattern/** | Groups related work, preserves features | Migration effort needed | ✅ **Recommended** |
| **E) Create features/command-improvements/** | Broader umbrella | May be too generic | 🤔 Alternative |

### Question 3: Impact on Completed Work?

**Minimal impact with proper approach:**
- `transition-plan-two-mode` remains in `features/` (already complete)
- New work goes in consolidated location
- Cross-references link related work
- ADRs and research remain in topic-specific directories

### Question 4: Handling Existing Directories?

**Recommended approach:**
1. **Keep completed work where it is** - `transition-plan-two-mode` stays
2. **Consolidate future work** - New `*-two-mode` features go in consolidated location
3. **Cross-reference** - Link related features in README files
4. **Consider archive** - Archive placeholder features that haven't started (`reflect-two-mode`, `decision-two-mode`)

---

## 💡 Key Insights

- [x] Insight 1: **Command improvements are template features** - Per ADR-001 Template Factory identity, commands are products
- [x] Insight 2: **Commands directory is for integration, not enhancement** - `admin/planning/commands/` tracks work-prod → dev-infra integration
- [x] Insight 3: **Current features structure works** - `transition-plan-two-mode` success validates the approach
- [x] Insight 4: **Consolidation reduces duplication** - 4 similar features would benefit from shared planning structure
- [x] Insight 5: **CI is wrong category** - CI is for infrastructure, not product features

---

## 💡 Recommendations

- [x] Recommendation 1: **Keep command improvements in `features/`** - They're template features per ADR-001
- [x] Recommendation 2: **Create consolidated hub** - `features/command-two-mode-pattern/` to group related work
- [x] Recommendation 3: **Preserve completed work** - Keep `transition-plan-two-mode` where it is, reference from consolidated hub
- [x] Recommendation 4: **Archive placeholder features** - Archive `reflect-two-mode` and `decision-two-mode` features (minimal content)
- [x] Recommendation 5: **Track pattern learnings** - Create shared learnings document for two-mode pattern across commands

---

## 📋 Requirements Discovered

- [x] FR-ORG-1: Command improvements MUST be tracked as features (not CI)
- [x] FR-ORG-2: Consolidated hub SHOULD reference related completed features
- [x] FR-ORG-3: Placeholder features with minimal content MAY be archived when consolidated
- [x] NFR-ORG-1: Directory structure MUST align with ADR-001 Template Factory identity
- [x] NFR-ORG-2: Consolidation SHOULD NOT require moving completed work with extensive history

---

## 🚀 Next Steps

1. ✅ Research complete
2. Create ADR for organization decision (if needed)
3. Continue with Topic 2 (Topic Unification Pattern)
4. Implementation: Create consolidated hub when ready

---

**Last Updated:** 2025-12-30
