# Research: Per-Repo Profile Location and Schema

**Status:** ✅ Complete
**Priority:** High
**Created:** 2026-05-06
**Completed:** 2026-05-07

---

## Research Question

Where should the unified per-repo skill profile live, what's its schema, and how do skills look it up?

---

## Research Goals

- [x] Evaluate candidate locations: `~/.cursor/repos/<slug>.yaml`, `~/.cursor/profiles/<slug>.yaml`, `~/.cursor/skills/_shared/repos/<slug>.yaml`, in-repo `.cursor/profile.yaml`
- [x] Define slug derivation strategy (repo basename, org/repo, remote URL hash, user-chosen)
- [x] Determine v1 schema fields: paths (artifact root, plan root, scratch), ticket conventions, skill version targeting
- [x] Assess migration cost of each location choice (if wrong, how hard to move later?)
- [x] Determine lookup convention: env var → explicit flag → config file → detection fallback
- [x] Evaluate relationship to `ticket-intake/repos/<slug>.yaml` (absorb, extend, or coexist?)
- [x] Determine whether in-repo files (AGENTS.md) can override/supplement the external profile

---

## Methodology

**Queries executed:**
1. "per-project configuration file patterns direnv mise asdf editorconfig tool-versions 2025 2026 best practices location"
2. "XDG Base Directory specification config state data directories 2025 2026 conventions for CLI tools"
3. "per-repository configuration external to repo patterns slug derivation git remote URL conventions tool config 2025 2026"
4. "YAML schema versioning best practices configuration file forward compatibility migration 2025 2026"
5. "cursor AI IDE configuration per project .cursor directory structure rules settings 2026"
6. "per-repo OR per-repository config file external to repository user home directory patterns examples tools 2025 2026"

**Internal sources consulted:**
- `~/.cursor/skills/ticket-intake/repos/*.yaml` — 5 existing per-repo YAML files
- `per-repo-skill-profile-unified.md` int-opp — proposed schema and improvements
- `skills-path-roots-configurable.md` int-opp — skill-level override patterns
- `skill-package-controller` exploration — three-tier authority model and registry concept

---

## Sources

- [x] `~/.cursor/skills/ticket-intake/repos/` — existing per-repo YAML precedent (5 files: config-ui, helm-charts, k8s-applications, launcher, nginx-config)
- [x] `per-repo-skill-profile-unified.md` int-opp — proposed schema sketch with `schema_version`, `ticket`, `paths` sections
- [x] `skills-path-roots-configurable.md` int-opp — three-tier precedence: invocation flag → per-repo config → hardcoded fallback
- [x] `skill-package-controller` exploration — Themes 2, 4, 5: registry as persistent state, three-tier authority, XDG separation
- [x] XDG Base Directory specification — config vs state vs data separation
- [x] Web search: per-project configuration patterns in other tool ecosystems (direnv, mise, asdf, editorconfig, roborev, lazygit, wt, git conditional includes)

---

## Findings

### Finding 1: The Two-Location Pattern Is Universal

**Source:** Web search: mise, direnv, roborev, git conditional includes
**Relevance:** Every mature tool ecosystem separates per-project config into two complementary locations:

1. **In-repo** (committed, shared with collaborators): `.editorconfig`, `mise.toml`, `.tool-versions`, `.roborev.toml`
2. **External to repo** (user-specific, not committed): `~/.config/mise/config.toml`, `~/.gitconfig` conditional includes, `~/.roborev/config.toml`

The in-repo file carries shared conventions; the external file carries user preferences and machine-specific overrides. Precedence: in-repo wins for shared conventions, external wins for personal preferences. This maps directly to the controller's three-tier authority: AGENTS.md (in-repo, Tier 1) + external profile (Tier 2) + detection fallback (Tier 3).

### Finding 2: XDG Separation of Config vs. State

**Source:** XDG Base Directory Specification; web search: CLI tool conventions 2025-2026
**Relevance:** The XDG spec distinguishes:

| Type | XDG Path | What goes here |
|------|----------|----------------|
| Config | `~/.config/<app>/` | User-editable settings (profile schema, paths, conventions) |
| State | `~/.local/state/<app>/` | Persistent but non-editable data (last-seen timestamps, setup state, detection cache) |
| Data | `~/.local/share/<app>/` | Application data files |
| Cache | `~/.cache/<app>/` | Disposable cached data |

Modern CLI tools (GitHub CLI, kubectl, docker, terraform) consistently use XDG paths on all platforms including macOS. The skill-package-controller exploration (Theme 5) already identified this: `~/.config/ai-workflow/repos/<slug>.yaml` for config, `~/.local/state/ai-workflow/` for state.

**Implication:** The per-repo profile (user-editable conventions) belongs in **config** (`~/.config/`). Controller metadata (setup state, last-seen) belongs in **state** (`~/.local/state/`). The current `~/.cursor/` location is pragmatic but Cursor-specific — XDG is the standards-compliant alternative.

### Finding 3: Current `~/.cursor/` Location Is Pragmatic but Non-Standard

**Source:** Internal: existing `~/.cursor/skills/`, `~/.cursor/commands/`, `~/.cursor/agents/` layout; Cursor documentation
**Relevance:** Cursor already uses `~/.cursor/` as its application directory:

- `~/.cursor/skills/` — skill definitions
- `~/.cursor/commands/` — command definitions
- `~/.cursor/agents/` — agent definitions
- `~/.cursor/rules/` — global rules
- `~/.cursor/hooks/` — session hooks

Adding `~/.cursor/repos/` follows the established pattern and is discoverable alongside existing config. However:
- It's Cursor-specific (won't transfer to Claude Code or other editors)
- It mixes config (user-editable) with state (detection cache) in one directory
- The `skills/ticket-intake/repos/` precedent nested it under a skill — the unified profile elevates it to top-level

**Tradeoff:** `~/.cursor/repos/` is pragmatically correct for single-editor use. XDG paths (`~/.config/ai-workflow/repos/`) are future-proof for multi-editor scenarios. Given that only one editor is supported today, pragmatism wins for v1.

### Finding 4: Slug Derivation — Basename Is Sufficient for v1

**Source:** Internal: existing `ticket-intake/repos/` files use plain repo names (`config-ui.yaml`, `launcher.yaml`); Web search: git-tool uses `{{ .Repo.FullName }}` patterns
**Relevance:** Slug derivation options:

| Strategy | Example | Pros | Cons |
|----------|---------|------|------|
| Repo basename | `dev-infra.yaml` | Simple, human-readable, existing precedent | Conflicts if user has two repos named `app` from different orgs |
| Org/repo | `grimm00-dev-infra.yaml` | Unique across orgs | Verbose, breaks if remote changes |
| Remote URL hash | `a3f2b1c.yaml` | Guaranteed unique | Unreadable, impossible to browse |
| User-chosen | `my-project.yaml` | Maximum flexibility | Requires explicit setup step |

The existing `ticket-intake` skill uses repo basename and it works — 5 repos with no collisions. For a single-user personal tool, basename collisions are rare and can be handled by user override (e.g., `dev-infra.yaml` vs `work-dev-infra.yaml`).

**Recommendation:** Use repo basename for v1 with an optional `slug` field in the profile itself for override. Derivation: `basename $(git remote get-url origin) .git` (strips trailing `.git`).

### Finding 5: mise's Hierarchical Config Is Instructive

**Source:** Web search: mise configuration, mise directory structure
**Relevance:** mise demonstrates the most mature hierarchical config pattern:

1. Global: `~/.config/mise/config.toml` (user defaults)
2. Per-directory: `mise.toml` in any ancestor directory (cascades upward)
3. Local override: `mise.local.toml` (gitignored, machine-specific)
4. Environment-specific: `mise.production.toml` (opt-in layers)

Key insight: mise doesn't force a choice between "in-repo" and "external." It supports both, with precedence rules. The per-repo profile can work the same way:
- External profile (`~/.cursor/repos/<slug>.yaml`) = user preferences, paths, ticket config
- In-repo AGENTS.md = shared conventions, build commands, architecture
- Skills resolve by checking both, with defined precedence per field

### Finding 6: Schema Versioning — Simple Integer Is Sufficient

**Source:** Web search: YAML schema versioning best practices; SUEWS implementation
**Relevance:** Best practices for config schema versioning:

- Use a `schema_version` field at the top level (integer, not semver)
- Minor additions (new optional fields) don't require version bump — forward-compatible by default
- Major structural changes bump the version and provide migration tooling
- If `schema_version` is absent, assume v1 (backwards compatibility)

The `per-repo-skill-profile-unified.md` int-opp already proposes `schema_version: 1`. This is correct. The schema should be additive — new sections can be added without breaking existing profiles.

### Finding 7: The Ticket-Intake Precedent Provides the v1 Schema Seed

**Source:** Internal: 5 existing `ticket-intake/repos/*.yaml` files
**Relevance:** The existing files establish a working schema:

```yaml
repo: launcher
remote: https://git.drwholdings.com/up-platform-infrastructure/launcher
detected_from: history
branch_format: "{ticket_id}/{slug}"
pr_title_format: "{type}: {ticket_id} {description}"
commit_format: "{type}: {description}"
default_branch: master
type_mapping:
  Story: feat
  Bug: fix
  ...
scopes: []
ticket_prefix: "UPPI"
```

The unified profile absorbs this as a `ticket:` section and adds parallel sections for other concerns. The `detected_from: history` field shows the profile already tracks provenance (how values were determined).

---

## Analysis

### The Location Decision

Three viable candidates remain after research:

| Location | Audience | Portability | Discoverability |
|----------|----------|-------------|-----------------|
| `~/.cursor/repos/<slug>.yaml` | Single-editor Cursor users | Cursor-only | High (alongside skills/commands/agents) |
| `~/.config/ai-workflow/repos/<slug>.yaml` | Multi-editor/future-proof | Any editor | Medium (follows XDG, less obvious) |
| In-repo `.cursor/profile.yaml` | Team/shared conventions | Travels with repo | High (committed, visible) |

**Recommendation:** `~/.cursor/repos/<slug>.yaml` for v1 (pragmatic, discoverable, existing pattern), with a documented migration path to XDG if/when multi-editor support matters. In-repo files (AGENTS.md) supplement but don't replace — they carry shared conventions, not personal preferences.

### The Schema Shape

The unified profile schema emerges naturally from combining:
- Existing `ticket-intake/repos/` fields → `ticket:` section
- `skills-path-roots-configurable.md` → `paths:` section
- Topic 9 (artifact management) → `artifacts:` section (location config)
- Controller metadata → `controller:` section (state, not user-editable — may live separately)

### The Lookup Convention

The three-tier resolution from `skills-path-roots-configurable.md` generalizes cleanly:

1. **Invocation flag** (explicit override for this run)
2. **In-repo AGENTS.md** (shared conventions, Tier 1 authority)
3. **External profile** (`~/.cursor/repos/<slug>.yaml`, Tier 2)
4. **Skill defaults / detection heuristics** (Tier 3 fallback)

Skills never need to know which tier provided the answer. The controller (or a shared lookup helper) resolves once, skills consume.

### The AGENTS.md Relationship

AGENTS.md and the external profile are complementary, not competing:

| Concern | Lives in AGENTS.md | Lives in external profile |
|---------|-------------------|--------------------------|
| Build commands | ✓ | |
| Architecture overview | ✓ | |
| Code style conventions | ✓ | |
| Ticket/branch conventions | | ✓ (personal workflow) |
| Artifact paths | | ✓ (personal preferences) |
| Artifact location strategy | | ✓ (per Topic 9) |
| Default base branch | ✓ (shared) | ✓ (override) |

AGENTS.md is the **repo's opinion about itself** (committed, shared). The profile is the **user's opinion about how they work in this repo** (external, personal). When both specify the same field, precedence depends on the field type: shared conventions (AGENTS.md wins), personal workflow (profile wins).

---

## Recommendations

- [x] Use `~/.cursor/repos/<slug>.yaml` as the v1 profile location — pragmatic, discoverable, consistent with existing `~/.cursor/` layout
- [ ] Use repo basename as slug derivation (`basename $(git remote get-url origin) .git`) with an optional `slug:` override field
- [ ] Start with `schema_version: 1` and three sections: `ticket:`, `paths:`, `artifacts:` — additive expansion without version bumps for new optional fields
- [ ] Implement the lookup convention as: invocation flag → AGENTS.md → external profile → skill defaults
- [ ] Migrate `ticket-intake/repos/` to the unified location with backwards-compatible fallback (read new location first, fall back to old)
- [ ] Separate controller state (last-seen, setup status, detection cache) from user-editable config — either as a `_state:` section clearly marked non-editable, or in a separate file (`~/.cursor/repos/.state/<slug>.yaml`)
- [ ] Document the schema publicly so users can hand-edit profiles and new skills can consume them without special knowledge

---

## Requirements Discovered

**FR-PROF-1:** The per-repo profile MUST live at `~/.cursor/repos/<slug>.yaml` where slug is derived from `basename $(git remote get-url origin) .git`.

**FR-PROF-2:** The profile MUST include a `schema_version` field (integer, starting at 1) for forward compatibility.

**FR-PROF-3:** The profile schema MUST support at minimum: `ticket:` (branch/commit/PR conventions), `paths:` (artifact roots, plan roots, scratch), and `artifacts:` (location strategy per Topic 9) sections.

**FR-PROF-4:** Skills MUST resolve configuration via the precedence chain: invocation flag → AGENTS.md → external profile → skill defaults. Skills MUST NOT hardcode paths without consulting this chain.

**FR-PROF-5:** The profile MUST support an optional `slug:` override field for cases where basename derivation produces collisions.

**FR-PROF-6:** The `ticket-intake/repos/<slug>.yaml` migration MUST be backwards-compatible — read unified profile first, fall back to legacy location.

**NFR-PROF-1:** Profile lookup MUST complete in < 100ms (single file read + YAML parse) to avoid perceptible latency on every skill invocation.

**NFR-PROF-2:** The schema MUST be additive — new optional sections can be added without requiring a schema_version bump or breaking existing profiles.

**NFR-PROF-3:** The profile file MUST be human-editable with clear inline comments explaining each section's purpose.

**C-PROF-1:** The `~/.cursor/repos/` location is Cursor-specific. If multi-editor support becomes a requirement, migration to `~/.config/ai-workflow/repos/` is the documented path. v1 does not need to support this.

**C-PROF-2:** Controller state (setup status, last-seen, detection cache) MUST NOT be mixed with user-editable config in the same YAML sections. Either use a clearly marked `_state:` section or a separate file.

---

## Next Steps

- Findings inform Topic 9 (artifact management schema) — the `artifacts:` section lives in this profile
- Findings inform Topic 3 (skill corpus ownership) — if skills stay in dev-infra, the profile location stays `~/.cursor/repos/`; if skills become a separate package, the XDG path becomes more relevant
- The `skills-path-roots-configurable.md` int-opp can now proceed with `~/.cursor/repos/<slug>.yaml` as the config source — it no longer needs to wait for this research
- Topic 8 (process artifact storage) will add a field to the `artifacts:` section for location strategy
