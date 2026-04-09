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

| Audience | Channel | Packaging | Update Model |
|----------|---------|-----------|-------------|
| **Personal/local projects** | Template generation (`new-project.sh`) | Skills seeded into `.claude/skills/` at project creation | Manual -- user re-runs generator or copies from dev-infra |
| **Team** | Claude Code marketplace (internal) | Plugin package with `.claude-plugin/plugin.json` + `marketplace.json` | Automatic -- `/plugin marketplace update` pulls latest |

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

| Category | Examples | Template? | Marketplace? | Rationale |
|----------|----------|-----------|-------------|-----------|
| **Workflow skills** | `/explore`, `/research`, `/task`, `/pr`, `/review` | Yes | Maybe | These define dev-infra's methodology. Projects may customize. |
| **Behavioral skills** | `/discuss` | Yes | Maybe | Behavioral contract may need project-specific tuning. |
| **Team utility skills** | `/update-pr-description`, code review standards | No | Yes | Team-specific, not methodology. Not relevant outside team. |
| **Background knowledge** | Code conventions, hub-and-spoke patterns | Yes | No | Context-layer content, not invocable skills. |

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

### Finding 9: A Monorepo Marketplace Can Coexist in the Dev-Infra Repo

Two viable architectures exist for hosting the marketplace:

**Option A: Marketplace in dev-infra repo (monorepo)**
```
dev-infra/
├── templates/
│   ├── standard-project/
│   │   └── .claude/skills/...     ← template-distributed skills
│   └── learning-project/
│       └── .claude/skills/...     ← template-distributed skills (synced via manifest)
├── marketplace/                    ← NEW: marketplace distribution
│   ├── .claude-plugin/
│   │   └── marketplace.json
│   └── plugins/
│       └── dev-infra-workflows/
│           ├── .claude-plugin/
│           │   └── plugin.json
│           └── skills/
│               ├── explore/SKILL.md
│               └── research/SKILL.md
└── scripts/
    └── publish-marketplace.sh      ← NEW: copies skills from templates/ to marketplace/
```

**Option B: Separate marketplace repo**
```
dev-infra/                          ← source
├── templates/
│   └── .claude/skills/...

dev-infra-marketplace/              ← separate repo
├── .claude-plugin/
│   └── marketplace.json
└── plugins/
    └── dev-infra-workflows/
        └── skills/...
```

**Trade-offs:**

| Factor | Monorepo (A) | Separate Repo (B) |
|--------|-------------|-------------------|
| **Simplicity** | Single repo, single PR | Two repos, cross-repo PRs |
| **Sync verification** | CI can compare templates/ vs marketplace/ in same repo | Requires cross-repo CI or manual sync |
| **Access control** | Same permissions for both | Can restrict marketplace access |
| **Version independence** | Must tag or branch for marketplace versions | Independent versioning natural |
| **User install** | Users add marketplace from dev-infra repo URL | Users add marketplace from dedicated repo URL |

**Recommendation:** Option A (monorepo) for dev-infra's scale. The team is small, the skill count is manageable, and having CI verify template-to-marketplace sync in a single repo is a significant simplicity win. A separate repo adds coordination overhead without clear benefit at this scale.

**Source:** Industry patterns (Finding 6); Claude Code marketplace docs

---

## 🔍 Analysis

### The Dual-Distribution Lifecycle

```
┌──────────────────────────────────────────────────────────────┐
│                    DEV-INFRA (Source of Truth)                │
│                                                              │
│  1. Author skill in templates/standard-project/.claude/skills│
│  2. Test locally in Cursor (template path)                   │
│  3. Template sync CI validates standard ↔ learning parity    │
│                                                              │
│  ┌──────────────┐          ┌──────────────────┐              │
│  │  TEMPLATE    │          │  MARKETPLACE     │              │
│  │  CHANNEL     │          │  CHANNEL         │              │
│  │              │          │                  │              │
│  │  new-project │          │  publish script  │              │
│  │  .sh copies  │          │  copies skills   │              │
│  │  skills to   │          │  to marketplace/ │              │
│  │  new project │          │  directory;      │              │
│  │              │          │  bump version    │              │
│  └──────┬───────┘          └────────┬─────────┘              │
│         │                           │                        │
└─────────┼───────────────────────────┼────────────────────────┘
          │                           │
          ▼                           ▼
  ┌───────────────┐          ┌──────────────────┐
  │ New Project   │          │ Team members     │
  │ (.claude/     │          │ run /plugin      │
  │  skills/ in   │          │ install from     │
  │  project dir) │          │ marketplace      │
  │               │          │                  │
  │ Snapshot;     │          │ Snapshot at      │
  │ evolves       │          │ install; update  │
  │ independently │          │ via /plugin      │
  │               │          │ marketplace      │
  └───────────────┘          │ update           │
                             └──────────────────┘
```

### Three Sync Boundaries

The dual-distribution model has three distinct sync boundaries, each with different characteristics:

1. **Intra-template sync** (standard ↔ learning): Enforced by `template-sync-manifest.txt` + CI. Files must be identical. Existing infrastructure handles this.

2. **Source → marketplace sync** (templates/ → marketplace/): A publish step that copies skills from the canonical template location to the marketplace plugin structure. Verified by CI (diff between source and marketplace copies). New infrastructure needed: publish script + CI check.

3. **Marketplace → consumer sync** (marketplace → installed): Managed by Claude Code's plugin update mechanism. Not dev-infra's responsibility beyond versioning.

### The Marketplace Bug Asymmetry Is Actually a Feature

C-3 (Cursor marketplace bug hiding `disable-model-invocation` skills) initially seemed like a blocker. But the audience split resolves it:

- Cursor users get skills via template distribution (project-local `.claude/skills/`)
- Claude Code users get skills via marketplace distribution (no bug)

This means dev-infra doesn't need to work around C-3 at all -- the natural distribution model avoids it.

**Key Insights:**
- [x] Insight 1: Distribution channels are inherently snapshot-based. "Keeping them in sync" is a publish step, not a live synchronization problem.
- [x] Insight 2: Template-sync-manifest extends to skills with zero tooling changes -- the manifest is just a list of relative paths.
- [x] Insight 3: The marketplace bug (C-3) is avoided by the natural audience split: templates for Cursor users, marketplace for Claude Code users.
- [x] Insight 4: The monorepo marketplace model (Option A) is the right choice for dev-infra's scale.
- [x] Insight 5: `plugin.json` adds minimal overhead -- one file with name + version + description. Skills don't change for marketplace distribution.

---

## 💡 Recommendations

- [x] **Adopt the template-first authoring model.** Skills are authored and tested in `templates/standard-project/.claude/skills/`. The template path is the canonical source of truth. The marketplace is a downstream publish target.

- [x] **Add a `publish-marketplace.sh` script.** A simple script that copies skills from `templates/standard-project/.claude/skills/` to `marketplace/plugins/dev-infra-workflows/skills/`, bumps the `plugin.json` version, and validates the result. Run manually before tagging a release.

- [x] **Extend template-sync-manifest incrementally.** When commands migrate to skills, replace `.cursor/commands/explore.md` with `.claude/skills/explore/SKILL.md` (and companion files) in the manifest. No tooling changes needed.

- [x] **Add a source-to-marketplace CI check.** Alongside the existing intra-template sync check, add a CI step that verifies `marketplace/plugins/*/skills/` matches `templates/standard-project/.claude/skills/` for publishable skills. This catches publish-step omissions.

- [x] **Use the monorepo marketplace model (Option A).** Host `marketplace/` within the dev-infra repo. Users add it with `/plugin marketplace add <dev-infra-repo-url>/marketplace`. The monorepo simplifies CI verification and keeps version history unified.

- [x] **Create a publish matrix document.** Maintain a simple table mapping each skill to its distribution channels (template-only, marketplace-only, both). This prevents accidental publication of project-specific or background-knowledge skills to the marketplace.

---

## 📋 Requirements Discovered

- [x] **FR-18: Skills Must Be Authored in Templates as Canonical Source.** The canonical location for all dev-infra skills is `templates/standard-project/.claude/skills/[skill-name]/`. Skills are developed, tested, and versioned here. The marketplace is a downstream distribution target, not an authoring location. Template sync (FR-13) ensures `learning-project` stays in parity.
  **Source:** Findings 1, 6 (single source of truth pattern)
  **Priority:** High

- [x] **FR-19: Marketplace Distribution Must Use a Publish Script.** A `publish-marketplace.sh` script must copy publishable skills from the canonical template location to `marketplace/plugins/[plugin-name]/skills/`, bump the `plugin.json` version field, and validate the result. The script must accept a `--dry-run` flag. Skills are not published automatically -- the publish step is explicit and versioned.
  **Source:** Findings 2, 3, 6 (snapshot model, industry pattern)
  **Priority:** Medium (required at marketplace launch, not before)

- [x] **FR-20: CI Must Verify Source-to-Marketplace Sync.** A CI check must compare publishable skills in `templates/standard-project/.claude/skills/` against their copies in `marketplace/plugins/*/skills/`. Drift must fail CI with a clear message identifying which files diverged. This complements intra-template sync (FR-13) -- they are independent checks.
  **Source:** Findings 5, 6 (CI drift detection pattern)
  **Priority:** Medium (required at marketplace launch)

- [x] **FR-21: Each Skill Must Declare Its Distribution Channels.** A publish matrix document (or metadata within the skill) must declare whether each skill is distributed via templates, marketplace, or both. Background knowledge skills (FR-5) are template-only. Team utility skills may be marketplace-only. Workflow skills default to both. This prevents accidental overpublishing or underpublishing.
  **Source:** Finding 7 (skill categorization)
  **Priority:** Medium

- [x] **NFR-2: Marketplace Updates Must Not Overwrite Project Customizations.** When a user installs or upgrades a marketplace plugin, the plugin's skills are installed to Claude Code's plugin cache, not to the project's `.claude/skills/` directory. Project-local skill customizations (made after template generation) must not be affected by marketplace updates. This is inherently satisfied by Claude Code's plugin caching model but must be documented as a design constraint.
  **Source:** Finding 3 (plugin caching model)
  **Priority:** Medium (architectural constraint)

---

## 🚀 Next Steps

1. Feed FR-18 into the transition plan: template-first authoring affects the migration ordering
2. Feed FR-19/FR-20 into implementation planning: the marketplace publish script and CI check are new infrastructure
3. Feed Finding 4 (C-3 audience split) into `--consolidate`: C-3's impact can be downgraded since the natural distribution model avoids it
4. Feed Finding 7 (skill categorization) into the design document: the publish matrix is a design artifact

---

**Last Updated:** 2026-04-09
