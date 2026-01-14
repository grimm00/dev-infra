# Research Summary - Template Doc Infrastructure

**Purpose:** Summary of all research findings  
**Status:** 🟡 In Progress  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 📋 Research Overview

Research for template-based documentation infrastructure that ensures consistent doc structure across all workflows. **Strategic insight:** This evolved into a broader **workflow orchestration architecture** where scripts handle structure + context gathering and AI handles creative content only.

**Research Topics:** 7 topics (5 original + 2 strategic)  
**Completed:** 2 high-priority topics (foundational)  
**Status:** 🟡 In Progress (Topics 1-2 complete, ready for decision phase)

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

### Finding 7: Four-Arm Placement Question ⭐ STRATEGIC

This tooling should **NOT** live in dev-infra (template factory identity per ADR-001). Options:

| Location | Pros | Cons |
|----------|------|------|
| dev-toolkit | Existing tooling home | May be too general |
| proj-cli | Project-specific focus | May be too narrow |
| New repo | Clean separation | Yet another repo |

**Needs Decision:** Architectural placement should be decided before implementation.

**Source:** Strategic discussion (exploration.md Theme 7)

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

---

## 📋 Requirements Summary

**Total Requirements Discovered:** 14 FRs, 8 NFRs, 7 Constraints

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
| Architectural Placement (Four-Arm) | 🔴 High | 🔴 Not Started | Decision phase |
| Validation Approach | 🟡 Medium | 🔴 Not Started | - |
| Command Integration | 🟡 Medium | 🔴 Not Started | - |
| Cursor CLI & Model Selection | 🟡 Medium | 🔴 Not Started | - |
| Template Format | 🟢 Low | 🔴 Not Started | - |

---

## 🚀 Next Steps

1. ✅ ~~Complete high-priority research (Topics 1-2)~~
2. Use `/decision template-doc-infrastructure --from-research` to make decisions:
   - Template architecture (17 doc types, 5 patterns)
   - Generation script architecture (shared library)
   - **Architectural placement (four-arm question)** ⭐
   - Model selection strategy
3. Create ADRs for each decision
4. Complete remaining research topics (3-5, 7) during implementation if needed

---

**Last Updated:** 2026-01-13
