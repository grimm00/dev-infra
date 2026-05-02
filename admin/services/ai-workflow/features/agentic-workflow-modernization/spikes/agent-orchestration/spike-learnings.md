# Spike Learnings: Agent Orchestration

**Feature:** Agentic Workflow Modernization
**Created:** 2026-05-02
**Time-box:** 1 hour
**Result:** Validated (design) — needs live test

---

## Questions Answered

- [x] Q1: What format should the agent definition use? — **Hybrid markdown: numbered steps (declarative pipeline) + behavioral boundaries (prose contract).** This mirrors the skill format (procedural steps + behavioral contract) at a higher level of abstraction.
- [x] Q2: Can the definition fit in a subagent prompt? — **Yes. 3KB for the definition, ~5KB with resolved inputs. Well within Task tool limits.**
- [x] Q3: How does dispatch work? — **Parent reads the `.agent.md` file, resolves inputs (feature, group, service, paths), and passes the full definition as the Task prompt. No special runtime needed — the definition IS the instruction set.**
- [ ] Q4: Does a subagent maintain coherence across all 5 pipeline steps? — **Not yet tested. Needs a real group cycle to validate. This is the key remaining unknown.**

---

## Key Findings

### Finding 1: Agent definitions are "skills for pipelines"

The `.agent.md` format naturally mirrors the `.claude/skills/` SKILL.md format:
- Skills define what a single capability does + behavioral contract
- Agents define what a pipeline of capabilities does + behavioral boundaries

The hierarchy: skills → agents → (future: workflows?)

### Finding 2: Dispatch is just "read file, fill inputs, send as prompt"

No special orchestration framework needed. The parent agent:
1. Reads the `.agent.md` file
2. Resolves inputs to concrete values (paths, branch names)
3. Sends it as a Task tool prompt

This is the simplest thing that could possibly work. The agent definition is a prompt template, not a program.

### Finding 3: The ceremony/judgment boundary is crisp

The agent definition naturally separates:
- **Agent does:** git operations, PR creation, validation, status updates
- **Human does:** design decisions, scope changes, merge approval
- **Stop condition:** 3 technical failures on the same task

This matches the lived experience from Stage 1 — the creative work was in skill authoring, the ceremony was everything around it.

### Finding 4: The "three strikes" contract is simple and sufficient

No need for sophisticated error handling. If `bats tests/` fails 3 times, the agent stops and reports. The human diagnoses. This avoids the anti-pattern of agents trying to "fix" things they don't understand.

### Finding 5: Open question — where do agent definitions live?

Two options emerged:
- **`.agents/` at project root** — parallel to `.claude/skills/`, gives agents first-class status
- **Alongside the feature** — agent definitions are feature-specific, not reusable

The group cycle agent is potentially reusable across features. This suggests `.agents/` at project root, with feature-specific agents able to reference shared ones.

---

## Edge Cases Identified

| Case | Concern | Mitigation |
|------|---------|------------|
| Subagent context decay on long groups | 5+ tasks might lose coherence | Monitor during Stage 2; if needed, dispatch per-task instead of per-group |
| PR validation needs fresh CI data | 60-second wait may not be enough | Agent can poll CI status before running validation |
| Nested skill invocation | Subagent may not have skills auto-attached | Include skill contents inline in prompt, or instruct subagent to read skill files |
| Branch conflicts | Another group cycle could conflict | One group cycle at a time; serialize, don't parallelize |

---

## Go / No-Go

**Recommendation:** Go — with a live test during Stage 2 Group 1

**Rationale:** The design is sound, the format is lightweight, and dispatch is trivial. The only unvalidated piece is end-to-end execution, which we can test on the first real Stage 2 group. If the subagent can't maintain coherence across 5 steps, the fallback is dispatching per-step instead of per-pipeline — still valuable, just more granular.

**What "Go" means:**
1. Create `.agents/` directory convention
2. Move `group-cycle.agent.md` to `.agents/group-cycle.agent.md`
3. Use it for Stage 2 Group 1 as a live test
4. Adjust based on what works and what doesn't

---

## Refined Questions

1. Should `.agents/` be a template product (like skills) or dev-infra internal tooling?
2. Can multiple agent definitions compose (e.g., `group-cycle` calls `pr-validation` as a sub-pipeline)?
3. What's the right granularity — per-pipeline, per-step, or adaptive?

---

## Spike Code

**Location:** `admin/services/ai-workflow/features/agentic-workflow-modernization/spikes/agent-orchestration/`
**Files:**
- `group-cycle.agent.md` — the agent definition (keep — this becomes the real thing)
- `dispatch-example.md` — how dispatch works (keep as reference)

**Keep or discard:** Keep — the agent definition is the prototype AND the product.

---

## Next Steps

- [ ] Create `.agents/` directory at project root
- [ ] Move `group-cycle.agent.md` there
- [ ] Start Stage 2 planning — use the agent for Group 1 as a live validation
- [ ] If live test passes: document the `.agents/` convention and add to AGENTS.md
- [ ] If live test fails: identify which step broke and adjust granularity
