# Research: AGENTS.md Portability and Platform Support

**Research Topic:** Agentic Workflow Modernization
**Question:** Is AGENTS.md a reliable portable equivalent of Cursor's always-applied rules?
**Status:** ✅ Spiked (Spike A)
**Priority:** High (gate for four-layer model)
**Created:** 2026-03-25

---

## 🎯 Research Question

Does AGENTS.md provide reliable always-on context feeding across both Cursor and Claude Code? What is its actual behavior, and how does it interact with platform-specific rule systems?

---

## 🔍 Research Summary

This topic was empirically tested in Spike A (`agents-md-portability`). Key findings are documented in `../spikes/spike-learnings.md`.

**Spike A Findings:**

1. **AGENTS.md is a real and growing standard** -- 60k+ repos, Linux Foundation-backed, broadly adopted. Not a fringe convention.

2. **Cursor support is real but lowest-priority** -- Cursor reads and feeds AGENTS.md content to the agent. However, it is treated with the lowest precedence in the rule hierarchy (below `.mdc` always-applied rules, below `.cursorrules`). It feeds in but doesn't override.

3. **Claude Code CLI does NOT natively read AGENTS.md** -- In the CLI usage pattern (the way the team uses Claude Code), AGENTS.md is not read. It IS read in Claude Code within GitHub Actions / CI contexts. This is a significant portability limitation for CLI-based workflows.

4. **Hub-and-spoke file references are NOT supported** -- The AGENTS.md spec (and Cursor's implementation) does not follow file references (`See: path/to/file.md`). Content must be inline or it won't be fed to the agent.

5. **Adjusted four-layer model:** The original proposal was AGENTS.md as the portable convention layer. Post-spike, the adjusted model is:
   - **Layer 1:** AGENTS.md -- portable, always-on, inline content only, Cursor + CI-context Claude Code
   - **Layer 2:** Platform-specific rules -- `.mdc` for Cursor, `CLAUDE.md` for Claude Code CLI
   - **Layer 3:** Skills (SKILL.md) -- portable behavioral/procedural workflows
   - **Layer 4:** Commands -- simple triggers, Cursor-specific

**Open Questions (for deeper research):**
- [ ] Is Claude Code CLI AGENTS.md support planned? Check current docs/changelog.
- [ ] Does the inline-only constraint make AGENTS.md too heavyweight for portable conventions?
- [ ] What is the appropriate scope of AGENTS.md content given inline-only constraint?

---

## 💡 Recommendations (from Spike A)

- **Use AGENTS.md for genuine cross-platform operational conventions** -- repo structure, test commands, branch strategy, conventions that both Cursor users and CI agents need.
- **Do not replicate behavioral configuration from `.mdc` rules** into AGENTS.md unless it needs to be portable to CI contexts.
- **File references are not a feature** -- all content must be inline.
- **Track Claude Code CLI AGENTS.md support** -- this is the key portability gap.

---

## 📋 Requirements Discovered (from Spike A)

- FR: AGENTS.md content must be inline (no file references) if it needs to be reliably fed to agents
- C: Claude Code CLI portability requires `CLAUDE.md` as a separate layer; AGENTS.md alone is insufficient
- A: AGENTS.md is treated as lowest-priority context in Cursor; `.mdc` rules take precedence

---

**Source:** `../spikes/spike-learnings.md` (Spike A section)
**Last Updated:** 2026-03-25
