# Research: Roadmap Layer in AGENTS.md

**Research Topic:** Agentic Workflow Modernization
**Question:** Should dev-infra's AGENTS.md include a "Roadmap" layer pointing to current planning artifacts?
**Status:** 🟡 Deferred (design-only, no spike needed)
**Priority:** Low
**Created:** 2026-03-25

---

## 🎯 Research Question

The four-layer AGENTS.md model proposed includes a "Roadmap" section that points to current planning artifacts (feature plans, phase status, active work). Does this belong in AGENTS.md? In a v0.11.0 template? What are the tradeoffs?

---

## 🔍 Design Question (not empirical research)

This is a design decision, not a research question requiring web search. The question is:

**Should AGENTS.md include:**
```markdown
## Roadmap
Current active work: [See docs/maintainers/planning/status-and-next-steps.md]
```

Or is this out-of-scope for AGENTS.md (which is meant for stable conventions, not current state)?

---

## 🔍 Design Considerations

**Arguments for including Roadmap:**
- Agents that read AGENTS.md get immediate context on current work without being told explicitly
- Planning artifacts are the "shared understanding" of active project goals -- aligning agents with this is high value
- The discussion agent insight: documentation is alignment infrastructure; roadmap is part of that

**Arguments against:**
- AGENTS.md is meant for stable conventions; roadmap changes frequently and creates maintenance burden
- Inline-only constraint (from Spike A) makes this a large inline block, not a pointer
- A separate `CLAUDE.md` or project-wide context file is better for mutable state

**Spike A constraint impact:**
- File references like `See: docs/maintainers/planning/status.md` are NOT followed
- Roadmap content would need to be inline or summarized, which makes it high-maintenance

**Tentative recommendation:** Roadmap section does NOT belong in AGENTS.md as a pointer. Consider a separate `CONTEXT.md` or `CURRENT-WORK.md` file that agents can be explicitly given when needed, rather than always-on context that goes stale.

---

## 🚀 Next Steps

1. Revisit during v0.11.0 planning
2. Incorporate four-layer model decisions from Topic 2 (redistribution criteria)
3. Consider whether "agent context files" (mutable, session-specific) are a separate layer from "agent identity files" (stable, always-on)

---

**Note:** This topic is deferred. No further research action needed until v0.11.0 planning begins.

---

**Last Updated:** 2026-03-25
