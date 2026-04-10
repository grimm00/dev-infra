# Research: Dual-Distribution Workflow

**Research Topic:** Agentic Workflow Modernization
**Question:** How should dev-infra maintain sync between skills distributed through templates and skills distributed through a marketplace?
**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-03-25
**Completed:** 2026-04-09

---

## 🎯 Research Question

Dev-infra's template system and a team marketplace are two independent distribution channels for skills. How does this dual-distribution model work concretely: how are skills authored, how are they synced, and what happens when they diverge?

---

## 🔍 Research Goals

- [x] Model the dual-distribution lifecycle: author in dev-infra → test in template → publish to marketplace vs marketplace-first
- [x] Determine how the existing `template-sync-manifest.txt` approach extends to cover skill files
- [x] Identify what marketplace metadata (`plugin.json`) is required and what dev-infra provides vs what the marketplace adds
- [x] Assess whether the `update-pr-description` skill distribution pattern (team marketplace → `.agents/skills/`) is the right model for dev-infra skills

---

## 📚 Research Methodology

**Context already established:**

- Team marketplace deploys to `.agents/skills/` directory (confirmed by user)
- `template-sync-manifest.txt` already handles cross-template file sync validation in CI
- Skills are developed in Cursor but packaged for Claude Code marketplace consumption
- Two distribution paths: (1) in-template for immediate use, (2) marketplace for team-wide publishing

**Sources consulted:**

- [x] Reviewed `scripts/template-sync-manifest.txt` -- 26 command files + `.sourcery.yaml` tracked; line-by-line file comparison; extensible to skill paths
- [x] Reviewed `scripts/validate-template-sync.sh` -- diff-based comparison between `standard-project/` and `learning-project/`; exits non-zero on drift
- [x] Web search: Claude Code plugin marketplace distribution and publishing workflows (2026)
- [x] Web search: monorepo skill publishing automation, cross-platform distribution patterns
- [x] Web search: `plugin.json` manifest structure, required fields, marketplace metadata
- [x] Web search: custom/self-hosted Claude Code marketplace distribution (`marketplace.json`)
- [x] [Claude Code Marketplace Docs](https://code.claude.com/docs/en/plugin-marketplaces) -- official walkthrough for creating and hosting marketplaces
- [x] [systemprompt.io: Publishing a Plugin to the Claude Marketplace](https://systemprompt.io/guides/publish-plugin-claude-marketplace) -- practical end-to-end guide
- [x] Cross-referenced with Topic 3 (conversion mechanics: `plugin.json` carries marketplace metadata only)
- [x] Cross-referenced with Topic 5 (portability: `.claude/skills/` as canonical location, C-3 marketplace bug)

---

## 📊 Findings

### Finding 1: Dev-Infra Has Two Distinct Audiences with Different Distribution Needs

The dual-distribution question maps to two fundamentally different audiences:

| Audience                    | Channel                                | Packaging                                                             | Update Model                                              |
| --------------------------- | -------------------------------------- | --------------------------------------------------------------------- | --------------------------------------------------------- |
| **Personal/local projects** | Template generation (`new-project.sh`) | Skills seeded into `.claude/skills/` at project creation              | Manual -- user re-runs generator or copies from dev-infra |
| **Team**                    | Claude Code marketplace (internal)     | Plugin package with `.claude-plugin/plugin.json` + `marketplace.json` | Automatic -- `/plugin marketplace update` pulls latest    |

The template channel is a **snapshot**: skills are copied once at project creation and evolve independently. The marketplace channel is a **live feed**: skills are pulled from a central source and can be updated in place.

This creates an asymmetry: template-distributed skills drift from their source over time (by design -- projects customize), while marketplace-distributed skills are expected to stay in sync with the source.

**Relevance:** Dev-infra must decide which channel is authoritative and design the workflow accordingly.

---

### Finding 2: The Claude Code Custom Marketplace Model Is Lightweight and Well-Suited for Teams

Claude Code supports self-hosted custom marketplaces with minimal infrastructure:

**Structure:**

```
team-marketplace/
├── .claude-plugin/
│   └── marketplace.json       # Catalog: lists plugins and their sources
├── plugins/
│   ├── workflow-skills/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json    # Plugin manifest (name, version, description)
│   │   └── skills/
│   │       ├── explore/
│   │       │   └── SKILL.md
│   │       └── research/
│   │           ├── SKILL.md
│   │           └── assets/
│   │               └── research-doc.md
│   └── review-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
│           └── code-review/
│               └── SKILL.md
```

**`marketplace.json` (minimal):**

```json
{
  "name": "team-dev-tools",
  "owner": { "name": "DevTools Team" },
  "plugins": [
    {
      "name": "workflow-skills",
      "source": "./plugins/workflow-skills",
      "description": "Dev-infra workflow skills (explore, research, task, etc.)"
    }
  ]
}
```

**`plugin.json` (minimal):**

```json
{
  "name": "workflow-skills",
  "description": "Dev-infra workflow skills for structured development",
  "version": "1.0.0"
}
```

**Key operational details:**

- Users add with `/plugin marketplace add <repo-url-or-local-path>`
- Install with `/plugin install workflow-skills@team-dev-tools`
- Update with `/plugin marketplace update`
- Plugins are copied to a cache location on install -- they cannot reference files outside their directory (no `../shared-utils` paths)
- Symlinks ARE followed during copying (allows shared resources)

**Relevance:** The marketplace infrastructure is simple enough that dev-infra doesn't need additional tooling to create a team marketplace. The main decision is organizational: how to structure the marketplace repo relative to dev-infra.

**Source:** [Claude Code Marketplace Docs](https://code.claude.com/docs/en/plugin-marketplaces)

---

### Finding 3: The Plugin Caching Model Creates a Hard Boundary Between Template and Marketplace Distribution

A critical architectural constraint: when Claude Code installs a plugin via marketplace, it **copies** the plugin directory to a local cache. The installed plugin is isolated from its source. This means:

1. **No live symlinks between dev-infra source and installed plugin.** The marketplace is a snapshot-at-install, not a live reference. Users must run `/plugin marketplace update` + `/plugin install --upgrade` to get updates.
2. **Plugin files cannot reference paths outside the plugin directory.** The `../` path pattern is blocked. If a skill needs shared assets, those assets must be duplicated within the plugin or linked via symlinks (which are resolved at copy time).
3. **Template-distributed skills and marketplace-distributed skills are structurally identical.** Both are files on disk in `.claude/skills/`. The difference is how they got there: one via `new-project.sh`, the other via marketplace install.

**Implication:** There is no "live sync" mechanism between template and marketplace channels. They are inherently snapshot-based. Drift is managed by versioning and explicit updates, not by continuous synchronization.

**Source:** Claude Code Marketplace Docs: "When users install a plugin, Claude Code copies the plugin directory to a cache location."

---

### Finding 4: C-3 (Marketplace Bug) Affects Only Cursor Plugin Distribution, Not Claude Code

Topic 1 identified C-3: `disable-model-invocation: true` completely hides marketplace-delivered skills from Cursor's `/` command palette. This was flagged as a constraint on the dual-distribution model.

However, this bug is **Cursor-specific**. The Claude Code marketplace does not exhibit this behavior (Topic 5, Finding 7 table). Skills with `disable-model-invocation: true` work correctly when installed via Claude Code's marketplace.

This means the dual-distribution model has an asymmetric bug profile:

- **Claude Code marketplace:** Skills with `disable-model-invocation: true` work correctly (can be invoked via `/skill-name`)
- **Cursor marketplace:** Skills with `disable-model-invocation: true` are invisible (C-3 bug)

**Implication for dev-infra:** The marketplace channel should target Claude Code users (where the bug doesn't exist). Cursor users receive skills via template distribution (`.claude/skills/` in the project, discovered by Cursor per FR-16). This aligns with the natural audience split: personal/local projects use templates (Cursor), team distribution uses marketplace (Claude Code).

**Source:** Topic 1 (C-3), Topic 5 (Finding 7 bug comparison table)

---

### Finding 5: The Template-Sync Manifest Extends Naturally to Skill Files

Dev-infra's existing `template-sync-manifest.txt` tracks 26 command files + `.sourcery.yaml` that must be identical between `standard-project/` and `learning-project/`. The `validate-template-sync.sh` script compares files line-by-line and exits non-zero on drift.

When commands migrate to skills, the manifest simply replaces command paths with skill paths:

**Current (commands):**

```txt
.cursor/commands/explore.md
.cursor/commands/research.md
.cursor/commands/task.md
```

**After migration (skills):**

```txt
.claude/skills/explore/SKILL.md
.claude/skills/explore/assets/exploration-full.md
.claude/skills/research/SKILL.md
.claude/skills/research/assets/research-doc.md
.claude/skills/task/SKILL.md
```

The key difference: skills have companion directories (`assets/`, `references/`), so the manifest must track individual files within those directories, not just the `SKILL.md`. This was already anticipated by FR-13.

**What changes:**

- **Manifest format:** No change needed. The manifest already uses relative paths from template root. Skill paths work identically.
- **Validation script:** No change needed. `validate-template-sync.sh` already does file-by-file diff comparison. It doesn't care whether files are commands or skills.
- **CI integration:** No change needed. The existing CI workflow runs `validate-template-sync.sh`.

**What doesn't change:** The fundamental model. Template sync ensures the two template types (standard, learning) stay in sync. This is an intra-template concern, not a template-to-marketplace concern.

**Relevance:** Template sync is orthogonal to marketplace distribution. They solve different problems: template sync prevents drift between template types; marketplace versioning prevents drift between source and installed copies.

**Source:** `scripts/template-sync-manifest.txt`, `scripts/validate-template-sync.sh`

---

### Finding 6: The Industry Pattern Is "Single Source of Truth with Multiple Distribution Targets"

The monorepo skill sync landscape (2026) has converged on a pattern:

1. **Canonical source in one repo** -- skills are authored and tested in a single location
2. **Distribution via build/publish step** -- a script or CI job copies/transforms skills into the required format for each target
3. **Symlinks for local multi-agent sync** -- if multiple local agents need the same skills, symlinks avoid duplication
4. **Drift detection in CI** -- automated checks verify targets stay in sync with source

Notable implementations:

- **OpenSite Skills Library:** Centralized monorepo with `setup.sh` that creates symlinks from each agent's skill directory back to the repo. Detects installed agents, pushes only changed skills.
- **skill-multi-publisher:** Automates publishing a single skill to multiple marketplaces in one command. Validates SKILL.md, auto-generates missing metadata, submits PRs.
- **Nx integration:** `npx nx configure-ai-agents` generates configurations for Claude Code, Cursor, Copilot, Gemini, Codex from a single source.

**Key insight:** None of these solutions try to keep two distribution channels "in sync" at runtime. They all accept that distribution channels are snapshots and manage the authoring → publish lifecycle instead.

**Relevance:** Dev-infra should follow this pattern: author skills in dev-infra (single source of truth), publish to templates AND marketplace via explicit steps (not automatic sync), accept that drift after distribution is expected and managed by versioning.

**Source:** [OpenSite Skills Library](https://dev.to/opensite/one-repo-every-ai-agent-zero-drift-introducing-the-opensite-skills-library-2k3g); [skill-multi-publisher](https://lobehub.com/skills/openclaw-skills-skill-multi-publisher); [Nx AI Agent Skills](https://nx.dev/blog/nx-ai-agent-skills)

---

### Finding 7: Dev-Infra Should Separate "Workflow Skills" from "Team Utility Skills"

Not all skills belong on both channels. The research reveals a natural categorization:

| Category                 | Examples                                           | Template? | Marketplace? | Rationale                                                     |
| ------------------------ | -------------------------------------------------- | --------- | ------------ | ------------------------------------------------------------- |
| **Workflow skills**      | `/explore`, `/research`, `/task`, `/pr`, `/review` | Yes       | Maybe        | These define dev-infra's methodology. Projects may customize. |
| **Behavioral skills**    | `/discuss`                                         | Yes       | Maybe        | Behavioral contract may need project-specific tuning.         |
| **Team utility skills**  | `/update-pr-description`, code review standards    | No        | Yes          | Team-specific, not methodology. Not relevant outside team.    |
| **Background knowledge** | Code conventions, hub-and-spoke patterns           | Yes       | No           | Context-layer content, not invocable skills.                  |

**Key distinction:** Workflow skills benefit from template distribution because projects should own and customize their development methodology. Team utility skills benefit from marketplace distribution because they enforce team-wide standards that shouldn't diverge.

Some skills may appear on both channels: a team might publish workflow skills to the marketplace so that existing (non-template-generated) projects can adopt the methodology without regenerating from a template. But this is opt-in, not the default.

**Relevance:** The categorization determines the publish matrix: which skills go where.

---

### Finding 8: The Marketplace Requires Minimal Additional Metadata Beyond What Skills Already Have

A Claude Code plugin's `plugin.json` requires only one field:

- `name` (required, kebab-case)

Recommended fields:

- `version` (semver, defaults to `0.1.0`)
- `description` (50-200 chars)
- `author` (object: `{ name, email?, url? }`)

The skill itself (`SKILL.md`) carries the behavioral contract, the description, and the frontmatter. The `plugin.json` is purely marketplace metadata -- it adds nothing to the skill's behavior.

**What dev-infra needs to add for marketplace distribution:**

1. A `.claude-plugin/plugin.json` per publishable plugin bundle
2. A `.claude-plugin/marketplace.json` if hosting a custom marketplace
3. A versioning strategy (semver on `plugin.json` version field)
4. A CHANGELOG per plugin (marketplace best practice)

**What dev-infra does NOT need:**

- Changes to SKILL.md format
- Changes to companion directories
- Platform-specific skill variants

**Relevance:** The packaging overhead is low. The main cost is maintaining version numbers and a changelog, not restructuring skills.

**Source:** [Claude Code Plugin Manifest Reference](https://code.claude.com/docs/en/plugins-reference)

---

### Finding 9: The Team Marketplace Is a Downstream Consumer, Not Dev-Infra's Responsibility

**Reframed (2026-04-10):** The original analysis proposed hosting a `marketplace/` directory inside dev-infra (Option A) or a separate marketplace repo (Option B). Both overcomplicate the model. The simpler framing:

- **Dev-infra is the superset.** All skills live in `.claude/skills/` within templates, packaged in marketplace-compatible format (SKILL.md + companion dirs).
- **The team marketplace is a curated subset.** The team's marketplace repo cherry-picks specific skills from dev-infra and bundles them as a Claude Code plugin. This is the team's concern, not dev-infra's.
- **Shipment is a manual copy + PR.** When a skill is ready for team distribution, the skill directory is copied from dev-infra to the team marketplace repo. No publish script needed in dev-infra -- the format is already 1:1.

```
dev-infra/                             ← superset (source of truth)
├── templates/standard-project/
│   └── .claude/skills/
│       ├── explore/SKILL.md           ← all skills, marketplace-compatible format
│       ├── research/SKILL.md
│       ├── discuss/SKILL.md
│       └── task/SKILL.md

team-marketplace/                      ← curated subset (team-owned, separate repo)
├── .claude-plugin/
│   ├── marketplace.json
│   └── plugin.json
└── skills/
    ├── explore/SKILL.md               ← cherry-picked from dev-infra
    └── research/SKILL.md              ← only skills relevant to the team
```

**What dev-infra does:**
- Authors and tests skills in `.claude/skills/` format
- Ensures skills are structurally valid (SKILL.md + companion dirs)
- Template sync ensures standard ↔ learning parity

**What dev-infra does NOT do:**
- Host a marketplace directory
- Maintain a publish script
- Run CI checks for marketplace sync (that's the team marketplace repo's job)

**Empirical validation (2026-04-10):** Cursor discovers skills installed via Claude Code's plugin cache at `~/.claude/plugins/cache/`. The team's Hex plugin skills appear in Cursor's command palette as `hex:brainstorm`, `hex:write-plan`, etc. -- with Cursor prepending the plugin name from `plugin.json` for namespacing. This confirms that skills published to the team marketplace are automatically available in Cursor too, without any dev-infra-side packaging.

**Source:** Industry patterns (Finding 6); empirical testing of Hex plugin cross-discovery in Cursor

---

## 🔍 Analysis

### The Dual-Distribution Lifecycle (Reframed)

```
┌──────────────────────────────────────────────────────────────┐
│                    DEV-INFRA (Superset / Source of Truth)     │
│                                                              │
│  1. Author skill in templates/standard-project/.claude/skills│
│  2. Test locally in Cursor (template path)                   │
│  3. Template sync CI validates standard ↔ learning parity    │
│  4. Skills already in marketplace-compatible format (1:1)    │
│                                                              │
│  ┌──────────────┐                                            │
│  │  TEMPLATE    │                                            │
│  │  CHANNEL     │                                            │
│  │  new-project │                                            │
│  │  .sh copies  │                                            │
│  │  skills to   │                                            │
│  │  new project │                                            │
│  └──────┬───────┘                                            │
│         │                                                    │
└─────────┼────────────────────────────────────────────────────┘
          │
          ▼
  ┌───────────────┐
  │ New Project   │
  │ (.claude/     │    ┌──────────────────────────────────────┐
  │  skills/ in   │    │  TEAM MARKETPLACE (Separate Repo)    │
  │  project dir) │    │  Curated subset of dev-infra skills  │
  │               │    │                                      │
  │ Snapshot;     │    │  Team copies skill dirs from         │
  │ evolves       │    │  dev-infra → opens PR to marketplace │
  │ independently │    │  repo → team members install via     │
  └───────────────┘    │  /plugin install                     │
                       └──────────────────────────────────────┘
```

### Two Sync Boundaries (Simplified from Three)

The reframed model reduces the sync concerns to two, with the third being external:

1. **Intra-template sync** (standard ↔ learning): Enforced by `template-sync-manifest.txt` + CI. Files must be identical. Existing infrastructure handles this.

2. **Dev-infra → team marketplace** (cherry-pick, manual): The team copies skill directories from dev-infra to their own marketplace repo via PR. This is the team's workflow, not dev-infra's CI concern. Dev-infra's contribution is maintaining skills in 1:1 marketplace-compatible format so the copy is frictionless.

3. **Marketplace → consumer sync** (marketplace → installed): Managed entirely by Claude Code's plugin update mechanism and the team marketplace repo's own CI/versioning. Not dev-infra's responsibility.

The original analysis proposed a third sync boundary (source → marketplace inside dev-infra) with a publish script and CI check. The reframed model eliminates this: there is no `marketplace/` directory in dev-infra, so there is nothing to keep in sync.

### The Marketplace Bug Asymmetry Is Actually a Feature

C-3 (Cursor marketplace bug hiding `disable-model-invocation` skills) initially seemed like a blocker. But the audience split resolves it:

- Cursor users get skills via template distribution (project-local `.claude/skills/`)
- Claude Code users get skills via marketplace distribution (no bug)
- Cursor users on the team also benefit: Cursor discovers skills in Claude Code's plugin cache with `plugin:skill` namespacing (empirically confirmed with Hex plugin)

This means dev-infra doesn't need to work around C-3 at all -- the natural distribution model avoids it.

**Key Insights:**

- [x] Insight 1: Distribution channels are inherently snapshot-based. "Keeping them in sync" is a cherry-pick-and-PR workflow, not a publish script or live synchronization problem.
- [x] Insight 2: Template-sync-manifest extends to skills with zero tooling changes -- the manifest is just a list of relative paths.
- [x] Insight 3: The marketplace bug (C-3) is avoided by the natural audience split: templates for Cursor users, marketplace for Claude Code users.
- [x] Insight 4: Dev-infra is the superset; the team marketplace is a curated subset in a separate repo. No `marketplace/` directory or publish script needed in dev-infra.
- [x] Insight 5: Authoring skills in `.claude/skills/` format makes them 1:1 compatible with marketplace packaging -- the copy is frictionless because the format matches.
- [x] Insight 6: Cursor discovers Claude Code plugin cache skills with `plugin:skill` namespacing, meaning team marketplace skills are accessible to Cursor users without separate packaging.

---

## 💡 Recommendations

- [x] **Adopt the template-first authoring model.** Skills are authored and tested in `templates/standard-project/.claude/skills/`. The template path is the canonical source of truth. The team marketplace is a downstream consumer, not an authoring or publish target within dev-infra.

- [x] ~~**Add a `publish-marketplace.sh` script.**~~ **Withdrawn (reframed 2026-04-10).** No publish script needed in dev-infra. Skills are already in marketplace-compatible format. The team copies skill directories to their own marketplace repo via PR. The shipment is 1:1 because the format matches.

- [x] **Extend template-sync-manifest incrementally.** When commands migrate to skills, replace `.cursor/commands/explore.md` with `.claude/skills/explore/SKILL.md` (and companion files) in the manifest. No tooling changes needed.

- [x] ~~**Add a source-to-marketplace CI check.**~~ **Withdrawn (reframed 2026-04-10).** Marketplace sync verification belongs in the team marketplace repo, not in dev-infra. Dev-infra's CI concern is intra-template sync only.

- [x] ~~**Use the monorepo marketplace model (Option A).**~~ **Withdrawn (reframed 2026-04-10).** The marketplace is a separate team-owned repo, not a directory in dev-infra. Dev-infra does not host marketplace infrastructure.

- [x] **Create a publish matrix document.** Maintain a simple table mapping each skill to its distribution channels (template-only, team-marketplace-eligible, both). This guides the team on which skills to cherry-pick. The matrix lives in dev-infra as a reference, not as automation.

---

## 📋 Requirements Discovered

- [x] **FR-18: Skills Must Be Authored in Templates as Canonical Source.** The canonical location for all dev-infra skills is `templates/standard-project/.claude/skills/[skill-name]/`. Skills are developed, tested, and versioned here. The marketplace is a downstream distribution target, not an authoring location. Template sync (FR-13) ensures `learning-project` stays in parity.
      **Source:** Findings 1, 6 (single source of truth pattern)
      **Priority:** High

- [x] **FR-19: Skills Must Be Authored in Marketplace-Compatible Format.** ~~(Previously: Marketplace Distribution Must Use a Publish Script.)~~ Skills in `templates/standard-project/.claude/skills/` must be structured so that the skill directory can be copied 1:1 into a Claude Code marketplace plugin without transformation. This means: `SKILL.md` at skill root, companion files in subdirectories, no references to paths outside the skill directory. The team marketplace is a separate repo that cherry-picks from dev-infra -- no publish script is needed in dev-infra itself.
      **Source:** Findings 2, 3, 9 (snapshot model, 1:1 format compatibility)
      **Priority:** High (structural constraint on skill authoring)

- [x] **FR-20: ~~CI Must Verify Source-to-Marketplace Sync.~~ Withdrawn.** Marketplace sync verification is the team marketplace repo's responsibility, not dev-infra's. Dev-infra CI covers intra-template sync (FR-13) only. This requirement is withdrawn and should not carry forward to design.
      **Source:** Finding 9 reframing (2026-04-10)
      **Priority:** N/A (withdrawn)

- [x] **FR-21: Each Skill Must Declare Its Distribution Channels.** A publish matrix document (or metadata within the skill) must declare whether each skill is distributed via templates, marketplace, or both. Background knowledge skills (FR-5) are template-only. Team utility skills may be marketplace-only. Workflow skills default to both. This prevents accidental overpublishing or underpublishing.
      **Source:** Finding 7 (skill categorization)
      **Priority:** Medium

- [x] **NFR-2: Marketplace Updates Must Not Overwrite Project Customizations.** When a user installs or upgrades a marketplace plugin, the plugin's skills are installed to Claude Code's plugin cache, not to the project's `.claude/skills/` directory. Project-local skill customizations (made after template generation) must not be affected by marketplace updates. This is inherently satisfied by Claude Code's plugin caching model but must be documented as a design constraint.
      **Source:** Finding 3 (plugin caching model)
      **Priority:** Medium (architectural constraint)

---

## 🚀 Next Steps

1. Feed FR-18 into the transition plan: template-first authoring affects the migration ordering
2. Feed FR-19 (1:1 format compatibility) into skill structure decisions: skills must be self-contained directories
3. Note FR-20 withdrawn: no marketplace CI in dev-infra (team marketplace repo handles its own sync)
4. Feed Finding 4 (C-3 audience split) into `--consolidate`: C-3's impact can be downgraded since the natural distribution model avoids it
5. Feed Finding 7 (skill categorization) into the design document: the publish matrix is a reference document, not automation

---

**Last Updated:** 2026-04-10
