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

### Topic 6: Dual-Distribution Workflow (🔴 Not Started)
*Findings to be added.*

### Topic 7: Conversation as Orchestration (🔴 Not Started)
*Findings to be added.*

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

---

## 📋 Requirements Summary

See [requirements.md](requirements.md) for complete requirements document.

**Current counts (Topics 1-5 + spikes):**
- Functional Requirements: 17 (FR-1 through FR-17; note FR-7 is flagged for supersession by FR-10; FR-1/FR-4 annotations need correction per Topic 5)
- Non-Functional Requirements: 1 (NFR-1)
- Constraints: 4 (C-1, C-2, C-3, C-4)
- Assumptions: 2 (A-1, A-2; A-2 upgraded to validated per Topic 5)

---

## 🚀 Next Steps

1. ~~Conduct Topic 1 (auto-detection)~~ ✅ Complete
2. ~~Conduct Topic 2 (redistribution rubric)~~ ✅ Complete
3. ~~Conduct Topic 3 (conversion mechanics)~~ ✅ Complete
4. ~~Conduct Topic 4 (structural schemas)~~ ✅ Complete
5. ~~Conduct Topic 5 (cross-platform portability)~~ ✅ Complete -- **Topic 3 Finding 9 corrected**
6. Conduct Topics 6-8 (dual-distribution, conversation orchestration, behavioral contracts)
7. Run `--consolidate` after all topics complete -- FR-7 supersession by FR-10 and FR-1/FR-4 annotation corrections are key cleanup items

---

**Last Updated:** 2026-03-25
