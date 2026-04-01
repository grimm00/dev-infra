# Research: Command-to-Skill Conversion Mechanics

**Research Topic:** Agentic Workflow Modernization
**Question:** What does it concretely look like to convert a complex dev-infra command into a Cursor skill?
**Status:** 🔴 Not Started
**Priority:** High
**Created:** 2026-03-25

---

## 🎯 Research Question

How do complex multi-mode commands (like `/explore` with setup/amend/conduct modes, 500+ lines) decompose into the skill format? How do reference files, 500-line limits, marketplace metadata, and template sync interact?

**Pre-answered by Spike B:** The `/discuss` command (behavioral archetype) converts cleanly at 267→143 lines. The question now focuses on the procedural archetype with complex multi-mode structure and reference file needs.

---

## 🔍 Research Goals

- [ ] Design the skill equivalent of `/explore` (post-issue-#72): SKILL.md core, reference files for templates, `plugin.json` marketplace metadata
- [ ] Determine how multi-mode commands (setup/amend/conduct) decompose -- one skill with modes, or multiple separate skills?
- [ ] Determine where doc-gen templates live in the skill structure (as reference files = structural schemas connection)
- [ ] Assess template sync validation: how does dev-infra's existing sync mechanism extend to cover skills?
- [ ] Define the `plugin.json` format and what marketplace metadata is required

---

## 📚 Research Methodology

**Context already established:**
- `update-pr-description` skill (procedural archetype, 208 lines, no reference files) is the known-good simple case
- `/discuss` skill (behavioral archetype, 143 lines) is validated by Spike B
- The next target is `/explore` -- the most complex command in the system
- Spike B finding: reference files are where doc templates (structural schemas) live

**Sources to investigate:**
- [ ] Review `update-pr-description` marketplace plugin structure (plugin.json, README, SKILL.md)
- [ ] Web search: Cursor skill reference file loading behavior
- [ ] Web search: multi-mode skill design patterns for AI coding agents
- [ ] Review dev-infra's template sync manifest for extensibility

---

## 📊 Findings

*To be filled in during conduct mode.*

---

## 🔍 Analysis

*To be filled in during conduct mode.*

**Key Insights:**
- [ ] Insight 1: [Description]
- [ ] Insight 2: [Description]

---

## 💡 Recommendations

- [ ] Proposed `/explore` skill structure
- [ ] Multi-mode decomposition strategy
- [ ] Reference file organization pattern
- [ ] Template sync extension approach

---

## 📋 Requirements Discovered

*To be filled in during conduct mode.*

---

**Last Updated:** 2026-03-25
