# Research: Auto-Detection vs Explicit Invocation

**Research Topic:** Agentic Workflow Modernization
**Question:** Should dev-infra's workflow model adopt auto-detection (agent decides when to invoke workflows), stay fully explicit, or go hybrid?
**Status:** 🔴 Not Started
**Priority:** High (GATE -- all other decisions depend on this)
**Created:** 2026-03-25

---

## 🎯 Research Question

Should dev-infra adopt auto-detection (agent automatically invokes skills when context suggests it), stay fully explicit (user always invokes), or go hybrid (per-skill opt-in/out)?

This is the gating decision: the redistribution rubric (Topic 2) and skill description design (Topic 8) both depend on which model is chosen.

---

## 🔍 Research Goals

- [ ] Understand `disable-model-invocation: true` behavior: does it fully suppress auto-detection on both Cursor and Claude Code?
- [ ] Review Hex/Superpowers' auto-detection patterns: what triggers automatic workflow invocation, and what are the failure modes?
- [ ] Define criteria for when auto-detection is appropriate vs harmful for dev-infra's specific commands
- [ ] Evaluate the hybrid model: per-skill opt-in/out without a global architecture decision
- [ ] Assess whether Cursor's Ask mode and Claude Code's existing modes provide sufficient read-only behavior to replace `/discuss`

---

## 📚 Research Methodology

**Context already established (from spikes and exploration):**
- `disable-model-invocation: true` in SKILL.md frontmatter prevents auto-detection per-skill (confirmed in Spike B)
- Hex/Superpowers is already deployed in the team marketplace (v2.1.0)
- Dev-infra's `/discuss` command exists precisely because auto-formalization is a problem
- The hybrid model is architecturally feasible without a global decision

**Sources to investigate:**
- [ ] Cursor docs on skill invocation behavior and `disable-model-invocation` semantics
- [ ] Claude Code docs on skill/tool invocation control
- [ ] Hex/Superpowers documentation on auto-detection triggers and patterns
- [ ] Web search: failure modes of auto-detection in agentic coding workflows
- [ ] Web search: explicit vs auto-detection UX patterns in AI developer tools

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

- [ ] Recommendation: [Go explicit / Go hybrid / Go auto-detect]
- [ ] Criteria for per-skill auto-detection decision (if hybrid)

---

## 📋 Requirements Discovered

*To be filled in during conduct mode.*

---

## 🚀 Next Steps

1. Conduct web research on auto-detection failure modes and patterns
2. Review Hex auto-detection triggers
3. Make explicit/hybrid/auto recommendation
4. Feed into Topic 2 (redistribution rubric)

---

**Last Updated:** 2026-03-25
