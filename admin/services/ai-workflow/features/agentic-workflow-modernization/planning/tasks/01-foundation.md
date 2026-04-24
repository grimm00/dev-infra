# Foundation (Rules + AGENTS.md)

**Feature:** Agentic Workflow Modernization (Stage 1: Thinker)
**Group:** Foundation (Rules + AGENTS.md)
**Status:** 🔴 Scaffolding (needs expansion)
**Last Updated:** 2026-04-24

---

## 📝 Tasks

> ⚠️ **Scaffolding:** Run `/transition-plan agentic-workflow-modernization --expand --group 1` to add detailed implementation notes.

- [ ] Task 1: Audit current `.mdc` rules content and classify by destination
  - Read all current `.mdc` rules files in `.cursor/rules/` and inventory content
  - Classify each section against FR-4's four-type separation: portable convention, Cursor-specific config, procedural reference, mutable state
  - Output: a classification table mapping each section to its destination (AGENTS.md, slimmed `.mdc`, skill body, or removed)

- [ ] Task 2: Draft AGENTS.md with portable conventions
  - Write portable conventions inline (FR-1 — no file references)
  - Target ~150-200 lines covering Git Flow, hub-and-spoke pattern, status indicators, naming, project structure
  - Include pointer to current state file rather than embedding mutable state (FR-5)

- [ ] Task 3: Draft CLAUDE.md mirroring AGENTS.md content
  - Same content as AGENTS.md (C-1, C-4 dual-file strategy)
  - Document the manual sync expectation; flag for future automation

- [ ] Task 4: Slim `.mdc` rules to ~50 lines
  - Cursor-specific behavioral config only (response style, tool preferences, mode-switching hints)
  - Pointer to AGENTS.md for shared conventions
  - Pointer to `.claude/skills/` for available workflows
  - Remove all mutable project state (FR-5)
  - One file replaces the current three (`main.mdc`, `workflow.mdc`, `template.mdc`)

---

## 🎯 Goals

1. Establish the always-on context layer that all subsequent skill conversion depends on
2. Reduce always-on context from ~1,500 lines to ~50 + AGENTS.md (~150-200 lines)
3. Validate the four-type separation (FR-4) on real content before applying it elsewhere

---

## ✅ Completion Criteria

- [ ] `.mdc` rules audit captured (classification of every section)
- [ ] AGENTS.md exists with portable conventions inline
- [ ] CLAUDE.md exists, content synchronized with AGENTS.md
- [ ] `.mdc` rules at ~50 lines with only Cursor-specific config
- [ ] No mutable project state in any always-on file
- [ ] Manual verification: agent behaves consistently with reduced context

---

## 🔗 Dependencies

- None (this is the foundation that subsequent groups depend on)
- Output enables Groups 2-4 (skill conversion)

---

**Last Updated:** 2026-04-24
