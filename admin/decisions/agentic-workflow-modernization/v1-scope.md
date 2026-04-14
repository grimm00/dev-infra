# V1 Scope — Agentic Workflow Modernization

**Purpose:** Incrementally-built scope document derived from decision interview discussions
**Status:** ✅ Interview Complete
**Created:** 2026-04-13
**Last Updated:** 2026-04-14

**Source:** [decision-interview.md](decision-interview.md)
**Requirements:** [requirements.md](../../research/agentic-workflow-modernization/requirements.md)

---

## Section 1: User Experience Priorities

### Conclusions

**C1-1: V1 scope is the thinking pipeline.**

The most-used commands (explore, research, transition-plan, review, commit, int-opp, discuss) form a cohesive thinking-to-artifact pipeline. These commands have the highest frequency, highest judgment-content ratio, and the most to gain from skill conversion. Estimated ~10-15 skills total. Mechanical commands (release automation, fix management) are explicitly deferred to v2+.

**C1-2: Explore's conduct mode is deprecated.**

Conduct overlaps with research. Explore should be a one-pass theme extractor with amend capability — lighter, faster, more focused. Depth work belongs in research. This simplifies skill decomposition (no explore-conduct skill needed) and is a design input from lived experience, not the requirements doc.

**C1-3: Role-based "models" inform skill grouping.**

Real-world professional roles (e.g., what a Release Manager does) serve as decomposition lenses for organizing skills — not as runtime agents. Studying a role's responsibilities informs how skills are grouped, named, and scoped. For the thinking pipeline, the candidate models are:

- **Thinker** — explore, discuss, int-opp (organizing and reacting to ideas)
- **Researcher** — research setup, conduct, consolidate (investigating questions)
- **Planner** — transition-plan, task (converting knowledge into action)
- **Reviewer** — review, commit (quality gate before permanence)

Whether these become directories, naming prefixes, or just a mental framework is a design decision deferred until implementation.

**C1-4: The value proposition is behavioral precision, not format conversion.**

Converting commands to skills 1:1 with the same content wouldn't produce a noticeable UX difference. The real gains come from what the skill format enables: richer behavioral contracts (FR-19), gotchas sections (FR-20), context efficiency (FR-4/FR-5), and progressive loading. V1 must demonstrate these advantages, not just migrate syntax.

### Requirement Impact

| Requirement | V1 Relevance | Rationale |
|---|---|---|
| FR-7 (multi-mode decomposition) | **Direct** | Explore and research both have modes |
| FR-19 (five-property rubric) | **Direct** | Thinking pipeline is the most behavioral |
| FR-20 (gotchas sections) | **Direct** | High-signal for judgment-heavy skills |
| FR-4 (rules content separation) | **Direct** | Enables context efficiency gains |
| FR-5 (remove mutable state) | **Direct** | Quick win, high impact |
| FR-2 (disable auto-detection) | **Direct** | All workflow skills need this |
| FR-8 (SKILL.md self-contained) | **Direct** | Structural constraint on all skills |
| FR-12 (`.claude/skills/` location) | **Direct** | Canonical path for all skills |
| FR-13 (no platform-breaking features) | **Direct** | Portability constraint |
| FR-21 (dual-location description) | **Direct** | Structural pattern for all skills |
| FR-9 (template sync for skills) | **Follows** | Needed after skills exist, not before |
| FR-10 (doc-gen template relocation) | **Follows** | Only when generating skills are converted |
| FR-14 (canonical source in templates) | **Follows** | Authoring location, not blocking |
| FR-15 (marketplace-compatible format) | **Structural** | Informs design but not a v1 experience goal |
| FR-16 (distribution channel declaration) | **Deferred** | v2 concern |
| FR-17 (orchestration spectrum metadata) | **Deferred** | Nice-to-have, not blocking |

---

## Section 2: Backward Compatibility and Migration

### Conclusions

**C2-1: No backward compatibility constraint. Clean cutover per command.**

Sole user means no deprecation period, no coexistence wrappers, no "old commands call new skills" bridges. When a command becomes a skill, the command file is deleted. Migration is atomic per command — convert, verify, remove. This eliminates the assumed gradual migration complexity from the research phase.

**C2-2: Mixed state is acceptable and functions as a validation gate.**

Having some workflows as skills and others as commands is tolerable indefinitely. More importantly, it serves as a natural go/no-go signal: if v1 skill conversions work well, that success motivates v2. If they don't, the blast radius is limited to the thinking pipeline.

**C2-3: No downstream project dependencies on current commands.**

No other projects currently consume dev-infra commands, so there's no external compatibility pressure. Distribution to downstream projects via template-distributed skills (FR-12, FR-14) is seen as an upgrade over template-distributed commands. The template path is sufficient for v1; marketplace distribution is a bonus, not a requirement.

### Migration Implications

- No versioned deprecation cycle needed (no "announce, wait, remove")
- Migration pace is dictated solely by implementation readiness, not compatibility timelines
- When skills eventually reach downstream projects via templates, backward compatibility *will* start to matter — but that's a v2+ concern with v1 learnings to inform it

---

## Section 3: Skill Count and Maintenance

### Conclusions

**C3-1: 60-80 skills sounds high but role-model decomposition makes it manageable.**

The raw number feels overwhelming, but grouping skills by professional role (Thinker, Researcher, Planner, Reviewer) reduces cognitive load from "pick from N" to "pick a role, then pick from 2-4." The role model manages perceived complexity, though maintenance burden of individual files remains.

**C3-2: Skill families validated via spike — explicit reference pattern, not automatic inheritance.**

The proposed skill family architecture (parent skill with shared behavioral contract + focused sub-skills) works, but not through automatic inheritance. Spike findings (2026-04-13):

- **No automatic inheritance:** Test A confirmed that directory nesting provides zero implicit context sharing. The parent's behavioral contract does NOT propagate to children automatically.
- **Explicit reference is sufficient:** Adding "read `../SKILL.md` for family conventions" to child skills is trivially reliable. Each child controls whether it opts into family context. No magic, no surprises.
- **Directory grouping serves humans AND agents:** Related skills live together for human maintenance/navigation. For agents, the parent SKILL.md functions as a progressive disclosure index — reducing search from 60-80 flat descriptions to one family orientation, then the right child. Same pattern as Topic 1's skill-level progressive disclosure, applied at the family level.
- **Platform divergence is thin:** Claude Code auto-discovers nested skills; Cursor requires explicit attachment. Same files, different discovery — a per-platform adapter, not a content fork.

**Spike source:** [nested-skill-discovery.md](../../explorations/agentic-workflow-modernization/spike/nested-skill-discovery.md)

**C3-3: Template sync is not a day-one requirement.**

Consistent with C2-3. Skills stabilize in dev-infra first, then propagate to templates. First downstream delivery will be a batch of stable skills, not an incremental trickle.

---

## Cross-Cutting Principle: Explicit Over Implicit

*Emerged from spike discussion (2026-04-13). Applies across all sections.*

**CP-1: The system should prefer explicit, deterministic mechanisms over implicit, probabilistic ones.**

This principle surfaces repeatedly across the research, interview, and spike work:

| Domain | Implicit (fragile) | Explicit (reliable) |
|---|---|---|
| Invocation | Auto-detection | `disable-model-invocation: true` (FR-2) |
| Behavioral contracts | Persona role-play | Observable, bounded, outcome-framed rules (FR-19) |
| Enforcement | Prose rules in skill body | Hooks and CLI tools (FR-22, escalation ladder) |
| Context sharing | Automatic directory inheritance | Explicit "read parent" instruction (spike) |
| Commit safety | "Never commit without review" instruction | Pre-commit hook (deterministic gate) |

**Requirement implications:**

- **FR-22 (enforcement layer allocation) priority elevated:** The escalation ladder is not just a design-phase concern — it's a foundational architectural principle. Each deterministic rule moved out of prose and into hooks/CLI is an instance of this principle.
- **New cross-cutting constraint candidate:** "When a behavior can be enforced deterministically (hook, tool, validation), it MUST NOT rely on probabilistic enforcement (prose instruction in a skill body)." This could become a new NFR during the decision phase.
- **Skill family parent SKILL.md serves dual purpose:** routing index for agents (progressive disclosure) AND shared behavioral contract for children (explicit opt-in). Both roles are explicit, not magical.

---

## Section 4: Rules and Context

### Conclusions

**C4-1: Aggressive rules slimming is acceptable for v1. Rules layer exploration deferred.**

The `.mdc` files can be aggressively reduced for v1 (keep only Cursor-specific config, move everything else to skills or AGENTS.md). However, the rules layer has unique capabilities (glob-based auto-attachment, always-on presence, Cursor-specific behavioral config) that deserve their own exploration -- not as part of this modernization, but as a separate effort to understand what rules are uniquely good at. Captured as an int-opp.

**C4-2: Mutable project state removed (FR-5 confirmed). State tracking is a four-arm architecture concern.**

Project state (version numbers, completion status) should be removed from always-on rules as FR-5 requires. State tracking beyond "point to existing files" is a separate concern that belongs to the four-arm architecture (dev-infra + work-prod + proj-cli + dev-toolkit), not to the workflow modernization. See [four-arm-architecture exploration](../../explorations/four-arm-architecture) for context.

**C4-3: AGENTS.md remains needed. CONVENTIONS.md gap identified and deferred.**

AGENTS.md continues to serve agent-specific behavioral config. A CONVENTIONS.md file was identified as filling a gap: shared human+agent conventions currently burden AGENTS.md. CONVENTIONS.md would let AGENTS.md point to shared conventions and focus on agent-specific config. However, this is a gap discovered during research, not a requirement of this modernization -- deferred as a separate int-opp. The C-4 dual-file strategy (AGENTS.md + CLAUDE.md) remains acceptable for v1.

---

## Section 5: Behavioral Skills and Quality

### Conclusions

**C5-1: Five-property rubric applied strictly during each conversion. No Tier 2/3 instructions shipped.**

The conversion is the audit checkpoint. Every behavioral instruction gets rubric-tested (observable, bounded, outcome-framed, delta-only, failure-aware) as part of the conversion process. This means conversion is slower (precision work per skill, not just format migration) but output quality is high from day one. This is how v1 demonstrates C1-4 (value comes from behavioral precision, not format conversion).

**C5-2: Gotchas populated upfront from audit + personal experience.**

Two sources feed gotchas sections: the Topic 8 audit (~15 Tier 3 instructions across 6 commands) and the user's lived experience with failure modes. Some gotchas that are deterministic rules (not judgment calls) may eventually move to hooks per CP-1, but they start documented in the skill body.

**C5-3: Discuss skill must not degrade from current command quality.**

The discuss command works well today. The skill conversion must be at least as good -- this is a regression constraint, not a gate. Discuss can be converted in parallel with other skills but gets extra scrutiny because it's the most behavioral command and degradation would be most noticeable. Spike B (267 -> 143 lines) already demonstrated the conversion improves precision.

---

## Section 6: Infrastructure and Tooling

### Conclusions

**C6-1: Hooks and CLI deferred to post-v1. V1 is skill conversion only.**

The three-state arc (prose -> skills -> hooks/CLI) is the long-term vision, but v1 stops at state two. Building tooling infrastructure (pre-commit hooks for deterministic enforcement, CLI for state surfacing) is valuable but not required to prove the skill conversion thesis. CP-1 applies: deterministic gotchas that *should* be hooks start as documented gotchas in skill bodies, and migrate to hooks when that infrastructure exists.

**C6-2: proj-cli and proj-clone are parallel efforts, not v1 dependencies.**

These tools address the project lifecycle (creation, cloning, template distribution) -- a separate concern from workflow skill conversion. They converge later in the distribution story (v2+) but have no blocking relationship with v1. The skill distribution path for v1 is dev-infra authoring only; template sync and marketplace are post-v1.

**C6-3: Team marketplace is future. Auto-detection / contextual routing is an exploration candidate.**

Shipping skills to the team marketplace is explicitly deferred. However, the rotation lead's observation (agent auto-detecting design questions and switching to plan mode) surfaced a new insight: for team users unfamiliar with the workflow, contextual intent detection may be as important as explicit invocation. This creates a tension with CP-1 (explicit over implicit) that has a nuanced resolution: CP-1 governs the *experienced user path*, while auto-detection serves as an *onboarding ramp* for new users. This distinction warrants its own exploration when team distribution becomes relevant.

---

## Section 7: Risk and Pace

### Conclusions

**C7-1: Primary risk is competitive positioning, not technical failure.**

The biggest worry isn't that the conversion fails technically -- it's that the result isn't compelling enough to stand as an alternative to Hex/Superpowers. This reframes quality as a market concern, not just an engineering concern. C1-4 (behavioral precision as value proposition) and C5-1 (strict rubric) are the direct mitigations: if the skills are demonstrably more precise than existing alternatives, the positioning follows.

**C7-2: Secondary risk: under-investing in implicit invocation patterns.**

The explicit-over-implicit principle (CP-1) is sound for v1, but there's an acknowledged concern that fully dismissing implicit patterns may miss UX opportunities. The nuance: even with explicit invocation, a child skill can still explicitly reference its parent. The risk is not about abandoning CP-1 but about not exploring where implicit mechanisms (auto-detection, contextual routing) add genuine value on top of explicit foundations. This is a design-phase concern, not a v1 blocker.

**C7-3: Small, polished v1. Thinking pipeline only.**

Confirms the quality-over-breadth strategy from C1-1. 3-5 core skills (or the full thinking pipeline if role grouping keeps it coherent), fully rubric-compliant, with populated gotchas. This is the minimum surface area that demonstrates the thesis. Success with this set justifies v2 expansion; failure keeps blast radius contained (C2-2).

**C7-4: 8-16+ hours per week available. Stages should be session-completable.**

Substantial time investment is possible. This means stages can be meaningful (convert a full role-group per stage, not one skill at a time) but should still be completable in 1-2 focused sessions to maintain momentum and the feedback loop of "shipped a stage." At 8-16 hours/week, a 3-5 skill v1 is realistic within a few weeks, not months.

---

## Section 8: Open-Ended

### Conclusions

**C8-1: Chat-as-runtime is an under-researched execution environment.**

The research examined what skills should contain and how they should be structured, but not the medium they execute in. Chat sessions have properties that affect skill behavior: context window decay, instruction dilution over long conversations, behavioral drift mid-session. Understanding these properties is a prerequisite for robust skill design at scale. The ai-prompt-lifecycle research in dev-infra is a starting point. This is a candidate for a future exploration or research topic, not a v1 blocker, but it's the kind of foundational understanding that separates "skills that work in demos" from "skills that work in real sessions."

**C8-2: UX north star is "in control and enriched through slowing down."**

The value proposition is the opposite of "10x faster with AI." Users should feel more engaged with their work -- whether projects, ideas, or support tickets -- through structured deceleration. This directly validates the thinking pipeline focus (C1-1): explore, research, discuss, and decision are all tools for slowing down to think better. If a skill makes the user feel rushed, confused, or bypassed, it has failed regardless of technical correctness. This north star should inform every design decision and rubric evaluation.

**C8-3: Domain knowledge ramp and modernization investment are complementary, not competing.**

Building workflow infrastructure while still learning the team's domain is a valid position -- the tools being built are the same ones needed to learn effectively. The risk is context-switching fatigue, but the available time (C7-4) provides buffer. The incomplete thought in the interview ("I don't know where I o...") suggests this tension is felt but not fully articulated -- worth revisiting as implementation progresses.

---

## 🔗 Related Documents

- [Decision Interview](decision-interview.md) — Raw interview answers
- [Requirements](../../research/agentic-workflow-modernization/requirements.md) — 22 FRs, 3 NFRs, 4 Constraints, 2 Assumptions
- [Research Summary](../../research/agentic-workflow-modernization/research-summary.md)
- [Exploration](../../explorations/agentic-workflow-modernization/exploration.md)

---

**Last Updated:** 2026-04-14
