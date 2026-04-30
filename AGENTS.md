# Dev-Infra — Project Conventions

Dev-infra is a **template factory** ([ADR-001](admin/services/meta/features/dev-infra-identity-and-focus/decisions/adr-001-project-identity.md)): it produces standardized project templates and encodes proven patterns from real projects. Templates are products, not reflections of dev-infra's internal process. Internal tooling (release automation, validation scripts) stays internal.

**Core goals:** Template quality (proven, tested templates), consistency (all projects start with consistent structure), best practices (encode real project patterns), workflow automation (skills for common workflows), documentation (comprehensive guides and examples).

**Primary users:** Developers creating new projects, template maintainers evolving templates, projects already using dev-infra templates.

## Project Structure

```
dev-infra/
├── templates/                     # Template products
│   ├── standard-project/          # Application template
│   └── learning-project/          # Tutorial/learning template
├── scripts/                       # Automation (generator, validation)
├── tests/                         # Template validation (Bats)
├── docs/                          # User-facing documentation
├── admin/                         # Project management
│   └── services/                  # Service-first organization
│       ├── ai-workflow/           # AI workflow tooling
│       ├── template-generation/   # Template creation/maintenance
│       ├── release-management/    # Versioning and releases
│       └── meta/                  # Dev-infra about itself
└── .cursor/                       # IDE configuration
    ├── commands/                   # Workflow commands (migrating to skills)
    └── rules/                     # AI assistant rules
```

Each service contains: `explorations/` (pre-formal thinking), `features/` (formal work with planning pipeline), and `maintenance/` (operational upkeep). Features follow the structure: `[feature]/planning/implementation-plan.md` + `tasks/` + `status-and-next-steps.md`.

## Git Flow

**Branches:** `main` (production releases, protected), `develop` (ongoing development, protected), `feat/*`, `fix/*`, `docs/*`, `chore/*`, `ci/*`, `release/*`.

**Commit format:** `type(scope): brief description` — types: `feat`, `fix`, `docs`, `chore`, `test`, `refactor`, `ci`. Scope is the feature or component name.

**Branch rules:**
- `feat/*`, `fix/*`, `ci/*` require pull requests to develop/main, full testing, conventional commits.
- `docs/*`, `chore/*` can push directly to develop/main with minimal validation.

**Worktree workflow:** Feature development uses `git worktree` for isolation. Naming convention: `feat/foo` branch → `worktrees/feat-foo` directory. All feature content (explorations, research, decisions, planning) stays on the feature branch — features are self-contained and portable.

## Documentation Standards

**Hub-and-spoke pattern:** Every major directory has a `README.md` hub linking to spoke documents. Hubs include a Quick Links section, overview, status, and last-updated date. Spoke documents focus on single topics and link back to their hub.

**Progressive disclosure:** Start with high-level overview, link to details. Don't overwhelm hub files.

**Status indicators** (use consistently):
- 🔴 Not Started
- 🟡 Planned
- 🟠 In Progress
- ✅ Active/Complete

**Date format:** Always `YYYY-MM-DD`.

**File naming:** kebab-case for files (`implementation-plan.md`, `status-and-next-steps.md`). `README.md` is always uppercase.

## Template Standards

**Two template types:** standard-project (application scaffold with backend/frontend separation, feature-based planning) and learning-project (stage-based progression with practice apps and reference materials). Both receive all workflow commands/skills.

**When modifying templates:**
1. Test generation with `./scripts/new-project.sh`
2. Verify generated structure, README files, and documentation links
3. Update user docs in `docs/` and planning docs if feature-related
4. Maintain consistency across template types and preserve proven patterns

**Template sync:** Shared files between templates are tracked in `scripts/template-sync-manifest.txt` and validated in CI via `scripts/validate-template-sync.sh`.

**Placeholder patterns:** `[PROJECT_NAME]`, `[PROJECT_DESCRIPTION]`, `[TECH_STACK]`, `[AUTHOR]` — replaced during generation.

**Template evolution lifecycle:** Discovery (identify opportunity from real projects) → Planning (write implementation plan, break into task groups) → Implementation (execute tasks) → Testing (validate template generation) → Documentation (update user docs) → Release (include in next version).

**Post-generation customization:** Update `start.txt` with project details and goals, update `README.md` with tech stack and description, configure CI/CD workflows. Optionally: remove unused directories, add project-specific directories.

## Code and Script Standards

**Template code quality:** Follow language-specific best practices, write self-documenting code, include inline comments for complex logic, create validation tests, update docs when changing behavior.

**Script quality:** Handle errors gracefully, provide clear user feedback, validate inputs, test edge cases, support interactive and non-interactive (`--non-interactive`) modes.

**TDD for shell scripts:** Use RED-GREEN-REFACTOR with Bats (Bash Automated Testing System). Tests live in `tests/unit/[script-name].bats`. Run with `bats tests/unit/*.bats`. Use `bash "$SCRIPT"` not `source "$SCRIPT"` in tests. Use specific assertions over keyword matching.

**Standard script flags:**

| Flag | Purpose |
|------|---------|
| `--dry-run` | Show what would happen without doing it |
| `--force` | Override blocking checks |
| `--verbose` | Detailed output |
| `--json` | JSON-formatted output |
| `--generate` | Generate output file |
| `--help` | Usage information |

## CI/CD

**Testing by branch type:** Feature branches get full test suite + template validation + linting. Documentation branches get markdown validation only. Release branches get full validation + external reviews.

**Template validation before committing:** Run `./scripts/new-project.sh` and `./scripts/validate-templates.sh`. Verify all required directories created, README files present, documentation links work.

**Investigating CI failures:** Check all similar patterns (not just the first issue found). Verify fix addresses all similar issues. Always investigate `.github/workflows/` files. PR validation workflow is valuable for catching issues invisible locally.

## Behavioral Guidelines

**When making changes:** Respect existing patterns. Update documentation when creating or modifying templates. Use established status indicators and date formats. Link bidirectionally (hub to spoke and back). Consider if an ADR is needed for significant decisions.

**When creating templates:** Create directory with all required files, update `templates/README.md`, use appropriate status indicators, test generation.

**Conventions, not instructions:** This file carries project-wide conventions. Procedural workflows (step-by-step command processes, checklists, specific tool usage) belong in skill definitions, not here.

---

Current project state: see `admin/services/meta/features/dev-infra-identity-and-focus/` for project identity, or feature-specific `planning/status-and-next-steps.md` files within each service.
