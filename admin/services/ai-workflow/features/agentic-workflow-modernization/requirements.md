# Requirements - Agentic Workflow Modernization

**Source:** Research on agentic workflow modernization
**Status:** Final
**Created:** 2026-03-25
**Last Updated:** 2026-04-10
**Consolidated:** 2026-04-10

---

## 📋 Overview

This document captures requirements discovered during research on redistributing dev-infra's workflow architecture across the four-layer model.

**Research Source:** [research-summary.md](research-summary.md)
**Spike Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Final counts (after consolidation):**
- Functional Requirements: 22 (FR-1 through FR-22)
- Non-Functional Requirements: 3 (NFR-1, NFR-2, NFR-3)
- Constraints: 4 (C-1, C-2, C-3, C-4)
- Assumptions: 2 (A-1, A-2)

**Consolidation actions applied:**
- Merged: old FR-1 into FR-4, old FR-2 into FR-24, old FR-11 into FR-14
- Removed: old FR-7 (superseded by FR-10), old FR-20 (withdrawn)
- Modified: A-2 (validated), C-3 (mitigated), FR-16 (exclusivity), FR-4 (cross-platform)
- Priority: old FR-8 Medium → High
- Renumbered: all FRs sequential FR-1 through FR-22

---

## ✅ Functional Requirements

### FR-1: AGENTS.md Content Must Be Inline

**Description:** Content intended for AGENTS.md must be written inline -- not as file references or pointers. The AGENTS.md spec and Cursor's implementation do not follow file references; content must be present in the AGENTS.md file itself to be reliably fed to agents.

**Source:** [spike-learnings.md (Spike A, Finding 4)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-3

---

### FR-2: All User-Triggered Workflow Skills Must Disable Auto-Detection

**Description:** All user-triggered workflow skills -- including both procedural workflows (e.g., `/task`, `/research`) and behavioral skills (e.g., `/discuss`) -- must set `disable-model-invocation: true` in their SKILL.md frontmatter. Auto-detection is prohibited for these skills; invocation must be explicitly initiated by the user via `/skill-name`. This flag is enforced cross-platform: both Cursor and Claude Code support it with identical semantics (confirmed by Topic 5, correcting Topic 3 Finding 9).

**Absorbs:** Old FR-1 (behavioral skills must suppress auto-detection). FR-1 was a subset -- it covered behavioral skills only. This requirement covers all workflow skills.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 1, Finding 3, Finding 7; [spike-learnings.md (Spike B)](../explorations/agentic-workflow-modernization/spike-learnings.md); [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 2 (cross-platform confirmation)

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-4 (absorbs FR-1)

---

### FR-3: Passive Background Knowledge May Use Auto-Detection

**Description:** Passive background knowledge extracted from always-on rules (e.g., code conventions, documentation patterns, hub-and-spoke structural rules) may use `user-invocable: false` for automatic loading. The skill must meet all four auto-detect eligibility criteria: (1) read-only, (2) no side effects if loaded uninvited, (3) domain-scoped to relevant contexts, (4) not a workflow a user would invoke on-demand.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 2, Finding 6

**Priority:** Medium

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-5

---

### FR-4: Rules Content Must Be Separated Into Four Types

**Description:** The content currently in always-apply `.mdc` rules must be categorized and redistributed by type: (1) portable conventions (git flow, naming, structure) → AGENTS.md; (2) Cursor-specific behavioral config (agent response style, guardrails) → trimmed `.mdc` rule; (3) procedural reference material (workflow descriptions, checklists) → skill `references/` files; (4) mutable project state (version numbers, completion status, planned features) → removed from always-on context entirely.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 2, Finding 5

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-6

---

### FR-5: Mutable Project State Must Be Removed from Always-On Context

**Description:** Current version numbers, release history, task completion status, and planned feature lists must be removed from always-apply `.mdc` rules. This content goes stale on every release and forces the agent to reason with outdated information. Replace with a single pointer: "Current state: see admin/planning/status-and-next-steps.md" and provide the file explicitly when needed.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 2

**Priority:** High (upgraded from Medium during consolidation -- Topic 2 explicitly called this "the highest-priority redistribution action")

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-8

---

### FR-6: Hybrid Skills Must Encode Both Steps and Behavioral Contract

**Description:** Commands that combine procedural steps with behavioral disposition guidance (e.g., `/task` with TDD cycle steps + "only one task in-progress at a time") must be implemented as hybrid skills. The SKILL.md description must communicate both the procedural archetype and the behavioral contract. The body must explicitly separate the step-by-step instructions from the behavioral guardrails.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 3, Analysis

**Priority:** Medium

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-9

---

### FR-7: Multi-Mode Commands Must Decompose Into Separate Skills, One Per Workflow

**Description:** Commands with distinct modes (setup/conduct/amend, etc.) must be implemented as separate skills with distinct names and routing descriptions -- not as a single skill with mode branches or a routing stub in SKILL.md. Mode parameter flags (`--conduct`, `--amend`) become separate skill names (`explore-conduct`, `explore-amend`). Shared logic between skills is accepted duplication until three or more real consumers exist.

**Superseded:** Old FR-7 ("Strategy A decomposition") -- removed during consolidation.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 2, Finding 3 (ComplexBench NeurIPS 2024 evidence; "one skill, one workflow" principle)

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-10

---

### FR-8: SKILL.md Must Be Operationally Complete Without Companion Files

**Description:** The core workflow of any skill must be understandable and executable from SKILL.md alone, even if `assets/`, `references/`, and `scripts/` fail to load. Companion files are supplementary, not load-bearing. A skill whose essential behavior requires a reference file to function violates the Agent Skills specification constraint and will break on clients that only load SKILL.md.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 1 (Agent Layer spec constraint); [Agent Layer Skill Design Guide](https://agent-layer.dev/skill-design/)

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-12

---

### FR-9: Template Sync Manifest Must Track Skill Files

**Description:** When commands migrate to skills, `scripts/template-sync-manifest.txt` must be updated to track skill files (`SKILL.md`, asset templates in `assets/`) instead of command files. Initial approach: list each skill file individually (no tooling change required). Future: directory-level tracking via `validate-template-sync.sh` extension.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 6

**Priority:** Medium (required at migration time, not before)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-13

---

### FR-10: Templates Must Be Relocated to Skill `assets/` Directories

**Description:** Doc-gen templates must live in skill `assets/` directories. The 19 `.tmpl` files in `scripts/doc-gen/templates/` must be moved to `assets/` within the skill that owns the document type during the skills migration. Files are renamed from `.tmpl` to `.md` (they are already valid markdown). The original `scripts/doc-gen/templates/` directory is retained as a compatibility layer until `dt-doc-gen` is updated to reference the new locations. After migration, new templates are authored directly in `assets/` -- this is the ongoing canonical location.

**Absorbs:** Old FR-11 (doc-gen templates must live in skill `assets/`). FR-11 stated the destination; this requirement covers both the migration and the ongoing constraint.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 1, Finding 4; [topic-4-structural-schemas.md](topic-4-structural-schemas.md) -- Finding 1, Finding 5

**Priority:** Medium (required during migration, not before)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-14 (absorbs FR-11)

---

### FR-11: Procedural Skills Must Include Agent Self-Validation Step

**Description:** Skills that generate or modify structured documents must include a verification step in SKILL.md: compare the output against the template structure in `assets/`, verify all required sections (marked with `<!-- REQUIRED: -->`) are present, and fix any structural gaps before committing. This is a lightweight supplement to external validation (`dt-doc-validate`) and CI enforcement, not a replacement.

**Source:** [topic-4-structural-schemas.md](topic-4-structural-schemas.md) -- Finding 6, Finding 4

**Priority:** Medium

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-15

---

### FR-12: Template-Distributed Skills Must Use `.claude/skills/` as Canonical Location

**Description:** Skills distributed through dev-infra templates must be placed in `.claude/skills/[skill-name]/SKILL.md`. Both Cursor (via cross-platform discovery of `.claude/skills/`) and Claude Code (natively) read from this location. Do NOT distribute to `.cursor/skills/` -- it is not discovered by Claude Code. This eliminates duplication and provides a single canonical path.

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 4

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-16

---

### FR-13: Portable Skills Must Not Use Platform-Breaking Features

**Description:** Skills intended for cross-platform use (template-distributed, dual-distribution) must not use: `context: fork`, `$ARGUMENTS` / `$N` substitution, `` !`command` `` shell preprocessing, or `${CLAUDE_SKILL_DIR}`. These Claude Code-specific features break silently on platforms that don't support them (Cursor, Codex). Platform-specific skills (clearly marked, not template-distributed) may use them.

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 2

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-17

---

### FR-14: Skills Must Be Authored in Templates as Canonical Source

**Description:** The canonical location for all dev-infra skills is `templates/standard-project/.claude/skills/[skill-name]/`. Skills are developed, tested, and versioned here. The marketplace is a downstream distribution target, not an authoring location. Template sync (FR-9) ensures `learning-project` stays in parity.

**Source:** [topic-6-dual-distribution.md](topic-6-dual-distribution.md) -- Findings 1, 6

**Priority:** High

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-18

---

### FR-15: Skills Must Be Authored in Marketplace-Compatible Format

**Description:** ~~(Previously: Marketplace Distribution Must Use a Publish Script.)~~ Skills in `templates/standard-project/.claude/skills/` must be structured so that the skill directory can be copied 1:1 into a Claude Code marketplace plugin without transformation. This means: `SKILL.md` at skill root, companion files in subdirectories, no references to paths outside the skill directory. The team marketplace is a separate repo that cherry-picks from dev-infra -- no publish script is needed in dev-infra itself.

**Source:** [topic-6-dual-distribution.md](topic-6-dual-distribution.md) -- Findings 2, 3, 9 (reframed 2026-04-10)

**Priority:** High (structural constraint on skill authoring)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-19

---

### FR-16: Each Skill Must Declare Its Distribution Channels

**Description:** A publish matrix document (or metadata within the skill) must declare whether each skill is distributed via templates, marketplace, or both. Background knowledge skills (FR-3) are template-only. Team utility skills may be marketplace-only. Workflow skills default to both. This prevents accidental overpublishing or underpublishing.

**Source:** [topic-6-dual-distribution.md](topic-6-dual-distribution.md) -- Finding 7

**Priority:** Medium

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-21

---

### FR-17: Skills Must Document Their Position on the Orchestration Spectrum

**Description:** Each skill's SKILL.md should indicate whether the workflow is conversationally orchestrated (human judgment at each step), hybrid (structured with human gates), or automated (pipeline, no human needed). This helps users and agents understand how much autonomy to apply and whether subagent dispatch is appropriate.

**Source:** [topic-7-conversation-orchestration.md](topic-7-conversation-orchestration.md) -- Finding 5, Analysis

**Priority:** Low (nice-to-have metadata, not blocking)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-22

---

### FR-18: Session Resume Must Load Current Workflow State

**Description:** When a conversation session begins and the user references a topic (e.g., `/research --conduct --topic-num 7`), the agent must read the research hub README status table and the latest requirements summary before beginning work. This compensates for the conversational model's lack of persistent state by grounding the agent in the committed artifacts.

**Source:** [topic-7-conversation-orchestration.md](topic-7-conversation-orchestration.md) -- Findings 3, 4

**Priority:** Medium

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-23

---

### FR-19: Behavioral Skills Must Pass a Five-Property Quality Rubric

**Description:** Every behavioral instruction in a SKILL.md must be assessed against five properties: (1) observable -- compliance is determinable from output, (2) bounded -- the agent can determine when it has done enough, (3) outcome-framed -- describes what to produce, not who to be, (4) delta-only -- adds information the model wouldn't have by default, (5) failure-aware -- specifies what NOT to do and how to handle ambiguity. Instructions failing 3+ properties must be rewritten or removed. This is a quality gate applied during skill conversion, not a runtime check.

**Absorbs:** Old FR-2 (behavioral skills must define precise engagement contracts). FR-2 was the spike-era requirement ("replace vague persona phrases"). This requirement operationalizes it with the testable five-property rubric.

**Source:** [topic-8-behavioral-contracts.md](topic-8-behavioral-contracts.md) -- Findings 2, 5, 6; [spike-learnings.md (Spike B, Finding 5)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High (quality gate for behavioral skill conversion)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-24 (absorbs FR-2)

---

### FR-20: Behavioral Skills Must Include a Gotchas Section

**Description:** Every behavioral skill must include a `## Gotchas` section listing cases where the model would do something plausible but wrong. Each gotcha names the mistake and the correct alternative. The section is initially populated from the command audit (Tier 3 instructions identified in Topic 8 Finding 1) and incrementally refined from real usage. Anthropic identifies gotchas as "the highest-signal content in any skill."

**Source:** [topic-8-behavioral-contracts.md](topic-8-behavioral-contracts.md) -- Findings 3, 7

**Priority:** Medium (high-signal content, populatable incrementally)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-25

---

### FR-21: Skill Descriptions Must Follow the Dual-Location Pattern

**Description:** The SKILL.md `description` frontmatter field must contain only routing information: what the skill does, when to invoke it, and negative triggers (when NOT to use it). Behavioral enforcement belongs exclusively in the body. This prevents the model from treating the description as a behavioral summary and skipping the body. The pattern applies to all skills, not just behavioral ones.

**Source:** [topic-8-behavioral-contracts.md](topic-8-behavioral-contracts.md) -- Finding 4

**Priority:** Medium (structural pattern affecting all skills)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-26

---

### FR-22: The Design Step Must Allocate Guidance to the Appropriate Enforcement Layer

**Description:** During skill design, each piece of guidance must be assigned to one of four enforcement layers: (1) **skill body** -- judgment work only (behavioral contracts, decision criteria, workflow sequence), (2) **hooks** -- deterministic rules (commit format validation, file boundary enforcement, pre-conditions before tool use), (3) **CLI/tooling** -- state surfacing (workflow position, completion status, cross-topic corrections), (4) **human sync points** -- cross-project connections, UX judgment, priority decisions. This allocation reduces cognitive load for both the agent (fewer tokens on non-judgment content) and the human (tooling replaces manual state reconstruction from long prose files).

**Source:** [topic-8-behavioral-contracts.md](topic-8-behavioral-contracts.md) -- Finding 9 (escalation ladder on both tracks); connects to workflow-simplification NFR-7 (context proportionality)

**Priority:** Medium (design-phase constraint, not blocking skill conversion itself)

**Status:** 🔴 Pending

**Pre-consolidation ID:** FR-27

---

## 🎯 Non-Functional Requirements

### NFR-1: Template Changes Must Be Treated as Interface Contract Changes

**Description:** Modifications to a template in a skill's `assets/` directory must be assessed for downstream impact on consuming skills. Templates serve as inter-skill interface contracts: when `explore-conduct` generates an exploration from `assets/exploration-full.md`, the `research` skill expects specific sections to exist. Breaking changes to a template's required sections must be communicated to downstream skill authors. Template sync validation (FR-9) is the enforcement mechanism.

**Source:** [topic-4-structural-schemas.md](topic-4-structural-schemas.md) -- Analysis (inter-skill interface contracts)

**Priority:** High (architectural principle)

**Status:** 🔴 Pending

---

### NFR-2: Marketplace Updates Must Not Overwrite Project Customizations

**Description:** When a user installs or upgrades a marketplace plugin, the plugin's skills are installed to Claude Code's plugin cache, not to the project's `.claude/skills/` directory. Project-local skill customizations (made after template generation) must not be affected by marketplace updates. This is inherently satisfied by Claude Code's plugin caching model but must be documented as a design constraint.

**Source:** [topic-6-dual-distribution.md](topic-6-dual-distribution.md) -- Finding 3

**Priority:** Medium (architectural constraint)

**Status:** 🔴 Pending

---

### NFR-3: Research/Planning/Design Workflows Must Remain Conversationally Orchestrated

**Description:** The agentic workflow modernization must not introduce pipeline infrastructure for judgment-intensive workflows (research, planning, design, discussion). These workflows are human-paced, sequential, and judgment-dependent. The implicit pipeline through commands (discuss → research → review → commit) provides adequate structure. Formal orchestration (DAGs, typed state, checkpointing) is reserved for implementation and CI/CD phases. Note: "conversational" means dual-track with async sync (human and agent working concurrently), not serial handoff.

**Source:** [topic-7-conversation-orchestration.md](topic-7-conversation-orchestration.md) -- Findings 1, 2, 4, 8

**Priority:** High (architectural constraint)

**Status:** 🔴 Pending

---

## ⚠️ Constraints

### C-1: Claude Code CLI Portability Requires a Separate Layer

**Description:** AGENTS.md alone is insufficient for Claude Code CLI portability. A separate `CLAUDE.md` file (or equivalent) is required for always-on context in Claude Code CLI usage.

**Source:** [spike-learnings.md (Spike A, Finding 3)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### C-2: SKILL.md Body Limited to 500 Lines

**Description:** The Cursor skills specification limits SKILL.md to 500 lines. Complex commands with reference templates must externalize content to reference files within the skill directory.

**Source:** [spike-learnings.md (Spike B, Finding 3)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### C-3: Marketplace Distribution of Explicit-Only Skills Is Blocked (Mitigated)

**Description:** Skills with `disable-model-invocation: true` cannot be distributed via Cursor marketplace plugins due to a known bug (reported March 2026, unresolved): the flag completely hides plugin-delivered skills from the `/` command palette, making them invisible and uninvokable. Skills requiring this flag must be distributed via repo/template path only until the bug is resolved.

**Impact downgraded (2026-04-10):** The natural audience split avoids this bug in practice. Cursor users receive skills via template distribution (project-local `.claude/skills/`, where the bug doesn't apply). Claude Code users receive skills via marketplace (where the bug doesn't exist). The dual-distribution model turns this from a blocker into a non-issue for dev-infra's architecture.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 1; [topic-6-dual-distribution.md](topic-6-dual-distribution.md) -- Finding 4

---

### C-4: AGENTS.md and CLAUDE.md Require Dual-File Strategy

**Description:** The context layer (project conventions, behavioral identity) cannot be served from a single file across both platforms. AGENTS.md is not supported by Claude Code (confirmed April 2026, open feature requests with no resolution timeline). CLAUDE.md is not supported by Cursor. Dev-infra must maintain both files with synchronized content. Sync drift between the two files is a maintenance risk that should be managed via template sync validation or a generation script.

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 5

---

## 💭 Assumptions

### A-1: Cursor Reads AGENTS.md at Lowest Priority

**Description:** When AGENTS.md and `.mdc` always-applied rules are both present, Cursor feeds both to the agent but treats `.mdc` rules with higher precedence. AGENTS.md content may be overridden by conflicting `.mdc` content.

**Source:** [spike-learnings.md (Spike A, Finding 2)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### A-2: Skills Are Compatible Between Cursor and Claude Code (Validated)

**Description:** Procedural and behavioral skills are compatible across both major platforms. Topic 5 confirmed that the core skill system (SKILL.md format, frontmatter, companion directories, progressive loading, invocation control including `disable-model-invocation: true`) is fully portable between Cursor and Claude Code. Three Claude Code-specific features (`context: fork`, `$ARGUMENTS`, `` !`command` ``) must be avoided in portable skills (see FR-13).

**Source:** [spike-learnings.md (Spike B)](../explorations/agentic-workflow-modernization/spike-learnings.md); [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 1 (validated)

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Spike Learnings](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## 🚀 Next Steps

1. ~~Run `--consolidate`~~ ✅ Complete (2026-04-10)
2. Use `/decision agentic-workflow-modernization --from-research` to make architectural decisions
3. Fill in design document (`designs/design.md`)

---

**Last Updated:** 2026-04-10
