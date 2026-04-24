# Research: Cross-Platform Portability

**Research Topic:** Agentic Workflow Modernization
**Question:** What behavioral gaps exist between Cursor and Claude Code for skills, rules, and AGENTS.md?
**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-03-25
**Completed:** 2026-04-02

---

## 🎯 Research Question

If dev-infra distributes skills for use in both Cursor IDE and Claude Code, what concretely breaks or differs? What is the portability tax for each artifact layer?

**Pre-answered by Spike A:** AGENTS.md is not natively read by Claude Code standalone (though it is read in Claude Code within CI/CD contexts). This moves the portability question to skills and commands.

---

## 🔍 Research Goals

- [x] Identify behavioral differences for SKILL.md between Cursor and Claude Code
- [x] Identify whether `disable-model-invocation: true` has equivalent semantics on Claude Code
- [x] Identify what falls back gracefully vs what breaks silently on the other platform
- [x] Determine what platform-specific wrappers or notes are needed
- [x] Clarify current AGENTS.md support status for Claude Code (post-Spike A: "not natively" vs "in some contexts")

---

## 📚 Research Methodology

**Sources consulted:**
- [x] [Claude Code official skills docs](https://code.claude.com/docs/en/skills.md) -- comprehensive frontmatter reference, invocation control, companion files, subagent execution
- [x] [Claude Code `.claude` directory docs](https://code.claude.com/docs/en/claude-directory) -- directory structure, settings loading
- [x] [Claude Code plugins docs](https://code.claude.com/docs/en/plugins) -- plugin format, marketplace distribution
- [x] [agentskills.io specification](https://agentskills.io/specification) -- portable standard baseline
- [x] [AgentPatterns.ai SKILL.md Frontmatter Reference](https://agentpatterns.ai/tool-engineering/skill-frontmatter-reference/) -- comprehensive field list
- [x] [Agentic Thinking: How Cursor Finds Skills](https://agenticthinking.ai/blog/skill-discovery/) -- Cursor discovery mechanics, cross-platform directory scanning
- [x] [Medium: Claude/Cursor Skills Practical Overview](https://asadmirza1.medium.com/claude-cursor-skills-a-practical-overview-e371dff4e508) -- comparative analysis
- [x] [Lellansin's Blog: Why Cursor Rules Failed and Claude Skill Succeeded](https://lellansin.github.io/2026/01/27/Why-Cursor-Rules-Failed-and-Claude-Skill-Succeeded/) -- upstream vs downstream behavioral consistency
- [x] [Dev.to: Porting AI Coding Workflows from Claude Code to Codex CLI](https://dev.to/shinpr/same-framework-different-engine-porting-ai-coding-workflows-from-claude-code-to-codex-cli-n3p) -- real-world migration
- [x] GitHub issues: [#34235 (AGENTS.md support)](https://github.com/anthropics/claude-code/issues/34235), [#31935 (disable-model-invocation context leak)](https://github.com/anthropics/claude-code/issues/31935), [#38969 (disable-model-invocation blocks user invocation)](https://github.com/anthropics/claude-code/issues/38969)

---

## 📊 Findings

### Finding 1: CRITICAL CORRECTION -- `disable-model-invocation` IS Supported by Claude Code

Topic 3 Finding 9 stated: "`disable-model-invocation` is Cursor-specific -- it does not appear in the agentskills.io specification." **This is factually incorrect for Claude Code.** Claude Code's official documentation explicitly lists `disable-model-invocation: true` as a first-class frontmatter field with identical semantics to Cursor: "Set to `true` to prevent Claude from automatically loading this skill. Use for workflows you want to trigger manually with `/name`."

The field may not appear in the agentskills.io *portable standard*, but both major platforms (Cursor and Claude Code) implement it independently. The practical portability of this field is HIGH.

**What this changes:** FR-1 and FR-4 were annotated during Topic 3 as "Cursor-specific enforcement; description-based guidance for other platforms." This annotation should be corrected: enforcement works on both Cursor and Claude Code. The portable spec gap only matters for third-party implementations (Codex, Copilot) that strictly follow agentskills.io.

**Source:** [Claude Code Skills Docs: Control who invokes a skill](https://code.claude.com/docs/en/skills.md#control-who-invokes-a-skill)

---

### Finding 2: Claude Code Has Richer Frontmatter Than Cursor

Claude Code extends the Agent Skills standard with fields that have no Cursor equivalent:

| Field | Claude Code | Cursor | Portability |
|-------|------------|--------|-------------|
| `argument-hint` | Autocomplete hints (e.g., `[issue-number]`) | Not supported | Graceful -- ignored in Cursor |
| `model` | Model override (sonnet, opus, haiku, inherit) | Not supported | Graceful -- ignored in Cursor |
| `effort` | Execution effort level (low, medium, high, max) | Not supported | Graceful -- ignored in Cursor |
| `context: fork` | Run skill in isolated subagent | Not supported | **Breaking** -- subagent execution fails silently |
| `agent` | Subagent type (Explore, Plan, custom) | Not supported | **Breaking** -- depends on `context: fork` |
| `hooks` | Lifecycle hooks scoped to skill | Not supported | Graceful -- ignored in Cursor |
| `paths` | Glob patterns for conditional activation | Not supported | Graceful -- ignored in Cursor |
| `shell` | PowerShell support on Windows | Not supported | Graceful -- ignored in Cursor |
| `$ARGUMENTS` substitution | Full support (`$0`, `$1`, `$ARGUMENTS[N]`) | Not supported | **Breaking** -- literal `$ARGUMENTS` in output |
| `` !`command` `` preprocessing | Shell commands run before skill content is sent | Not supported | **Breaking** -- literal text in output |
| `${CLAUDE_SKILL_DIR}` | Skill directory path substitution | Not supported | **Breaking** -- literal text in output |

**Key insight:** Most Claude Code extensions degrade gracefully (unknown frontmatter fields are ignored). But three features -- `context: fork`, `$ARGUMENTS` substitution, and `` !`command` `` preprocessing -- would **break silently** on Cursor if used in a shared skill.

**Implication for dev-infra:** Dev-infra's skills must avoid `context: fork`, `$ARGUMENTS` substitution, and shell preprocessing to remain portable. These features are valuable for Claude Code-only skills but cannot appear in template-distributed skills.

**Source:** [Claude Code Skills Docs: Frontmatter reference](https://code.claude.com/docs/en/skills.md#frontmatter-reference); [Cursor Agent Skills docs](https://cursor.com/docs/skills)

---

### Finding 3: Companion Directories and Progressive Loading Are Fully Portable

Both platforms support the same companion directory structure:

```
skill-name/
├── SKILL.md           ← required; ≤500 lines
├── scripts/           ← executable code (on-demand)
├── references/        ← supplemental docs (on-demand)
└── assets/            ← templates, data (on-demand)
```

Progressive disclosure (three-level loading) works identically:
1. **Level 1:** YAML frontmatter loaded at startup (name + description only)
2. **Level 2:** SKILL.md body loaded when skill is invoked/relevant
3. **Level 3:** Companion files loaded as needed during execution

The SKILL.md 500-line recommendation is consistent across both platforms. The instruction "keep `SKILL.md` under 500 lines; move detailed reference material to separate files" appears in both Cursor and Claude Code documentation.

**Source:** [Claude Code Skills Docs: Add supporting files](https://code.claude.com/docs/en/skills.md#add-supporting-files); [Cursor Skills: references/, assets/ directories](https://cursor.com/docs/skills)

---

### Finding 4: Cross-Platform Skill Discovery Is Already Solved

Cursor automatically scans compatibility directories beyond `.cursor/skills/`:
- `.cursor/skills/` (native)
- `.claude/skills/` (Claude Code compatibility)
- `.codex/skills/` (Codex compatibility)
- `~/.cursor/skills/` and `~/.claude/skills/` (user-level global)

This means a skill stored in `.claude/skills/` works in **both** Cursor and Claude Code without duplication. Dev-infra's templates can distribute skills to `.claude/skills/` as the canonical location, and Cursor will discover them automatically.

Claude Code additionally supports automatic discovery from nested directories in monorepo setups (e.g., `packages/frontend/.claude/skills/` when editing files in that package).

**Source:** [Agentic Thinking: How Cursor Finds Skills](https://agenticthinking.ai/blog/skill-discovery/)

---

### Finding 5: AGENTS.md Remains Unsupported by Claude Code (Confirmed April 2026)

Multiple GitHub feature requests remain open:
- Issue #34235 (March 2026): "support AGENTS.md as a native context file alongside CLAUDE.md" -- 15 reactions, open
- Issue #25882 (February 2026): "Auto-load ~/.claude/AGENTS.md like CLAUDE.md" -- closed as not_planned
- Issue #27732 (February 2026): "Auto-detect and load CLAUDE.md/AGENTS.md" -- closed

Workarounds remain unchanged from Spike A:
1. Minimal `CLAUDE.md` that instructs Claude to read `AGENTS.md`
2. Bash hooks to inject AGENTS.md content at session start
3. Duplicate content across both files

The CLAUDE.md shim approach ("Read and follow AGENTS.md") is reported as working but relies on Claude Code following file-read instructions, which is not guaranteed.

**Source:** GitHub issues #34235, #25882, #27732

---

### Finding 6: Behavioral Fidelity May Be Better on Claude Code Than Cursor

An underappreciated portability factor: Anthropic is the upstream LLM provider for Claude Code, giving it deeper behavioral integration. Cursor is a downstream IDE application that relies on prompt engineering to apply skills, meaning behavioral consistency varies across Cursor's LLM backend options.

The implication for behavioral skills like `/discuss`: the behavioral contract ("be a collaborator who pushes back, don't formalize prematurely") may be followed more reliably on Claude Code than on Cursor, because Claude Code can integrate behavioral instructions at a deeper level than prompt context.

This is a positive finding for portability: the more demanding platform for behavioral fidelity (Claude Code) is also the one with better behavioral integration. Skills designed for Cursor's prompt-engineering constraints will likely perform at least as well on Claude Code.

**Source:** [Lellansin's Blog: Why Cursor Rules Failed and Claude Skill Succeeded](https://lellansin.github.io/2026/01/27/Why-Cursor-Rules-Failed-and-Claude-Skill-Succeeded/)

---

### Finding 7: Known Bugs Differ Between Platforms

| Bug | Cursor | Claude Code |
|-----|--------|-------------|
| `disable-model-invocation: true` + marketplace delivery | Completely hides skill from `/` palette (C-3) | Not reported for plugins |
| `disable-model-invocation: true` + user invocation | Works correctly | Some versions incorrectly block user-initiated `/skill-name` (issue #38969) |
| Disabled skill context consumption | Unknown | Descriptions still consume context tokens even when disabled (issue #31935) |
| Nested directory discovery | Unstable in 2.4.36 (community reports) | Stable -- monorepo support documented |

The bug profiles are different: Cursor's bugs affect marketplace distribution (relevant to dual-distribution model), while Claude Code's bugs affect invocation reliability and context efficiency. Both are evolving.

**Source:** [Cursor Forum: disable-model-invocation marketplace bug](https://forum.cursor.com/t/disable-model-invocation-true-completely-hides-plugin-delivered-skills-from-command-palette/155748); Claude Code issues #31935, #38969

---

### Finding 8: The `.claude/commands/` Backward Compatibility Layer

Claude Code explicitly merged custom commands into skills. A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and work identically. If both exist with the same name, the skill takes precedence.

Existing `.claude/commands/` files continue working and support the same frontmatter. Skills are recommended for new development because they support companion directories and richer configuration.

This means dev-infra's current `.cursor/commands/` files could be distributed as `.claude/commands/` for Claude Code users as a zero-effort migration step -- before the full skill conversion is complete.

**Source:** [Claude Code Skills Docs](https://code.claude.com/docs/en/skills.md)

---

### Finding 9: Real-World Migration Reports Confirm High Portability

A documented migration of a complex sub-agent workflow framework from Claude Code to Codex CLI reports "near-zero migration effort" when the architecture was designed around "agent roles and context separation rather than tool-specific features."

The principle aligns with dev-infra's approach: skills that encode *what to do* (procedural steps, behavioral contracts) rather than *how the platform works* (specific tool APIs, platform-specific features) are portable by design.

**Source:** [Dev.to: Porting AI Coding Workflows from Claude Code to Codex CLI](https://dev.to/shinpr/same-framework-different-engine-porting-ai-coding-workflows-from-claude-code-to-codex-cli-n3p)

---

## 🔍 Analysis

### The Portability Matrix

| Artifact Layer | Cursor | Claude Code | Portability Level |
|----------------|--------|-------------|-------------------|
| **SKILL.md (core format)** | `.cursor/skills/` | `.claude/skills/` | **Full** -- same format, cross-discovered |
| **`disable-model-invocation`** | ✅ (repo skills) | ✅ (with known bugs) | **High** -- both platforms support it |
| **`user-invocable: false`** | ✅ | ✅ | **Full** |
| **Companion dirs** (scripts/references/assets) | ✅ | ✅ | **Full** |
| **Progressive loading** | ✅ (3-level) | ✅ (3-level) | **Full** |
| **AGENTS.md** | ✅ (lowest priority) | ❌ | **Low** -- Cursor only |
| **CLAUDE.md** | ❌ | ✅ (auto-loaded) | **Low** -- Claude Code only |
| **`.mdc` rules** | ✅ (always-apply, globs) | ❌ | **None** -- Cursor only |
| **Claude Code extensions** (context:fork, $ARGUMENTS, hooks, model, effort, paths) | ❌ | ✅ | **None** -- Claude Code only; some break silently |
| **Nested directory discovery** | Unstable | ✅ (monorepo support) | **Partial** |
| **Plugin/marketplace** | Cursor marketplace | Claude Code marketplace | **Separate ecosystems** |

### The Portability Story Is Better Than Expected

The core skill system -- SKILL.md format, frontmatter fields, companion directories, progressive loading, invocation control -- is **fully portable** between Cursor and Claude Code. The earlier assessment (Topic 3 Finding 9) that `disable-model-invocation` was Cursor-only was incorrect and created an overly pessimistic portability view.

The portability gaps fall into two categories:

1. **Context layer gaps** (AGENTS.md vs CLAUDE.md): Each platform has its own always-on context file. This requires a dual-file strategy for the conventions layer. Skills are unaffected.

2. **Platform extension gaps** (Claude Code's richer frontmatter): Claude Code offers features Cursor doesn't have (subagent execution, argument substitution, hooks, model override). These degrade gracefully (unknown fields ignored) UNLESS the skill's functionality depends on them. The three breaking features (`context: fork`, `$ARGUMENTS`, `` !`command` ``) must be avoided in portable skills.

### What This Means for Dev-Infra

1. **Skills are the portable layer.** The skill system is where cross-platform portability is strongest. Dev-infra's decision to migrate commands to skills is validated by the portability data.

2. **`.claude/skills/` is the canonical distribution path.** Cursor auto-discovers `.claude/skills/`. Claude Code natively reads `.claude/skills/`. Using this as the single location eliminates duplication.

3. **The context layer requires a dual-file strategy.** AGENTS.md (for Cursor + other tools that support it) and CLAUDE.md (for Claude Code). Content overlap should be managed via template sync or a generation script.

4. **Platform-specific features are additive, not required.** Claude Code's richer frontmatter (`context: fork`, `model`, `effort`, `hooks`) enables advanced usage for Claude Code users without breaking Cursor compatibility -- as long as the core skill doesn't depend on them.

**Key Insights:**
- [x] Insight 1: `disable-model-invocation: true` is cross-platform (Cursor + Claude Code) -- Topic 3 Finding 9 was incorrect
- [x] Insight 2: `.claude/skills/` is the optimal single distribution path -- both platforms discover it
- [x] Insight 3: Three Claude Code features break silently on Cursor (`context: fork`, `$ARGUMENTS`, `` !`command` ``); portable skills must avoid them
- [x] Insight 4: Behavioral skills may work *better* on Claude Code than Cursor (upstream LLM integration vs prompt engineering)
- [x] Insight 5: The portability gap is primarily in the context layer (AGENTS.md vs CLAUDE.md), not the skill layer

---

## 💡 Recommendations

- [x] **Correct FR-1 and FR-4 annotations:** Remove "Cursor-specific enforcement" annotation. `disable-model-invocation: true` is enforced on both Cursor and Claude Code. The annotation should read: "Cross-platform enforcement (Cursor + Claude Code); portable spec (agentskills.io) does not include this field -- third-party implementations may not enforce it."

- [x] **Use `.claude/skills/` as the canonical skill location in templates.** Both platforms discover this path. Templates should distribute skills here rather than `.cursor/skills/`. Cursor's cross-discovery handles the rest.

- [x] **Establish a portable skill constraint: no `context: fork`, no `$ARGUMENTS`, no `` !`command` `` in template-distributed skills.** These Claude Code features break silently on Cursor. Platform-specific skills (e.g., a Claude Code-only deploy skill) can use them, but they must not appear in the shared skill set.

- [x] **Adopt a dual-file context strategy:** Create both `AGENTS.md` (for Cursor, Codex, Copilot) and `CLAUDE.md` (for Claude Code). Keep them in sync via template sync validation or a generation script. CLAUDE.md can be a shim ("Read and follow AGENTS.md") or a full duplicate -- the shim approach is simpler but less reliable.

- [x] **Defer Claude Code-specific features as future enhancements.** Features like `context: fork` (subagent execution), `hooks` (lifecycle automation), and `paths` (glob-based activation) are powerful but not needed for the initial migration. They can be adopted as Claude Code-only enhancements after the portable skill base is established.

---

## 📋 Requirements Discovered

- [x] **FR-16: Template-Distributed Skills Must Use `.claude/skills/` as Canonical Location.** Skills distributed through dev-infra templates must be placed in `.claude/skills/[skill-name]/SKILL.md`. Both Cursor (via cross-platform discovery) and Claude Code (natively) read from this location. Do not distribute to `.cursor/skills/` -- it is not discovered by Claude Code.
  **Source:** Finding 4
  **Priority:** High

- [x] **FR-17: Portable Skills Must Not Use Platform-Breaking Features.** Skills intended for cross-platform use (template-distributed, dual-distribution) must not use: `context: fork`, `$ARGUMENTS` / `$N` substitution, `` !`command` `` shell preprocessing, or `${CLAUDE_SKILL_DIR}`. These features break silently on platforms that don't support them. Platform-specific skills (clearly marked, not template-distributed) may use them.
  **Source:** Finding 2
  **Priority:** High

- [x] **C-4: AGENTS.md and CLAUDE.md Require Dual-File Strategy.** The context layer (project conventions, behavioral identity) cannot be served from a single file. AGENTS.md is not supported by Claude Code; CLAUDE.md is not supported by Cursor. Dev-infra must maintain both files with synchronized content. Sync drift between them is a maintenance risk.
  **Source:** Finding 5
  **Priority:** High (constraint on context layer design)

- [x] **Note: FR-1/FR-4 Correction Required.** The annotation "Cursor-specific enforcement; description-based guidance for other platforms" from Topic 3 is incorrect. `disable-model-invocation: true` is enforced on both Cursor and Claude Code. Correct during `--consolidate` to: "Cross-platform enforcement (Cursor + Claude Code); agentskills.io spec does not include this field -- third-party tools may not enforce."
  **Source:** Finding 1

- [x] **Note: A-2 (Assumption) Can Be Upgraded to Validated.** A-2 assumed procedural skill compatibility across platforms. This research confirms: SKILL.md format, companion directories, progressive loading, and invocation control are fully portable. A-2 can be marked as validated with the caveat that three Claude Code-specific features break portability if used.
  **Source:** Findings 1-4, 9

---

## 🚀 Next Steps

1. Feed FR-16 and FR-17 into implementation planning: the `.claude/skills/` decision affects template structure
2. Feed C-4 into Topic 6 (dual-distribution): the dual-file strategy is a distribution concern
3. Feed Finding 1 correction into `--consolidate`: FR-1/FR-4 annotation must be fixed
4. Feed Finding 6 into Topic 8 (behavioral contracts): behavioral fidelity on Claude Code vs Cursor

---

**Last Updated:** 2026-04-02
