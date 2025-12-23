# Terraform-Style Project Management - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 What Are We Exploring?

The concept of dev-infra evolving from a **template factory** (produces projects, then done) to a **project infrastructure manager** (maintains ongoing relationship with managed projects).

**Current Model (Factory):**

```
dev-infra → generates → project → project is on its own
```

**Proposed Model (Infrastructure Manager):**

```
dev-infra → manages → projects → continuous relationship
                 ↑
                 └── Registry tracks all managed projects
                 └── CI/CD pushes updates
                 └── State tracking prevents drift
```

---

## 🤔 Why Explore This?

**Problem:** Projects generated from dev-infra templates currently have no way to receive updates when templates improve. Each project is an island.

**Opportunity:** If dev-infra maintains a relationship with projects it creates, it can:

1. Push template improvements automatically
2. Detect when projects drift from best practices
3. Provide a unified view of all managed projects
4. Enable consistent infrastructure across a portfolio

**User Insight (2025-12-22):**

> "I described dev-infra-created projects as being managed by dev-infra. My first thought is a CI/CD workflow that pushes updates to projects that are managed."

---

## 🏗️ The Terraform Parallel

This is the core insight: **Terraform's model maps remarkably well to project management.**

### Concept Mapping

| Terraform Concept        | Dev-Infra Equivalent                                       |
| ------------------------ | ---------------------------------------------------------- |
| **Provider**             | dev-infra (source of templates/commands)                   |
| **Resource definitions** | Templates (standard-project, learning-project)             |
| **terraform.tfstate**    | `.dev-infra.yml` (tracks version, config, what was synced) |
| **`terraform init`**     | `proj init` (initialize project as managed)                |
| **`terraform plan`**     | `proj plan` (show what would change)                       |
| **`terraform apply`**    | `proj apply` (make the changes)                            |
| **`terraform refresh`**  | `proj sync --refresh` (update state without changes)       |
| **`terraform import`**   | `proj adopt` (bring existing project under management)     |
| **State drift**          | Project files diverging from template                      |

### Why This Model Works

1. **Declarative:** You say _what_ you want, not _how_ to get there
2. **Predictable:** `plan` before `apply` - see changes before making them
3. **Trackable:** State file knows exactly what's deployed
4. **Recoverable:** State history enables rollback
5. **Auditable:** Know what changed, when, and why

---

## 💡 Initial Concepts

### 1. State File: `.dev-infra.yml`

```yaml
# .dev-infra.yml - Declarative project configuration
managed_by: dev-infra
template: standard-project
version: 0.7.0
created: 2025-12-22
last_sync: 2025-12-22

# What to sync (declarative)
sync:
  commands: global # Use ~/.cursor/commands/
  rules: project # Keep rules in project
  structure:
    - docs/maintainers/ # Sync planning structure
    - .github/workflows/ # Sync CI/CD

# What to ignore (like .gitignore or terraform lifecycle ignore)
ignore:
  - backend/ # Never touch application code
  - frontend/
  - README.md # Project customizes this

# Track intentional customizations
customizations:
  - file: .cursor/rules/main.mdc
    reason: "Project-specific rules added"
    date: 2025-12-22
```

### 2. CLI Commands (via proj-cli)

```bash
# Initialize a new managed project
proj new myapp --template standard

# Check what updates are available
proj plan
# Output:
# ~ .cursor/commands/task-phase.md (modified in template)
# + .cursor/commands/new-command.md (new in template)
# = 12 files unchanged

# Apply the updates
proj apply

# Show current state
proj state
# Output:
# Template: standard-project
# Version: 0.7.0 (latest: 0.8.0)
# Last sync: 2025-12-22
# Drift: 2 files modified locally

# Import existing project into management
proj adopt --template standard
```

### 3. CI/CD Push Model

When dev-infra releases a new version:

```yaml
# .github/workflows/push-updates.yml (in dev-infra)
name: Push Updates to Managed Projects

on:
  release:
    types: [published]

jobs:
  push-updates:
    runs-on: ubuntu-latest
    steps:
      - name: Get managed projects
        run: |
          # Read from registry (GitHub-based or local)
          projects=$(curl -s $REGISTRY_URL/projects.json)

      - name: Create PRs for each project
        run: |
          for project in $projects; do
            # Fork/clone project
            # Run proj plan
            # If changes, create PR
            gh pr create \
              --repo $project \
              --title "chore: sync with dev-infra $VERSION" \
              --body "Updates from dev-infra template"
          done
```

### 4. Registry Architecture

**Option A: Local Registry**

```
~/.dev-infra/
├── registry.json        # List of managed projects
├── cache/               # Cached template versions
└── state/               # Local state backups
```

**Option B: GitHub-Based Registry**

- Projects with `.dev-infra.yml` are discoverable
- GitHub API queries for repos with the file
- No central registry needed

**Option C: Hybrid**

- Local registry for fast access
- GitHub sync for discovery
- work-prod API for analytics

---

## 🔍 Key Questions

- [ ] **State format:** What exactly should `.dev-infra.yml` contain?
- [ ] **Registry location:** Local, GitHub-based, or hybrid?
- [ ] **Push vs Pull:** Should updates be pushed (CI/CD) or pulled (user runs sync)?
- [ ] **Conflict resolution:** How to handle intentional customizations?
- [ ] **Drift detection:** How to know when a project has diverged?
- [ ] **Adoption path:** How to bring existing projects under management?
- [ ] **Permissions:** How to handle CI/CD creating PRs across repos?
- [ ] **Rollback:** How to undo a bad sync?

---

## 🎭 Identity Evolution

This exploration suggests a further evolution of dev-infra's identity:

```
v0.x: Template Factory
  └── Produces templates with commands embedded

v1.x: Command Hub + Template Factory
  └── Global commands + templates
  └── (Current direction from v4 exploration)

v2.x: Project Infrastructure Manager
  └── Global commands + templates
  └── State tracking
  └── CI/CD push updates
  └── Drift detection
  └── Registry of managed projects
```

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research terraform-style-project-management --from-explore` to conduct research
3. After research, use `/decision terraform-style-project-management --from-research` to make decisions

---

## 📝 Notes

**Connection to existing work:**

- Template Metadata research already exploring `.dev-infra.yml` format
- Global Command Distribution validated `~/.cursor/commands/` approach
- proj-cli could be the CLI interface for these commands

**Terraform learnings to consider:**

- Terraform's state locking prevents concurrent modifications
- Terraform workspaces allow multiple environments
- Terraform modules enable composition
- Terraform cloud provides remote state and collaboration

---

**Last Updated:** 2025-12-22
