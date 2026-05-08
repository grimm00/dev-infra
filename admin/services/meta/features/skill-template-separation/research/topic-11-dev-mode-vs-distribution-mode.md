# Research: Dev Mode vs. Distribution Mode — Lifecycle and Triggers

**Status:** ✅ Complete
**Priority:** Low
**Created:** 2026-05-08
**Completed:** 2026-05-08

---

## Research Question

What does the dev-mode (symlinks for authoring/testing) vs. distribution-mode (plugin publish for consumers) split look like concretely, and what triggers the transition from one to the other?

---

## Research Goals

- [x] Confirm the npm link analogy holds and identify where it breaks down for AI skills
- [x] Determine whether conventional AI agent/skill testing is feasible or if usage-as-testing is the practical reality
- [x] Map Cursor's plugin system as the distribution mechanism and identify its dev-mode story
- [x] Define when the transition from dev-mode to distribution-mode is triggered
- [x] Identify whether both modes coexist permanently or if one supersedes the other

---

## Methodology

**Queries executed:**
1. "npm link symlink development workflow vs publish install pattern plugin development local testing 2025 2026"
2. "AI agent skill testing methodology quality assurance prompt testing LLM non-deterministic evaluation 2025 2026"
3. "cursor plugin development local symlink workflow skills testing iteration 2026"

**Internal sources consulted:**
- User's existing `~/.claude/plugins/cache/` — working plugin-delivered skills (hex, superpowers)
- Topic 10 findings — symlink feasibility and Cursor bugs
- Skill-package-controller exploration — distribution concept

---

## Sources

- [x] npm docs — npm link mechanics, two-step symlink process
- [x] Scalified/Wilcox blog posts — npm link pain points, modern alternatives (npx link)
- [x] ArXiv: AgentAssay (2603.02601) — first token-efficient regression testing for non-deterministic agent workflows
- [x] ArXiv: ReliabilityBench (2601.06112) — agent reliability under production stress
- [x] ArXiv: Empirical Study of Testing Practices (2509.19185) — testing gaps in open-source agent frameworks
- [x] Cursor plugin docs — `~/.cursor/plugins/local/` mechanism
- [x] GitHub: cursor/plugin-template#4 — how to test plugins locally
- [x] GitHub: cursor/plugins#35 — symlink bug for local plugins (confirmed)
- [x] GitHub: cursor/plugins@82d7c79 — default new plugins to local/ for immediate availability

---

## Findings

### Finding 1: The npm link Analogy Holds But With a Key Difference

**Source:** npm docs, Scalified blog, npx link documentation
**Relevance:** npm link creates symlinks for zero-friction development iteration. The pattern: edit source → symlink makes it visible to consumers → test immediately. Problems arise from module resolution (Node resolves from the symlinked package's `node_modules`, not the consumer's) and cross-package-manager incompatibility.

**Key difference for AI skills:** Skills don't have dependency resolution. A skill is a self-contained markdown file read by the AI at prompt time. There's no `node_modules` equivalent, no dependency graph, no version conflicts between the skill and its consumer. This means symlinks for skills are *simpler* than npm link — they don't hit the problems that make npm link fragile for JavaScript packages.

The analogy maps cleanly at the workflow level (symlink = dev, publish = distribution) but the implementation is simpler because skills are leaf nodes with no transitive dependencies.

### Finding 2: Conventional AI Agent Testing Is Expensive and Nascent

**Source:** AgentAssay (ArXiv 2603.02601), ReliabilityBench, Empirical Study of Testing Practices
**Relevance:** The state of AI agent/skill testing in 2026:

- **AgentAssay** (March 2026) is the first framework attempting principled regression testing for non-deterministic agents. It uses three-valued outcomes (Pass/Fail/Inconclusive), behavioral fingerprinting, and requires 5-10+ trials for statistical confidence. Cost: 78-100% reduction vs. naive approaches, but still requires running the agent multiple times per test.
- **ReliabilityBench** shows that even high-performing agents (96.9% pass@1) degrade significantly under perturbation (88.1% at moderate levels).
- **Empirical study finding:** Prompt testing appears in only ~1% of tests across open-source agent frameworks. The vast majority of testing effort goes to deterministic components (tools, workflows), not the prompt/skill layer.

**Implication:** There is no practical, affordable way to "unit test" a skill file in isolation. The frameworks that exist (AgentAssay) require running the full agent multiple times — expensive for a personal tool author iterating on skill wording. Usage-as-testing is not laziness; it's the only economically viable approach for a sole author at this scale.

### Finding 3: Cursor's Plugin System IS the Distribution Mechanism

**Source:** Cursor plugin docs, cursor/plugin-template#4, cursor/plugins@82d7c79
**Relevance:** Cursor's plugin system already delivers skills:

- Plugin structure: `.cursor-plugin/plugin.json` manifest + `skills/`, `agents/`, `commands/`, `hooks/`, `scripts/` directories
- Local dev path: `~/.cursor/plugins/local/<plugin-name>/` — Cursor parses these as first-party plugins
- The user already consumes plugin-delivered skills: `hex` and `superpowers` under `~/.claude/plugins/cache/`

This means the distribution mechanism already exists and works. The question isn't "how do we distribute?" — it's "how do we develop without the overhead of the distribution mechanism?"

### Finding 4: The Symlink Bug Affects Plugin Loading, Not File Reading

**Source:** GitHub: cursor/plugins#35, cursor/plugin-template#4
**Relevance:** Confirmed: symlinks from a source directory to `~/.cursor/plugins/local/` do not load. Cursor's plugin discovery skips symlinked directories. The official workaround is `cp -R` (copy) instead of `ln -s`.

However, this bug is in the **plugin discovery** code path (`~/.cursor/plugins/local/`). Skills placed directly at `~/.cursor/skills/` (not via the plugin system) use a different discovery mechanism. The bug may not apply to raw skill files — but this is Topic 10's spike territory, not confirmed here.

**Two dev-mode options emerge:**
1. **Raw symlinks at `~/.cursor/skills/`** — bypasses the plugin system entirely, skill files are read directly. May work (needs spike from Topic 10).
2. **Copy-on-save to `~/.cursor/plugins/local/`** — uses the plugin system but with a file watcher that copies on change. More complex but uses the official mechanism.

### Finding 5: The Transition Trigger Is "Second Consumer"

**Source:** Analysis of npm ecosystem patterns, plugin marketplace model
**Relevance:** The dev→distribution transition is triggered by the appearance of a second consumer who:
- Doesn't have access to the canonical source repo
- Wants a stable versioned snapshot, not the bleeding edge
- Shouldn't be affected by in-progress edits

For the user today (sole consumer, sole author), there IS no second consumer. The transition doesn't happen yet. When it does:
- The canonical source gets a `publish` step that packages it as a Cursor plugin or Claude plugin
- The published artifact lands in a marketplace or registry
- Consumers install the published version; the author continues using symlinks/local

Both modes coexist permanently — the author always uses dev mode, consumers always use distribution mode. There's no "graduation" from one to the other.

---

## Analysis

### The Two Modes Are Permanent, Not Sequential

This isn't a maturity progression (dev → production). Both modes serve different audiences permanently:

| Mode | Audience | Mechanism | Lifecycle |
|------|----------|-----------|-----------|
| Dev | Author (sole consumer today) | Symlinks or local plugin with file watcher | Permanent — always the authoring workflow |
| Distribution | External consumers (future) | Plugin publish to marketplace/registry | Activated when consumers appear, runs in parallel |

### Why Usage-as-Testing Is Correct (Not Lazy)

The research confirms that:
1. Prompt/skill testing appears in only ~1% of agent framework tests (empirical study)
2. Proper frameworks (AgentAssay) require 5-10 trials per test with statistical analysis — cost-prohibitive for iterating on skill wording
3. The skill's value is in how it guides judgment, not in deterministic output — qualitative evaluation by the author during usage is the highest-signal feedback

This validates the dev-mode workflow: edit → use → evaluate → edit. No build step, no test harness, no publish cycle.

### The Cursor Plugin System Provides Distribution When Ready

When external consumers appear, the path is clear:
1. Add a `.cursor-plugin/plugin.json` manifest to the canonical source
2. Run a publish step (CI or manual) that packages and pushes to the Cursor marketplace
3. Consumers install from marketplace, get versioned snapshots
4. Author continues using symlinks/local for development

The effort to add distribution is *additive* — a manifest file and a CI step. It doesn't change the authoring workflow.

---

## Recommendations

- [x] Use raw symlinks (`~/.cursor/skills/` → canonical source) as the primary dev-mode mechanism — simplest, zero-friction, pending Topic 10 spike confirmation
- [ ] Do NOT invest in conventional skill testing infrastructure — usage-as-testing is the correct approach at this scale and maturity
- [ ] Treat the Cursor plugin system as the future distribution mechanism — add a manifest when there's a second consumer, not before
- [ ] If symlinks fail (Topic 10 spike), fall back to copy-on-save (file watcher that copies to `~/.cursor/plugins/local/` on change) — slightly more complex but proven to work
- [ ] Both modes coexist permanently — there's no "migration" from dev to distribution, they serve different audiences

---

## Requirements Discovered

**FR-DEV-1:** The dev-mode workflow MUST support zero-friction edit-test cycles: editing a skill file at the canonical source MUST make the change visible to the next AI invocation without any manual build, copy, or publish step.

**FR-DEV-2:** The dev-mode mechanism SHOULD be symlinks from editor-expected paths to the canonical source. If symlinks are infeasible (C-INST-1), a file-watcher-based copy mechanism is the fallback.

**FR-DIST-1:** Distribution mode MUST be additive — adding distribution to an existing dev-mode setup requires only a manifest file and a publish step, not restructuring the canonical source.

**FR-DIST-2:** Distribution SHOULD use the target editor's native plugin system (Cursor plugins, Claude plugins) rather than a custom mechanism.

**NFR-DEV-1:** The dev-mode feedback loop (edit → use → evaluate) MUST NOT require running any command between editing a skill file and using it. Zero-step iteration.

**C-DEV-1:** Conventional AI skill testing (statistical, multi-trial) is not economically viable for a sole author. Usage-as-testing is the accepted methodology until scale justifies investment in evaluation infrastructure.

---

## Next Steps

- Topic 10 spike (symlink one skill dir, test loading) would confirm FR-DEV-2's primary path
- When a second consumer appears, add `.cursor-plugin/plugin.json` to canonical source and set up publish step
- The `global-command-distribution` feature (Topic 6) had requirements about versioning and updates — those apply to distribution mode specifically, not dev mode
