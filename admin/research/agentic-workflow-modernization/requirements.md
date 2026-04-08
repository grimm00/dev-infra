# Requirements - Agentic Workflow Modernization

**Source:** Research on agentic workflow modernization
**Status:** Draft
**Created:** 2026-03-25
**Last Updated:** 2026-04-02

---

## 📋 Overview

This document captures requirements discovered during research on redistributing dev-infra's workflow architecture across the four-layer model.

**Research Source:** [research-summary.md](research-summary.md)
**Spike Source:** [spike-learnings.md](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## ✅ Functional Requirements

### FR-1: Explicit-Only Skills Must Suppress Auto-Detection

**Description:** Skills that are designed for explicit human invocation (e.g., behavioral skills like `/discuss`) must set `disable-model-invocation: true` in their SKILL.md frontmatter. The system must not invoke these automatically based on context inference.

**Source:** [spike-learnings.md (Spike B)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-2: Behavioral Skills Must Define Precise Engagement Contracts

**Description:** Behavioral skills must replace vague persona phrases (e.g., "play devil's advocate") with specific, actionable behavioral instructions. Instructions must distinguish genuine critical engagement from manufactured contrarianism.

**Source:** [spike-learnings.md (Spike B, Finding 5)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-3: AGENTS.md Content Must Be Inline

**Description:** Content intended for AGENTS.md must be written inline -- not as file references or pointers. The AGENTS.md spec and Cursor's implementation do not follow file references; content must be present in the AGENTS.md file itself to be reliably fed to agents.

**Source:** [spike-learnings.md (Spike A, Finding 4)](../explorations/agentic-workflow-modernization/spike-learnings.md)

**Priority:** High

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

*(To be added as research is conducted)*

---

## ⚠️ Constraints

### C-1: Claude Code CLI Portability Requires a Separate Layer

**Description:** AGENTS.md alone is insufficient for Claude Code CLI portability. A separate `CLAUDE.md` file (or equivalent) is required for always-on context in Claude Code CLI usage.

**Source:** [spike-learnings.md (Spike A, Finding 3)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### C-3: Marketplace Distribution of Explicit-Only Skills Is Blocked

**Description:** Skills with `disable-model-invocation: true` cannot be distributed via Cursor marketplace plugins due to a known bug (reported March 2026, unresolved): the flag completely hides plugin-delivered skills from the `/` command palette, making them invisible and uninvokable. Skills requiring this flag must be distributed via repo/template path only until the bug is resolved.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 1; [Cursor Forum bug report](https://forum.cursor.com/t/disable-model-invocation-true-completely-hides-plugin-delivered-skills-from-command-palette/155748)

---

### C-2: SKILL.md Body Limited to 500 Lines

**Description:** The Cursor skills specification limits SKILL.md to 500 lines. Complex commands with reference templates must externalize content to reference files within the skill directory.

**Source:** [spike-learnings.md (Spike B, Finding 3)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## 💭 Assumptions

### A-1: Cursor Reads AGENTS.md at Lowest Priority

**Description:** When AGENTS.md and `.mdc` always-applied rules are both present, Cursor feeds both to the agent but treats `.mdc` rules with higher precedence. AGENTS.md content may be overridden by conflicting `.mdc` content.

**Source:** [spike-learnings.md (Spike A, Finding 2)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### A-2: Skills Are Compatible Between Cursor and Claude Code for Procedural Archetypes

**Description:** Procedural skills (sequential steps, no platform-specific behavioral instructions) are assumed compatible across platforms. Platform-specific behavior differences in behavioral skills (e.g., `disable-model-invocation` semantics) require further validation (Topic 5).

**Source:** [spike-learnings.md (Spike B)](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

### FR-6: Rules Content Must Be Separated Into Four Types

**Description:** The content currently in always-apply `.mdc` rules must be categorized and redistributed by type: (1) portable conventions (git flow, naming, structure) → AGENTS.md; (2) Cursor-specific behavioral config (agent response style, guardrails) → trimmed `.mdc` rule; (3) procedural reference material (workflow descriptions, checklists) → skill `references/` files; (4) mutable project state (version numbers, completion status, planned features) → removed from always-on context entirely.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 2, Finding 5

**Priority:** High

**Status:** 🔴 Pending

---

### FR-7: Multi-Mode Commands Must Use Strategy A Decomposition

**Description:** Commands with ≥3 modes or >500 lines (e.g., `/explore`, `/research`, `/pr`, `/task`) must be implemented as a skill using Strategy A: SKILL.md core (≤500 lines, handles routing and key guardrails) plus a `references/` directory containing per-mode detail documents. The single user-facing invocation surface (`/skill-name`) must be preserved. Per-mode reference files load progressively on demand.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 3, Finding 4

**Priority:** High

**Status:** 🔴 Pending

---

### FR-8: Mutable Project State Must Be Removed from Always-On Context

**Description:** Current version numbers, release history, task completion status, and planned feature lists must be removed from always-apply `.mdc` rules. This content goes stale on every release and forces the agent to reason with outdated information. Replace with a single pointer: "Current state: see admin/planning/status-and-next-steps.md" and provide the file explicitly when needed.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 2

**Priority:** High

**Status:** 🔴 Pending

---

### FR-9: Hybrid Skills Must Encode Both Steps and Behavioral Contract

**Description:** Commands that combine procedural steps with behavioral disposition guidance (e.g., `/task` with TDD cycle steps + "only one task in-progress at a time") must be implemented as hybrid skills. The SKILL.md description must communicate both the procedural archetype and the behavioral contract. The body must explicitly separate the step-by-step instructions from the behavioral guardrails.

**Source:** [topic-2-redistribution-criteria.md](topic-2-redistribution-criteria.md) -- Finding 3, Analysis

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-4: Workflow Skills Must Disable Auto-Detection

**Description:** All user-triggered workflow skills (skills that initiate side effects such as file writes, git operations, or subagent dispatch) must set `disable-model-invocation: true` in their SKILL.md frontmatter. Auto-detection is prohibited for these skills -- invocation must be explicitly initiated by the user via `/skill-name`.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 1, Finding 3, Finding 7

**Priority:** High

**Status:** 🔴 Pending

---

### FR-5: Passive Background Knowledge May Use Auto-Detection

**Description:** Passive background knowledge extracted from always-on rules (e.g., code conventions, documentation patterns, hub-and-spoke structural rules) may use `user-invocable: false` for automatic loading. The skill must meet all four auto-detect eligibility criteria: (1) read-only, (2) no side effects if loaded uninvited, (3) domain-scoped to relevant contexts, (4) not a workflow a user would invoke on-demand.

**Source:** [topic-1-auto-detection.md](topic-1-auto-detection.md) -- Finding 2, Finding 6

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-10: Multi-Mode Commands Must Decompose Into Separate Skills, One Per Workflow

**Description:** Commands with distinct modes (setup/conduct/amend, etc.) must be implemented as separate skills with distinct names and routing descriptions -- not as a single skill with mode branches or a routing stub in SKILL.md. Mode parameter flags (`--conduct`, `--amend`) become separate skill names (`explore-conduct`, `explore-amend`). Shared logic between skills is accepted duplication until three or more real consumers exist.

**Supersedes:** FR-7 ("Strategy A decomposition") -- FR-7 should be removed during `--consolidate`.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 2, Finding 3 (ComplexBench NeurIPS 2024 evidence; "one skill, one workflow" principle)

**Priority:** High -- FR-7 was incorrect; this correction is required before any implementation

**Status:** 🔴 Pending

---

### FR-11: Doc-Gen Templates Must Live in Skill `assets/` Directories

**Description:** Document templates currently embedded inline in commands (e.g., the canonical exploration.md structure inside `/explore`, research document templates inside `/research`) must be externalized to `assets/` within the owning skill directory. SKILL.md must instruct the agent to use the canonical template from `assets/`, with a fallback to memory-generated structure. Assets make templates independently versionable and validatable.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 1, Finding 4

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-12: SKILL.md Must Be Operationally Complete Without Companion Files

**Description:** The core workflow of any skill must be understandable and executable from SKILL.md alone, even if `assets/`, `references/`, and `scripts/` fail to load. Companion files are supplementary, not load-bearing. A skill whose essential behavior requires a reference file to function violates the Agent Skills specification constraint and will break on clients that only load SKILL.md.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 1 (Agent Layer spec constraint); [Agent Layer Skill Design Guide](https://agent-layer.dev/skill-design/)

**Priority:** High

**Status:** 🔴 Pending

---

### FR-13: Template Sync Manifest Must Track Skill Files

**Description:** When commands migrate to skills, `scripts/template-sync-manifest.txt` must be updated to track skill files (`SKILL.md`, asset templates in `assets/`) instead of command files. Initial approach: list each skill file individually (no tooling change required). Future: directory-level tracking via `validate-template-sync.sh` extension.

**Source:** [topic-3-conversion-mechanics.md](topic-3-conversion-mechanics.md) -- Finding 6

**Priority:** Medium (required at migration time, not before)

**Status:** 🔴 Pending

---

### FR-14: Templates Must Be Relocated to Skill `assets/` During Migration

**Description:** The 19 `.tmpl` files in `scripts/doc-gen/templates/` must be moved to `assets/` within the skill that owns the document type during the skills migration. Files are renamed from `.tmpl` to `.md` (they are already valid markdown). The original `scripts/doc-gen/templates/` directory is retained as a compatibility layer until `dt-doc-gen` is updated to reference the new locations.

**Source:** [topic-4-structural-schemas.md](topic-4-structural-schemas.md) -- Finding 1, Finding 5

**Priority:** Medium (required during migration, not before)

**Status:** 🔴 Pending

---

### FR-15: Procedural Skills Must Include Agent Self-Validation Step

**Description:** Skills that generate or modify structured documents must include a verification step in SKILL.md: compare the output against the template structure in `assets/`, verify all required sections (marked with `<!-- REQUIRED: -->`) are present, and fix any structural gaps before committing. This is a lightweight supplement to external validation (`dt-doc-validate`) and CI enforcement, not a replacement.

**Source:** [topic-4-structural-schemas.md](topic-4-structural-schemas.md) -- Finding 6, Finding 4

**Priority:** Medium

**Status:** 🔴 Pending

---

### FR-16: Template-Distributed Skills Must Use `.claude/skills/` as Canonical Location

**Description:** Skills distributed through dev-infra templates must be placed in `.claude/skills/[skill-name]/SKILL.md`. Both Cursor (via cross-platform discovery of `.claude/skills/`) and Claude Code (natively) read from this location. Do not distribute to `.cursor/skills/` -- it is not discovered by Claude Code. This eliminates duplication and provides a single canonical path.

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 4

**Priority:** High

**Status:** 🔴 Pending

---

### FR-17: Portable Skills Must Not Use Platform-Breaking Features

**Description:** Skills intended for cross-platform use (template-distributed, dual-distribution) must not use: `context: fork`, `$ARGUMENTS` / `$N` substitution, `` !`command` `` shell preprocessing, or `${CLAUDE_SKILL_DIR}`. These Claude Code-specific features break silently on platforms that don't support them (Cursor, Codex). Platform-specific skills (clearly marked, not template-distributed) may use them.

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 2

**Priority:** High

**Status:** 🔴 Pending

---

## 🎯 Non-Functional Requirements

### NFR-1: Template Changes Must Be Treated as Interface Contract Changes

**Description:** Modifications to a template in a skill's `assets/` directory must be assessed for downstream impact on consuming skills. Templates serve as inter-skill interface contracts: when `explore-conduct` generates an exploration from `assets/exploration-full.md`, the `research` skill expects specific sections to exist. Breaking changes to a template's required sections must be communicated to downstream skill authors. Template sync validation (FR-13) is the enforcement mechanism.

**Source:** [topic-4-structural-schemas.md](topic-4-structural-schemas.md) -- Analysis (inter-skill interface contracts)

**Priority:** High (architectural principle)

**Status:** 🔴 Pending

---

### C-4: AGENTS.md and CLAUDE.md Require Dual-File Strategy

**Description:** The context layer (project conventions, behavioral identity) cannot be served from a single file across both platforms. AGENTS.md is not supported by Claude Code (confirmed April 2026, open feature requests with no resolution timeline). CLAUDE.md is not supported by Cursor. Dev-infra must maintain both files with synchronized content. Sync drift between the two files is a maintenance risk that should be managed via template sync validation or a generation script.

**Source:** [topic-5-cross-platform-portability.md](topic-5-cross-platform-portability.md) -- Finding 5

---

## 🔗 Related Documents

- [Research Summary](research-summary.md)
- [Research Hub](README.md)
- [Spike Learnings](../explorations/agentic-workflow-modernization/spike-learnings.md)

---

## 🚀 Next Steps

1. Conduct Topics 1-8 research; extract additional requirements
2. Run `--consolidate` after all topics complete
3. Use `/decision agentic-workflow-modernization --from-research` to make architectural decisions

---

**Last Updated:** 2026-03-25
