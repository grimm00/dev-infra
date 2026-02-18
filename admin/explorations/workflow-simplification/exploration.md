# Exploration: Workflow Simplification

**Status:** ✅ Expanded
**Created:** 2026-02-13
**Expanded:** 2026-02-13

---

## 🎯 What We're Exploring

The spike workflow integration (explore → spike → research → decision loop) and draft PR workflow (1 PR per feature) have exposed that several parts of the current command and planning structure may be over-engineered. Specifically: the feature/phase/task hierarchy, the `/task-phase` command naming, the role of `/decision` (formerly performative, now substantial), and whether the heavyweight feature plan structure still earns its weight.

This exploration matters because the workflow commands are the core product of dev-infra as a template factory. If the commands impose unnecessary friction, every project generated from these templates inherits that friction. The goal is not to remove structure, but to right-size it -- keeping what genuinely helps while removing ceremony that exists only because it was designed for a different workflow era (multi-PR phases).

The catalyst is clear: two recent changes -- the spike workflow (creating stronger pre-decision validation) and the draft PR workflow (collapsing 3-5 PRs per feature to 1) -- have shifted the weight of the workflow. What was load-bearing structure may now be dead weight.

---

## 🔍 Themes

### Theme 1: Decision Command Value Shift

With the spike workflow creating an iterative validation loop (explore → spike → research, repeat as needed), `/decision` now produces a much stronger, less mutable ADR. Previously, decisions were created quickly and revised frequently -- essentially a checkbox step before `/transition-plan`. Now they should be high-confidence records backed by spike evidence and thorough research.

**What changed:**

The old flow was: explore → research → decision (quickly) → plan → implement. Decisions were lightweight because research was the only input, and research alone can't validate technical feasibility. The spike workflow fills that gap. Now the flow is: explore → spike (if high-risk) → research (informed by spike) → decision. By the time you reach `/decision`, you have both theoretical understanding (research) and empirical evidence (spike). The ADR isn't a tentative choice -- it's a crystallized conclusion.

**Connections:**

- Stronger decisions reduce the need for elaborate phase planning (Theme 2) -- if you're confident in the approach, you don't need to hedge with multiple planning documents
- The review posture shift (from reactive to proactive) compounds this: developers who front-load discovery don't need as much process guardrails during implementation
- This aligns with the "template factory" identity: commands should guide, not gate

**Implications:**

- `/decision` documentation should reflect its elevated role as a "crystallize validated knowledge" step
- The transition plan receives a higher-quality input, which means its output can be simpler
- Fewer decisions should need revision after implementation starts, reducing the "decision churn" that the old hierarchy was designed to absorb

**Concerns:**

- Not all decisions will have spike evidence (some are low-risk research-only). The command needs to handle both confidently-backed and research-only decisions gracefully
- There's a risk of over-investing in the explore → spike → research loop for simple decisions. Need clear guidance on when to skip steps

---

### Theme 2: Feature/Phase/Task Hierarchy Weight

The current structure (`features/[name]/feature-plan.md`, `phase-1.md`, `phase-2.md`, `status-and-next-steps.md`) was designed when each phase was a separate PR (~3-5 PRs per feature). With the draft PR workflow collapsing this to 1 PR per feature, the phase documents become internal planning artifacts rather than PR boundaries.

**What changed:**

In the old workflow, each phase had a PR. Phase documents served double duty: they were planning artifacts AND PR descriptions. The `status-and-next-steps.md` tracked which phase was current because there were multiple PR cycles per feature. Now with 1 PR per feature:

- Phase documents are never directly referenced in PRs
- `status-and-next-steps.md` tracks progress within a single branch, not across PR cycles
- `feature-plan.md` provides an overview, but the transition plan already does this
- The `/post-pr` command's phase update logic becomes largely ceremonial

**Connections:**

- If `/decision` produces stronger ADRs (Theme 1), the transition plan receives better input and can produce a simpler output
- A flat work breakdown (ordered list of tasks in the transition plan) could replace the need for separate phase documents
- The draft PR workflow (ADR-003) already demonstrated that reducing PR count simplifies the workflow -- this is the natural continuation

**Implications:**

- The transition plan could become the single planning artifact between decision and implementation
- Phase documents could be replaced by sections/headings within the transition plan
- `status-and-next-steps.md` could be simplified to a checklist within the transition plan
- `feature-plan.md` may be redundant with the transition plan's overview section
- Template structure would become lighter: fewer files, less boilerplate, lower barrier to entry

**Concerns:**

- Some features genuinely need phases (large multi-week efforts with distinct milestones). The simplified structure should support optional phase grouping without requiring it
- Removing phase documents may lose the "progressive disclosure" benefit -- new team members currently browse phase docs to understand feature history
- The `/post-pr` command, `/pr --phase`, and other phase-aware commands would need significant updates or deprecation
- Existing projects using the current template would need a migration path (or graceful degradation)

---

### Theme 3: `/task-phase` Naming and Interface

`/task-phase 3 2` (phase 3, task 2) implies a rigid 2-level hierarchy. In practice, after a strong decision + transition plan, you often just need to execute the next chunk of work. A simpler interface like `/task [item]` or `/task next` could reduce friction.

**What changed:**

The command was designed when phases were first-class workflow boundaries. You needed to know which phase and which task because phases mapped to PRs. With 1 PR per feature, the phase number is mostly organizational -- you're just working through an ordered list of tasks on a single branch.

**Connections:**

- If the transition plan produces a flat work breakdown (Theme 2/4), the task command should consume that flat structure
- The "phase" concept may still be useful for logical grouping (e.g., "foundation tasks" vs "API tasks" vs "documentation tasks") but doesn't need to be a required parameter
- The review-then-commit workflow (`/review` + `/commit`) already decouples commit boundaries from task boundaries

**Interface Options Explored:**

| Interface | Example | Pros | Cons |
|-----------|---------|------|------|
| Current | `/task-phase 3 2` | Explicit, unambiguous | Rigid, verbose, implies phase PRs |
| Numbered | `/task 7` | Simple, direct | Requires knowing task numbers |
| Named | `/task "add-auth-endpoint"` | Descriptive, self-documenting | Verbose, naming overhead |
| Sequential | `/task next` | Zero-friction, progressive | Can't skip or jump, loses context |
| Hybrid | `/task 7` or `/task next` | Flexible | Two modes to learn |

**Implications:**

- Renaming from `/task-phase` to `/task` is a breaking change for all templates (23 commands across 2 templates + dev-infra)
- The command's internal logic (finding phase docs, task docs) would need to change to work with a flat task list
- Documentation, rules files (`workflow.mdc`, `main.mdc`), and other commands that reference `/task-phase` would all need updates

**Concerns:**

- This is a high-touch change that affects every template and every command that references `/task-phase`
- Need to ensure the simplified interface doesn't lose the TDD workflow that `/task-phase` currently enforces
- The command's commit strategy (which distinguishes phase tasks from docs tasks) would need rethinking
- Migration: existing projects with phase-based planning would need the old command to keep working (or a migration guide)

---

### Theme 4: Transition Plan as the New Center of Gravity

If decisions become stronger and the feature plan structure gets lighter, the transition plan becomes the critical bridge between "what we decided" and "what we build." It may need to evolve from producing a feature plan + phases into producing a simpler, ordered work breakdown that feeds directly into a `/task` command.

**What changed:**

Currently, `/transition-plan --from-adr` reads ADR documents and produces:
- `feature-plan.md` (overview)
- `phase-1.md`, `phase-2.md`, etc. (detailed phases)
- `status-and-next-steps.md` (tracking)

This is a lot of output for what is essentially: "here's what to build, in what order." With stronger decisions (Theme 1) and lighter hierarchy (Theme 2), the transition plan could produce a single document with an ordered work breakdown.

**Connections:**

- Absorbs the role of `feature-plan.md` (overview)
- Absorbs the role of phase documents (task ordering)
- Absorbs the role of `status-and-next-steps.md` (progress tracking via checkboxes)
- Becomes the single document between `/decision` and `/task`

**What the new transition plan output might look like:**

```markdown
# Transition Plan: [Feature Name]

## Overview
[From ADR summary -- what we decided and why]

## Work Breakdown

### Foundation (optional grouping)
- [ ] Task 1: Set up database schema
- [ ] Task 2: Create base API models

### Core Implementation
- [ ] Task 3: Implement CRUD endpoints
- [ ] Task 4: Add authentication middleware

### Documentation & Testing
- [ ] Task 5: Write integration tests
- [ ] Task 6: Update API documentation

## Acceptance Criteria
[From ADR -- when is this "done"?]
```

**Implications:**

- `/transition-plan` becomes the most important planning command
- Its output format directly determines how `/task` (renamed from `/task-phase`) works
- The template structure becomes dramatically simpler: one planning document per feature instead of 3-5+
- Generated projects get a lower barrier to entry

**Concerns:**

- The current transition plan command would need a significant rewrite
- All commands that reference phase documents would need updating
- The "progressive disclosure" pattern (hub → spoke) loses some of its depth with fewer documents
- For genuinely complex features, optional phase grouping (sections within the transition plan) needs to feel natural, not bolted on

---

### Theme 5: Dev-Infra Code Boundary (Emerged from Research)

*Added during Topic 3 research iteration. The tiered blueprint design raised a fundamental question: where does the executable logic live?*

During research, we designed a tiered implementation plan structure (simple/medium/complex) with codified thresholds and YAML frontmatter blueprints. The natural next step was "make a `scaffold-feature.sh` script in dev-infra that implements this." But this assumption deserves scrutiny.

**The core tension:**

Dev-infra's identity is **template factory** -- it produces standards, templates, manifests, and validation rules. Dev-toolkit is the **CLI implementation** -- it takes those standards and makes them executable. When we start putting scripts like `scaffold-feature.sh` in dev-infra, we're blurring that boundary.

**What's already in dev-infra's `scripts/`:**

- `new-project.sh` -- template generator (core product, justified)
- `validate-templates.sh` -- validation (core product, justified)
- `create-release-branch.sh`, `check-release-readiness.sh`, `analyze-releases.sh` -- internal tooling (dev-infra only, not shipped to projects)
- `validate-template-sync.sh` -- CI (internal)

**The proposed additions would be different:**

- `scaffold-feature.sh` -- would need to work in generated projects, not just dev-infra
- Tier determination logic -- would need to be deployed to every project
- Template rendering logic -- duplicates what `dt-doc-gen` already does

**Concerns:**

- Scripts in dev-infra that are intended for generated projects create a deployment problem: how do projects get them? Copy at generation time? Symlink? Git submodule? All are messy.
- If dev-toolkit already has `dt-doc-gen` with template rendering, adding parallel rendering logic to dev-infra is duplication.
- Scripts written as "prototypes for dev-toolkit" tend to accumulate users and become hard to deprecate.
- Projects that rely on these scripts before dev-toolkit implements them will have a broken upgrade path.

**The alternative view:**

- Dev-infra already maintains `new-project.sh` -- it's precedent for executable code.
- The doc-gen templates (`scripts/doc-gen/templates/`) are already the shared contract; scripts that consume them are a natural extension.
- Dev-toolkit is still in development; waiting for it means the tiered structure has no implementation.
- Scripts can be explicitly marked as "dev-infra internal" (like release scripts) vs "template product."

**Connections:**

- Template Factory identity (ADR-001) says "templates are products, internal tooling stays internal." Scripts for generated projects are products, not internal tooling -- which side of the line are they on?
- The doc-gen template system already straddles this: templates live in dev-infra, `dt-doc-gen` lives in dev-toolkit, discovery uses `DT_TEMPLATES_PATH`.
- This question affects whether FR-22 through FR-24 (scaffolding script requirements added during conversation) are valid or premature.

**Implications:**

- If dev-infra stays specs-only: tier logic is a specification in documentation/templates; dev-toolkit implements it. Dev-infra owns the "what," dev-toolkit owns the "how."
- If dev-infra maintains scripts: tier logic is a script that dev-toolkit wraps. Dev-infra owns both "what" and a reference "how."
- Hybrid: dev-infra maintains manifests (YAML/template specs) that describe the tier structure; dev-toolkit AND Cursor commands consume those manifests. No executable scripts in dev-infra beyond what exists today.

---

## ❓ Key Questions

### Question 1: Does the feature plan structure still add value with 1 PR per feature?

**Context:** The feature plan structure (`feature-plan.md` + `phase-N.md` + `status-and-next-steps.md`) was designed for a multi-PR workflow. With draft PRs collapsing features to 1 PR, these documents serve a different purpose -- internal planning rather than PR boundaries.

**Sub-questions:**
- What information from `feature-plan.md` isn't already in the transition plan?
- How often are phase documents referenced after implementation starts?
- Does `status-and-next-steps.md` tracking justify a separate file vs. checkboxes in the transition plan?
- What would existing projects lose if this structure was simplified?

**Research Approach:** Review actual usage in dev-infra's completed features (command simplification, worktree workflow, release readiness) to see how phase documents were actually used post-implementation.

### Question 2: Should `/task-phase` be renamed/simplified?

**Context:** The current interface (`/task-phase 3 2`) implies a rigid hierarchy. With flat work breakdowns, a simpler `/task` interface would reduce friction and better match the actual workflow.

**Sub-questions:**
- What's the migration path for existing templates and projects?
- Should `/task-phase` remain as a backward-compatible alias?
- Does the TDD workflow in `/task-phase` depend on the phase concept, or can it work with flat tasks?
- How does the commit strategy change with flat tasks?

**Research Approach:** Analyze the `/task-phase` command internals to identify what depends on the phase concept vs. what's task-generic. Review how helm-charts and other projects use the command.

### Question 3: What's the minimum planning structure between `/decision` and implementation?

**Context:** Currently the path is: `/decision` → `/transition-plan` → `feature-plan.md` + `phase-N.md` + `status-and-next-steps.md` → `/task-phase`. The question is whether this can be: `/decision` → `/transition-plan` → single work breakdown document → `/task`.

**Sub-questions:**
- What's the minimum viable transition plan output?
- Should the transition plan absorb feature-plan.md entirely?
- How should complex features (8+ phases) handle grouping within a flat structure?
- Does the template need to support both simple and complex planning modes?

**Research Approach:** Design the minimal transition plan output format, then test it against 2-3 real features to see if it captures enough information.

### Question 4: How does this affect the templates?

**Context:** Changes to the planning structure affect both `standard-project` and `learning-project` templates. The template sync system ensures consistency, but the change itself is significant.

**Sub-questions:**
- Is this a breaking change for existing projects?
- Should simplified structure be the default with optional phase support?
- How does the learning-project template (stage-based) interact with a flat work breakdown?
- What migration guidance is needed?

**Research Approach:** Map the current template structure against the proposed simplified structure. Identify what changes, what's removed, and what's new.

### Question 5: Should dev-infra maintain executable scaffolding scripts for generated projects?

**Context:** Research produced requirements (FR-22 through FR-24) assuming dev-infra would host a `scaffold-feature.sh` script. But this crosses the template factory boundary -- dev-infra produces specs and templates, dev-toolkit produces CLI tools. Scripts that need to run in generated projects create deployment problems.

**Sub-questions:**
- Where is the line between "template product" and "internal tooling"?
- Can the tiered blueprint be a manifest/spec that dev-toolkit consumes, rather than a script dev-infra executes?
- What happens to projects that adopt the new planning structure before dev-toolkit implements the scaffolding?
- Is the doc-gen template set sufficient as the "spec" without an accompanying script?

**Research Approach:** Review the existing dev-infra ↔ dev-toolkit boundary (template discovery, validation rules compilation) to determine whether a manifest-only approach works. Assess whether FR-22 through FR-24 should be moved to dev-toolkit scope or revised as manifest specs.

---

### Question 6: Can the transition plan produce a flat work breakdown?

**Context:** The transition plan currently produces multiple files. A flat work breakdown (ordered task list in a single document) would be simpler and directly consumable by a `/task` command.

**Sub-questions:**
- What format should the flat work breakdown use (checkboxes, numbered list, table)?
- How should optional task grouping work within the flat structure?
- Should the transition plan include acceptance criteria (from the ADR)?
- How does the `/task` command parse and track progress in this format?

**Research Approach:** Prototype the flat work breakdown format, test with 2-3 features of varying complexity.

---

## 💡 Initial Thoughts

The core insight is that the workflow has evolved organically through several releases, and the planning structure hasn't kept pace. The draft PR workflow (v0.8.0) reduced PR count but the planning structure still assumes multi-PR phases. The spike workflow (this session) strengthened pre-decision validation but the planning structure still assumes decisions need elaborate phase planning to derisk.

**The direction is clear:** simplify from a 3-5 file planning structure to a single transition plan document with an ordered work breakdown. The question isn't "should we simplify?" but "how much, and how do we migrate?"

**Opportunities:**

- **Lower barrier to entry** for generated projects -- fewer files to understand, less boilerplate to maintain
- **Faster feature iteration** -- less ceremony between "decide" and "build"
- **Cleaner command interface** -- `/task next` is more intuitive than `/task-phase 3 2`
- **Template simplification** -- fewer template files to maintain, sync, and validate
- **Aligned with template factory identity** -- simpler templates are better products

**Concerns:**

- **Migration complexity** -- many commands reference phase documents; this is a significant refactor
- **Loss of progressive disclosure** -- fewer documents means less browsable history
- **Complex feature support** -- need to ensure the flat structure scales to large features
- **Backward compatibility** -- existing projects need a migration path or graceful degradation
- **Scope creep risk** -- this exploration could easily expand into a months-long refactor

---

## 🧪 Spike Determination

| Topic | Risk Level | Spike? | Rationale |
|-------|------------|--------|-----------|
| Flatten feature plan structure | MEDIUM | No | Can be researched by reviewing existing usage patterns across completed features |
| Rename/simplify `/task-phase` | MEDIUM-HIGH | Consider | Interface change affects all templates and workflow rules; prototype the new interface |
| Transition plan output format | MEDIUM | No | Design question that can be prototyped on paper before implementation |
| Impact on generated projects | LOW | No | Follows from whatever we decide for the core structure |
| Dev-infra code boundary | MEDIUM-HIGH | Consider | Wrong answer creates deployment mess or blocks implementation; affects FR-22-24 validity |

**Risk Assessment:**

| Risk Level | Determination | Rationale |
|------------|---------------|-----------|
| HIGH | Spike first | Hard to pivot once committed |
| MEDIUM-HIGH | Consider spike | Benefits from hands-on validation |
| MEDIUM | Research only | Depends on other decisions |
| LOW | Research only | Clear path, low risk |

**Spike Candidates:**

- **`/task-phase` → `/task` rename** (MEDIUM-HIGH) -- Consider prototyping the new command interface against 2-3 real features to validate the flat task model works in practice. Use `/spike task-command-interface --from-explore workflow-simplification` if research raises concerns.

---

## 🚀 Next Steps

1. If spike candidates identified, run `/spike task-command-interface --from-explore workflow-simplification` first
2. Review research topics in `research-topics.md`
3. Use `/research workflow-simplification --from-explore workflow-simplification` to conduct research
4. After research, use `/decision workflow-simplification --from-research` to make decisions

---

## 🔗 Related

- **[Spike Workflow Framework](../../planning/opportunities/external/dev-toolkit/spike-workflow-framework.md)** - The catalyst for this exploration
- **[Worktree Feature Workflow](../../docs/WORKTREE-WORKFLOW.md)** - Draft PR workflow (1 PR per feature)
- **[ADR-003: Draft PR Workflow](../../admin/decisions/worktree-feature-workflow/adr-003-draft-pr-review-workflow.md)** - Decision that reduced PRs per feature
- **[Reflection: New Commands Workflow Evolution](../../planning/notes/reflections/reflection-new-commands-workflow-evolution-2026-02-13.md)** - Review posture shift insights

---

**Last Updated:** 2026-02-13  
**Amended:** Theme 5 added during research iteration (code boundary question)
