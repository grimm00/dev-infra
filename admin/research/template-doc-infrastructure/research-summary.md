# Research Summary - Template Doc Infrastructure

**Purpose:** Summary of all research findings  
**Status:** 🟡 In Progress  
**Created:** 2026-01-13  
**Last Updated:** 2026-01-13

---

## 📋 Research Overview

Research for template-based documentation infrastructure that ensures consistent doc structure across all workflows.

**Research Topics:** 5 topics  
**Completed:** 2 high-priority topics  
**Status:** 🟡 In Progress (Topics 1-2 complete)

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

## 💡 Key Insights

- [x] **Insight 1:** Current AI-inline generation causes format drift that breaks automation
- [x] **Insight 2:** Hub-and-spoke is the universal documentation organization pattern
- [x] **Insight 3:** Two-mode generation (scaffolding + expansion) is emerging as standard
- [x] **Insight 4:** Simple sed-based templates are sufficient; avoid external dependencies
- [x] **Insight 5:** Validation is as important as generation - catches drift before problems

---

## 📋 Requirements Summary

**Total Requirements Discovered:** 14 FRs, 8 NFRs, 6 Constraints

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

---

## 📊 Research Status

| Topic | Priority | Status | Key Finding |
|-------|----------|--------|-------------|
| Template Inventory & Structure | 🔴 High | ✅ Complete | 17 doc types, 5 common patterns |
| Generation Script Architecture | 🔴 High | ✅ Complete | Shared library + template files |
| Validation Approach | 🟡 Medium | 🔴 Not Started | - |
| Command Integration | 🟡 Medium | 🔴 Not Started | - |
| Template Format | 🟢 Low | 🔴 Not Started | - |

---

## 🚀 Next Steps

1. ✅ ~~Complete high-priority research (Topics 1-2)~~
2. Complete remaining research topics (3-5) if needed
3. Review requirements in `requirements.md`
4. Use `/decision template-doc-infrastructure --from-research` to make decisions
5. Create ADRs for template architecture and generation approach

---

**Last Updated:** 2026-01-13
