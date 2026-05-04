# Meta Service

**Purpose:** Dev-infra about itself — identity, process, structure, workflow conventions
**Status:** 🟠 Bootstrap (first service in the new structure)
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

---

## 📋 What Lives Here

The meta service holds work that is about the dev-infra project itself rather than about its external products (ai-workflow skills, templates, release automation). It's the "factory about the factory."

### Features (full pipeline)

- `dev-infra-identity-and-focus` — project identity and scope decisions (migration pending)
- `worktree-feature-workflow` — feature development workflow with worktrees (migration pending)
- `four-arm-architecture` — relationship between dev-infra, work-prod, proj-cli, dev-toolkit (migration pending)
- `project-model-definition` — project type classification (migration pending)

### Maintenance (lighter pipeline)

- **[directory-restructure](maintenance/directory-restructure/README.md)** — Service/feature/phase directory restructure (🟠 In Progress)

### Cross-Project Concerns (provisional)

These are about projects other than dev-infra but currently tracked here. May eventually relocate:

- `global-command-distribution` — cross-project command distribution
- `work-prod-integration`, `work-prod-analysis-service` — about work-prod
- `proj-cli-focused-role` — about proj-cli
- `terraform-style-project-management` — cross-project exploration

---

## 🏗️ Structure

```
meta/
├── README.md                    ← this file
├── explorations/                ← service-level questions (empty until populated)
├── features/                    ← full-pipeline work (migration pending)
└── maintenance/                 ← structural, CI, tooling (lighter pipeline)
    └── directory-restructure/   ← first bootstrap item
```

---

**Last Updated:** 2026-04-24
