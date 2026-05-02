# Skill Toolbelt — Co-located Scripts for Skills

**Source:** Agentic Workflow Modernization (Stage 1, Group 3 testing)
**Target:** Dev-infra skill architecture (Stage 2+)
**Status:** 🟡 Planned
**Created:** 2026-05-01
**Last Updated:** 2026-05-01

---

## 📋 Overview

During Group 3 (Explore Family) implementation and testing, a pattern emerged:
skills spend significant context and tokens on deterministic work (creating
directory structures, rendering templates, counting headings for auto-numbering)
that a simple script could handle in milliseconds. The idea is to give skills
a "toolbelt" — co-located scripts that handle the deterministic parts, freeing
the agent to focus on the judgment parts.

**Precedent:** `dt-review` already demonstrates this pattern. It's a shell script
that collects Sourcery comments and formats them into a priority matrix template.
The agent fills in the assessment. Script handles collection, agent handles judgment.

---

## 🎯 Proposed Architecture

```
.claude/skills/
├── explore/
│   ├── SKILL.md                         ← behavioral contract + workflow
│   ├── scripts/
│   │   ├── create-exploration.sh        ← creates 3-file directory structure
│   │   └── count-themes.sh             ← returns next theme number for amend
│   ├── explore-start/SKILL.md
│   └── explore-amend/SKILL.md
├── int-opp/
│   ├── SKILL.md
│   └── scripts/
│       └── create-opportunity-dir.sh    ← creates project/learnings/improvements dirs
```

**Principle:** Scripts handle deterministic scaffolding, agents handle judgment.

---

## 🔍 Skills That Would Benefit

| Skill | Deterministic work (script candidate) | Judgment work (stays in agent) |
|-------|--------------------------------------|-------------------------------|
| explore-start | Create 3-file directory, template structure | Theme extraction, question extraction |
| explore-amend | Count themes, insert at right position | Theme content, spike assessment |
| int-opp | Create opportunity directory, template files | Learning classification, actionability |
| narrative | Gather context from multiple directories | Story arc, tone, evidence selection |
| discuss | **None** — read-only, no artifacts | Everything |

---

## ✅ Benefits

- **Speed:** Script execution is milliseconds vs agent "thinking" about file creation
- **Consistency:** Template format is deterministic — scripts produce identical structure every time (no drift in bullet labels, heading format, etc.)
- **Reduced contract surface:** Fewer behavioral instructions about format = less room for contract violations
- **Proven pattern:** `dt-review` demonstrates the script-for-scaffolding, agent-for-judgment separation works in practice

---

## ⚠️ Considerations

- **Platform portability:** Shell scripts work in both Claude Code (tool execution) and Cursor (Shell tool). Invocation mechanism differs but the scripts themselves are identical.
- **Discovery:** Does Claude Code's plugin system recognize `scripts/` directories inside skills? Hex's plugin has `hooks/` — `scripts/` may follow the same pattern. Needs validation.
- **Simplicity tradeoff:** Current skills are pure markdown — any model on any platform can follow them without executing anything. Adding scripts makes skills faster but platform-dependent for the scripted parts. Skills should still be *functional* without scripts (graceful degradation).
- **Scope:** Start with one skill (explore-start) as a pilot before standardizing across all skills.

---

## 🚀 Suggested Next Steps

1. **Pilot:** Add `scripts/create-exploration.sh` to explore-start as the first test
2. **Validate:** Test in both Cursor and Claude Code — verify script execution works
3. **Measure:** Compare agent token usage and output consistency with and without script support
4. **Standardize:** If pilot succeeds, define the `scripts/` convention in the explore family parent SKILL.md and apply to other skills

**When:** Stage 2+ (after Stage 1 cutover is complete). Not a Stage 1 blocker.

---

## 🔗 Related

- **Discussion source:** `/discuss` session during Group 3 testing (2026-05-01)
- **`dt-review` precedent:** `scripts/dt-review` — shell script for Sourcery review collection
- **Hex plugin `hooks/`:** `~/.claude/plugins/cache/drw-up-claude-marketplace/hex/2.1.0/hooks/` — similar co-located script pattern in marketplace plugins
- **ADR-004 (Five-Property Rubric):** Scripts reduce the number of behavioral instructions that need rubric compliance

---

**Last Updated:** 2026-05-01
