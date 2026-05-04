# Release Management Service

**Purpose:** Release automation, readiness assessment, distribution workflows
**Status:** 🟠 Scaffold (features pending migration)
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

---

## 📋 What Lives Here

The release-management service holds everything about how dev-infra ships releases: release readiness criteria and automation, version management, release branching, distribution to downstream projects, and CI/CD improvements that support the release cycle.

### Features (full pipeline, migration pending)

| Feature | Status |
|---------|--------|
| release-readiness | 🟠 (verify during migration) |
| release-automation-v2 | 🟠 (verify during migration) |
| ci-cd-workflow-improvements | 🟠 Research-level (verify during migration) |

### Explorations (service-level questions, migration pending)

Service-level explorations that haven't been promoted to features will land here during migration.

### Maintenance (structural, CI, tooling)

CI pipeline refinements, release script improvements, etc.

---

## 🏗️ Structure

```
release-management/
├── README.md                    ← this file
├── explorations/                ← service-level questions
├── features/                    ← new capabilities (full pipeline)
│   ├── release-readiness/
│   ├── release-automation-v2/
│   └── ci-cd-workflow-improvements/
└── maintenance/                 ← structural, CI, tooling
```

---

## 🔗 Related

- [meta service](../meta/README.md) — Dev-infra about itself
- [ai-workflow service](../ai-workflow/README.md) — Commands, skills, rules
- [template-generation service](../template-generation/README.md) — Templates and generator
- [Directory restructure migration](../meta/maintenance/directory-restructure/plan.md) — How features land here

---

**Last Updated:** 2026-04-24
