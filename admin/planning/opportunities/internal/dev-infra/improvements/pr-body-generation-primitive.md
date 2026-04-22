# PR Body Generation: Prune Performative Content, Reuse Primitive Skill

**Source:** /discuss session 2026-04-22 — combining `update-pr-description` skill with `/pr` command
**Target:** dev-infra `/pr` command (near-term) and agentic-workflow-modernization PR/release cluster (long-term)
**Status:** 🔴 Not Started
**Priority:** MEDIUM
**Effort:** LOW (content prune) / MEDIUM (skill family integration, part of modernization)
**Created:** 2026-04-22
**Last Updated:** 2026-04-22

---

## Problem Statement

The dev-infra `/pr` command's generated PR body templates (phase/fix/release modes) produce content that duplicates GitHub's built-in UI or is performative:

- `- [x] All tests passing (N tests)` — the checkbox is ceremonial; nobody writes `- [ ]` and ships the PR, so it's lie-prone boilerplate
- `**Files Modified:** - [file] - [description]` — GitHub's Files tab is authoritative, always current, and supports per-file review; duplicating it in the body is stale the moment the next commit lands
- `**Deliverables:**`, `**Changes by Category**` — often restate the commit log (already visible in GitHub's Commits tab)
- `**Coverage:** [X]%` — if CI publishes coverage, GitHub shows it; if not, the body number is stale-on-arrival

Meanwhile, the globally-installed `update-pr-description` skill already operates on a better principle — *"Do not narrate the diff line by line. Synthesize."* — and uses a generic **Summary / Why / After Merge / Follow-ups** body shape that expresses intent and downstream consequences rather than restating what GitHub already displays.

## Observation

Underlying principle worth naming:

> **The PR body is for things GitHub's UI cannot show automatically** — intent, rationale, downstream consequences, migration implications, coordination flags. The Files, Commits, Conversation, and Checks tabs already cover files, commits, diff, and CI status. Duplicating them in the body is redundant, invites filler, and goes stale when the next commit lands.

The `update-pr-description` skill is also a well-shaped **primitive**: single-purpose, manual-invoke (`disable-model-invocation: true`), no per-mode templates, smart-merge with existing body. It's already the shape a shared body-generation primitive should take in a future PR/release skill family.

## Proposed Solution

Two threads, decoupled:

### Thread A — Near-term content prune (independent of modernization)

- [ ] Remove performative checkboxes from `/pr` templates (test counts, coverage numbers, completion markers that duplicate PR state)
- [ ] Remove Files Modified narration from phase/fix/release templates
- [ ] Reduce Deliverables / Changes-by-Category sections that restate commits
- [ ] Move toward synthesis-style sections (Summary / Why / After Merge / Follow-ups) even while `/pr` remains a slash command
- [ ] Alternative path (zero code change): stop using `/pr`'s generated body and invoke `update-pr-description` manually — behavioral change only

### Thread B — Modernization input for PR/release cluster

- [ ] When the agentic-workflow-modernization reaches the PR/release cluster (per interview 1.2's "Release Manager" role-model idea), body generation should call `update-pr-description` rather than re-embed templated bodies per sub-skill
- [ ] Treat `update-pr-description` as the reference shape for a shared primitive in a skill family: single-purpose, manual-invoke, composable, platform-agnostic
- [ ] Sub-skills (e.g., `create-phase-pr`, `create-fix-pr`, `create-release-pr`) add project-specific context (links to `implementation-plan.md`, status docs, ticket references) and delegate body generation to the primitive

## Why Partially Deferred

Thread A is actionable today but low-stakes. Given `/pr` will be rewritten during modernization against the five-property rubric (FR-19), fixing the templates now is optional. The zero-code alternative (stop using the templated body, invoke the skill manually) may be sufficient until the cluster is modernized.

Thread B is explicitly deferred: it's a note feeding into the modernization's PR/release cluster work, not a separate effort.

## Meta-Learning

During the discussion that surfaced this, a recurring hazard appeared: **scope creep from narrow concerns into the agentic-workflow-modernization**. A content-quality concern ("PR body has performative filler") easily drags in a packaging concern ("how does `/pr` decompose into a skill family"). Naming them as separate threads — one actionable now, one feeding the modernization — keeps small fixes from being gated on large architecture. Worth remembering as a pattern when discussing other commands pre-modernization.

## Connection

- **Modernization interview 1.2:** "release commands could be consolidated into a release agent with multiple skills" — PR/release cluster is already flagged as a role-model candidate
- **Modernization interview 3.2:** skill families mean you "don't have to choose" between few-large and many-focused; `update-pr-description` is a natural shared primitive for such a family
- **Modernization FR-19 (five-property rubric):** the `update-pr-description` skill already meets the "single-purpose, composable, manual-invoke" quality bar and can serve as a worked example during rubric application
- **Four-arm architecture:** a generic body-generation skill is useful in any repo, not just dev-infra-structured projects; fits the "template-distributed, globally-useful" distribution pattern

---

**Last Updated:** 2026-04-22
