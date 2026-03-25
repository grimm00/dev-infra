# Research Topics - Agentic Workflow Modernization

**Status:** 🟠 In Progress
**Created:** 2026-03-25

---

## 📋 Research Topics

### Topic 1: Rules Decomposition Criteria

**Question:** What sorting criteria should determine whether rule content stays as always-on rules, becomes a skill, or gets removed entirely?

**Priority:** High

**Context:** The three `.mdc` files contain ~500+ lines of always-on context. The skills model's progressive disclosure could significantly reduce per-conversation token cost, but the decomposition boundary isn't obvious for tightly coupled content.

**Method:** Research / analysis

---

### Topic 2: Command-to-Skill Migration Assessment

**Question:** Which of the 26 commands benefit most from conversion to skills, and what does the conversion look like concretely?

**Priority:** High

**Context:** Each command should be assessed against: auto-detection value, progressive disclosure value, cross-platform portability, reference material needs, and migration cost. The answer likely isn't "all of them" -- some are better as commands.

**Method:** Research / analysis per command

---

### Topic 3: Auto-Detection vs Explicit Invocation

**Question:** Should dev-infra's workflow model adopt auto-detection (agent decides when to invoke workflows), or should explicit user invocation remain the design principle?

**Priority:** High

**Context:** Superpowers enforces workflows automatically. Dev-infra's `/discuss` command exists precisely because auto-formalization is a problem. The tension between discipline (auto-enforcement) and autonomy (explicit invocation) is a core design decision.

**Method:** Research -- compare outcomes of both models, look for hybrid approaches

---

### Topic 4: Subagent-per-Task Architecture

**Question:** Can Cursor's native Task/subagent system be integrated into the `/task` workflow for per-task delegation?

**Priority:** Medium-High

**Context:** This is the one area where Superpowers offers something dev-infra doesn't have. Fresh context per task could improve quality for larger features. But subagent limitations (no conversation history, no user message access) may make this impractical.

**Method:** Spike -- requires runtime experimentation with Cursor's Task tool

---

### Topic 5: Cross-Platform Portability

**Question:** How portable are skills across Cursor, Claude Code, Codex, and Gemini CLI? Does the agentskills.io standard actually work in practice?

**Priority:** Medium

**Context:** If dev-infra templates are meant to be tool-agnostic, portability matters. But if the user base is primarily Cursor, the investment may not be justified. Need to assess the standard's maturity and real-world adoption.

**Method:** Research -- documentation review, community feedback

---

### Topic 6: Issue #72 Integration

**Question:** How does removing `/explore --conduct` (issue #72) interact with the skills migration? Does the simplified explore workflow make the skill version easier or does it change the architecture?

**Priority:** Medium

**Context:** Issue #72 proposes explore as a map (scaffolding + amend only), with research/spike as peer investigation tools. This toolbox model is cleaner but changes the shape of what an "explore skill" would look like.

**Method:** Research / analysis -- design the post-#72 explore workflow and assess skill fit

---

### Topic 7: Maintenance Cost Comparison

**Question:** What's the total maintenance burden of skills + leaner rules + commands vs. the current rules + commands model?

**Priority:** Medium

**Context:** Dev-infra already maintains 26 commands across dev-infra + 2 templates (standard-project, learning-project). Template sync validation ensures consistency. Adding skills as a third artifact type increases the surface area. Need to assess whether the reduced rule size and improved context efficiency justify the added complexity.

**Method:** Research / analysis

---

### Topic 8: Superpowers Hands-On Evaluation

**Question:** What does Superpowers actually feel like in practice, and which of its concepts are worth adopting?

**Priority:** Low-Medium

**Context:** The comparison so far is based on documentation. Installing Superpowers in a test project and running through its workflow firsthand would ground the analysis in experience rather than theory.

**Method:** Spike -- install and use Superpowers in a throwaway project

---

## 🎯 Research Workflow

1. Address Topics 1-3 first (High priority -- core architecture decisions)
2. Spike Topic 4 if subagent integration looks promising
3. Topics 5-7 inform the migration strategy after core decisions are made
4. Topic 8 is optional -- useful for grounding but not blocking

---

**Last Updated:** 2026-03-25
