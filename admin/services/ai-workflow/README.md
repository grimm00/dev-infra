# AI Workflow Service

**Purpose:** Commands, skills, rules, and the thinking pipeline that supports AI-assisted development
**Status:** 🟠 Scaffold (features pending migration)
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

---

## 📋 What Lives Here

The ai-workflow service holds everything about how dev-infra guides AI-assisted development: the command library, the skill architecture (in progress), the rules layer, and the thinking pipeline (explore, research, discuss, decision, transition-plan, task).

### Features (full pipeline, migration pending)

| Feature | Status |
|---------|--------|
| agentic-workflow-modernization | 🟠 Decision + design complete; Stage 1 pending |
| workflow-simplification | 🟠 Complete or in progress (verify during migration) |
| command-simplification | 🟠 (verify during migration) |
| command-adaptation-template | 🟠 (verify during migration) |
| command-testing-integration | 🟠 (verify during migration) |
| command-distribution | 🟠 (verify during migration) |
| command-branch-workflow | 🟠 (verify during migration) |
| explore-two-mode | 🟠 (verify during migration) |
| decision-two-mode | 🟠 (verify during migration) |
| reflect-two-mode | 🟠 (verify during migration) |
| transition-plan-two-mode | 🟠 (verify during migration) |
| handoff-command | 🟠 (verify during migration) |
| ai-prompt-lifecycle | 🟠 (verify during migration) |

### Explorations (service-level questions, migration pending)

Service-level explorations that haven't been promoted to features will land here during migration.

### Maintenance (structural, CI, tooling)

Items affecting the ai-workflow service's own infrastructure (skill testing, skill sync, etc.) live here. None at the moment.

---

## 🏗️ Structure

```
ai-workflow/
├── README.md                    ← this file
├── explorations/                ← service-level questions
├── features/                    ← new capabilities (full pipeline)
│   ├── agentic-workflow-modernization/
│   ├── workflow-simplification/
│   └── ... (13 features total)
└── maintenance/                 ← structural, CI, tooling
```

---

## 🔗 Related

- [meta service](../meta/README.md) — Dev-infra about itself
- [template-generation service](../template-generation/README.md) — Templates and generator
- [release-management service](../release-management/README.md) — Release automation
- [Directory restructure migration](../meta/maintenance/directory-restructure/plan.md) — How features land here

---

**Last Updated:** 2026-04-24
