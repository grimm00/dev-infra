# Research: Cross-Platform Portability

**Research Topic:** Agentic Workflow Modernization
**Question:** What behavioral gaps exist between Cursor and Claude Code for skills, rules, and AGENTS.md?
**Status:** 🔴 Not Started
**Priority:** Medium
**Created:** 2026-03-25

---

## 🎯 Research Question

If dev-infra distributes skills for use in both Cursor IDE and Claude Code, what concretely breaks or differs? What is the portability tax for each artifact layer?

**Pre-answered by Spike A:** AGENTS.md is not natively read by Claude Code standalone (though it is read in Claude Code within CI/CD contexts). This moves the portability question to skills and commands.

---

## 🔍 Research Goals

- [ ] Identify behavioral differences for SKILL.md between Cursor and Claude Code
- [ ] Identify whether `disable-model-invocation: true` has equivalent semantics on Claude Code
- [ ] Identify what falls back gracefully vs what breaks silently on the other platform
- [ ] Determine what platform-specific wrappers or notes are needed
- [ ] Clarify current AGENTS.md support status for Claude Code (post-Spike A: "not natively" vs "in some contexts")

---

## 📚 Research Methodology

**Context already established:**
- Spike A: AGENTS.md read by Claude Code in CI/CD contexts (GitHub Actions) but not in CLI usage
- Spike B: `/discuss` SKILL.md converted successfully; Claude Code compatibility not tested
- Team marketplace distributes skills for both platforms from same SKILL.md
- `disable-model-invocation: true` confirmed working in Cursor; Claude Code equivalent unclear

**Sources to investigate:**
- [ ] Claude Code documentation on skill/SKILL.md support and invocation behavior
- [ ] Cursor documentation on skill loading and platform-specific features
- [ ] Web search: Claude Code AGENTS.md support updates (post March 2026)
- [ ] Review marketplace SKILL.md files for any platform-conditional behavior

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

- [ ] Portability compatibility matrix (per artifact type, per platform)
- [ ] Wrapper/annotation strategy for platform-specific behavior
- [ ] Go/no-go recommendation for each skill archetype on Claude Code

---

## 📋 Requirements Discovered

*To be filled in during conduct mode.*

---

**Last Updated:** 2026-03-25
