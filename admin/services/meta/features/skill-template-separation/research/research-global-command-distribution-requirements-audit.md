# Research: `global-command-distribution` Requirements Audit

**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-05-06
**Completed:** 2026-05-11

---

## Research Question

Which requirements from the December 2025 `global-command-distribution` feature still apply, which are outdated, and which should be absorbed into this research?

---

## Research Goals

- [x] Read and catalog all requirements from `admin/services/meta/features/global-command-distribution/requirements.md`
- [x] For each FR (FR-1 through FR-5): assess current status (done? obsolete? still needed?)
- [x] For each NFR (NFR-1, NFR-2): assess relevance to the separation model
- [x] For each constraint (C-1, C-2): assess whether they still hold
- [x] Identify requirements that should be absorbed directly into this research's `requirements.md`
- [x] Identify requirements that are superseded by reality (global installs already exist)
- [x] Determine disposition of the `global-command-distribution` feature itself (mark superseded? archive? absorb?)

---

## Methodology

**Queries executed:**
1. "superseding requirements document audit obsolete feature requirements disposition 2025 2026 best practice"

**Internal sources consulted:**
- `admin/services/meta/features/global-command-distribution/requirements.md` — FR-1 through FR-5, NFR-1/2, C-1/2, A-1/2
- `admin/services/meta/features/global-command-distribution/README.md` — status: 🟡 Planned
- Current global install state (18 skills, 13 cursor-skills, 20 commands, 3 agents)
- Skill-template-separation Topics 1-4, 10-11 findings

---

## Sources

- [x] `admin/services/meta/features/global-command-distribution/requirements.md` — full requirements document
- [x] `admin/services/meta/features/global-command-distribution/README.md` — feature status
- [x] Current global install state — already achieved what FR-1 described
- [x] Topic 10-11 findings — symlink installer replaces the "install script" concept
- [x] Web search: requirements supersession best practices (ADR pattern for linking old → new)

---

## Findings

### Finding 1: Disposition Table — Requirement-by-Requirement Audit

**Source:** Internal: `global-command-distribution/requirements.md` cross-referenced with current state and Topics 1-4, 10-11
**Relevance:** This is the core deliverable of the audit.

| ID | Description | Disposition | Rationale |
|----|-------------|-------------|-----------|
| **FR-1** | Install commands globally to `~/.cursor/commands/` | ✅ **Done** | Already achieved. 20 commands live at `~/.cursor/commands/` today. |
| **FR-2** | Install commands to project `./.cursor/commands/` | ❌ **Superseded** | FR-MVPC-6 and FR-BNDL-1 say templates don't bundle. Project-level installs are the old model. |
| **FR-3** | Version tracking (which dev-infra version commands came from) | 🔄 **Evolves** | Still relevant but reframed: the corpus has its own version (FR-OWN-1), not pegged to dev-infra versions. Absorbed as corpus versioning concern. |
| **FR-4** | Update installed commands to newer versions | 🔄 **Evolves** | Replaced by symlink model (Topic 10): updates are instant because symlinks point to canonical source. No "update command" needed in dev mode. For distribution mode (Topic 11): plugin update mechanism handles this. |
| **FR-5** | Check if updates are available | ❌ **Superseded** | Symlinks mean you're always on latest (dev mode). Plugin system handles update notifications (distribution mode). No custom check needed. |
| **NFR-1** | Simple installation (single command) | 🔄 **Evolves** | Still valid but reframed: the installer is `stow` or equivalent (Topic 10, Finding 1). One command, but it's a symlink operation, not a copy. Absorbed into FR-INST-1. |
| **NFR-2** | Clear scope indication (global vs. project) | ❌ **Superseded** | There is no project-level scope anymore. Everything is global (corpus lives at XDG canonical location, symlinked to editor paths). The distinction is eliminated. |
| **C-1** | `~/.cursor/rules/` is NOT loaded globally | ⚠️ **Still holds** | Validated Dec 2025. Rules are project-level only. Skills/commands/agents work globally; rules do not. This remains a platform constraint. |
| **C-2** | Project commands override global commands of same name | ⚠️ **Still holds** | Cursor's precedence rule. Relevant if a generated project ever has local commands — the global ones are hidden. With FR-BNDL-1 (no bundling), this is unlikely to matter in practice. |
| **A-1** | Users have dev-infra access | ❌ **Superseded** | The corpus is its own repo (FR-OWN-1). Access to dev-infra is not required for skill installation. |
| **A-2** | Bash available | ✅ **Still holds** | Installer scripts still assume bash (macOS/Linux). Reasonable constraint for personal tooling. |

### Finding 2: The Feature's Core Assumption Was Wrong

**Source:** Internal: `global-command-distribution/README.md` — "Distribute workflow commands globally across all projects"
**Relevance:** The feature was framed as "how do we get dev-infra's commands to other places?" — assuming dev-infra was the authority and commands needed to be *distributed from* it.

Reality proved the opposite: commands/skills/agents are personal operational tooling that *happen to be authored in dev-infra*. The authority is the global install, not the repo. The feature was asking the distribution question from the wrong direction.

The skill-template-separation research (Theme 1, Topic 3) reframed this correctly: the corpus is its own product; dev-infra is not the source of truth for distribution.

### Finding 3: Two Requirements Worth Absorbing

**Source:** Analysis of disposition table
**Relevance:** Two concepts from the old feature survive in evolved form:

1. **Version tracking (FR-3):** The corpus needs its own versioning — not "which dev-infra version" but "which corpus version." This matters for distribution mode (Topic 11) when consumers pin to a version. Currently low priority since there's one consumer.

2. **Platform constraint C-1 (rules not global):** This is a real, validated constraint that affects architecture. Skills and commands work globally; rules don't. The skill-package-controller's authority model (AGENTS.md as Tier 1) partially works around this, but it's worth noting.

---

## Analysis

### Feature Disposition: Superseded

The `global-command-distribution` feature should be marked **superseded by** skill-template-separation. The reasoning:

1. Its core goal (get commands to global installs) is already achieved
2. Its remaining requirements (versioning, updates, scope clarity) are absorbed into the broader separation research under different framing
3. Its assumptions (dev-infra as authority, project-level installs needed) are explicitly rejected by Topics 1, 3, and 4
4. Following ADR pattern best practice: mark as superseded, link to the new feature, don't maintain the old one

### What Survives

| From old feature | Absorbed into |
|------------------|---------------|
| Version tracking concept | Future corpus-versioning concern (distribution mode, Topic 11) |
| C-1 (rules not global) | Active platform constraint, noted in research |
| C-2 (project overrides global) | Active platform constraint, noted in research |
| A-2 (bash available) | Assumed for installer scripts |

Everything else is done or superseded.

---

## Recommendations

- [x] Mark `global-command-distribution` feature as **Superseded** by skill-template-separation
- [ ] Add a one-line note to its README: "Superseded by skill-template-separation (2026-05). Core goal achieved; remaining concerns absorbed into broader research."
- [ ] Do NOT archive or delete the old feature docs — they serve as provenance for the requirements that evolved
- [ ] Absorb C-1 (rules not global) into this research's constraints as a platform constraint that affects the authority model
- [ ] Defer corpus versioning (evolved FR-3) until distribution mode is needed (no second consumer yet)

---

## Requirements Discovered

**C-PLAT-1:** Cursor global rules (`~/.cursor/rules/`) are NOT loaded by the editor. Only skills, commands, and agents work globally. Rules require project-level `.cursor/rules/` files.
**Source:** Topic 6 — C-1 validation (December 2025, confirmed still holds)

**C-PLAT-2:** Project-level commands (`<repo>/.cursor/commands/`) ALWAYS override global commands of the same name.
**Source:** Topic 6 — C-2 validation (December 2025, confirmed still holds)

---

## Next Steps

- Mark `global-command-distribution` feature README as superseded (implementation task, not research)
- C-PLAT-1 informs the skill-package-controller exploration: skills can be global authority, but rules must be generated in-repo (connects to AGENTS.md as the in-repo authority file)
- Corpus versioning is deferred until Topic 11's distribution mode trigger (second consumer) is met
