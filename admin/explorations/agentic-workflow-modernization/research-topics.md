# Research Topics - Agentic Workflow Modernization

**Status:** 🟠 In Progress
**Created:** 2026-03-25
**Restructured:** 2026-03-25 - Reordered by dependency, scoped narrower, removed spike-only items, flagged downstream topics

---

## 📋 Research Topics

### Topic 1: Auto-Detection vs Explicit Invocation

**Question:** Should dev-infra's workflow model adopt auto-detection (agent decides when to invoke workflows), stay fully explicit, or go hybrid?

**Priority:** High (gates all other decisions)

**Context:** Superpowers enforces workflows automatically. Dev-infra's `/discuss` command exists precisely because auto-formalization is a problem. This is the core design decision: if the answer is "always explicit," skills are just portable commands with progressive loading and the migration is simpler. If "hybrid," the architecture changes fundamentally. Look for real-world experience with both models, failure modes of auto-detection, and hybrid patterns that balance discipline with autonomy.

**Method:** Research -- compare outcomes of both models in practice, look for hybrid approaches, examine Superpowers' and Cursor's auto-detection behavior

---

### Topic 2: Three-Layer Redistribution Criteria

**Question:** What sorting criteria determine whether content stays as always-on rules, becomes a skill, or remains a command?

**Priority:** High (depends on Topic 1 decision)

**Context:** The three `.mdc` files contain ~500+ lines of always-on context. The 26 commands span simple triggers to complex workflows. Need concrete sorting criteria, not just "it depends." Propose a rubric (e.g., "if it has reference materials → skill; if it's under 50 lines and always relevant → rule; if it's a one-shot trigger → command") and test it against representative samples from each tier.

**Scope:** Develop the rubric and apply it to a representative sample: 2-3 rules sections, 3-5 commands from different complexity tiers (e.g., `/commit`, `/pr`, `/explore`). Do NOT exhaustively assess all 26 commands -- the rubric should be generalizable.

**Method:** Research / analysis -- audit rule content, sample commands, propose and validate rubric

---

### Topic 3: Command-to-Skill Conversion Mechanics

**Question:** What does it concretely look like to convert a dev-infra command into a Cursor skill?

**Priority:** High

**Context:** Dev-infra has never built a Cursor skill. The file format differs (SKILL.md with YAML frontmatter in a directory vs single `.md` command file), the 500-line limit may force decomposition, reference materials are a new concept, and detection descriptions need to be precise without false positives. Additionally, template sync validation would need to handle skills as a third artifact type.

**Scope:** Focus on one representative command (e.g., `/explore` post-issue-#72) and design its skill equivalent on paper. Document: directory structure, SKILL.md content, reference materials, detection description, what rule content it absorbs. This is the "anatomy" of a conversion, not the full migration.

**Method:** Research + spike candidate -- design on paper first, then `/spike command-to-skill-migration` to validate

---

### Topic 4: Templates as Structural Schemas

**Question:** Can dev-infra's templates serve as living structural contracts that agents validate against? What does this look like in practice?

**Priority:** Medium-High

**Context:** Currently templates define initial document shape and are forgotten. If agents could reference templates as structural schemas ("this is what an exploration should look like"), they'd produce more consistent outputs across sessions. This connects to skill reference materials (schemas could live as skill references) and to orchestration (schemas enable machine-checkable completion criteria).

**Scope:** Design a schema for one artifact type (exploration document). Define: what the schema contains, how an agent would reference it, what "validation" means in this context (hard fail vs soft guidance), and where the schema lives (skill reference? standalone file?).

**Method:** Research + consider spike -- analyze the concept, potentially prototype with exploration template

---

### Topic 5: Cross-Platform Portability

**Question:** How portable are skills across Cursor, Claude Code, Codex, and Gemini CLI? Does the agentskills.io standard actually work?

**Priority:** Medium (informational, doesn't gate architecture)

**Context:** If dev-infra templates are meant to be tool-agnostic, portability matters. But if the user base is primarily Cursor, the investment may not be justified. This topic informs the *weight* given to portability in the redistribution rubric (Topic 2), not the architecture itself.

**Method:** Research -- documentation review, community feedback on agentskills.io adoption

---

## 🔬 Spike-Only Items (Not Research Topics)

These are addressed through spikes, not research. They're tracked in the exploration's spike determination table.

| Item | Spike | Depends On |
|------|-------|------------|
| Subagent-per-task delegation | `/spike subagent-task-delegation` | -- |
| Pipeline orchestration with tracker state | `/spike pipeline-orchestrator` | Subagent spike results |
| Superpowers hands-on evaluation | Install and try in throwaway project | -- (optional) |

---

## ⏳ Downstream Validation (After Architecture Decisions)

These can only be answered after Topics 1-3 are resolved.

| Question | Depends On | When |
|----------|------------|------|
| What's the total maintenance cost delta? | Topics 1-3 (know the target architecture) | After redistribution rubric is applied |
| How does issue #72 interact with skills migration? | Issue #72 resolution + Topic 3 | After #72 is addressed |

---

## 🎯 Research Workflow

```
Topic 1: Auto-detection decision      ← GATE: determines architecture direction
    ↓
Topic 2: Redistribution rubric        ← Apply to representative sample
    ↓
Topic 3: Conversion mechanics          ← Design one skill on paper → spike to validate
    ↓
Topic 4: Structural schemas            ← Design one schema → consider spike
    |
Topic 5: Portability                   ← Informational, feeds into rubric weighting
    
[After architecture decisions]
    ↓
Downstream: Maintenance cost, issue #72 interaction
    
[Parallel / independent]
Spike: Subagent delegation → Spike: Pipeline orchestration
```

---

**Last Updated:** 2026-03-25
