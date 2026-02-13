# Dev-Toolkit External Opportunities

**Source:** `~/Projects/dev-toolkit` (dt-workflow v1 exploration)  
**Status:** 🟡 Documented  
**Last Updated:** 2026-02-13

---

## 🎯 Overview

Learnings from the dev-toolkit project, specifically the `dt-workflow` exploration branch which produced valuable conceptual frameworks that inform dev-infra's workflow commands and patterns.

**Key Outcome:** The spike workflow framework - a time-boxed experimentation pattern that complements the explore → research → decision pipeline.

---

## 📋 Quick Links

### Learnings Documents

- **[Spike Workflow Framework](spike-workflow-framework.md)** - Complete spike methodology (HIGH priority)
  - When to spike vs research
  - Spike determination framework
  - Templates and process
  - Meta-learnings on agentic coding

---

## 🔑 Key Contributions to Dev-Infra

### 1. Spike Workflow Framework (HIGH Priority)

The most transferable artifact from dt-workflow exploration. Fills a gap in the current explore → research → decision pipeline.

**Gap identified:** Current workflow goes explore → research → decision, but some decisions need hands-on validation before research. Research investigates options; spikes validate assumptions.

**Solution:** Insert spike checkpoint between explore and research for high-risk topics.

**See:** [spike-workflow-framework.md](spike-workflow-framework.md)

### 2. Meta-Learnings on Agentic Coding

Valuable insights on working with AI assistants:

- **Discovery Problem:** Rapid AI implementation can skip the learning phase
- **Ownership Problem:** Harder to maintain code you didn't write
- **Mitigation Strategies:** Smaller increments, test-first, architecture yourself

### 3. Two-Tier Documentation Pattern

Pattern for AI-discoverable vs human-detailed documentation:

| Tier | Location | Purpose | Audience |
|------|----------|---------|----------|
| Tier 1 | `.cursor/rules/*.mdc` | AI-discoverable, concise | AI assistants |
| Tier 2 | `docs/patterns/` | Detailed, with rationale | Human developers |

### 4. L1/L2/L3 Validation Levels

Tiered validation for progressive strictness:

| Level | Type | Failure Behavior |
|-------|------|------------------|
| L1 | Existence | Hard fail - missing required input |
| L2 | Structure | Warn - malformed but present |
| L3 | Content | Suggest - quality/completeness issues |

---

## 📊 Priority Assessment

| Learning | Priority | Effort | Impact |
|----------|----------|--------|--------|
| Spike Workflow Framework | HIGH | 4h | HIGH |
| Meta-Learnings (docs) | MEDIUM | 2h | MEDIUM |
| Two-Tier Documentation | LOW | 1h | LOW |
| L1/L2/L3 Validation | LOW | 2h | MEDIUM |

---

## 🚀 Recommended Next Steps

1. **Integrate spike workflow into explore command** - Add spike determination section to explore output
2. **Update workflow.mdc** - Add spike workflow section to dev-infra and template workflow rules
3. **Create /spike command** - Alias or dedicated command for time-boxed experiments
4. **Document meta-learnings** - Add agentic coding best practices to dev-infra docs

---

## 🔗 Related

- **[Helm-Charts Lightweight Commands](../helm-charts/lightweight-commands.md)** - Mentions spike commands, complements this framework
- **Source Repository:** `~/Projects/dev-toolkit`
- **Source Branch:** `feat/dt-workflow` (archived as exploration)

---

**Last Updated:** 2026-02-13  
**Status:** 🟡 Documented  
**Next:** Integrate spike framework into explore command
