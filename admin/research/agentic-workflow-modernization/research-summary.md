# Research Summary - Agentic Workflow Modernization

**Purpose:** Summary of all research findings
**Status:** 🔴 Research
**Created:** 2026-03-25
**Last Updated:** 2026-04-02

---

## 📋 Research Overview

Research into redistributing dev-infra's workflow architecture across a four-layer model: AGENTS.md (portable conventions), platform-specific rules, skills (SKILL.md), and commands (simple triggers).

Two spikes were conducted prior to structured research and inform all topics:
- **Spike A: AGENTS.md Portability** -- Partially validated; Claude Code CLI does not read AGENTS.md natively
- **Spike B: Command-to-Skill Conversion** -- Validated; two skill archetypes (procedural, behavioral); `disable-model-invocation: true` required for explicit-only skills

**Research Topics:** 10
**Spiked:** Topic 9 (AGENTS.md portability)
**Deferred:** Topic 10 (Roadmap layer scope)
**Active:** Topics 1-8
**Status:** 🔴 Research

---

## 🔍 Key Findings

### Spike A: AGENTS.md is Real but Not Universally Portable

AGENTS.md is a growing standard (60k+ repos, Linux Foundation) but has significant platform limitations. Cursor reads it at lowest precedence. Claude Code CLI does not read it natively. File references are not followed -- content must be inline.

**Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### Spike B: Two Distinct Skill Archetypes Identified

Procedural skills (sequential steps, reference files for templates) and behavioral skills (role assumption, engagement rules, `disable-model-invocation: true`). The `/discuss` command converted cleanly from 267 to 143 lines. Conversion acts as a precision audit for vague behavioral instructions.

**Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### Topics 1-8: Pending

*Findings to be added as research is conducted.*

### Topic 1: Auto-Detection vs Explicit Invocation (✅ Complete)

**Recommendation: Hybrid model -- explicit for workflows, auto-detect for passive background knowledge.**

The research converges on a clear answer supported by platform convergence (both Cursor and Claude Code 2.1 landed on explicit-first independently), empirical failure rates (context-loading-to-application gaps make auto-detection unreliable for critical workflows), and the architecture of dev-infra's commands (workflow-triggered, not ambient).

Key finding: `disable-model-invocation: true` works reliably for repo/template-distributed skills but has a known bug for marketplace-distributed skills (complete invisibility from command palette). This creates a constraint on the dual-distribution model.

Criteria for auto-detect eligibility (all four required):
1. Read-only background knowledge
2. No side effects if loaded uninvited
3. Domain-scoped (relevant only in certain contexts)
4. Not a workflow a user would want to invoke on-demand

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md)

### Topic 2: Three-Layer Redistribution Criteria (✅ Complete)

**Key output: The Redistribution Decision Tree and four content type framework.**

The rubric: rules guide, skills do, commands trigger. Dev-infra's always-apply `.mdc` files contain four distinct content types that belong in different layers: (1) portable conventions → AGENTS.md, (2) Cursor behavioral config → slim `.mdc`, (3) procedural reference → skill reference files, (4) mutable project state → remove entirely.

Every dev-infra command has enough complexity to warrant skill treatment. Multi-mode commands (explore, research, pr, task) use Strategy A decomposition: SKILL.md core ≤500 lines + `references/` per mode. No command is a "simple trigger."

Critical finding: `main.mdc` currently carries ~120 lines of mutable project state (v0.10.0 release history, planned features) as always-on context. This is actively harmful -- it forces the agent to reason with stale information. Removal is the highest-priority redistribution action.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md)

### Topic 3: Conversion Mechanics (✅ Complete)

**Key output: FR-7 is wrong -- multi-mode commands must decompose into separate skills, not a single skill with mode branches in references/.**

The critical finding overturns Topic 2's FR-7 (Strategy A decomposition). Empirical evidence from ComplexBench (NeurIPS 2024) and related research shows that multi-mode skills with conditional branching degrade model performance catastrophically -- from 0.881 (flat composition) to 0.083 (nested multi-layer). Even externalizing mode branches to `references/` doesn't fix the problem because instruction composition degradation is about the model's working attention, not disk layout.

The correct decomposition: one skill per workflow. `/explore` (1375 lines, 3 modes) becomes 3 separate skills (`explore`, `explore-conduct`, `explore-amend`), each under 250 lines with unambiguous activation descriptions.

Additional findings:
- `assets/` is where doc-gen templates live (structural schemas in practice)
- `references/` is for supplementary guidance within a single workflow, not mode branches
- SKILL.md must be operationally complete without companion files (spec constraint)
- `plugin.json` carries marketplace metadata only; behavioral contract lives in SKILL.md
- Template sync manifest extends incrementally: list each skill file individually

New requirements: FR-10 (replaces FR-7), FR-11 (doc-gen templates in assets/), FR-12 (SKILL.md completeness), FR-13 (template sync extension).

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md)

### Topic 4: Structural Schemas (✅ Complete)

**Key output: The structural schema system already exists (ADR-002 + ADR-004) -- the gap is packaging in skills, not design.**

The `template-doc-infrastructure` feature (v0.9.0) already designed 17 document types, 5 common patterns, 3 placeholder types, and a layered validation architecture. The existing `.tmpl` files in `scripts/doc-gen/templates/` ARE structural schemas -- they define required sections, content markers, and type-specific constraints.

The packaging answer: templates move to `assets/` within the owning skill. They serve a dual role: generation guidance (what to create) AND interface contract (what downstream skills expect). When `explore-conduct` generates an exploration from `assets/exploration-full.md`, the `research` skill knows exactly what sections to find.

Additional findings:
- Markdown schema validation tools have matured (mdschema, contextlint, doc-structure-lint) -- may replace planned custom `dt-doc-validate`
- Agent self-validation is a lightweight new layer: skills can instruct the agent to verify its output against the template structure
- Template changes are API changes -- modifying a template affects all downstream skills in the pipeline

New requirements: FR-14 (template relocation to assets/), FR-15 (agent self-validation step), NFR-1 (template changes as interface contract changes).

**Source:** [topic-4-structural-schemas.md](topic-4-structural-schemas.md)

### Topic 5: Cross-Platform Portability (✅ Complete)

**Key output: Portability is better than expected -- and Topic 3 Finding 9 was wrong.**

The critical correction: `disable-model-invocation: true` IS supported by Claude Code, not Cursor-only. Both major platforms enforce it. The earlier annotation on FR-1 and FR-4 ("Cursor-specific enforcement") must be corrected.

The core skill system (SKILL.md format, frontmatter, companion directories, progressive loading, invocation control) is **fully portable** between Cursor and Claude Code. Cursor auto-discovers `.claude/skills/`, making it the optimal single distribution path.

Three Claude Code-specific features break silently on Cursor: `context: fork` (subagent execution), `$ARGUMENTS` substitution, and `` !`command` `` shell preprocessing. Portable skills must avoid these.

The context layer remains split: AGENTS.md (Cursor + others) and CLAUDE.md (Claude Code). A dual-file strategy is required. AGENTS.md support in Claude Code remains an open feature request with no resolution timeline.

Behavioral fidelity may actually be better on Claude Code than Cursor -- Anthropic's upstream LLM integration provides deeper behavioral consistency than Cursor's prompt-engineering approach.

New requirements: FR-16 (`.claude/skills/` as canonical location), FR-17 (portable skill constraints), C-4 (dual-file context strategy).

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md)

### Topic 6: Dual-Distribution Workflow (✅ Complete)

**Key output: Template-first authoring with a publish script to marketplace. Distribution channels are snapshots, not live sync.**

Dev-infra serves two audiences through two channels: personal/local projects via template generation (skills seeded into `.claude/skills/` at creation) and the team via Claude Code marketplace (plugin package with `marketplace.json`). Both channels are inherently snapshot-based -- there is no live sync mechanism, and none is needed.

The template-sync-manifest extends to skills with zero tooling changes (just replace command paths with skill paths). A new `publish-marketplace.sh` script copies publishable skills from the canonical template location to a `marketplace/` directory within the dev-infra repo (monorepo model), bumps the `plugin.json` version, and validates. A CI check verifies source-to-marketplace parity alongside the existing intra-template sync check.

Critical finding: C-3 (Cursor marketplace bug hiding `disable-model-invocation` skills) is naturally avoided by the audience split. Cursor users get skills via template distribution (project-local, no marketplace involved). Claude Code users get skills via marketplace (where the bug doesn't exist). The dual-distribution model turns the bug into a non-issue.

Skills are categorized by distribution channel: workflow skills (both channels), behavioral skills (both), team utility skills (marketplace only), background knowledge (template only). A publish matrix document prevents accidental overpublishing.

New requirements: FR-18 (template-first authoring), FR-19 (publish script), FR-20 (source-to-marketplace CI), FR-21 (distribution channel declaration), NFR-2 (marketplace updates must not overwrite project customizations).

**Source:** [topic-6-dual-distribution.md](topic-6-dual-distribution.md)

### Topic 7: Conversation as Orchestration (✅ Complete)

**Key output: Conversational orchestration is the right model for research/planning/design. Don't over-engineer it.**

The industry has converged on three orchestration tiers (1-3 agents in-process, 3-10 with local orchestrator, 10+ cloud async). Dev-infra sits squarely at Tier 1, and that's correct. The meta-experiment (conducting Topics 1-6 serially in conversation) demonstrated that serial conversational research works well -- the original hypothesis that parallel subagents were needed was wrong because research topics have sequential dependencies.

The conversation model provides four things pipelines don't: judgment at every step, cross-topic context accumulation, lateral movement via `/discuss`, and zero ceremony. It lacks three things: cross-session persistence, parallel execution, and formal progress tracking. For dev-infra's solo-developer research workflow, the lacking features are non-blocking.

The breakover point from conversation to pipeline is state complexity, not agent count. Dev-infra would need formal orchestration only if: multiple people researched simultaneously, tasks had enforceable dependencies, or >10 active items exceeded mental tracking capacity.

Critical insight: dev-infra's command sequence (discuss → research → review → commit) is already an implicit pipeline with human judgment gates -- it just uses conversation as the execution engine.

New requirements: NFR-3 (research/planning must stay conversational), FR-22 (orchestration spectrum metadata in skills), FR-23 (session resume must load workflow state).

**Source:** [topic-7-conversation-orchestration.md](topic-7-conversation-orchestration.md)

### Topic 8: Behavioral Contracts (🔴 Not Started)
*Findings to be added.*

---

## 💡 Key Insights (from Spikes)

- [x] Insight: AGENTS.md is not a drop-in replacement for always-applied `.mdc` rules -- it is a separate, lower-priority, inline-only layer
- [x] Insight: Two skill archetypes exist and require different conversion approaches and invocation strategies
- [x] Insight: `disable-model-invocation: true` is mandatory for behavioral skills like `/discuss`
- [x] Insight: Auto-detection criteria -- hybrid model (explicit for workflows, auto-detect for passive background knowledge)
- [x] Insight: Redistribution rubric -- four content types in rules; "rules guide, skills do, commands trigger"
- [x] Insight: Multi-mode commands decompose into separate skills per workflow, not per flag argument (overturns FR-7)
- [x] Insight: Doc-gen templates belong in `assets/`, supplementary guidance in `references/`, executable scripts in `scripts/`
- [x] Insight: SKILL.md must be operationally complete on its own -- companion files are always supplementary
- [x] Insight: `disable-model-invocation: true` is cross-platform (Cursor + Claude Code) -- Topic 3 Finding 9 correction
- [x] Insight: `.claude/skills/` is the optimal single distribution path -- both platforms discover it
- [x] Insight: Three Claude Code features break silently on Cursor: `context: fork`, `$ARGUMENTS`, `` !`command` ``
- [x] Insight: Behavioral fidelity may be better on Claude Code than Cursor (upstream LLM vs prompt engineering)
- [x] Insight: Distribution channels are snapshots, not live sync -- "keeping in sync" is a publish step
- [x] Insight: Template-sync-manifest extends to skill files with zero tooling changes
- [x] Insight: C-3 marketplace bug is naturally avoided by the audience split (templates for Cursor, marketplace for Claude Code)
- [x] Insight: Monorepo marketplace (marketplace/ in dev-infra) is the right model for dev-infra's scale
- [x] Insight: `plugin.json` adds minimal overhead -- skills don't change for marketplace distribution
- [x] Insight: Conversational orchestration is the right model for research/planning/design -- don't over-engineer
- [x] Insight: Breakover point is state complexity, not agent count -- dev-infra is well within conversational sufficiency
- [x] Insight: The implicit pipeline (discuss → research → review → commit) already works as human-gated orchestration
- [x] Insight: Parallel subagent dispatch is counterproductive for sequential research with inter-topic dependencies
- [x] Insight: Different workflow phases belong at different points on the orchestration spectrum

---

## 📋 Requirements Summary

See [requirements.md](requirements.md) for complete requirements document.

**Current counts (Topics 1-7 + spikes):**
- Functional Requirements: 23 (FR-1 through FR-23; note FR-7 is flagged for supersession by FR-10; FR-1/FR-4 annotations need correction per Topic 5)
- Non-Functional Requirements: 3 (NFR-1, NFR-2, NFR-3)
- Constraints: 4 (C-1, C-2, C-3, C-4; C-3 impact downgraded per Topic 6 audience split finding)
- Assumptions: 2 (A-1, A-2; A-2 upgraded to validated per Topic 5)

---

## 🚀 Next Steps

1. ~~Conduct Topic 1 (auto-detection)~~ ✅ Complete
2. ~~Conduct Topic 2 (redistribution rubric)~~ ✅ Complete
3. ~~Conduct Topic 3 (conversion mechanics)~~ ✅ Complete
4. ~~Conduct Topic 4 (structural schemas)~~ ✅ Complete
5. ~~Conduct Topic 5 (cross-platform portability)~~ ✅ Complete -- **Topic 3 Finding 9 corrected**
6. ~~Conduct Topic 6 (dual-distribution)~~ ✅ Complete -- template-first authoring, publish script, C-3 audience split
7. ~~Conduct Topic 7 (conversation orchestration)~~ ✅ Complete -- conversational model validated, breakover criteria defined
8. Conduct Topic 8 (behavioral contracts)
9. Run `--consolidate` after all topics complete -- FR-7 supersession by FR-10, FR-1/FR-4 annotation corrections, and C-3 impact downgrade are key cleanup items

---

**Last Updated:** 2026-04-09
