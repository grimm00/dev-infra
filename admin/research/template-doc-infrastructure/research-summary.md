# Research Summary - Template Doc Infrastructure

**Purpose:** Summary of all research findings  
**Status:** 🟡 In Progress  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 📋 Research Overview

Research for template-based documentation infrastructure that ensures consistent doc structure across all workflows. **Strategic insight:** This evolved into a broader **workflow orchestration architecture** where scripts handle structure + context gathering and AI handles creative content only.

**Research Topics:** 7 topics (5 original + 2 strategic)  
**Completed:** 6 topics (3 high-priority + 3 medium)  
**Status:** 🟡 Near Complete (Topics 1, 2, 3, 4, 6, 7 complete; Topic 5 optional)

---

## 🔍 Key Findings

### Finding 1: 17 Doc Types Need Templates

Research identified 17 distinct document types across 6 workflows:

| Category | Count | Examples |
|----------|-------|----------|
| Hub Templates | 4 | README.md variants for exploration, research, decision, feature |
| Exploration | 2 | exploration.md, research-topics.md |
| Research | 3 | research-[topic].md, research-summary.md, requirements.md |
| Decision | 3 | adr-NNN.md, decisions-summary.md, transition-plan.md |
| Planning | 3 | feature-plan.md, phase-N.md, status-and-next-steps.md |
| Other | 2 | handoff.md, fix-review-report.md |

**Source:** [research-template-inventory.md](research-template-inventory.md)

---

### Finding 2: Five Common Patterns to Standardize

All docs share five structural patterns:

1. **Status Header Block** - `**Status:** 🔴 | **Created:** | **Last Updated:**`
2. **Quick Links Section** - Hub navigation with emoji markers
3. **Status Tables** - Progress tracking with priority/status columns
4. **Next Steps Section** - Actionable next actions
5. **Related Links Section** - Cross-references to related docs

**Source:** [research-template-inventory.md](research-template-inventory.md)

---

### Finding 3: Shared Library Architecture Recommended

For generation scripts, analysis recommends:

```
scripts/doc-gen/
├── lib/
│   ├── common.sh         # Shared utilities
│   ├── render.sh         # Template rendering
│   └── validate.sh       # Validation functions
├── templates/            # Template files by workflow
├── gen-doc.sh            # Unified entry point
└── validate-doc.sh       # Validation entry point
```

**Key decision:** Templates as separate files + sed-based variable expansion

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

---

### Finding 4: Hybrid Command Integration

Recommended approach for Cursor command integration:

1. **Scripts generate** base scaffolding with correct structure
2. **AI customizes** content within the generated structure
3. **Validation scripts** ensure output compliance

This balances consistency (scripts) with flexibility (AI customization).

**Source:** [research-generation-architecture.md](research-generation-architecture.md)

---

### Finding 5: Scripts as Orchestration Layer ⭐ STRATEGIC

**From strategic discussion:** The hybrid pattern extends beyond doc generation to **full workflow orchestration**:

```
Scripts (0 tokens)              AI (targeted tokens)
├── Context gathering           ├── Analysis
├── Structure generation        ├── Insights  
├── Model selection             ├── Connections
├── Cursor CLI invocation       ├── Recommendations
├── Validation                  └── Content fill
└── Side effects (commits)
```

**Token Efficiency:**
- **Output tokens:** Scripts generate structure (0 AI tokens), AI fills placeholders (~40-60% savings)
- **Input tokens:** Scripts gather context into manifests, AI reads less (~80-90% savings on discovery)
- **Estimated total savings:** ~50-60%

**Source:** Strategic discussion (exploration.md Themes 5-7)

---

### Finding 6: Model Selection by Task Type ⭐ STRATEGIC

Different cognitive tasks benefit from different AI models:

| Task Type | Model | Reasoning |
|-----------|-------|-----------|
| explore, research, decision | claude-opus-4 | Deep thinking, analysis |
| naming, creative | gemini-2.5-pro | Divergent creativity |
| pr, post-pr, release-prep | claude-sonnet-4 | Structured, routine |
| task-phase, implement | composer-1 | Code implementation |

Scripts can select optimal model based on task type, optimizing both cost and quality.

**Source:** Strategic discussion (exploration.md Theme 6)

---

### Finding 7: Four-Arm Placement Decision ⭐ STRATEGIC ✅

Research confirms: **Templates in dev-infra, tooling in dev-toolkit**.

| Component | Location | Rationale |
|-----------|----------|-----------|
| Doc templates | dev-infra | Template Factory identity (ADR-001) |
| gen-doc, validate scripts | dev-toolkit | Follows dt-review precedent |
| Context gathering | dev-toolkit | Tooling that uses templates |
| Model selection | dev-toolkit | Orchestration logic |

**Key precedents:**
- ADR-001 (Project Identity): "Internal tooling stays internal"
- ADR-001 (Command Distribution): Source owner ≠ distribution owner
- dt-review: Workflow tool in dev-toolkit, not dev-infra

**Source:** [research-architectural-placement.md](research-architectural-placement.md) ✅ Complete

---

### Finding 8: Layered Validation Architecture ✅

Validation uses three layers with on-demand CLI as primary interface:

| Layer | Component | Role |
|-------|-----------|------|
| 1. Library | `lib/validate.sh` | Reusable validation functions |
| 2. CLI | `dt-doc-validate` | Primary interface (developers, CI) |
| 3. Commands | Cursor commands | Call CLI during workflow |

**Validation timing:**
- **On-demand CLI** (primary): Developer invokes when ready
- **In-command** (secondary): Commands call CLI before commit
- **Pre-commit** (optional): User-configurable enhancement
- **CI** (enforcement): GitHub Action on PR

**Source:** [research-validation-approach.md](research-validation-approach.md) ✅ Complete

---

### Finding 9: Command Integration Pattern ✅

Commands have 154 inline template instances across 23 commands. Migration to external templates:

| Phase | Action | Risk |
|-------|--------|------|
| 1. Extract | Create external templates | None (no command changes) |
| 2. Integrate | Commands call scripts | Low (fallback to inline) |
| 3. Cleanup | Remove inline templates | Low (after validation) |

**Integration pattern:**

```
Command → dt-doc-gen → Structure
       → AI        → Content (fill placeholders)
       → dt-doc-validate → Check compliance
       → git commit
```

**Placeholder types:**
- `{{VAR}}` - Script replaces (DATE, TOPIC)
- `<!-- AI: instruction -->` - AI fills content
- `<!-- EXPAND: scope -->` - AI expands in Conduct mode

**Source:** [research-command-integration.md](research-command-integration.md) ✅ Complete

---

### Finding 10: Cursor CLI is File-Open Only ✅

Cursor CLI cannot programmatically invoke AI agents:

| Capability | Available | Notes |
|------------|-----------|-------|
| Open project/file | ✅ Yes | `cursor /path/to/project` |
| Agent invocation | ❌ No | No `--prompt` flag |
| Model selection | ❌ No | No `--model` flag |
| Context passing | ❌ No | No `--context` flag |

**Alternative tools available:**
- **Aider:** `--model` flag, `--files` for context
- **LLM CLI:** Pipe context, `-m model` selection
- **Claude API:** Full programmatic control

**Recommendation:** Config-based model selection now, programmatic invocation as future enhancement.

**Source:** [research-cursor-cli-model-selection.md](research-cursor-cli-model-selection.md) ✅ Complete

---

## 💡 Key Insights

- [x] **Insight 1:** Current AI-inline generation causes format drift that breaks automation
- [x] **Insight 2:** Hub-and-spoke is the universal documentation organization pattern
- [x] **Insight 3:** Two-mode generation (scaffolding + expansion) is emerging as standard
- [x] **Insight 4:** Simple sed-based templates are sufficient; avoid external dependencies
- [x] **Insight 5:** Validation is as important as generation - catches drift before problems
- [x] **Insight 6:** Scripts can orchestrate entire workflows, not just generate docs ⭐
- [x] **Insight 7:** Significant token savings (~50-60%) from hybrid architecture ⭐
- [x] **Insight 8:** Model selection by task type optimizes cost and quality ⭐
- [x] **Insight 9:** "Full generation" docs MUST still have script-generated structure - AI only fills content ⭐
- [x] **Insight 10:** On-demand CLI is primary validation interface; pre-commit is optional ⭐
- [x] **Insight 11:** 154 inline templates across 23 commands confirms duplication problem ⭐
- [x] **Insight 12:** Commands remain orchestrators; scripts are tools they invoke ⭐
- [x] **Insight 13:** Cursor CLI is file-open only - no programmatic agent API exists ⭐
- [x] **Insight 14:** Model selection is enhancement, not blocker - implement incrementally ⭐

---

## 🏗️ Implementation Scope Boundaries

Research confirmed multi-repository architecture. Work must be dispersed:

| Repository | Scope | Priority |
|------------|-------|----------|
| **dev-infra** (this feature) | Doc templates (17 types), format spec, validation rules spec | 🔴 High |
| **dev-toolkit** (separate) | `dt-doc-gen`, `dt-doc-validate`, `lib/*.sh`, template fetching | 🔴 High |
| **dev-toolkit** (separate) | Cursor CLI wrapper, model selection | 🟡 Medium |

**Note:** ADRs from `/decision` phase will formalize this split.

---

## 📋 Requirements Summary

**Total Requirements Discovered:** 33 FRs, 16 NFRs, 16 Constraints, 4 Assumptions

### High-Priority Requirements

| ID | Requirement | Source |
|----|-------------|--------|
| FR-1 | Templates for all 17 doc types | Topic 1 |
| FR-2 | Required sections with placeholder markers | Topic 1 |
| FR-8 | Scaffolding and full generation modes | Topic 2 |
| FR-11 | Validation for required sections per type | Topic 2 |
| NFR-1 | Template structure parseable for validation | Topic 1 |
| NFR-5 | Standard bash (no exotic dependencies) | Topic 2 |

**See:** [requirements.md](requirements.md) for complete requirements document

---

## 🎯 Recommendations

### Template Infrastructure

1. **Create 17 template files** organized by workflow category
2. **Standardize five common patterns** with exact formatting
3. **Use placeholder comments** (`<!-- PLACEHOLDER: ... -->`) for human input

### Generation Scripts

4. **Shared library architecture** with template files
5. **sed-based variable expansion** (simple, no dependencies)
6. **Unified entry point** (`gen-doc.sh`) with subcommand interface

### Validation

7. **Separate validation scripts** from generation (single responsibility)
8. **Clear error messages** that help fix issues
9. **Exit codes** for CI integration

### Strategic (New)

10. **Decide architectural placement** before implementation (four-arm question)
11. **Design context gathering** scripts for token efficiency
12. **Explore Cursor CLI** capabilities for programmatic invocation
13. **Configure model selection** by task type

---

## 📊 Research Status

| Topic | Priority | Status | Key Finding |
|-------|----------|--------|-------------|
| Template Inventory & Structure | 🔴 High | ✅ Complete | 17 doc types, 5 common patterns |
| Generation Script Architecture | 🔴 High | ✅ Complete | Shared library + template files |
| Architectural Placement (Four-Arm) | 🔴 High | ✅ Complete | Templates in dev-infra, tooling in dev-toolkit |
| Validation Approach | 🟡 Medium | ✅ Complete | Layered validation, on-demand CLI primary |
| Command Integration | 🟡 Medium | ✅ Complete | 154 inline templates, incremental migration |
| Cursor CLI & Model Selection | 🟡 Medium | ✅ Complete | No CLI API; config-based model selection |
| Template Format | 🟢 Low | 🔴 Scaffolding | Optional - can defer |

---

## 🚀 Next Steps

1. ✅ ~~Complete high-priority research (Topics 1-2, 6)~~
2. ✅ ~~Complete validation approach research (Topic 3)~~
3. ✅ ~~Complete command integration research (Topic 4)~~
4. ✅ ~~Complete Cursor CLI & model selection research (Topic 7)~~
5. Use `/decision template-doc-infrastructure --from-research` to make decisions:
   - Template architecture (17 doc types, 5 patterns)
   - Generation script architecture (shared library)
   - Architectural placement (four-arm question)
   - Validation architecture
   - Command integration pattern
   - Model selection configuration
6. Create ADRs for each decision
7. Template Format (Topic 5) is optional - can defer to implementation

---

**Last Updated:** 2026-01-14
