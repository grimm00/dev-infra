# Research Topics — Skill-Template Separation

**Created:** 2026-05-06

---

## 📋 Topics Identified

### Topic 1: Minimum Viable Project Contract

**Question:** What's the minimum set of files/structure that `proj-cli`/`work-prod` and AI agents need to manage a project's lifecycle — i.e., what must be in the minimal template?
**Priority:** High
**Context:** If templates become minimal, we need to know the floor — below which tooling can't function. This determines the boundary between "template provides" and "added on demand."

### Topic 2: Per-Repo Profile Location and Schema

**Question:** Where should the unified per-repo skill profile live, what's its schema, and how do skills look it up?
**Priority:** High
**Context:** The per-repo profile is the substrate that enables skills to work in any repo without hardcoded path assumptions. Getting the location and schema right at v1 matters because migration is costly later.

### Topic 3: Skill Corpus Ownership Model

**Question:** Does dev-infra continue to own the skill corpus (global installs as primary, dev-infra as the repo), or do skills become a separate project?
**Priority:** Medium
**Context:** If skills stay in dev-infra, the separation is internal (different release cadence, same repo). If skills split out, there's a real coordination cost but cleaner boundaries. The answer depends on whether other people will consume these skills or they stay personal.

### Topic 4: Template Skill Bundling Strategy

**Question:** After separation, do templates still bundle a subset of skills (as release snapshots), or do they rely entirely on global installs and just document which skills they expect?
**Priority:** Medium
**Context:** Bundling means templates are self-contained (a generated project works without global installs). Relying on global installs means templates are lighter but depend on the user having set up their environment. Different tradeoffs for different audiences.

### Topic 5: Migration Path for Existing Projects

**Question:** What happens to projects already generated from the comprehensive template? Do they get a migration command, or do they just keep their existing structure indefinitely?
**Priority:** Low
**Context:** Existing projects (PiHole-DNS, support-shark, etc.) have the full scaffold. If templates slim down, these projects don't automatically slim — they'd need either a migration tool or a "you're fine, just ignore the extra structure" answer.

### Topic 6: `global-command-distribution` Requirements Audit

**Question:** Which requirements from the December 2025 `global-command-distribution` feature still apply, which are outdated, and which should be absorbed into this exploration's research?
**Priority:** Medium
**Context:** That feature has 5 FRs, 2 NFRs, and 2 constraints already researched. Some (FR-1: install globally) are already done. Others (FR-3: version tracking) may still be relevant. Auditing avoids duplicating work.

### Topic 7: Meta Work-Unit Naming

**Question:** Should meta-level work units be called "initiatives" (or something else), and should the directory structure change from `features/` to reflect this?
**Priority:** Low
**Context:** "Feature" implies product delivery; meta work is structural. Naming matters for how work feels and gets communicated, but it's a decision to make, not a research problem. Quick resolution once other topics are clearer.

### Topic 8: Process Artifact Storage — Branch-Local vs. Merged

**Question:** Should process artifacts (explorations, research, planning docs) remain branch-local and never merge to develop, with only hard artifacts (ADRs, summaries) reaching the main line? What branch preservation or recovery mechanism is needed?
**Priority:** Medium
**Context:** The worktree workflow already states feature content stays on the branch, but the service directory structure assumes it all merges. Resolving this contradiction determines what `develop` looks like and whether the explorations/features duplication pattern persists.

### Topic 9: Artifact Management Configuration Schema — Location and Retention Axes

**Question:** What should the per-repo profile schema look like for artifact location (on-disk / worktree / in-repo), and how should the handoff/merge skill prompt for retention strategy (full / condensed / minimal) at feature completion?
**Priority:** Medium
**Context:** Location is a project-level decision (set once in the profile); retention is a per-feature decision (asked at completion). Separating these into the right configuration surfaces — profile for location, handoff skill for retention — keeps the schema clean and asks questions at the right time in the workflow.

### Topic 10: Symlink-Based Installation — Feasibility and Editor Compatibility

**Question:** Can a symlink-based installer (GNU Stow pattern) bridge the canonical XDG package location and editor-specific expected paths, and do Cursor's known symlink handling bugs affect skill/config file loading specifically?
**Priority:** Medium
**Context:** GNU Stow proves the pattern works for dotfiles/packages, but Cursor has documented bugs with symlinked plugin directories (cursor/plugins#35). Skills are markdown files read by the AI engine, not plugins loaded by the editor runtime — they may use a different code path. A quick spike would confirm.

### Topic 11: Dev Mode vs. Distribution Mode — Lifecycle and Triggers

**Question:** What does the dev-mode (symlinks for authoring/testing) vs. distribution-mode (plugin publish for consumers) split look like concretely, and what triggers the transition from one to the other?
**Priority:** Low
**Context:** AI skills can't be conventionally tested — usage IS testing. This makes symlinks the correct dev-time mechanism (zero friction between edit and use). Plugin distribution is additive for when there are external consumers. The question is when/how the transition happens and whether both modes coexist permanently.

### Topic 12: XDG Semantics Correction — Config vs. Corpus Location

**Question:** How should XDG semantics apply correctly — config (profiles, installer mapping) in `~/.config/ai-workflow/`, corpus repo at a normal project path, symlinks bridging — and what does the installer config look like?
**Priority:** Low
**Context:** Prior research conflated the corpus (the product) with `~/.config/` (user settings). Config IS config (profiles, mappings); the corpus is a git repo at a normal project directory. The installer reads config to know where the corpus is and where to symlink. Multi-machine bootstrap = clone repo + run installer.

### Topic 13: Three-Tier Distribution Model — Install Script and Tiers

**Question:** What does the corpus repo's self-contained install script look like, and how does the three-tier model (author → source install → plugin publish) work in practice?
**Priority:** Low
**Context:** Tier 1→2 is free (clone + run installer). Tier 2→3 requires a plugin manifest + publish step. The repo being its own installer means source-install distribution requires no new infrastructure — just a README and a script.

---

## 🚀 Next Steps

Use `/research --from-explore skill-template-separation` to investigate these questions.

Topics 1 and 2 are the highest priority — they determine the shape of both the minimal template and the skill substrate. Topic 6 is housekeeping that should happen early to avoid duplicating existing research.
