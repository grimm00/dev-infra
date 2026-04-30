# Design: Agentic Workflow Modernization

**Status:** ✅ Complete
**Created:** 2026-04-02
**Last Updated:** 2026-04-14
**Inputs:** 5 ADRs, 22 conclusions + CP-1, 22 FRs

---

## Inputs

- [x] Decision ADRs -- [decisions hub](../../decisions/agentic-workflow-modernization/README.md) (5 ADRs accepted)
- [x] Consolidated requirements -- [requirements.md](../../research/agentic-workflow-modernization/requirements.md) (22 FRs, 3 NFRs, 4 Constraints, 2 Assumptions)
- [x] Interview conclusions -- [v1-scope.md](../../decisions/agentic-workflow-modernization/v1-scope.md) (C1-1 through C8-3 + CP-1)
- [x] Exploration constraints -- [exploration.md](../../explorations/agentic-workflow-modernization/exploration.md)

---

## 1. System Overview

A developer opens a project generated from dev-infra templates. The `.claude/skills/` directory contains ~16 workflow skills organized by command relationship: `explore/` and `research/` are family directories with a parent index and focused children; everything else (`discuss/`, `int-opp/`, `spike/`, `decision/`, etc.) is a flat skill directory.

The developer invokes skills explicitly by name: `/discuss`, `/explore-start`, `/research-conduct`. No skill activates automatically. The `/` menu in Cursor shows all available skills; family parents (`/explore`, `/research`) provide orientation to sub-skills when invoked directly.

The thinking pipeline flows naturally: `/explore-start` organizes thoughts into themes, `/discuss` reacts without side effects, `/research-setup` scaffolds investigation, `/research-conduct` executes it, `/decision` produces ADRs through an interview-first process, `/transition-plan` decomposes designs into tasks. At every step, the developer feels in control of the pace and direction. The agent produces structured analysis; the human decides what to do with it.

Always-on context is minimal: a ~50-line `.mdc` rule for Cursor-specific behavioral config, plus AGENTS.md (and CLAUDE.md for Claude Code) carrying portable conventions. No mutable project state loads automatically. Skills carry their own procedural content and load only when invoked.

The system feels like a well-organized toolkit, not a sprawling instruction manual. Each skill does one thing. Behavioral contracts are precise: the agent knows what to produce, what not to do, and when to stop. Gotchas sections preempt common failure modes. The developer's experience is: invoke a skill, get exactly the right behavior, maintain judgment authority throughout.

---

## 2. Cross-Cutting Quality Attributes

### Usability

The developer discovers skills through the `/` command palette. With ~16 skills total (v1), the list is browsable without search. Family parents (`explore`, `research`) reduce cognitive load for multi-mode workflows: invoke the parent to see what's available, invoke the child for the specific workflow.

Naming convention `{command}-{mode}` maps directly from prior command knowledge. A developer who used `/research --conduct` types `/research-conduct`. No learning curve for the naming; the migration is predictable.

The UX north star (C8-2): "in control and enriched through slowing down." Every skill is designed so the developer paces the work, not the agent. Sync-point skills (`discuss`, `review`, `plan-review`) explicitly invite the human's parallel processing results.

### Shippability

Each stage (ADR-001) leaves the system in a coherent, usable state. After Stage 1, the Thinker skills work alongside the remaining commands. After Stage 2, research is fully skill-based. Mixed command/skill state is acceptable (C2-2) and functions as a go/no-go signal for continuing.

Stage boundaries are releases. Each stage can be committed, tested in personal use, and assessed independently. If Stage 1 proves the thesis, Stage 2 proceeds. If it doesn't, the blast radius is 4-5 skills.

### Maintainability

Each skill is a self-contained directory with SKILL.md (~200-400 lines) and optional companion files in `assets/`. Maintenance is per-skill, not per-monolithic-file. Template sync (FR-9, deferred) will eventually keep `standard-project` and `learning-project` in parity; for v1, skills exist only in `standard-project`.

Family parent SKILL.md files add light maintenance overhead (2 files for explore, research) but reduce it systemically by providing a single place to update shared conventions.

AGENTS.md + CLAUDE.md dual-file maintenance is the primary ongoing cost. For v1, manual sync is acceptable. A generation script or sync check is a v2 concern.

### Migration Safety

Clean cutover per command (C2-1). When a command becomes a skill, the command file is deleted. No coexistence wrappers, no deprecation period. Sole user means the developer knows the moment of transition and can verify immediately.

The risk is skill quality regression (C5-3). ADR-004's seven-step conversion workflow and regression testing mitigate this.

### Backward Compatibility

Not a constraint for v1 (C2-1). No external consumers of current commands. When skills eventually reach downstream projects via templates, backward compatibility will matter -- but that's a v2+ concern informed by v1 learnings.

### Portability

Fully addressed by Topic 5 research and ADR-005. Skills are portable between Cursor and Claude Code. The gap is only in the context layer (AGENTS.md vs CLAUDE.md, requiring dual-file strategy per C-4). Three Claude Code-specific features are prohibited in portable skills (FR-13): `context: fork`, `$ARGUMENTS`, `` !`command` ``. Portability is enforced during the conversion quality gate (ADR-004, step 6).

### Context Efficiency

The primary motivation for content redistribution (ADR-003). Always-on context drops from ~1,500 lines to ~50. Mutable project state removed entirely (FR-5). Skills load only when invoked -- a research workflow loads ~200-400 lines of research-conduct, not 1,500 lines of everything. NFR-7 from workflow-simplification research (context consumption proportional to work) is directly satisfied.

### Lifecycle

For v1: installation is template seeding (`new-project.sh` generates the project with skills pre-installed), setup is zero (self-contained skills, no config), uninstallation is directory deletion (self-contained per FR-8), and updates are `git pull` (sole user). For v2+ when skills reach downstream projects and the team marketplace, lifecycle becomes a first-class concern: versioning, update notifications, customization preservation (NFR-2). Deferred.

### Testability

Covered by the conversion process (ADR-004). Each skill conversion includes a regression test (step 7): the skill must perform at least as well as the command it replaces. Behavioral skills are tested against the five-property rubric (FR-19) -- each property is independently verifiable from output. Discuss is the quality benchmark (C5-3). No additional design-level testability concerns for v1.

### Observability

Not applicable for v1. Skills are static markdown files consumed by agents at invocation time. There is no runtime, no state machine, no background process to observe. If future hooks/CLI infrastructure introduces stateful behavior (three-state arc, state 3), observability would become relevant.

### Security

Not applicable for v1. Skills contain no secrets, no access control mechanisms, no authentication flows. The content is workflow guidance (markdown). If marketplace distribution introduces plugin signing or access-scoped skills, security would become relevant.

---

## 3. Component Design

### 3.1 AGENTS.md + CLAUDE.md

**Content:** Portable conventions shared between human and agent.

- Git Flow branching strategy and commit format
- Hub-and-spoke documentation pattern
- Status indicators (`🔴`, `🟡`, `🟠`, `✅`) and date format (`YYYY-MM-DD`)
- File naming conventions (kebab-case)
- Project structure overview (directory map, truncated)
- Template development standards (test generation, update docs, maintain consistency)
- Pointer to current state: `see admin/planning/status-and-next-steps.md`

**Target size:** ~150-200 lines (conventions are compact when not buried in workflow prose).

**Both files contain identical content.** AGENTS.md for Cursor (A-1), CLAUDE.md for Claude Code (C-1). All content inline (FR-1).

**Does NOT contain:** Workflow procedures (those are in skills), mutable state (removed per FR-5), Cursor-specific config (that stays in `.mdc`).

### 3.2 Slimmed `.mdc` Rules

**Content:** Cursor-specific behavioral config only.

- Agent response style (tone, formatting preferences)
- Tool usage preferences (prefer specialized tools over terminal)
- Mode-switching hints (plan mode for complex tasks)
- Pointer to AGENTS.md for shared conventions
- Pointer to `.claude/skills/` for available workflows

**Target size:** ~50 lines. One file replaces three (`main.mdc`, `workflow.mdc`, `template.mdc`).

### 3.3 Skill Architecture

Per ADR-002:

```
templates/standard-project/.claude/skills/
├── explore/
│   ├── SKILL.md                    ← family index
│   ├── explore-start/SKILL.md
│   └── explore-amend/SKILL.md
├── research/
│   ├── SKILL.md                    ← family index
│   ├── research-setup/SKILL.md
│   ├── research-conduct/SKILL.md
│   └── research-consolidate/SKILL.md
├── discuss/SKILL.md
├── int-opp/SKILL.md
├── spike/SKILL.md
├── decision/SKILL.md
├── transition-plan/SKILL.md
├── plan-review/SKILL.md
├── review/SKILL.md
├── commit/SKILL.md
├── handoff/SKILL.md
├── narrative/SKILL.md
└── reflect/SKILL.md
```

**Internal structure per skill:**

```
skill-name/
├── SKILL.md          ← core (≤500 lines, self-contained)
└── assets/           ← companion files (templates, examples) — optional
```

**Family children** include: `**Before responding, read the parent SKILL.md for family conventions.**`

### 3.4 Template Sync

Deferred to post-Stage 1 (ADR-005, C3-3). When activated:

- `scripts/template-sync-manifest.txt` updated to track skill files instead of command files
- Each `SKILL.md` and `assets/` file listed individually
- `validate-template-sync.sh` checks `standard-project` ↔ `learning-project` parity
- No tooling changes needed for initial sync; directory-level tracking is a future optimization

### 3.5 Distribution

Deferred to v2+ (ADR-005). The design ensures v1 skills are distribution-ready without requiring distribution infrastructure:

- Marketplace-compatible format (FR-15): skill directory is 1:1 copyable
- No platform-breaking features (FR-13): portability enforced during conversion
- Auto-detection toggle is per-platform config, not content fork

---

## 4. Interaction Design

### User Journey: Daily Thinking Pipeline

```
Developer has an idea or question
    │
    ├── /explore-start [topic]          → Organize thoughts into themes
    │       └── /explore-amend [topic]  → Add themes as thinking evolves
    │
    ├── /discuss [topic]                → React, question, think out loud (no artifacts)
    │
    ├── /research-setup [topic]         → Scaffold investigation from exploration
    │       └── /research-conduct       → Execute per-topic research
    │       └── /research-consolidate   → Merge and deduplicate requirements
    │
    ├── /decision [topic]               → Interview → cluster → options → ADRs
    │
    ├── /transition-plan [topic]        → Break design into implementation tasks
    │
    ├── /review                         → Stage and review changes before commit
    │       └── /commit                 → Commit with reviewed message
    │
    └── /int-opp                        → Capture learnings at any point
        /narrative                      → Tell the story of completed work
        /reflect                        → Personal growth reflection
        /handoff                        → Session continuity
```

`/discuss` is lateral -- it can be invoked at any point without disrupting the pipeline flow.

### User Journey: Resuming a Session

The developer returns to a topic after time away. They invoke `/handoff` (or read the handoff doc) to reconstruct state. They invoke the next pipeline skill (e.g., `/research-conduct --topic-num 5`). The skill reads the research hub status table and latest requirements summary (FR-18 pattern) before beginning work. The developer is grounded in committed artifacts, not stale memory.

### User Journey: Mixed Command/Skill State (During Migration)

After Stage 1, the developer has skills for Thinker workflows and commands for everything else. The experience is: `/discuss` (skill), `/research --conduct` (command), `/transition-plan` (command). The naming difference (flat skill name vs command with flags) is the visible seam. This is acceptable (C2-2) and disappears as later stages convert remaining commands.

---

## 5. Staging Plan

### Stage 1: Thinker (Proves the Thesis)

**Skills:** discuss, explore-start, explore-amend, int-opp, narrative

**Entry criteria:** ADRs accepted, design complete, AGENTS.md drafted

**Work:**
1. Draft AGENTS.md + CLAUDE.md (content redistribution, ADR-003)
2. Slim `.mdc` rules to ~50 lines
3. Convert discuss (quality benchmark, Spike B validated)
4. Convert explore-start and explore-amend (first family pattern)
5. Convert int-opp (single-mode procedural)
6. Convert narrative (single-mode hybrid)
7. Delete converted command files
8. Verify all skills pass quality gate (ADR-004)

**Exit criteria:** All 5 skills pass five-property rubric, discuss regression test passes, explore family pattern validated, AGENTS.md + CLAUDE.md in place, `.mdc` rules slimmed.

**User experience at boundary:** Thinking skills are skills, everything else is commands. The developer uses `/discuss` and `/explore-start` as skills, `/research --conduct` as a command. Mixed state is visible but functional.

**Go/no-go signal:** Does the skill-based discuss feel at least as good as the command? Does the context window savings from slimmed rules feel noticeable?

### Stage 2: Researcher (Validates Multi-Mode)

**Skills:** research-setup, research-conduct, research-consolidate, spike, reflect

**Entry criteria:** Stage 1 go decision, family pattern proven

**Work:**
1. Convert research-setup (scaffolding mode)
2. Convert research-conduct (most complex hybrid skill — procedural steps + behavioral contract for source evaluation, finding quality, requirement discovery)
3. Convert research-consolidate (procedural with merge logic)
4. Convert spike (hybrid — time-boxed behavioral contract)
5. Convert reflect (hybrid — personal growth behavioral contract)
6. Delete converted command files

**Exit criteria:** Research family pattern validated (3 children + parent), all skills pass quality gate, research-conduct regression test passes against recent topic research.

**User experience at boundary:** Thinking and research skills are all skill-based. Planning and review still use commands.

**Go/no-go signal:** Does research-conduct (the most complex command) convert without quality loss? Is the family pattern navigable?

### Stage 3: Planner (Applies Patterns)

**Skills:** decision, transition-plan, plan-review

**Entry criteria:** Stage 2 go decision

**Work:**
1. Convert decision (bake in interview pattern from this research)
2. Convert transition-plan (two-mode: may decompose into transition-plan-setup and transition-plan-expand, or stay single if modes are thin enough)
3. Convert plan-review
4. Delete converted command files

**Exit criteria:** All skills pass quality gate, decision skill includes interview workflow.

**User experience at boundary:** Full thinking pipeline is skill-based. Only review/commit/handoff remain as commands.

### Stage 4: Reviewer (Completes v1)

**Skills:** review, commit, handoff

**Entry criteria:** Stage 3 go decision

**Work:**
1. Convert review (hybrid — procedural steps + behavioral contract for diff analysis)
2. Convert commit (procedural, tightly coupled to review)
3. Convert handoff (procedural)
4. Delete converted command files
5. Final quality sweep across all 16 skills

**Exit criteria:** All thinking pipeline commands removed, ~16 skills operational, full quality gate pass.

**User experience at boundary:** The entire thinking pipeline is skill-based. Implementation commands (`/task`, `/pr`, `/fix-plan`, etc.) remain as commands. The developer experiences a clear split: thinking = skills, doing = commands.

### Post-V1

- Template sync activation (FR-9)
- Learning-project receives skills
- Evaluate whether implementation commands warrant v2 conversion
- Evaluate distribution to team marketplace
- Evaluate hooks/CLI infrastructure (three-state arc, state 3)

---

## 6. Open Questions / Risks

### Resolved Since Stub

- ~~Pending spikes: skill-decomposition-pattern, conversation-as-orchestration~~ → Resolved by Topics 3, 7, and nested skill discovery spike
- ~~`disable-model-invocation` marketplace bug (C-3)~~ → Mitigated by dual-distribution model; Cursor users get template path, Claude Code users get marketplace

### Remaining

- **Transition-plan mode decomposition.** ADR-001 lists it as a single skill, but it has setup/expand modes. During Stage 3, assess whether it decomposes into two skills or stays single. Decision deferred to implementation time.
- **Research add-topic.** Folded into research-setup in ADR-001. During Stage 2, verify this is the right home or if it warrants a separate skill.
- **Discuss quality bar.** C5-3 says it must not degrade. The Spike B transformation (267→143 lines) demonstrated improvement, but the real test is sustained daily use post-conversion.
- **AGENTS.md size.** Target ~150-200 lines, but actual size depends on how much convention content exists in the current rules. May need trimming during Stage 1 drafting.
- **Address-review exclusion.** Excluded from v1 as low standalone value. May warrant inclusion if plan-review conversion reveals it's needed.

---

## 7. NFR Checklist

- [x] **Usability** — Addressed in Section 2 (Usability) and Section 4 (Interaction Design). Naming convention maps from commands, family parents provide orientation, UX north star guides all behavioral design.
- [x] **Shippability** — Addressed in Section 5 (Staging Plan). Each stage has entry/exit criteria and a go/no-go signal. Mixed state is acceptable and functional at every boundary.
- [x] **Maintainability** — Addressed in Section 2 (Maintainability) and Section 3 (Component Design). Per-skill maintenance, family parents reduce shared convention drift, AGENTS.md dual-file is the primary ongoing cost.
- [x] **Migration Safety** — Addressed in Section 2 (Migration Safety). Clean cutover per command, seven-step conversion with regression testing, sole user validates immediately.
- [x] **Backward Compatibility** — Addressed in Section 2 (Backward Compatibility). Not a v1 constraint (C2-1). Becomes relevant at v2+ when skills reach downstream projects.
- [x] **Portability** — Addressed in Section 2 (Portability) and ADR-005. Fully portable skill layer, dual-file context layer, enforced during conversion.
- [x] **Context Efficiency** — Addressed in Section 2 (Context Efficiency) and ADR-003. ~1,500 → ~50 always-on lines. Skills load on demand.
- [x] **Lifecycle** — Addressed in Section 2 (Lifecycle). V1 is simple (template seeding, git pull, directory deletion). V2+ deferred.
- [x] **Testability** — Addressed in Section 2 (Testability) and ADR-004. Regression testing per conversion, rubric is verifiable.
- [ ] **Observability** — N/A for v1. No runtime to observe. Revisit if hooks/CLI introduce stateful behavior.
- [ ] **Security** — N/A for v1. No secrets or access control. Revisit if marketplace introduces signing.

---

## References

- [Decisions Hub](../../decisions/agentic-workflow-modernization/README.md) — 5 ADRs
- [V1 Scope](../../decisions/agentic-workflow-modernization/v1-scope.md) — 22 conclusions + CP-1
- [Requirements](../../research/agentic-workflow-modernization/requirements.md) — 22 FRs, 3 NFRs, 4 Cs, 2 As
- [Research Summary](../../research/agentic-workflow-modernization/research-summary.md)
- [Exploration](../../explorations/agentic-workflow-modernization/exploration.md)
- [Design Step Int-Opp](../../planning/opportunities/internal/dev-infra/improvements/design-step-in-pipeline.md)

---

**Last Updated:** 2026-04-14
