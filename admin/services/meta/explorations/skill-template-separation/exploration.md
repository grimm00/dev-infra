# Exploration: Skill-Template Separation

**Created:** 2026-05-06
**Amended:** 2026-05-06 — discuss session surfaced branch-as-workspace concept from Topic 1 Finding 7
**Amended:** 2026-05-06 — discuss session identified configurable artifact strategy (location + retention as separate axes)

---

## 🎯 What We're Exploring

Dev-infra's skills, commands, and agents have been installed globally (`~/.cursor/skills/`, `~/.cursor/commands/`, `~/.cursor/agents/`) and run across all projects — including non-dev-infra work repos. Meanwhile, the templates (`templates/standard-project/`, `templates/learning-project/`) are products shipped to other people's projects. These two concerns have different audiences, different release cadences, and different evolution pressures. The authoritative source for skills currently lives inside the template tree, but that's wrong — the template tree is a snapshot destination, not an authoring location. We need to separate them and, in the process, rethink what templates should actually contain.

---

## 🔍 Themes

### Theme 1: Skills/Commands/Agents as Their Own Concern

- Skills, commands, and agents are now global installs (`~/.cursor/skills/`, `~/.cursor/commands/`, `~/.cursor/agents/`) that run in any repo — they're personal operational tooling, not template products
- The authoritative copies currently live in `templates/standard-project/.claude/skills/` and `templates/standard-project/.cursor/commands/`, but the global installs have already diverged (skills like `ticket-intake`, `update-pr-description`, `apprentice-eod`, and agents like `group-cycle-work.agent.md` exist only globally)
- The `git status` on develop shows mass deletions of `.claude/skills/` and `.cursor/commands/` — evidence that the working tree already treats these as global, not template-local
- Skills evolve continuously; templates get released with version numbers. Forcing both into the same release cycle creates friction
- The dependency direction should be: global installs are authority → templates get a snapshot at release time (Model A from the `/discuss` session)
- This is the resolution of the `global-command-distribution` feature (December 2025), which stalled at requirements/research because it didn't have the broader framing

### Theme 2: Template Minimalism

- Templates currently assume backend/frontend structure, full thinking-pipeline docs infrastructure, CI/CD with template-sync, hub-and-spoke documentation — that's overwhelming as a day-one scaffold
- Even in the author's own projects, the backend/frontend split was dropped entirely — evidence that the opinion doesn't generalize
- A user looking at the scaffold has to understand what the templates are doing before they can do their own work — the template is noise until it's learned
- The alternative framing: templates should be just enough for lifecycle management (`proj-cli`/`work-prod`) and a safe "landing site" for AI agents to do their work in
- This dramatically reduces the docs therein — the template becomes a "project contract" (manifest, agent scratch path, git hygiene) rather than a "comprehensive scaffold"
- Everything else (directory structure, docs infrastructure, the full thinking pipeline) becomes opt-in layers added as needed, not pre-installed on day one

### Theme 3: Per-Repo Skill Profile as the Enabling Substrate *(ai-workflow owns implementation; meta depends on it)*

- Skills today hardcode path-detection lists (three artifact roots for `pre-commit-review`, dev-infra-shaped paths for `write-plan`). This breaks when a skill runs in a repo the author didn't anticipate
- The `research` skill stopped in `~/apprentice-notes/` because it was too opinionated about repo structure — it should have said "I'm going to set up here, if this is not cool, tell me where I should go"
- The per-repo profile concept (`~/.cursor/repos/<slug>.yaml`) would let skills ask "where do things go in this repo?" and get a per-repo answer without hardcoding
- The profile is the substrate that makes both separation (skills work anywhere) and template minimalism (the template doesn't pre-build structure; the profile tells skills where to create it on demand) possible
- The `ticket-intake/repos/<slug>.yaml` precedent already works for branch/commit conventions — the generalization extends it to artifact roots, plan roots, scratch paths
- Without this substrate, skills either need detection heuristics (fragile) or the template must pre-build all structure (heavy)
- **Service boundary:** This theme's *implementation* belongs to the `ai-workflow` service (it's about how skills resolve paths). The meta exploration *depends on* it as an enabling substrate — the separation and template minimalism goals can't be fully realized until skills can work without hardcoded repo assumptions. The int-opp docs (`skills-path-roots-configurable.md`, `per-repo-skill-profile-unified.md`) will sort into ai-workflow's backlog once they get formal feature treatment

### Theme 4: Initiative Naming and Roadmap Artifact

- "Feature" as a concept under `meta/` feels wrong because features imply product deliverables to users; meta work is structural evolution of the project itself
- "Initiative" is a better fit — signals coordinated internal work that reshapes how we operate, without borrowing product-delivery connotations
- A roadmap artifact should be **service-level** (e.g., `admin/services/meta/roadmap.md`), not nested under planning — it connects the initiatives into a sequenced whole
- Planning itself goes deeper, at the initiative/feature level — the roadmap is the thing that says "here's the order, here are the dependencies between initiatives"
- The roadmap gets produced at the end of the thinking pipeline for this exploration (after research and decisions), not at the beginning

### Theme 6: Branch-as-Workspace — Process Artifacts Don't Merge

- The worktree workflow already says "all feature content stays on the feature branch" but the service directory structure (explorations/ alongside features/) implies everything eventually merges to develop — these two things contradict each other
- The resolution: branches hold all process work (explorations, research, planning, spikes); only hard artifacts (ADRs, decision summaries, final requirements) merge back to develop
- This eliminates the explorations/ → features/ duplication: an exploration IS the branch work; what persists on develop is just the feature's conclusions
- The "promotion" ceremony (marking an exploration as promoted, creating a parallel feature directory with the same name) adds no information — it's organizational bookkeeping that the branch boundary already provides
- Skills that emit process artifacts (explore, research, write-plan) would target the branch working tree; skills that emit archival artifacts (decision, narrative) would target the merge-back set
- Open question: what's the mechanism for recovering process work after branch deletion? Squash merges compress history; deleted branches lose the pointer. The summary/ADR needs to be rich enough to stand alone, or branches need a preservation convention
- Source: `/discuss` session reacting to Topic 1 Finding 7 ("Agent Landing Site") — extended to ask whether docs should live in the repo at all

### Theme 7: Configurable Artifact Strategy — Location as Project Config, Retention as Per-Feature

- The artifact storage question has two orthogonal axes: where process artifacts live during work (location) and what happens to them after the feature concludes (retention)
- Location options: on-disk (outside repo entirely), worktree/branch (in working tree, doesn't merge), in-repo (current model, everything merges) — this is a project-level setting in the per-repo profile, chosen once at setup
- Retention options: save everything as-is, condense into a summary/extract, or discard process and keep only decisions and deliverables — this is a per-feature choice made at completion time, not upfront
- The separation matters because you can't commit to retention strategy before the work is done — you don't know how valuable the process artifacts are until the feature concludes; but you CAN commit to location upfront because that's just "where do skills put things while I'm working"
- This means the profile schema (Topic 2) needs a `location` field for artifact storage, and the handoff/merge skill becomes the place that asks about retention — two different moments in the workflow, two different configuration surfaces
- Source: `/discuss` session extending Theme 6 — instead of picking one right answer, make the axes explicit and ask the questions at the right time

### Theme 5: The `global-command-distribution` Feature — Absorb or Reference?

- The December 2025 feature under `admin/services/meta/features/global-command-distribution/` has requirements and research (FR-1 through FR-5, NFR-1/2, constraints C-1/C-2) that are directly relevant
- Some of those requirements still apply (install commands globally, version tracking, update mechanism)
- Some are outdated (the feature assumed templates were the authority; reality has since drifted to global-first)
- The exploration should absorb the relevant requirements into its themes rather than leaving a stale feature alongside the new exploration
- The feature's research topics (installation methods, project-vs-global scope, version management, update strategy) are still useful prior art for research

---

## ❓ Key Questions

1. What's the minimum "project contract" that `proj-cli`/`work-prod` and agents need to manage a project's lifecycle? (i.e., what *must* be in the minimal template?)
2. Should the per-repo skill profile live at `~/.cursor/repos/<slug>.yaml` (top-level), `~/.cursor/profiles/<slug>.yaml`, or `~/.cursor/skills/_shared/repos/<slug>.yaml`? What's the lookup convention?
3. Does dev-infra continue to own the skill corpus (just with global installs as the primary location), or do skills become a separate project/repo?
4. What happens to the `templates/standard-project/.claude/skills/` copies — do they stay as release snapshots, or do templates stop bundling skills entirely (relying on global installs)?
5. If templates become minimal, what's the migration path for existing projects that already generated from the comprehensive templates?
6. What's the right naming for meta-level work units — "initiative"? — and does the directory structure change from `features/` to `initiatives/`?
7. How does the `global-command-distribution` feature's research fold into this exploration? Absorb into research topics, or mark as superseded and reference?
8. Should process artifacts (explorations, research, plans) remain branch-local and never merge, with only hard artifacts (ADRs, summaries) reaching develop? What's the branch preservation/recovery mechanism?
9. What are the right configuration axes for artifact management — location (project-level: on-disk / worktree / in-repo) and retention (per-feature at completion: full / condensed / minimal) — and where does each get configured?

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Skills as their own concern | LOW | No | Already de facto done — the global installs exist. This is catching up documentation and release process to reality. |
| Template minimalism | MEDIUM-HIGH | Consider | Major product redefinition. What "minimum viable template" looks like is genuinely unclear. A spike creating a minimal template and testing it on a real project would surface what's actually needed. |
| Per-repo skill profile | MEDIUM | No | The shape is already sketched (`per-repo-skill-profile-unified.md`). Research is sufficient — no hard-to-reverse decisions. |
| Initiative naming / roadmap | LOW | No | Naming is a decision, not a risk. Can be made directly after research. |
| Absorbing global-command-distribution | LOW | No | Reading existing requirements and deciding what's still relevant. Pure desk work. |
| Branch-as-workspace / process artifacts don't merge | MEDIUM | No | The worktree workflow already describes this model. The open question is branch preservation, which is a convention choice, not a hard-to-reverse technical decision. |
| Configurable artifact strategy (location + retention) | MEDIUM | No | The axes are clear and the configuration surfaces are identified (profile for location, handoff skill for retention). Research into schema options is sufficient. |

**Risk framework:** HIGH = spike first (hard to pivot), MEDIUM-HIGH = consider spike, MEDIUM/LOW = research only.

---

## 📎 Related Explorations and Features

**Directly connected (same problem space, different vantage points):**

| Exploration/Feature | Service | Status | Connection to Skill-Template Separation |
|---------------------|---------|--------|----------------------------------------|
| **[Workflow Decoupling](../../../template-generation/explorations/workflow-decoupling/)** | template-generation | 🔴 Exploration | The *same problem* from the template-generation perspective. Themes 1–3 there (drift, velocity layers, command-vs-skill distinction) are the template-side of our Theme 1 and Theme 2. Its "Package Manager Question" (Theme 4) is the distribution mechanism we'll need once separation is decided. **Should be absorbed or cross-referenced as sibling.** |
| **[Four-Arm Architecture](../../features/four-arm-architecture/)** | meta | ✅ Complete | Established ADR-001 (command distribution: dev-infra = source, dev-toolkit = distribution). Skill-template separation *extends* this: if skills/commands/agents are their own concern, the four-arm architecture gains a clearer "what ships where" story. The per-repo profile (Theme 3) is the substrate that makes ADR-003's "per-tool configuration" actually work for skills. |
| **[proj-cli Focused Role](../proj-cli-focused-role/)** | meta | 🔴 Exploration | Defined proj-cli's scope as "lifecycle sync against templates." Template minimalism (Theme 2) directly changes *what proj-cli syncs* — a minimal template means proj-cli tracks a smaller, stabler surface. If templates stop bundling skills, proj-cli's scope narrows further. |
| **[Worktree Feature Workflow](../worktree-feature-workflow/)** | meta | 🔴 Exploration | Self-contained feature branches with docs traveling on-branch. The `.scratch/` pattern from `group-cycle-work.agent.md` is a runtime instance of this principle — planning artifacts live in the workspace but don't commit to the repo. Separation enables this: skills know where to put things (profile), not where templates pre-built things. |

**Implications:** The workflow-decoupling exploration in template-generation is essentially asking "how do we distribute what's being separated?" while skill-template-separation asks "what *is* the separation and what does a template become after?" They're two halves of the same initiative. Research should proceed jointly or at minimum cite each other's findings.

---

## 📎 Related Int-Opps and Prior Art

**Directly enabling (ai-workflow substrate, depended on by this exploration):**
- `admin/planning/opportunities/internal/dev-infra/improvements/skills-path-roots-configurable.md` — make path roots configurable in `pre-commit-review`, `commit`, `write-plan*` (HIGH priority)
- `admin/planning/opportunities/internal/dev-infra/improvements/per-repo-skill-profile-unified.md` — unify per-repo config under single profile file (MEDIUM priority)
- `admin/planning/opportunities/internal/dev-infra/learnings/skills-shape-not-location.md` — the principle underpinning Theme 3

**Informing (independent int-opps, cite for research):**
- `admin/planning/opportunities/internal/dev-infra/improvements/artifact-emission-strategy.md` — L0-L3 spectrum for skill artifact emission; Principles 1-4 directly inform Topic 1 (minimum viable project contract) and Template Minimalism (Theme 2). Its "Essential vs Incidental Artifacts" classification is useful for determining what *must* be in a template.
- `admin/planning/opportunities/internal/dev-infra/improvements/feature-first-directory-structure.md` — already implemented (service-first structure), but its Capstone ("tool injection vs framework marriage") provides the framing for Template Minimalism: dev-infra should produce tools, not impose structure.
- `admin/planning/opportunities/internal/dev-infra/improvements/skill-config-rendering.md` — Helm-style values for per-platform rendering (Cursor vs Claude Code). Adjacent to Theme 1 (skills as their own concern) because platform distribution is part of how skills get shipped.
- `admin/planning/opportunities/internal/dev-infra/improvements/skill-toolbelt-colocated-scripts.md` — co-located scripts travel with skills; relevant to Theme 1 because scripts are part of the skill surface that separates from templates.

---

## 🚀 Next Steps

Review this exploration, then:
- `/explore-amend` to add new themes from downstream discovery
- `/research --from-explore skill-template-separation` to investigate open questions
- The template-minimalism theme (MEDIUM-HIGH risk) may benefit from a `/spike` before committing to a design — test the "minimal template" concept on a real project
- Proceed directly to the skill-separation initiative if the exploration is sufficient (it's LOW risk and de facto already done)
