# Dev-Infra Identity & Focus - Exploration

**Status:** 🟠 Active Exploration (v4)  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-22

---

## 🎯 What Are We Exploring?

The fundamental question: **What should dev-infra be?**

### v4 Discovery (2025-12-22) — Global Commands! 🎉

**Key Discovery:** Cursor supports global commands from `~/.cursor/commands/`!

**Validation Test:**

1. Created `~/.cursor/commands/foobar.md` with test content
2. Invoked `/foobar` from a workspace
3. ✅ Command executed successfully!

**What This Means:**

```
~/.cursor/commands/           # Global - available in ALL projects
├── task-phase.md
├── pr.md
├── fix-plan.md
└── ... (19 commands from dev-infra)

project/.cursor/commands/     # Local - project-specific overrides
└── custom-command.md
```

**Implications:**

1. **Templates become lighter** — Commands optional, not embedded
2. **Single source of truth** — Update once globally, all projects benefit
3. **Dev-infra evolves** — From "Template Factory" to "Command Hub + Template Factory"
4. **Feedback loop** — Usage patterns inform command improvements

**New Identity:**

```
dev-infra (v1): Template Factory → produces templates with commands
dev-infra (v2): Command Hub + Template Factory → provides global commands + templates
```

### v3 Refinement (2025-12-22)

**Key Insight:** proj-cli should be the unified CLI that consumes dev-infra as a "template layer."

Rather than building CLI tooling into dev-infra, we leverage the existing `proj-cli` project which already provides:

- Project management: `proj list`, `proj get`, `proj create` (work-prod API)
- Inventory management: `proj inv scan`, `proj inv analyze`
- Python CLI with Typer + Pydantic + XDG configuration

**New Architecture:**

```
proj-cli (CLI)        →    dev-infra (Templates)
                      →    work-prod (API)
                      →    ~/.dev-infra/ (Local Registry)
```

**Implications:**

- Dev-infra does NOT need to become a CLI tool
- Dev-infra focuses on: templates, sync rules, metadata format
- proj-cli implements: `proj new`, `proj sync`, registry operations

---

### v2 Refinement (2025-12-18)

After completing the command simplification (v0.7.0) and migrating to 0.x.x versioning, we have new clarity:

**Key Realization:** There are no external users yet. The only user is the creator, and what's learned from using these templates informs further development. This changes everything.

**New Focus:** Infrastructure management for multiple scenarios, not pleasing a broad developer audience.

---

## 🎯 The Four Scenarios

### Scenario 1: New Projects (Primary)

**Need:** Projects that need an easily recognizable and familiar structure with workflow and pattern guidance.

**Current Support:** ✅ `./scripts/new-project.sh` generates from templates

**Opportunity:** Enhanced - tagging, better customization

---

### Scenario 2: External Project Sync (New)

**Need:** Projects NOT generated with dev-infra that want to adopt structure/patterns.

**Current Support:** ❌ None

**Approach Options:**

- "Scaffolding mode" - Add structure to existing project
- "Best effort" script - Compare and suggest additions
- "Adoption guide" - Manual checklist for migration

**Complexity:** High - must handle arbitrary existing structures

---

### Scenario 3: Dev-Infra Project Updates (New)

**Need:** Projects generated with dev-infra that need to sync new files/folders.

**Current Support:** ⚠️ Partial (template-sync validates, but doesn't update)

**Approach Options:**

- Automatic sync (triggered by version bump or manually)
- CLI patterns (`dev-infra sync`, `dev-infra update`)
- Diff-based update (show what changed, let user apply)

**Key Questions:**

- How to handle customizations in generated projects?
- What files should sync vs stay local?
- How to handle breaking structure changes?

---

### Scenario 4: Template Tagging (New)

**Need:** Each template needs metadata to help dev-infra and other dev-infra projects understand what kind of project it is.

**Current Support:** ❌ None

**Approach:**

- `.dev-infra.yml` or similar config file in generated projects
- Tags like: `template: standard-project`, `version: 0.7.0`, `type: application`
- Enables smart sync, version tracking, compatibility checks

---

### Scenario 5: proj-cli Integration (v3 - 2025-12-22)

**Need:** Unified CLI for all project operations instead of separate tools.

**Current Support:** ✅ proj-cli exists with work-prod integration

**Approach:**

- `proj new [name]` creates project from dev-infra template
- `proj sync` syncs template updates to existing projects
- Local registry at `~/.dev-infra/registry.json` tracks all projects
- Projects automatically registered on creation

**Architecture:**

```
┌─────────────────────────────────────────────────────────┐
│                      proj-cli                            │
│         (User-Facing CLI - installed globally)           │
│                                                          │
│  Commands:                                               │
│  • proj new [name] --template standard                   │
│  • proj list / get / create (work-prod API)              │
│  • proj inv scan / analyze                               │
│  • proj sync                                             │
└─────────────────────────────────────────────────────────┘
                          │
           ┌──────────────┼──────────────┐
           ▼              ▼              ▼
┌─────────────────┐ ┌─────────────┐ ┌─────────────────┐
│ dev-infra       │ │ work-prod   │ │ ~/.dev-infra/   │
│ (Templates)     │ │ (API)       │ │ (Local Registry)│
└─────────────────┘ └─────────────┘ └─────────────────┘
```

**Key Insight:** Dev-infra doesn't need its own CLI. proj-cli is the CLI layer; dev-infra is the template layer.

**Related:** [proj-cli-architecture exploration](https://github.com/grimm00/proj-cli/blob/develop/docs/maintainers/planning/explorations/proj-cli-architecture/exploration.md)

---

### Scenario 6: Global Command Distribution (v4 - 2025-12-22) 🎉

**Need:** Commands that are shared across all projects without duplication.

**Current Support:** ✅ Validated! Cursor reads from `~/.cursor/commands/`

**Discovery:** A test command (`foobar.md`) was created at `~/.cursor/commands/` and successfully invoked from a multi-project workspace.

**Architecture:**

```
┌─────────────────────────────────────────────────────────┐
│                     ~/.cursor/                          │
│                                                         │
│  commands/                 # Global commands            │
│  ├── task-phase.md         # From dev-infra             │
│  ├── pr.md                                              │
│  ├── fix-plan.md                                        │
│  └── ... (19 workflow commands)                         │
│                                                         │
│  rules/                    # Global rules (TBD)         │
│  └── shared-patterns.mdc   # Common patterns            │
│                                                         │
│  workspaces/               # Workspace files            │
│  └── proj-management.code-workspace                     │
└─────────────────────────────────────────────────────────┘
              │
              ▼ (overrides)
┌─────────────────────────────────────────────────────────┐
│                  project/.cursor/                       │
│                                                         │
│  commands/                 # Project-specific only      │
│  └── custom-command.md     # Override or extend         │
│                                                         │
│  rules/                    # Project-specific rules     │
│  └── main.mdc              # Project context            │
└─────────────────────────────────────────────────────────┘
```

**Installation Options:**

1. **Global Install (Recommended):**

   ```bash
   # From dev-infra repository
   ./scripts/install-commands.sh --global
   # Copies commands to ~/.cursor/commands/
   ```

2. **Project Install (Opt-in):**

   ```bash
   ./scripts/install-commands.sh --local
   # Copies commands to ./.cursor/commands/
   ```

3. **Template Generation:**
   ```bash
   ./scripts/new-project.sh
   # Option: Include commands? [y/N]
   # N = rely on global commands
   # y = copy to project
   ```

**Implications:**

| Aspect           | Before (v1)                | After (v2)                |
| ---------------- | -------------------------- | ------------------------- |
| Command Location | Embedded in templates      | Global + optional project |
| Updates          | Sync per-project           | Update globally once      |
| Feedback Loop    | Per-project learnings      | Centralized analytics     |
| Template Size    | Heavy (~20 command files)  | Light (optional)          |
| New Projects     | Get commands automatically | Rely on global or opt-in  |

**Research Results (2025-12-22):**

| Question                                      | Answer        | Test                              |
| --------------------------------------------- | ------------- | --------------------------------- |
| Do project commands override global?          | ✅ YES        | Project `/status` overrode global |
| Is agent aware of global when project exists? | ❌ NO (good!) | Clean isolation                   |
| Do global rules work?                         | ❌ NO         | `~/.cursor/rules/` not loaded     |

**Confirmed Architecture:**

- Commands: Two-tier (global fallback, project override) ✅
- Rules: Project-only (no global support) ❌

---

## 🤔 Why This Shift?

### What We Learned

1. **Single User Reality**

   - No external users to satisfy
   - No need for complex graduation processes (removed in v0.7.0)
   - Can iterate quickly based on personal learnings

2. **Learning Loop**

   - Using templates reveals gaps
   - Gaps inform template improvements
   - Improvements enable better projects
   - Better projects reveal more gaps

3. **Infrastructure vs Features**
   - Less focus on "features for developers"
   - More focus on "infrastructure for project management"
   - The value is in structure and guidance, not tooling

---

## 💡 Initial Thoughts

### Template Metadata System

```yaml
# .dev-infra.yml (in generated projects)
template: standard-project
version: 0.7.0
created: 2025-12-18
last_sync: 2025-12-18

# What files to sync automatically
sync:
  always:
    - .cursor/commands/
    - .gitignore
  ask:
    - docs/maintainers/planning/
  never:
    - README.md
    - backend/
    - frontend/

# Project-specific overrides
customizations:
  - removed: .cursor/commands/status.md # User removed intentionally
```

### Sync CLI Concept (Updated for proj-cli)

```bash
# Create new project from template
proj new myapp --template standard

# Check what's new in dev-infra
proj sync --check

# Sync specific files/patterns
proj sync --commands  # Just commands
proj sync --structure # Just directory structure
proj sync --all       # Everything syncable

# Adopt dev-infra in existing project
proj adopt --template standard-project --dry-run
proj adopt --template standard-project --apply
```

**Note:** These commands are implemented in proj-cli, which consumes dev-infra templates.

### Version Compatibility Matrix

| Project Version | Dev-Infra Version | Sync Status                         |
| --------------- | ----------------- | ----------------------------------- |
| 0.6.0           | 0.7.0             | ⚠️ Breaking changes - manual review |
| 0.7.0           | 0.7.0             | ✅ In sync                          |
| 0.7.0           | 0.8.0             | 🔄 Updates available                |

---

## 🔍 Key Questions

### Identity

- [x] Should dev-infra be primarily a template factory? **YES - decided in ADR-001**
- [ ] Should it also be an infrastructure manager? **Exploring**

### Sync System

- [ ] What's the minimum viable sync system?
- [ ] How to handle conflicts/customizations?
- [ ] Should sync be automatic or always manual?

### Template Metadata

- [ ] What metadata is essential?
- [ ] Where should it live? (`.dev-infra.yml`, `package.json`, etc.)
- [ ] How to handle version migrations?

### External Adoption

- [ ] Is "adopt existing project" worth the complexity?
- [ ] Or just focus on new projects + updates?

---

## 🎭 Identity Clarification

### What Dev-Infra IS (Updated v4)

1. **Command Hub** - Provides global commands installable to `~/.cursor/commands/` (NEW!)
2. **Template Factory** - Produces project templates
3. **Template Layer** - Source consumed by proj-cli (v3 insight)
4. **Pattern Library** - Encodes workflow patterns in commands
5. **Sync Rules Provider** - Defines what/how to sync (metadata, manifests)
6. **Feedback Collector** - Gathers usage patterns to improve commands/templates

### What Dev-Infra is NOT

1. ~~CLI Tool~~ - proj-cli is the CLI; dev-infra provides templates and commands
2. ~~Feature Platform~~ - Not trying to build features for broad audiences
3. ~~Workflow Optimizer~~ - Not optimizing for complex scenarios
4. ~~Multi-User System~~ - Single user (for now), can scale later

---

## 🚀 Next Steps

1. **Test command override:** Verify project commands override global commands
2. **Test global rules:** See if `~/.cursor/rules/` works like commands
3. **Create install script:** `scripts/install-commands.sh` for global installation
4. **Update template generator:** Add "Include commands?" option
5. **Research:** Complete template metadata research (in progress)
6. **Coordinate with proj-cli:** Align on template integration architecture
7. **Decision:** ADR for global command distribution

**See also:** [proj-cli-architecture exploration](https://github.com/grimm00/proj-cli/blob/develop/docs/maintainers/planning/explorations/proj-cli-architecture/exploration.md)

---

## 📝 Historical Notes

### v1 Exploration (2025-12-11)

The original exploration identified three identities:

1. Laboratory (Workflow Experimentation)
2. Factory (Template Production)
3. Reference Implementation (Dogfooding)

**Resolution:** v0.7.0 simplified to "Template Factory" with "Commands as Guides" philosophy.

### From v0.7.0 Command Simplification

- Removed experimental template
- All templates get all commands
- Graduation process archived
- ADR-001: Commands as Guides established

### From v3 proj-cli Integration (2025-12-22)

- Realized proj-cli should be the CLI layer
- Dev-infra becomes "template layer" consumed by proj-cli
- No need for dev-infra to build its own CLI
- Research Topic 6 (CLI vs Script) resolved: use proj-cli

### From v4 Global Commands Discovery (2025-12-22)

- **Discovery:** Cursor reads commands from `~/.cursor/commands/` globally
- **Validation:** Created `~/.cursor/commands/foobar.md`, invoked `/foobar` successfully
- **Implication:** Dev-infra can provide commands installable globally, not just per-template
- **New Identity:** Dev-infra is now "Command Hub + Template Factory"
- **New Scenario:** Scenario 6 (Global Command Distribution) added
- **Context:** Discovery made during workspace exploration session

---

**Last Updated:** 2025-12-22
