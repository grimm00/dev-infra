# Research: Three-Layer Redistribution Criteria

**Research Topic:** Agentic Workflow Modernization
**Question:** What sorting criteria determine whether content stays as always-on rules, becomes a skill, or remains a command?
**Status:** ✅ Complete
**Priority:** High (depends on Topic 1 decision)
**Created:** 2026-03-25
**Completed:** 2026-03-25

---

## 🎯 Research Question

What is the concrete rubric for sorting dev-infra's existing rules content and commands into the four-layer model (AGENTS.md / platform rules / skills / commands)?

The rubric must handle three archetypes from Spike B: procedural skill, behavioral skill, and simple trigger command. It must also handle always-on rules content (passive guidance vs procedural reference material vs current state).

---

## 🔍 Research Goals

- [x] Develop a concrete sorting rubric -- not "it depends" but a decision tree or criteria table
- [x] Apply rubric to a representative sample of rules content (2-3 sections from `.mdc` files)
- [x] Apply rubric to a representative sample of commands across complexity tiers: `/commit` (simple), `/pr` (moderate), `/explore` (complex)
- [x] Validate that the rubric handles the behavioral archetype (from Spike B) as a distinct category
- [x] Identify what stays as a Cursor-only `.mdc` rule vs what moves to AGENTS.md

---

## 📚 Research Methodology

**Sources consulted:**
- [x] Direct audit of `main.mdc`, `workflow.mdc` -- content categorization pass
- [x] Direct audit of commands: `/commit.md` (308 lines), `/review.md`, `/pr.md` (~1700 lines), `/explore.md` (~1376 lines)
- [x] iBuildWith.ai: [Rules, Skills, Commands: When to Use Each](https://www.ibuildwith.ai/blog/cursor-rules-skills-and-commands-oh-my-when-to-use-each/) -- industry framing
- [x] Builder.io: [Agent Skills vs Rules vs Commands](https://www.builder.io/blog/agent-skills-rules-commands) -- comparative analysis
- [x] GetAIBook.com: [Agent Skills vs Cursor Rules](https://getaibook.com/blog/agent-skills-vs-cursor-rules) -- additional classification
- [x] Medium (JIN, Feb 2026): Rules, Commands, Skills, and Agents definitive guide
- [x] Topic 1 findings: hybrid model settled, `disable-model-invocation: true` semantics confirmed

---

## 📊 Findings

### Finding 1: The Canonical Three-Sentence Classification

Industry consensus from multiple sources converges on a single framing:

> **Rules guide. Skills do. Commands trigger.**

- **Rules** are passive. They shape how the agent behaves across all tasks. Loaded automatically based on configuration; the agent absorbs them as standing context.
- **Skills** are active. They give the agent specific capabilities it can perform on demand. Load progressively -- name/description first, full content only when invoked.
- **Commands** are manual shortcuts. Saved prompts triggered only by the user typing `/command-name`. The agent never calls them autonomously.

The `/` menu surface is shared between commands and skills, but what happens behind the scenes differs significantly. A skill registered with `disable-model-invocation: true` appears in the same `/` menu as a command but brings progressive loading, reference files, and the full skill directory structure.

**Source:** [iBuildWith.ai: Rules, Skills, Commands](https://www.ibuildwith.ai/blog/cursor-rules-skills-and-commands-oh-my-when-to-use-each/); [Builder.io: Agent Skills vs Rules vs Commands](https://www.builder.io/blog/agent-skills-rules-commands)

**Relevance:** Provides the governing principle for the rubric. The question to ask of any piece of content is: does it *guide*, *do*, or *trigger*?

---

### Finding 2: Rules Contain Four Distinct Content Types -- Only Two Belong There

Direct audit of `main.mdc` and `workflow.mdc` reveals that the content inside dev-infra's always-on rules is not homogeneous. It contains at least four distinct content types that belong in different layers:

| Content Type | Example from rules | Correct Layer |
|---|---|---|
| **Portable conventions** | Git branch naming, date format, file naming, hub-and-spoke structure | AGENTS.md |
| **Cursor behavioral config** | "NEVER use emojis unless asked", AI response style, "be clear and actionable" | `.mdc` rule (Cursor-only) |
| **Mutable project state** | Current version (v0.10.0), "✅ Completed" / "🟡 Planned" task lists, "next: v0.11.0 planning" | ❌ Remove entirely; stale context is worse than no context |
| **Procedural reference** | PR review checklist steps, template development lifecycle, spike workflow description | Skill reference files |

The bloat in dev-infra's current `.mdc` files comes primarily from types 3 and 4. The current project state section in `main.mdc` (v0.10.0, release history, what's planned) is the single largest section and should not be always-on context -- it goes stale on every release and forces the agent to reason with outdated information.

**Source:** Direct audit of `main.mdc` (548 lines total), `workflow.mdc` (648 lines total)

**Relevance:** The redistribution exercise is primarily about separating these four types, not wholesale converting rules to skills. Much of what's in rules doesn't belong in *any* always-on layer.

---

### Finding 3: Commands Map Directly to Three Archetypes

Auditing the command set against the three archetypes (procedural skill, behavioral skill, simple trigger) reveals a clean distribution:

| Command | Lines | Archetype | Primary Indicator |
|---|---|---|---|
| `/commit` | 308 | **Procedural skill** | 5 sequential steps, git operations, reference to review artifacts |
| `/review` | ~294 | **Procedural skill** | Sequential steps, creates diff artifacts, explicit STOP gate |
| `/discuss` | 267 → 143 | **Behavioral skill** | Role assumption, engagement rules, NO side effects, read-only |
| `/pr` | ~1700 | **Procedural skill** | Multi-mode (draft/ready/review/phase), path detection, template selection |
| `/explore` | ~1376 | **Procedural skill** | Multi-mode (setup/amend/conduct), reference templates embedded in steps |
| `/research` | ~1500+ | **Procedural skill** | Multi-mode (setup/conduct/add-topic/consolidate), path detection |
| `/task` | unknown | **Hybrid** | Procedural (TDD cycle steps) + behavioral (how to approach tasks) |
| `/handoff` | unknown | **Procedural skill** | Session continuity artifact, sequential steps |
| `/reflect` | unknown | **Procedural skill** | Reflection artifact creation, sequential steps |

**Key insight:** No dev-infra command is a "simple trigger" (a few-line reusable prompt). Every command has enough procedural logic that it warrants skill treatment. The `/commit` command is the simplest case and still runs to 308 lines with 5 distinct steps and guard logic.

**Source:** Direct audit of `/commit.md` (308 lines), `/review.md`, `/pr.md`, `/explore.md`

**Relevance:** This means the redistribution decision for commands is not *whether* to convert but *how* -- specifically how to handle multi-mode commands that exceed the 500-line SKILL.md limit.

---

### Finding 4: The 500-Line Limit Forces Decomposition of Complex Commands

From Topic 1 and Spike B findings: SKILL.md is limited to 500 lines. `/pr.md` is ~1700 lines. `/explore.md` is ~1376 lines. `/research.md` is ~1500 lines. These cannot be directly converted -- they must be decomposed.

Two decomposition strategies emerge from the research:

**Strategy A: Multi-mode → single SKILL.md + reference files**
- SKILL.md: Core invocation instructions, mode routing, key guardrails (≤500 lines)
- `references/`: Mode-specific detail documents (setup-mode.md, conduct-mode.md, etc.)
- `assets/`: Templates, configuration files, doc-gen templates
- Agent loads SKILL.md first, then pulls in the specific mode reference only when invoked

**Strategy B: Multi-mode → multiple specialized skills**
- `/explore` becomes `explore-setup` + `explore-conduct` + `explore-amend` skills
- Each skill is ≤500 lines and handles one mode
- User invokes `/explore-setup` or `/explore-conduct` explicitly

**Tradeoff:** Strategy A preserves the single invocation surface (`/explore`) and uses progressive loading. Strategy B is simpler per-file but fragments the user-facing API. For dev-infra's commands, Strategy A is preferred because the mode is usually determined by flags (`--conduct`, `--amend`) not by separate invocations.

**Source:** Cursor Docs: Skills structure (references/, assets/ directories); Spike B findings on 500-line limit

**Relevance:** Every complex multi-mode command (explore, research, pr, task) will require Strategy A decomposition. The reference files are where structural schemas (Topic 4) and doc-gen templates live.

---

### Finding 5: AGENTS.md Scope is Narrower Than Current Rules Content

Combining Topic 1's inline-only constraint with Finding 2's content type analysis: AGENTS.md should carry only portable conventions that are both:
1. Relevant to non-Cursor tooling (Claude Code, CI agents, other contributors)
2. Stable enough to not require frequent updates (not project state)

From `main.mdc` and `workflow.mdc`, the AGENTS.md candidates are:

| Content | Why It Belongs in AGENTS.md |
|---|---|
| Git branch strategy (branch naming, commit message format) | Every tool that touches git needs this |
| Date format standard (YYYY-MM-DD) | Cross-tool convention |
| File naming convention (kebab-case) | Cross-tool convention |
| Hub-and-spoke documentation pattern overview | Any contributing agent needs this |
| Status indicator legend (🔴🟡🟠✅) | Any contributing agent needs this |
| Key directories and their purpose | CI agents, other contributors |

What does NOT go into AGENTS.md from current rules:
- Behavioral config for the AI agent (Cursor-specific)
- Current project state / version (stale)
- Full workflow descriptions (too long for inline)
- Reference to ADRs or planning documents via file links (Spike A: not followed)

**Source:** Spike A findings (AGENTS.md inline-only, lowest priority in Cursor); direct audit of `main.mdc`

**Relevance:** AGENTS.md for dev-infra will be significantly smaller than `main.mdc`. The `.mdc` rules file shrinks to Cursor-specific behavioral config only -- it becomes the "agent personality for Cursor" file.

---

### Finding 6: Cursor's /migrate-to-skills Tool Confirms the Archetype Mapping

Cursor 2.4 shipped a built-in `/migrate-to-skills` skill that converts existing rules and commands to skills. The migration logic confirms the archetype mapping:

- **Dynamic rules** (rules with `alwaysApply: false` and no glob patterns) → standard skills (auto-detect)
- **Slash commands** (both user-level and workspace-level) → skills with `disable-model-invocation: true`
- **Always-apply rules** (`alwaysApply: true`) → NOT migrated; these stay as rules
- **Glob-scoped rules** → NOT migrated; they have explicit file-based triggering

This confirms: dev-infra's always-apply `.mdc` rules are intentionally NOT candidates for skill conversion. Their content gets redistributed to AGENTS.md (portable conventions) and slimmed `.mdc` files (Cursor behavioral config), not to skills.

**Source:** Cursor Docs: Agent Skills, `/migrate-to-skills` behavior

**Relevance:** Cursor's own migration tooling validates the redistribution framework. The always-apply rules don't become skills -- their content gets redistributed.

---

## 🔍 Analysis

The rubric is built from three inputs: the "rules guide, skills do, commands trigger" canonical framing, the four content types found in dev-infra's rules, and the three command archetypes from Spike B + this audit.

### The Redistribution Decision Tree

```
Is this content?

├── Behavioral guidance (shapes HOW the agent responds)
│   ├── Portable to all platforms → AGENTS.md (inline, stable conventions)
│   └── Cursor-specific → .mdc always-apply rule (slim to behavioral config only)
│
├── Procedural workflow (describes WHAT to do, multi-step)
│   ├── > ~100 lines or needs reference files → Skill (disable-model-invocation: true)
│   │   ├── Multi-mode → SKILL.md core + references/ per mode
│   │   └── Simple steps → SKILL.md only
│   └── < ~20 lines, no iteration → Command (.md file, keep as-is)
│
├── Role/behavioral persona (assumes a role, governs engagement style)
│   └── Skill (behavioral archetype, disable-model-invocation: true)
│
├── Background knowledge (passive, should load when domain is relevant)
│   └── Skill (user-invocable: false) or AGENTS.md if cross-platform
│
└── Mutable project state (versions, task status, "what's planned")
    └── ❌ Remove from always-on files entirely
        → Session context file (provide explicitly when needed)
        → Or: referenced planning documents (not always-on)
```

### Applied to Dev-Infra's Current Artifacts

**`main.mdc` redistribution:**

| Section | Lines (approx) | Target |
|---|---|---|
| Project overview/identity | ~30 | AGENTS.md (portable convention) |
| Documentation standards (hub-spoke, status, date format) | ~40 | AGENTS.md |
| Project structure (directory org, file locations) | ~40 | AGENTS.md |
| Work categories / command distribution | ~20 | AGENTS.md |
| AI assistant guidelines (response style, when to suggest) | ~60 | `.mdc` rule (Cursor behavioral config) |
| Template development standards | ~40 | Skill reference files |
| Current project state (v0.10.0, completed/planned lists) | ~120 | ❌ Remove / session context |
| Reference templates (markdown snippets) | ~40 | Skill assets/ |

**`workflow.mdc` redistribution:**

| Section | Lines (approx) | Target |
|---|---|---|
| Git Flow branch strategy + commit format | ~30 | AGENTS.md |
| Review-then-commit workflow description | ~20 | Slim to 2-line pointer to `/review` command |
| PR review workflow (NEVER merge without review) | ~40 | `.mdc` rule (behavioral guardrail, Cursor-specific) |
| Status check checklist | ~30 | Skill reference (part of `/pr` skill) |
| Template development process | ~30 | Skill reference |
| CI/CD integration notes | ~20 | AGENTS.md |
| Command list (core commands) | ~30 | AGENTS.md or slim pointer |
| Spike/worktree workflow descriptions | ~60 | Skill reference files |
| Release process | ~40 | Skill reference (`/task-release`) |

**Command sample redistribution:**

| Command | Target | Rationale |
|---|---|---|
| `/commit` | Procedural skill | 5 sequential steps, git operations |
| `/review` | Procedural skill | Sequential steps, artifact creation, STOP gate |
| `/discuss` | Behavioral skill | Role assumption, no side effects, read-only |
| `/pr` | Procedural skill, decomposed | ~1700 lines → SKILL.md core + references/per-mode |
| `/explore` | Procedural skill, decomposed | ~1376 lines → SKILL.md core + references/per-mode |
| `/research` | Procedural skill, decomposed | ~1500 lines → SKILL.md core + references/per-mode |
| `/task` | Hybrid (procedural + behavioral) | TDD cycle + response disposition guidance |

**Key Insights:**
- [x] The always-apply `.mdc` rules are primarily bloated by mutable state and procedural reference material that doesn't belong in always-on context. The actual behavioral config that should stay in rules is much smaller (~100-150 lines total across all three `.mdc` files).
- [x] Every dev-infra command has enough complexity to warrant skill treatment. The migration question is about decomposition strategy for multi-mode commands, not whether to migrate.
- [x] AGENTS.md will be substantially smaller than current `main.mdc`. The portable conventions are maybe 100-150 lines inline. The rest of `main.mdc` goes to skills, session context, or gets deleted.
- [x] The "mutable project state" problem is significant: `main.mdc` currently carries the release history and planned features list. This is actively harmful as always-on context -- it forces the agent to reason with stale version numbers and outdated task states.

---

## 💡 Recommendations

- [x] **Adopt the four-type content categorization for rules redistribution:** portable conventions → AGENTS.md; Cursor behavioral config → `.mdc` (trimmed); procedural reference → skill reference files; mutable state → remove entirely.

- [x] **Use Strategy A (SKILL.md core + references/ per mode) for all multi-mode commands.** Single user-facing invocation surface, progressive loading, reference files carry the per-mode detail and doc-gen templates.

- [x] **Target `.mdc` file size: ~100-150 lines each.** If a `.mdc` rule is much longer, it contains content that belongs elsewhere. The behavioral config that's genuinely Cursor-specific is not that much text.

- [x] **Remove the current project state section from `main.mdc` before any other redistribution.** This is the single highest-value change: it removes ~120 lines of actively misleading always-on context (v0.10.0 completion status, "planned" items that may have since changed). Replace with a single line: `Current state: see admin/planning/status-and-next-steps.md`.

- [x] **Treat `/task` as a hybrid archetype.** The TDD cycle is procedural (steps to follow); the disposition guidance ("always update status during work", "only one in_progress at a time") is behavioral. The SKILL.md description must encode both.

---

## 📋 Requirements Discovered

- [x] **FR-6:** The four content types in always-apply rules must be separated: (1) portable conventions → AGENTS.md, (2) Cursor behavioral config → `.mdc`, (3) procedural reference → skill reference files, (4) mutable project state → removed from always-on context.
  **Priority:** High

- [x] **FR-7:** Multi-mode commands (≥3 modes or >500 lines) must use Strategy A decomposition: SKILL.md core (≤500 lines) + `references/` directory per mode. The single invocation surface (`/skill-name`) must be preserved.
  **Priority:** High

- [x] **FR-8:** Mutable project state (current version, completion status, planned features) must be removed from always-apply `.mdc` rules. It must be made available on-demand only (as session context or via explicit reference to a planning document).
  **Priority:** High -- this is the single most harmful content in current always-on context.

- [x] **FR-9:** A hybrid skill archetype specification is needed for commands that contain both procedural steps and behavioral disposition guidance (e.g., `/task`). The SKILL.md description and body must explicitly encode both the steps and the behavioral contract.
  **Priority:** Medium

---

## 🚀 Next Steps

1. Feed FR-7 into Topic 3 (conversion mechanics): Strategy A decomposition needs a concrete design example
2. Feed FR-6 into AGENTS.md design: the portable conventions list is now defined
3. Feed FR-8 into the `.mdc` slimming work: removal of mutable state is prerequisite for everything else

---

**Last Updated:** 2026-03-25
