# Requirements - Template Doc Infrastructure

**Source:** Research on template-doc-infrastructure  
**Status:** Draft  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 📋 Overview

This document captures requirements discovered during research on template-based documentation infrastructure.

**Research Source:** [research-summary.md](research-summary.md)

---

## ✅ Functional Requirements

### FR-1: Template Coverage

**Description:** System must provide templates for all 17 identified doc types across 6 workflows (exploration, research, decision, planning, fix, handoff).

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-2: Required Section Markers

**Description:** Templates must include all required sections with placeholder markers indicating where human/AI input is needed.

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-3: Consistent Status Header

**Description:** Templates must use consistent status header format: `**Status:** [indicator] | **Created:** YYYY-MM-DD | **Last Updated:** YYYY-MM-DD`

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-4: Hub Quick Links

**Description:** Hub templates (README.md variants) must include Quick Links section with standardized format and emoji markers.

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-5: Two-Mode Support

**Description:** Templates must support two-mode generation: scaffolding mode (~60-80 lines) and full/expanded mode (~200-300 lines).

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-6: Consistent Indicators

**Description:** Templates must use consistent priority indicators (🔴 High, 🟡 Medium, 🟢 Low) and status indicators (🔴 Not Started, 🟠 In Progress, ✅ Complete).

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-7: Workflow Hub Templates

**Description:** Each workflow must have a hub template (README.md variant) for navigation and status tracking.

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-8: Generation Modes

**Description:** Generation scripts must support multiple modes:
- **Scaffolding mode:** Structure with empty placeholders (AI/human fills later)
- **Partial fill mode:** Structure with some placeholders pre-filled
- **Full fill mode:** Complete structure with all placeholders for AI to fill

**CRITICAL:** Even "full generation" docs (ADRs, transition plans, handoff) MUST have script-generated structure. "Full generation" means "script generates full structure, AI fills all content" - NOT "AI generates everything."

**Source:** [research-generation-architecture.md](research-generation-architecture.md), [research-template-inventory.md](research-template-inventory.md) (Finding 6 - Hybrid Architecture Insight)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-9: External Templates

**Description:** Templates must be stored as separate files in `scripts/doc-gen/templates/[workflow]/`, not embedded in scripts.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-10: Variable Substitution

**Description:** Generation scripts must support variable substitution for common fields (DATE, TOPIC, STATUS).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-11: Type-Specific Validation

**Description:** Validation scripts must check all required sections based on document type (exploration, research, ADR, etc.).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-12: Actionable Error Messages

**Description:** Validation scripts must provide clear, actionable error messages that explain what's wrong and how to fix it.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-13: Dry Run Support

**Description:** Scripts must support `--dry-run` flag to preview output without creating files.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟢 Low

**Status:** 🔴 Pending

---

### FR-14: CI Exit Codes

**Description:** Scripts must return meaningful exit codes (0 = success, non-zero = failure type) for CI integration.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-15: Templates in dev-infra

**Description:** Doc templates must be stored in dev-infra (`scripts/doc-gen/templates/`) as part of the Template Factory identity.

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-16: Tooling in dev-toolkit

**Description:** Doc generation and validation tooling must be in dev-toolkit (`bin/dt-doc-gen`, `bin/dt-doc-validate`) following the dt-* pattern.

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### FR-17: Template Fetching

**Description:** Tooling must be able to fetch templates from dev-infra releases or a local dev-infra clone.

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### FR-18: dt-* Naming Convention

**Description:** Tooling must follow the established dt-* command naming convention (e.g., dt-doc-gen, dt-doc-validate).

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Parseable Structure

**Description:** Template structure must be parseable for automated validation (consistent heading levels, section markers).

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### NFR-2: Line Count Validation

**Description:** Templates should enable line count validation (scaffolding ~60-80, expanded ~200-300).

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🟢 Low

**Status:** 🔴 Pending

---

### NFR-3: Naming Convention

**Description:** Template file naming must follow kebab-case convention matching doc type names.

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🟢 Low

**Status:** 🔴 Pending

---

### NFR-4: Self-Documenting

**Description:** Templates must be self-documenting with comments explaining usage and required customization.

**Source:** [research-template-inventory.md](research-template-inventory.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### NFR-5: Standard Bash

**Description:** Scripts must work with standard bash without exotic dependencies (no jinja2, gomplate, etc.).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🔴 High

**Status:** 🔴 Pending

---

### NFR-6: Fast Rendering

**Description:** Template rendering must be fast (<1 second per file) to enable interactive use.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### NFR-7: Testable

**Description:** Scripts must be testable with BATS or similar bash testing framework.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### NFR-9: Independent Versioning

**Description:** Template and tooling versions should be independent - template structure changes don't require tooling releases and vice versa.

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

### NFR-10: Template Version Compatibility

**Description:** Tooling should work with template versions from dev-infra releases, supporting a reasonable range of versions.

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

**Priority:** 🟢 Low

**Status:** 🔴 Pending

---

### NFR-8: Non-Interactive CI

**Description:** Scripts must work in non-interactive CI environments (detect CI, skip prompts).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

**Priority:** 🟡 Medium

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Pure Markdown

**Description:** Templates must remain pure markdown without custom syntax or extensions.

**Source:** [research-template-inventory.md](research-template-inventory.md)

---

### C-2: Command Compatibility

**Description:** Templates must work with existing Cursor command structures and expectations.

**Source:** [research-template-inventory.md](research-template-inventory.md)

---

### C-3: Guidance Not Limits

**Description:** Line counts are guidance, not hard limits - validation should warn, not block.

**Source:** [research-template-inventory.md](research-template-inventory.md)

---

### C-4: No External Dependencies

**Description:** Scripts must not require dependencies beyond coreutils (sed, awk, grep, bash).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

---

### C-5: Cross-Platform

**Description:** Scripts must work on both macOS and Linux (POSIX-compatible shell).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

---

### C-6: Human-Readable Templates

**Description:** Template files must remain human-readable and editable without special tooling.

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

---

### C-7: Scripts Generate Structure, AI Fills Content (Hybrid Architecture)

**Description:** AI must NEVER generate document structure - only fill in content within script-generated structure. This applies to ALL doc types, including "full generation" docs like ADRs, transition plans, and handoff docs.

**Rationale:**
1. **Consistency:** Script-generated structure is guaranteed correct (0 format drift)
2. **Token efficiency:** Structure generation costs 0 AI tokens
3. **Validation:** Structure can be validated independently of content
4. **Predictability:** Output structure is deterministic

**Source:** [research-template-inventory.md](research-template-inventory.md) (Finding 6 - Hybrid Architecture Insight), Strategic discussion

---

### C-8: No Template Duplication

**Description:** Tooling must not duplicate templates - always fetch from dev-infra source (releases or local clone).

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

---

### C-9: dev-infra No Orchestration Scripts

**Description:** dev-infra must not contain workflow orchestration scripts - only templates. Tooling belongs in dev-toolkit.

**Source:** [research-architectural-placement.md](research-architectural-placement.md)

---

## 💭 Assumptions

### A-1: Cursor Environment

**Description:** Primary usage is within Cursor IDE where AI can execute shell commands.

**Source:** Research context

---

### A-2: Developer Audience

**Description:** Template users are developers familiar with markdown and shell commands.

**Source:** Research context

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Exploration](../../explorations/template-doc-infrastructure/README.md)
- [Topic 1: Template Inventory](research-template-inventory.md)
- [Topic 2: Generation Architecture](research-generation-architecture.md)

---

## 🚀 Next Steps

1. Review and prioritize requirements
2. Use `/decision template-doc-infrastructure --from-research` to make architectural decisions
3. Decisions may refine or add requirements

---

**Last Updated:** 2026-01-13
