# Research Topics - Template Doc Infrastructure

**Status:** ✅ Expanded (Updated with Strategic Topics)  
**Created:** 2026-01-13  
**Expanded:** 2026-01-13  
**Updated:** 2026-01-13

---

## 📋 Research Topics

### Topic 1: Template Inventory & Structure

**Question:** What document types need templates and what structure should each have?

**Context:** Before designing templates, we need a complete inventory of all doc types used across workflows. Each workflow (`/explore`, `/research`, `/decision`, `/handoff`, `/task-phase`, `/fix`) has specific document needs. Missing a doc type means that type continues with inconsistent ad-hoc generation. Understanding the required structure for each enables proper template design.

**Priority:** 🔴 High

**Rationale:** This is foundational - all other topics depend on knowing what docs exist and what structure they need. Without this inventory, we can't design generation or validation.

**Suggested Approach:**
- Audit `admin/explorations/`, `admin/research/`, `admin/decisions/`, `admin/planning/` directories
- Catalog existing doc types and their structures
- Identify common patterns (status headers, quick links, sections)
- Document required vs optional sections for each type
- Create template specification for each doc type

---

### Topic 2: Generation Script Architecture

**Question:** How should doc generation scripts be structured (standalone, library, command integration)?

**Context:** Scripts need to generate docs from templates with variable expansion. Architecture options include standalone scripts per doc type, a shared library with functions, or deep integration with Cursor commands. The choice affects maintainability, reusability, and how commands invoke generation. Reference implementations exist: `dt-review` is standalone, `release-readiness` uses function libraries.

**Priority:** 🔴 High

**Rationale:** Architecture decisions have long-term implications. Getting this right enables clean integration with all commands. Getting it wrong creates technical debt.

**Suggested Approach:**
- Review `dt-review` and `release-readiness` script patterns
- Analyze pros/cons of standalone vs library vs integrated
- Prototype small generation script for one doc type
- Evaluate integration points with Cursor commands
- Design extensible architecture for future doc types

---

### Topic 3: Validation Approach

**Question:** How should doc validation work (CLI, pre-commit, command checks)?

**Context:** Validation ensures docs match expected structure before they're used by commands. Options range from on-demand CLI validation to automatic pre-commit hooks to validation within commands. Each has tradeoffs: CLI is explicit but requires manual invocation, pre-commit catches issues early but adds friction, in-command validation is automatic but may be late in the workflow.

**Priority:** 🟡 Medium

**Rationale:** Important for catching issues, but generation (Topic 2) should come first. Validation is most valuable once we have templates to validate against.

**Suggested Approach:**
- Define validation rules for each doc type (required sections, field formats)
- Review `release-readiness` validation patterns
- Design error message format (actionable, specific)
- Prototype validator for one doc type
- Evaluate pre-commit vs on-demand vs in-command timing
- Consider CI integration for doc quality gates

---

### Topic 4: Command Integration

**Question:** How do templates integrate with existing commands (`/explore`, `/research`, `/handoff`)?

**Context:** Commands currently describe output format inline in their markdown definitions. Integrating templates means commands would invoke generation scripts and rely on templated structure. This requires updating command definitions, designing invocation patterns, and handling AI-generated content within templates.

**Priority:** 🟡 Medium

**Rationale:** Integration is the payoff from Topics 1-3. However, we need templates and generation working first before integrating with commands.

**Suggested Approach:**
- Audit command definitions in `.cursor/commands/`
- Identify doc generation points in each command
- Design invocation pattern (how commands call scripts)
- Define how AI-generated sections work within templates
- Plan migration path for existing command outputs
- Test integration with one command end-to-end

---

### Topic 5: Template Format

**Question:** What format should templates use (markdown with placeholders, bash heredocs, template engine)?

**Context:** Templates need variable expansion (date, topic name, author). Options include simple markdown with placeholders (`{{DATE}}`), bash heredocs in scripts, or a template engine (envsubst, jinja2). Simpler is better for maintenance, but more powerful enables complex generation.

**Priority:** 🟢 Low

**Rationale:** Format is an implementation detail that can be decided during prototyping. The concepts from Topics 1-2 matter more than specific format choice.

**Suggested Approach:**
- Survey template approaches in existing dev-infra scripts
- Evaluate simplicity vs power tradeoffs
- Prototype with simple placeholder replacement
- Consider consistency with existing patterns
- Document chosen format for template authors

---

### Topic 6: Architectural Placement (Four-Arm Question) ⭐ NEW

**Question:** Where should this tooling live in the four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod)?

**Context:** The four-arm architecture separates concerns. Dev-infra is the "template factory" (ADR-001), so workflow tooling should likely live elsewhere. Options include dev-toolkit (general tooling), proj-cli (project management), or a new repo. The placement affects versioning, distribution, and project consumption.

**Priority:** 🔴 High

**Rationale:** Architectural placement should be decided before implementation to avoid restructuring later. This decision impacts versioning semantics and project consumption patterns.

**Suggested Approach:**
- Review four-arm architecture research
- Evaluate fit for each arm (dev-toolkit, proj-cli, new repo)
- Consider distribution mechanism (how projects get tooling)
- Analyze versioning implications
- Consider existing tool locations (where does dt-review live?)

---

### Topic 7: Cursor CLI Programmatic Invocation & Model Selection ⭐ NEW

**Question:** How should scripts invoke Cursor programmatically with model selection based on task type?

**Context:** The hybrid architecture (scripts orchestrate, AI fills creative content) requires programmatic Cursor invocation. Different cognitive tasks benefit from different models (opus for deep thinking, sonnet for routine, composer for code). Scripts need to select models and invoke Cursor with targeted prompts.

**Priority:** 🟡 Medium

**Rationale:** This is the key enabler for the full hybrid architecture. Without programmatic invocation, scripts can only generate structure but can't orchestrate AI work.

**Suggested Approach:**
- Investigate Cursor CLI capabilities for agent invocation
- Determine how to pass context to AI via CLI
- Determine how to select models via CLI flags
- Prototype script → Cursor → output flow
- Design model selection configuration

**Model Mapping (from discussion):**

| Task Type | Model | Reasoning |
|-----------|-------|-----------|
| explore, research, decision | claude-opus-4 | Deep thinking, analysis |
| naming, creative | gemini-2.5-pro | Divergent creativity |
| pr, post-pr, release-prep | claude-sonnet-4 | Structured, routine |
| task-phase, implement | composer-1 | Code implementation |

---

## 📊 Topic Summary

| # | Topic | Priority | Status |
|---|-------|----------|--------|
| 1 | Template Inventory & Structure | 🔴 High | ✅ Complete |
| 2 | Generation Script Architecture | 🔴 High | ✅ Complete |
| 3 | Validation Approach | 🟡 Medium | 🔴 Not Started |
| 4 | Command Integration | 🟡 Medium | 🔴 Not Started |
| 5 | Template Format | 🟢 Low | 🔴 Not Started |
| 6 | Architectural Placement (Four-Arm) | 🔴 High | 🔴 Not Started |
| 7 | Cursor CLI & Model Selection | 🟡 Medium | 🔴 Not Started |

---

## 🎯 Research Workflow

1. ✅ ~~Use `/research template-doc-infrastructure --from-explore template-doc-infrastructure` to start research~~
2. ✅ ~~Research created documents in `admin/research/template-doc-infrastructure/`~~
3. Use `/decision template-doc-infrastructure --from-research` to make decisions

---

## 📝 Research Order Recommendation

**Suggested sequence:**

1. ✅ **Topic 1 (Inventory)** - Foundation for everything else
2. ✅ **Topic 2 (Architecture)** - Design before building
3. **Topic 6 (Placement)** - Where does this live? (decision phase)
4. **Topic 5 (Format)** - Quick decision during prototyping
5. **Topic 3 (Validation)** - After templates exist
6. **Topic 4 (Integration)** - After generation works
7. **Topic 7 (Cursor CLI)** - Research during implementation

Topics 1-2 are complete. Topic 6 should be addressed in decision phase. Topics 3-5 can be researched during implementation. Topic 7 requires experimentation with Cursor CLI.

---

**Last Updated:** 2026-01-13
