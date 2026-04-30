# Template Generation Service

**Purpose:** Project templates, new-project.sh generator, template sync infrastructure
**Status:** 🟠 Scaffold (features pending migration)
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

---

## 📋 What Lives Here

The template-generation service holds everything about how dev-infra produces project templates: the templates themselves, the generator script, template validation, template sync between standard-project and learning-project, and the documentation infrastructure that lives inside templates.

### Features (full pipeline, migration pending)

| Feature | Status |
|---------|--------|
| template-restructure | 🟠 (verify during migration) |
| template-architecture | 🟠 Exploration-level (verify during migration) |
| template-doc-infrastructure | 🟠 (verify during migration) |
| template-metadata | 🟠 Research-level (verify during migration) |
| template-generation-testing-automation | 🟠 (verify during migration) |
| templates-enhancement | 🟠 (verify during migration) |
| directory-selection | 🟠 (verify during migration) |

### Explorations (service-level questions, migration pending)

Service-level explorations that haven't been promoted to features will land here during migration.

### Maintenance (structural, CI, tooling)

Template sync validation, generator script improvements, etc.

---

## 🏗️ Structure

```
template-generation/
├── README.md                    ← this file
├── explorations/                ← service-level questions
├── features/                    ← new capabilities (full pipeline)
│   ├── templates-enhancement/
│   ├── template-doc-infrastructure/
│   └── ... (7 features total)
└── maintenance/                 ← structural, CI, tooling
```

---

## 🔗 Related

- [meta service](../meta/README.md) — Dev-infra about itself
- [ai-workflow service](../ai-workflow/README.md) — Commands, skills, rules
- [release-management service](../release-management/README.md) — Release automation
- [Directory restructure migration](../meta/maintenance/directory-restructure/plan.md) — How features land here

---

**Last Updated:** 2026-04-24
