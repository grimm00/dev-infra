# ADR-004: Quality and Conversion Process

**Status:** Accepted
**Created:** 2026-04-14
**Last Updated:** 2026-04-14

---

## Context

ADR-001 selected ~16 skills across 4 stages. ADR-002 defined the architectural patterns. This ADR codifies how each skill conversion is executed and what quality standards apply. The interview pre-decided these through Sections 5 and 8.

Key requirements:

- FR-19: Five-property quality rubric for behavioral instructions
- FR-20: Gotchas section in every behavioral skill
- FR-22: Enforcement layer allocation (skill body vs hooks vs CLI)
- FR-11: Agent self-validation step for procedural skills
- NFR-1: Template changes are interface contract changes
- NFR-3: Research/planning workflows must remain conversationally orchestrated

---

## Decision

**Strict rubric application during conversion. No Tier 2/3 instructions shipped.**

### Conversion Workflow Per Skill

For each skill in a stage:

1. **Audit the source command** -- Classify every behavioral instruction against the three precision tiers from Topic 8 Finding 1:
   - Tier 1 (Precise): Keep as-is
   - Tier 2 (Mixed): Rewrite to pass rubric
   - Tier 3 (Vague/Problematic): Rewrite or remove

2. **Apply the five-property rubric (FR-19)** -- Every behavioral instruction must be:
   - **Observable:** Compliance is determinable from output
   - **Bounded:** Agent can determine when it has done enough
   - **Outcome-framed:** Describes what to produce, not who to be
   - **Delta-only:** Adds information the model wouldn't have by default
   - **Failure-aware:** Specifies what NOT to do and how to handle ambiguity

   Instructions failing 3+ properties must be rewritten or removed.

3. **Populate gotchas (FR-20)** -- Two sources:
   - Topic 8 audit (~15 Tier 3 instructions across 6 commands)
   - Personal experience with failure modes
   - Each gotcha names the mistake and the correct alternative

4. **Separate workflow from behavioral contract (FR-6)** -- Hybrid skills get explicit `## Workflow` and `## Behavioral Contract` sections

5. **Write dual-location description (FR-21)** -- Description routes (what, when, when NOT), body enforces

6. **Verify self-containment (FR-8)** -- Core workflow works from SKILL.md alone; companion files are supplementary

7. **Regression test against current command** -- The skill must perform at least as well as the command it replaces (C5-3)

### Quality Gate

A skill is not shipped until:

- All behavioral instructions pass the five-property rubric
- Gotchas section is populated
- SKILL.md is under 500 lines (C-2)
- Skill works without companion files loaded (FR-8)
- No degradation from current command quality

This makes conversion slower (precision work, not format migration) but output quality is high from day one (C1-4, C5-1).

### Enforcement Layer Allocation (FR-22)

During conversion, each piece of guidance is noted for its enforcement layer:

| Layer | What Goes Here | V1 Status |
|-------|---------------|-----------|
| Skill body | Judgment work (behavioral contracts, decision criteria, workflow sequence) | Active |
| Hooks | Deterministic rules (commit format, file boundaries, pre-conditions) | Documented as gotchas, deferred to hooks post-v1 |
| CLI/tooling | State surfacing (workflow position, completion status) | Deferred (C6-1) |
| Human sync points | Cross-project connections, UX judgment, priority decisions | Active via `/discuss` |

Gotchas that are deterministic rules (not judgment calls) start documented in the skill body and migrate to hooks when that infrastructure exists (CP-1 applied).

### UX North Star

Every design decision and rubric evaluation is tested against: **"Does this make the user feel in control and enriched through slowing down?"** (C8-2). If a skill makes the user feel rushed, confused, or bypassed, it has failed regardless of technical correctness.

---

## Consequences

### Positive

- Conversion is the quality audit -- no separate review step needed
- Five-property rubric is testable (not subjective)
- Gotchas upfront means fewer failure modes in practice
- Enforcement layer documentation creates a migration roadmap for hooks/CLI
- Discuss skill gets extra scrutiny as the quality benchmark (C5-3)

### Negative

- Conversion is slower than format migration (~2-4 hours per skill vs ~30 min)
- Rubric application requires judgment (some instructions are borderline)
- Gotchas need periodic refresh from real usage (initial population is a starting point)

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-19 (five-property rubric) | Directly satisfied -- applied during every conversion |
| FR-20 (gotchas) | Directly satisfied -- populated from audit + experience |
| FR-22 (enforcement layer) | Documented per skill; hooks/CLI deferred |
| FR-11 (self-validation) | Included in conversion checklist for procedural skills |
| NFR-1 (template contracts) | Awareness during conversion; formal enforcement via sync |
| NFR-3 (conversational orchestration) | Preserved -- conversion doesn't add pipeline infrastructure |

---

## References

- [V1 Scope](v1-scope.md) -- C5-1, C5-2, C5-3, C8-2
- [Requirements](../../research/agentic-workflow-modernization/requirements.md)
- [Topic 8: Behavioral Contracts](../../research/agentic-workflow-modernization/topic-8-behavioral-contracts.md)
- [Spike B Learnings](../../explorations/agentic-workflow-modernization/spike-learnings.md)

---

**Last Updated:** 2026-04-14
