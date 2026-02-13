# External Opportunities

**Purpose:** Learnings and improvements from external projects  
**Status:** ✅ Active  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

### External Sources by Project

- **[Work-Prod Opportunities](work-prod/README.md)** - Comprehensive learnings from work-prod project
  - [Code Improvements](work-prod/code-improvements.md) - Phase 1-3 learnings (26h)
  - [Cursor Commands](work-prod/cursor-commands/) - 🔴 CRITICAL: Workflow automation (40h)
  - [Documentation Templates](work-prod/documentation-templates.md) - Process templates (6h)
- **[Helm-Charts Opportunities](helm-charts/lightweight-commands.md)** - Lightweight commands for non-proj-cli projects
  - Success with `/review` + `/commit`, spike commands, and `/reflect --eod` in a repo without scaffolding
- **[Dev-Toolkit Opportunities](dev-toolkit/README.md)** - Spike workflow framework and agentic coding learnings
  - [Spike Workflow Framework](dev-toolkit/spike-workflow-framework.md) - Time-boxed experimentation methodology (HIGH priority)

---

## 🎯 Overview

This directory captures valuable patterns, improvements, and learnings discovered during implementation of external projects. These opportunities inform dev-infra template improvements and best practices.

**Organization:** Opportunities are grouped by source project (e.g., `work-prod/`) to maintain clear lineage and context.

### How External Opportunities Work

1. **Discovery** - Patterns identified during real project implementation
2. **Documentation** - Learnings captured in opportunity documents
3. **Prioritization** - Opportunities assessed by priority, impact, and effort
4. **Application** - High-priority items applied to dev-infra templates
5. **Validation** - Updated templates tested with new projects

---

## 📊 Current Opportunities by Project

### Work-Prod Project

**Source:** `~/Projects/work-prod`  
**Status:** ✅ Active  
**Total Effort:** ~72 hours

**Opportunity Categories:**

- **Code Improvements** - Phase 1-3 learnings (26h, HIGH priority)
- **Cursor Commands** - Workflow automation (40h, CRITICAL priority)
- **Documentation Templates** - Process templates (6h, MEDIUM priority)

**See:** [Work-Prod Opportunities](work-prod/README.md) for complete details

### Helm-Charts Project

**Source:** `~/Projects/work/helm-charts`
**Status:** 🟡 Documented
**Focus:** Lightweight commands for non-proj-cli projects

**Key Finding:** A small set of Cursor commands (review/commit, spike, EOD reflect) proved effective in a shared team Helm chart repo with no `admin/` structure, no phases, and no Sourcery. Informs how dev-infra can guide contributions to projects not created with proj-cli.

**See:** [Helm-Charts Lightweight Commands](helm-charts/lightweight-commands.md) for details

### Dev-Toolkit Project

**Source:** `~/Projects/dev-toolkit` (dt-workflow v1 exploration)  
**Status:** 🟡 Documented  
**Focus:** Spike workflow framework and agentic coding meta-learnings

**Key Findings:**
- **Spike Workflow Framework** - Time-boxed experiments to validate high-risk decisions before research
- **Meta-Learnings** - Discovery problem and ownership problem with agentic coding
- **Two-Tier Documentation** - AI-discoverable vs human-detailed pattern

**See:** [Dev-Toolkit Opportunities](dev-toolkit/README.md) for details

---

## 🔄 Review Process

**After Each External Project Phase:**

- Capture learnings while fresh
- Document patterns that worked well
- Note improvements needed in templates

**Quarterly Review:**

- Prioritize opportunities by impact
- Estimate effort for template updates
- Plan implementation schedule

**Before Template Updates:**

- Consolidate related opportunities
- Create implementation plan
- Test updated templates

---

## 📁 Directory Structure

```
external/
├── README.md                    # 📍 HUB - This file
├── work-prod/                    # Work-prod opportunities
│   ├── README.md                # Work-prod hub
│   ├── code-improvements.md      # Phase 1-3 learnings
│   ├── cursor-commands/         # Cursor commands integration
│   │   ├── README.md
│   │   ├── integration.md        # Complete analysis
│   │   └── adaptations/          # Adaptation guides
│   └── documentation-templates.md # Process templates
├── helm-charts/                  # Helm-charts opportunities
│   └── lightweight-commands.md   # Lightweight commands for non-proj-cli projects
└── dev-toolkit/                  # Dev-toolkit opportunities
    ├── README.md                 # Dev-toolkit hub
    └── spike-workflow-framework.md # Spike methodology and agentic coding learnings
```

---

**Last Updated:** 2026-02-13  
**Status:** ✅ Active  
**Next:** Integrate spike workflow framework into explore command and workflow rules
