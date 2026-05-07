# Research: Minimum Viable Project Contract

**Status:** ✅ Complete
**Priority:** High
**Created:** 2026-05-06
**Completed:** 2026-05-06

---

## Research Question

What's the minimum set of files/structure that `proj-cli`/`work-prod` and AI agents need to manage a project's lifecycle — i.e., what must be in the minimal template?

---

## Research Goals

- [x] Identify what `proj-cli` requires to detect and manage a project (state file, manifest, etc.)
- [x] Identify what AI agents (skills, commands, agents) require to operate in a repo (scratch path, AGENTS.md, profile pointer)
- [x] Identify what `work-prod` requires to register and track a project (registry entry, metadata)
- [x] Determine the boundary between "template provides" and "on-demand creation by skills/tools"
- [x] Produce a candidate list of "day-one files" that constitute the minimal template
- [x] Compare against what the current comprehensive template provides to understand what would be removed

---

## Methodology

**Queries executed:**
1. "minimal project scaffold template 2025 2026 what files are essential for project initialization cookiecutter cargo init yeoman"
2. "AGENTS.md project configuration file AI coding assistants 2025 2026 agentskills.io"
3. "minimal viable project template scaffold what files necessary 2026 developer experience day one productivity"

**Internal sources consulted:**
- `templates/standard-project/` full file listing (89 files)
- `templates/learning-project/` full file listing (50 files)
- `admin/services/meta/features/project-model-definition/requirements.md` — proj-cli/work-prod API contract
- `admin/services/ai-workflow/explorations/skill-package-controller/exploration.md` — agent requirements
- `templates/standard-project/start.txt` — current initialization form
- Global skills directory listing — which skills create structure on demand

---

## Sources

- [x] Current `templates/standard-project/` file listing (89 files total)
- [x] Current `templates/learning-project/` file listing (50 files total)
- [x] `proj-cli` requirements — FR-1: only `name` field required on project create
- [x] `work-prod` API — CRUD on projects, only `name` required, rest optional metadata
- [x] Existing skills that create files on first run: `explore-start`, `research-setup`, `write-plan-setup`, `decision`, `int-opp`, `handoff`, `pre-commit-review` — all create directory structure on demand
- [x] `skill-package-controller` exploration — AGENTS.md as project contract, three-tier authority model
- [x] Web search: minimal scaffolds in other ecosystems (see Methodology)

---

## Findings

### Finding 1: Cargo/Rust — The Minimalist Standard

**Source:** Web search: "minimal project scaffold template 2025 2026"
**Relevance:** Cargo is the gold standard for minimal project initialization. `cargo init` creates exactly 3 artifacts: `Cargo.toml` (manifest), `src/main.rs` (entry point), `.gitignore`. Everything else is opt-in via `cargo add`, crate features, or workspace configuration.

The pattern: **manifest + entry point + git hygiene**. No pre-built directory tree, no documentation scaffold, no CI config. Those arrive when needed.

### Finding 2: AGENTS.md Is a Linux Foundation Standard (2026)

**Source:** Web search: "AGENTS.md project configuration file AI coding assistants 2026"; mdskills.ai, morphllm.com, agents.md
**Relevance:** AGENTS.md is now recognized across Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI, and Aider. Princeton research shows it reduced median agent runtime by 28.6% and token usage by 16.6% across 124 PRs. It's the "README for machines" — providing build commands, architecture, code style, and project rules in one file that all agents read.

Key characteristics: plain markdown, no required fields, 32 KiB cap, supports nested files in monorepos. One file works across tools (unlike `.cursorrules` or `CLAUDE.md` which are tool-specific).

**Implication for minimal template:** AGENTS.md is the single highest-leverage file for AI agent productivity. It replaces tool-specific configuration files and provides the project contract that the skill-package-controller's Tier 1 authority reads.

### Finding 3: proj-cli/work-prod Need Almost Nothing

**Source:** `admin/services/meta/features/project-model-definition/requirements.md` (FR-1, FR-1a)
**Relevance:** The work-prod API requires only a `name` field to create a project. All other metadata (status, organization, classification) is optional. proj-cli's state file (`.dev-infra.yml`) tracks template version and customizations — it's the only proj-cli-specific file.

**Implication:** The lifecycle tooling imposes almost zero file requirements on a repo. proj-cli needs its state file; work-prod needs nothing in-repo at all (it's an external registry).

### Finding 4: Skills Create Their Own Structure On-Demand

**Source:** Internal: `~/.cursor/skills/` — 15+ skills that create directories
**Relevance:** The following skills create directory structure when first invoked:
- `explore-start` → creates `explorations/[topic]/` with README, exploration.md, research-topics.md
- `research-setup` → creates `research/` tree with hub, per-topic docs, summary, requirements
- `write-plan-setup` → creates `planning/` tree with implementation plan, status, task group skeleton
- `decision` → creates `decisions/` tree with ADR hub and templates
- `int-opp` → creates `admin/planning/opportunities/` tree
- `handoff` → creates `admin/tmp/handoffs/` or `tmp/handoffs/`
- `pre-commit-review` → creates review bundle directory

**Implication:** The comprehensive template pre-builds structure that skills would create on demand anyway. The `docs/maintainers/planning/explorations/`, `docs/maintainers/research/`, `docs/maintainers/decisions/` directories in the current template are all created by skills when they're actually needed. Pre-building them is wasted scaffolding — it's noise on day one and becomes stale if the skill's expectations change.

### Finding 5: Current Templates Are 80% Pre-Built Structure That Skills Would Create

**Source:** Internal: `templates/standard-project/` file listing analysis
**Relevance:** Of the 89 files in `standard-project`:
- **42 files** (47%) are skills/commands (`.claude/skills/`, `.cursor/commands/`) — already migrated to global installs
- **24 files** (27%) are docs infrastructure (`docs/maintainers/` planning pipeline, examples, workflow guides) — created on demand by skills
- **7 files** (8%) are structural empties (`README.md` files in empty directories, `.gitkeep` files)
- **5 files** (6%) are CI/tooling config (`.github/workflows/ci.yml`, `.sourcery.yaml`, `.dockerignore`, `.gitignore`)
- **3 files** (3%) are application scaffold (`backend/`, `frontend/` READMEs, root README)
- **1 file** (1%) is the start form (`start.txt`)
- **5 files** (6%) are root-level docs (`README.md`, `docs/README.md`, `scripts/README.md`, `tests/README.md`)

**Bottom line:** Only ~10-15 files serve a purpose that can't be fulfilled on demand. The rest is either migrated to global installs, created by skills when needed, or structural noise.

### Finding 6: Modern Scaffolds Converge on "Config + Entry Point + Git Hygiene"

**Source:** Web search: "minimal viable project template scaffold 2026"
**Relevance:** Across ecosystems (Vite, uv, cargo, cookiecutter), modern scaffolds converge on:
1. **Package manifest** (Cargo.toml, pyproject.toml, package.json) — declares identity, deps, scripts
2. **Source entry point** (src/main.rs, src/main.py, src/index.ts) — proves the stack works
3. **Git configuration** (.gitignore) — prevents tracking of build artifacts
4. **Optional:** CI pipeline, README, LICENSE

The trend is away from comprehensive scaffolds and toward minimal starts with opt-in layers added via `add` commands (cargo add, npm install, etc.).

### Finding 7: The "Agent Landing Site" Concept

**Source:** Internal: `skill-package-controller` exploration Theme 3, Theme 4
**Relevance:** The controller exploration identified that agents need a "landing site" — enough information to orient themselves in a repo without exploring. This is:
1. **AGENTS.md** — project conventions, build commands, architecture (Tier 1 authority)
2. **Scratch path convention** — where agents put transient artifacts (reviews, handoffs, planning)
3. **Git hygiene for agent artifacts** — .gitignore entries for scratch paths

Without these, agents either explore (wasteful) or assume (fragile). The minimal template's job is to provide this landing site, not to pre-build the structure that agents will create on demand.

---

## Analysis

### The Three Consumers and Their Needs

| Consumer | What it needs in-repo | What it needs externally |
|----------|----------------------|-------------------------|
| **proj-cli** | `.dev-infra.yml` (state file) | work-prod registry entry (API) |
| **work-prod** | Nothing | `name` field via API |
| **AI agents** | AGENTS.md (conventions), .gitignore (scratch hygiene) | Per-repo profile (paths, ticket config) |

### The Boundary: Template Provides vs. On-Demand

**Template provides (day-one files):**
- Files that can't be meaningfully created by a tool at runtime because they require human knowledge (project name, conventions, tech stack)
- Files that must exist before any tool runs (git config, agent conventions)

**On-demand (skills create when needed):**
- Directory structure for planning, research, decisions, explorations
- CI/CD pipelines (depends on tech stack chosen later)
- Documentation infrastructure (grows with the project)
- Application scaffold (varies wildly by project type)

### What the Current Template Gets Wrong

The current template conflates three things:
1. **Contract files** that tools need → should stay in template
2. **Convenience scaffold** that saves one `mkdir` → should be on-demand
3. **Workflow tooling** (skills/commands) → already migrated to global installs

### Candidate Minimal Template

Based on findings, the minimal template should contain **7-9 files**:

| File | Purpose | Consumer |
|------|---------|----------|
| `AGENTS.md` | Project conventions for AI agents (build commands, architecture, rules) | All AI agents (Tier 1 authority) |
| `.dev-infra.yml` | Template version and customization state | proj-cli |
| `.gitignore` | Ignore build artifacts, agent scratch paths, editor files | Git, agents |
| `README.md` | Project identity (name, description, tech stack, getting started) | Humans, GitHub |
| `start.txt` | Project initialization form (filled during setup) | proj-cli setup flow |
| `.github/workflows/ci.yml` | Minimal CI (lint + test, parameterized for tech stack) | GitHub Actions |
| `src/` or entry point | Proves the stack works (varies by project type) | Developer |
| `.sourcery.yaml` | Code review configuration | Sourcery |

**Optional (include if project type warrants):**
- `Dockerfile` + `.dockerignore` (if containerized)
- `LICENSE` (if open source)

### What Gets Removed (vs. current 89-file template)

| Category | Files Removed | Reason |
|----------|--------------|--------|
| Skills/commands | 42 files | Migrated to global installs |
| Docs infrastructure | 24 files | Created on demand by skills |
| Structural empties | 7 files | No value until populated |
| Backend/frontend scaffold | 2 files | Project-type dependent, not universal |
| Workflow guides | 4 files | Available globally, not template-specific |

**Reduction: 89 files → ~8 files (91% reduction)**

---

## Recommendations

- [x] AGENTS.md should be the centerpiece of the minimal template — it's the highest-leverage file for both AI productivity and cross-tool compatibility
- [ ] The template should stop bundling skills/commands entirely (they're global installs with independent release cadence)
- [ ] Directory structure should be created on demand by skills, not pre-built by templates
- [ ] `start.txt` should evolve from a form into a machine-readable manifest that proj-cli consumes during setup
- [ ] The minimal template should be project-type-parameterized: the core contract files are universal, but the entry point and CI config vary by tech stack
- [ ] Consider splitting into "contract layer" (AGENTS.md, .dev-infra.yml, .gitignore) and "starter layer" (README, CI, entry point) — the contract layer is truly minimal, the starter layer is opinionated but thin

---

## Requirements Discovered

**FR-MVPC-1:** The minimal template MUST include AGENTS.md with project conventions sufficient for AI agents to operate without exploration.

**FR-MVPC-2:** The minimal template MUST include `.dev-infra.yml` for proj-cli state tracking (template version, customizations).

**FR-MVPC-3:** The minimal template MUST include `.gitignore` with entries for agent scratch paths (`.scratch/`, `tmp/`, `admin/tmp/`).

**FR-MVPC-4:** The minimal template SHOULD include a README.md with project identity and getting-started instructions.

**FR-MVPC-5:** The minimal template SHOULD NOT include directory structure that skills create on demand (explorations, research, decisions, planning).

**FR-MVPC-6:** The minimal template MUST NOT bundle skills, commands, or agents (these are global installs with independent lifecycle).

**NFR-MVPC-1:** The minimal template SHOULD be generatable in < 5 seconds with no network calls.

**NFR-MVPC-2:** The minimal template SHOULD produce a working project (passes CI, agents can operate) immediately after generation without additional setup steps.

**C-MVPC-1:** AGENTS.md content depends on project type (tech stack, framework, conventions). The template must parameterize this rather than shipping a generic placeholder.

**C-MVPC-2:** Existing projects generated from comprehensive templates are not affected — they keep their structure. Migration is a separate concern (Topic 5).

---

## Next Steps

- Findings feed directly into Topic 2 (per-repo profile) — the profile stores paths that the template no longer pre-builds
- Findings inform Topic 4 (bundling strategy) — recommendation is "don't bundle skills at all"
- The candidate minimal template (7-9 files) should be validated via spike: generate it for a real project and test whether skills/agents can operate without the pre-built infrastructure
