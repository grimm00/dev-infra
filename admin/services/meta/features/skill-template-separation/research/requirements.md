# Requirements — Skill-Template Separation

**Status:** Final
**Created:** 2026-05-06
**Last Updated:** 2026-05-19

---

## Overview

Requirements extracted from research findings across 11 topics (7 complete, 4 deferred). Consolidated 2026-05-19: merged redundancies, corrected XDG semantics, added gaps for installer self-containment.

---

## Functional Requirements

### FR-MVPC-1: AGENTS.md Required
The minimal template MUST include AGENTS.md with project conventions sufficient for AI agents to operate without exploration.
**Source:** Topic 1 — Finding 2 (AGENTS.md standard), Finding 7 (agent landing site)

### FR-MVPC-2: proj-cli State File Required
The minimal template MUST include `.dev-infra.yml` for proj-cli state tracking (template version, customizations).
**Source:** Topic 1 — Finding 3 (proj-cli needs)

### FR-MVPC-3: Git Hygiene for Agent Scratch
The minimal template MUST include `.gitignore` with entries for agent scratch paths (`.scratch/`, `tmp/`, `admin/tmp/`).
**Source:** Topic 1 — Finding 7 (scratch path convention)

### FR-MVPC-4: README with Project Identity
The minimal template SHOULD include a README.md with project identity and getting-started instructions.
**Source:** Topic 1 — Finding 6 (modern scaffold convergence)

### FR-MVPC-5: No Pre-Built Skill Structure
The minimal template SHOULD NOT include directory structure that skills create on demand (explorations, research, decisions, planning).
**Source:** Topic 1 — Finding 4 (skills create on demand), Finding 5 (80% analysis)

### FR-PROF-1: Profile Location
The per-repo profile MUST live at `~/.config/ai-workflow/repos/<slug>.yaml` and MAY be symlinked to `~/.cursor/repos/<slug>.yaml` for editor compatibility. Slug derived from `basename $(git remote get-url origin) .git`.
**Source:** Topic 2 — Finding 3 (pragmatic location), Finding 4 (slug derivation); amended by Theme 10 (XDG correction: profiles are config)

### FR-PROF-2: Schema Versioning
The profile MUST include a `schema_version` field (integer, starting at 1) for forward compatibility.
**Source:** Topic 2 — Finding 6 (schema versioning)

### FR-PROF-3: Minimum Schema Sections
The profile schema MUST support at minimum: `ticket:`, `paths:`, and `artifacts:` sections.
**Source:** Topic 2 — Finding 7 (ticket-intake seed), Analysis (schema shape)

### FR-PROF-4: Lookup Precedence Chain
Skills MUST resolve configuration via: invocation flag → AGENTS.md → external profile → skill defaults. Skills MUST NOT hardcode paths without consulting this chain.
**Source:** Topic 2 — Analysis (lookup convention), `skills-path-roots-configurable.md`

### FR-PROF-5: Slug Override
The profile MUST support an optional `slug:` override field for basename collision cases.
**Source:** Topic 2 — Finding 4 (slug derivation)

### FR-PROF-6: Backwards-Compatible Migration
The `ticket-intake/repos/<slug>.yaml` migration MUST be backwards-compatible — read unified profile first, fall back to legacy location.
**Source:** Topic 2 — Finding 7 (ticket-intake precedent), `per-repo-skill-profile-unified.md`

### FR-INST-1: Symlink-Based Installation
The installer MUST create symlinks from editor-specific expected paths to the corpus project directory, not copy files. If Cursor's skill discovery has symlink compatibility issues (C-INST-1), a file-watcher-based copy mechanism is the fallback.
**Source:** Topic 10 — Finding 1 (GNU Stow pattern), Finding 4 (installer boundary); absorbs FR-DEV-2 (symlink dev mode + fallback)

### FR-INST-2: Editor Mapping Configuration
The installer MUST support a mapping configuration that defines per-editor path expectations (adding a new editor = adding config, not code).
**Source:** Topic 10 — Finding 4 (narrow responsibility boundary)

### FR-INST-3: Clean Uninstallation
The installer MUST support uninstallation (removing all symlinks) without affecting the canonical package.
**Source:** Topic 10 — Finding 1 (GNU Stow reversibility)

### FR-INST-4: Config at XDG, Corpus at Project Path
Package configuration (per-repo profiles, installer mapping) MUST live at `~/.config/ai-workflow/`. The corpus itself (skills, commands, agents) MUST live at a normal project directory (e.g., `~/Projects/ai-workflow/`), NOT inside `~/.config/`. The installer symlinks from editor paths to the corpus project directory.
**Source:** Topic 10 — Analysis; Topic 2 — Finding 2 (XDG separation); Theme 10 (XDG correction); absorbs FR-OWN-3

### FR-DEV-1: Zero-Friction Edit-Test Cycle
The dev-mode workflow MUST support zero-friction edit-test cycles: editing a skill file at the canonical source MUST make the change visible to the next AI invocation without any manual build, copy, publish, or run step between edit and use.
**Source:** Topic 11 — Finding 2 (testing is impractical), Analysis (usage-as-testing); absorbs NFR-DEV-1 (zero-step iteration)

### FR-DIST-1: Additive Distribution
Distribution mode MUST be additive — adding distribution to an existing dev-mode setup requires only a manifest file and a publish step, not restructuring the canonical source.
**Source:** Topic 11 — Finding 3 (Cursor plugin system), Analysis

### FR-DIST-2: Native Plugin System
Distribution SHOULD use the target editor's native plugin system (Cursor plugins, Claude plugins) rather than a custom mechanism.
**Source:** Topic 11 — Finding 3 (existing plugin-delivered skills: hex, superpowers)

### FR-INST-5: Self-Contained Install Script
The corpus repo MUST contain its own install script enabling tier-2 source installs: `git clone` + one command produces a working installation with all symlinks created.
**Source:** Theme 11 (three-tier distribution), Topic 10 Finding 1 (GNU Stow)

### FR-INST-6: Installer Config at XDG
The installer MUST read its editor-path mapping from `~/.config/ai-workflow/installer.yaml` (or equivalent XDG-compliant config file), not from hardcoded paths in the script.
**Source:** Theme 10 (XDG correction), Topic 10 Finding 4 (narrow responsibility boundary)

### FR-OWN-1: Separate Product
The skill corpus (skills, commands, agents) MUST be a separate product from dev-infra templates, with its own repository and independent versioning.
**Source:** Topic 3 — Finding 1 (76% global-only), Finding 2 (different products)

### FR-OWN-2: No Authoritative Copies in Dev-Infra
Dev-infra MUST NOT contain authoritative copies of skills. It MAY contain a manifest listing expected skills for template validation.
**Source:** Topic 3 — Finding 1 (stale subset), Analysis (Model B)

### FR-BNDL-1: No Bundling
Templates MUST NOT bundle skills, commands, or agents (these are global installs with independent lifecycle). They MAY include a manifest declaring expected skills.
**Source:** Topic 4 — Finding 1 (prior findings converge), Finding 2 (drift confirmed); absorbs FR-MVPC-6 from Topic 1.

### FR-BNDL-2: Expected-Skills Manifest
The expected-skills manifest SHOULD live in `.dev-infra.yml` as an `expected_skills` list (machine-readable for proj-cli validation).
**Source:** Topic 4 — Finding 5 (manifest shape)

### FR-BNDL-3: Validation with Warning
`proj-cli` setup SHOULD validate that expected skills are installed and warn (not error) if missing, providing install guidance.
**Source:** Topic 4 — Analysis (self-containment tradeoff)

### FR-BNDL-4: Retire Template-Sync-Manifest
`template-sync-manifest.txt` SHOULD be retired once templates stop bundling commands.
**Source:** Topic 4 — Finding 4 (manifest already obsolete)

---

## Non-Functional Requirements

### NFR-MVPC-1: Fast Generation
The minimal template SHOULD be generatable in < 5 seconds with no network calls.
**Source:** Topic 1 — Finding 6 (modern scaffold UX)

### NFR-MVPC-2: Immediate Operability
The minimal template SHOULD produce a working project (passes CI, agents can operate) immediately after generation without additional setup steps.
**Source:** Topic 1 — Finding 6 (day-one productivity)

### NFR-PROF-1: Lookup Performance
Profile lookup MUST complete in < 100ms (single file read + YAML parse) to avoid perceptible latency on every skill invocation.
**Source:** Topic 2 — Analysis (lookup convention must be fast)

### NFR-PROF-2: Additive Schema
The schema MUST be additive — new optional sections can be added without requiring a schema_version bump or breaking existing profiles.
**Source:** Topic 2 — Finding 6 (schema versioning best practices)

### NFR-PROF-3: Human-Editable
The profile file MUST be human-editable with clear inline comments explaining each section's purpose.
**Source:** Topic 2 — Analysis (user-editable config)

### NFR-INST-1: Idempotent Operations
Installation/uninstallation MUST be idempotent — running twice produces the same result as running once.
**Source:** Topic 10 — GNU Stow behavior model

### NFR-INST-2: No Internal Knowledge Required
The installer MUST NOT require knowledge of skill schemas, profile shapes, or package internals — it operates purely on filesystem paths.
**Source:** Topic 10 — Finding 4 (responsibility boundary)

### NFR-OWN-1: No Coordination Overhead
The separation MUST NOT introduce coordination overhead for daily skill development.
**Source:** Topic 3 — Finding 5 (symlinks eliminate cross-repo cost)

### NFR-OWN-2: Single Browsable Unit
The corpus repo SHOULD be browsable and searchable as a single unit (all skills, commands, agents in one tree).
**Source:** Topic 3 — Analysis (discoverability)

### NFR-BNDL-1: Graceful Degradation
A generated project MUST function (CI passes, agents can orient via AGENTS.md) even without the expected skills installed.
**Source:** Topic 4 — Analysis (self-containment tradeoff)

---

## Constraints

### C-MVPC-1: AGENTS.md Must Be Parameterized
AGENTS.md content depends on project type (tech stack, framework, conventions). The template must parameterize this rather than shipping a generic placeholder.
**Source:** Topic 1 — Analysis

### C-MVPC-2: No Breaking Existing Projects
Existing projects generated from comprehensive templates are not affected — they keep their structure. Migration is a separate concern (Topic 5).
**Source:** Topic 1 — Analysis

### C-PROF-1: XDG Is Primary, Editor Paths Are Symlinks
The `~/.config/ai-workflow/repos/` location is the canonical config path. The installer symlinks to `~/.cursor/repos/` for Cursor compatibility. Multi-editor support = adding symlink targets, not migrating data.
**Source:** Topic 2 — Finding 2 (XDG); Theme 10 (XDG correction flips the framing)

### C-PROF-2: State Separation
Controller state (setup status, last-seen, detection cache) MUST NOT be mixed with user-editable config in the same YAML sections.
**Source:** Topic 2 — Finding 2 (XDG config vs state), skill-package-controller Theme 2

### C-INST-1: Cursor Symlink Compatibility
If Cursor's skill discovery has the same `isDirectory()` bug as plugin discovery, file-level or subtree-level symlinks MUST be used instead of directory-level.
**Source:** Topic 10 — Finding 2 (Cursor plugin bug), Finding 5 (fallback strategy)

### C-DEV-1: Usage-as-Testing Accepted
Conventional AI skill testing (statistical, multi-trial) is not economically viable for a sole author. Usage-as-testing is the accepted methodology until scale justifies investment in evaluation infrastructure.
**Source:** Topic 11 — Finding 2 (AgentAssay cost, 1% prompt testing coverage in industry)

### C-OWN-1: No Migration Deadline
No migration deadline for formalizing the corpus repo. Current global installs work. Formalization happens when convenient.
**Source:** Topic 3 — Analysis (de facto already separated)

### C-PLAT-1: Rules Not Global
Cursor global rules (`~/.cursor/rules/`) are NOT loaded by the editor. Only skills, commands, and agents work globally. Rules require project-level `.cursor/rules/` files.
**Source:** Topic 6 — C-1 validation (December 2025, confirmed still holds)

### C-PLAT-2: Project Commands Override Global
Project-level commands (`<repo>/.cursor/commands/`) ALWAYS override global commands of the same name.
**Source:** Topic 6 — C-2 validation (December 2025, confirmed still holds)

---

## Assumptions

*(Extracted during research-conduct)*

---

## Traceability

| Requirement | Source Topic | Evidence |
|-------------|-------------|----------|
| FR-MVPC-1 through FR-MVPC-5 | Topic 1 | Findings 2-7 (minimal template analysis) |
| FR-PROF-1 through FR-PROF-6 | Topic 2 | Findings 1-7 (profile schema research) |
| FR-INST-1 through FR-INST-6 | Topics 10, 11, Themes 10-11 | GNU Stow, XDG correction, three-tier model |
| FR-DEV-1 | Topic 11 | Finding 2 (testing impractical), Analysis |
| FR-DIST-1, FR-DIST-2 | Topic 11 | Finding 3 (Cursor plugin system) |
| FR-OWN-1, FR-OWN-2 | Topic 3 | Finding 1 (76% global-only) |
| FR-BNDL-1 through FR-BNDL-4 | Topic 4 | Findings 1-5 (bundling analysis) |
| C-PLAT-1, C-PLAT-2 | Topic 6 | December 2025 validation (confirmed still holds) |

---

## Next Steps

Consolidated requirements are ready for `/decision` phase. Recommended decisions:
1. **ADR: Separation model** — corpus as separate repo, templates as minimal (FR-OWN-1, FR-BNDL-1)
2. **ADR: Installation architecture** — symlinks, XDG config, project-path corpus (FR-INST-1 through FR-INST-6)
3. **ADR: Profile schema v1** — location, fields, lookup chain (FR-PROF-1 through FR-PROF-6)

Deferred topics (5, 7, 8, 9) may add requirements later but do not block architectural decisions.
