# Release Notes - v0.11.0

**Version:** v0.11.0
**Release Date:** 2026-05-XX
**Status:** 🔴 Draft - Needs Review

---

## Highlights

**Agentic Workflow Modernization v1** — The entire thinking pipeline is now skill-based. 19 skills replace the old `.cursor/commands/` system, loading on demand instead of bloating every conversation with ~1,500 lines of always-on context. Skills are organized by role group (Thinker, Researcher, Planner, Reviewer) and carry their own behavioral contracts, gotchas, templates, and declarative I/O schemas. The developer experience: invoke a skill, get exactly the right behavior, maintain judgment authority throughout.

---

## New Features

### Skill-Based Thinking Pipeline

The full thinking pipeline — from exploring a problem through committing reviewed changes — is now delivered as `.claude/skills/` directories in `templates/standard-project/`. Each skill is a self-contained directory with a SKILL.md (behavioral contract) and optional companion files:

| Skill | Type | What It Does |
|-------|------|--------------|
| `discuss` | Behavioral | Read-only collaborative thinking — no side effects |
| `explore-start` / `explore-amend` | Hybrid | Organize and extend exploration themes |
| `int-opp` | Procedural | Capture internal improvement opportunities |
| `narrative` | Hybrid | Tell the story of completed work |
| `research-setup` / `research-conduct` / `research-consolidate` | Family | Scaffold, execute, and merge research |
| `spike` | Hybrid | Time-boxed technical validation |
| `reflect` | Hybrid | Personal growth reflection |
| `decision` | Hybrid | Interview-driven architectural decisions → ADRs |
| `write-plan-setup` / `write-plan-expand` | Family | Create and deepen implementation plans |
| `plan-review` | Hybrid | Review plans for consistency and cross-stage carry-forward |
| `pre-commit-review` | Hybrid | Stage changes, capture diff, review before committing |
| `commit` | Procedural | Commit with review context (coupled to pre-commit-review) |
| `handoff` | Procedural | Session continuity documents |

### Skill Architecture Conventions

- **`assets/` directory** — Copyable templates (planning docs, ADR scaffolds, review checklists) live alongside the skill, not inline
- **`references/structure.yaml`** — Declarative I/O contract: what the skill reads, what it produces, where outputs go. Machine-checkable by other skills (e.g., `plan-review` can verify a skill's claimed outputs)
- **Family pattern** — Multi-mode skills decompose into parent hub + focused children (explore, research, write-plan). Parent provides orientation; children provide the workflow

### Agent Pipeline Infrastructure

- **`.agents/group-cycle.agent.md`** — Pipeline agent definition for dispatching task groups as subagents in isolated git worktrees. Handles plan expansion, task execution, PR creation, Sourcery review polling, and structured reporting
- **`/agent-dispatch` command** — Pre-flight checklist ensuring clean workspace, correct branch, and assembled inputs before dispatch

### CI/CD

- **GitHub Release automation** — Releases are now automatically created from tags via GitHub Actions workflow

---

## Improvements

- **Context efficiency** — Always-on context reduced from ~1,500 lines (three `.mdc` files + mutable state) to ~50 lines (single `cursor-config.mdc`). AGENTS.md (~115 lines) carries portable conventions. Skills load only when invoked
- **Admin directory restructure** — Service-first organization under `admin/services/` with four services: `ai-workflow`, `template-generation`, `release-management`, `meta`
- **Sourcery review polling** — `group-cycle.agent.md` now uses `dt-review` directly (with 15s initial wait and content checking) instead of raw GitHub API polling

---

## Breaking Changes

None for template consumers. Projects generated from prior templates continue to work. New projects get the skills automatically.

For dev-infra itself: all thinking pipeline commands have been archived to `admin/archived/commands/`. The `.cursor/commands/` directory retains only implementation commands (`/task`, `/pr`, `/fix-plan`, etc.) and workflow automation (`/release-prep`, `/agent-dispatch`, etc.).

---

## Migration Guide

**For new projects:** No migration needed. Run `./scripts/new-project.sh` to generate a project with all v1 skills pre-installed.

**For existing projects using dev-infra templates:** Skills are in `templates/standard-project/.claude/skills/`. Copy the skill directories you want into your project's `.claude/skills/` directory. Skills are self-contained — no external dependencies.

**For dev-infra contributors:** The `.cursor/commands/` directory now contains only implementation and release commands. Thinking workflows are invoked as skills (e.g., `/discuss`, `/explore-start`, `/pre-commit-review`).

---

## Statistics

| Metric | Value |
|--------|-------|
| PRs Merged | 18 |
| Skills Created | 19 SKILL.md files |
| Commands Archived | 12 (across 4 stages) |
| Stages Completed | 4 (Thinker → Researcher → Planner → Reviewer) |
| Tasks Executed | 52 |
| Bats Tests Passing | 248 (3 skipped) |

---

**Full Changelog:** [v0.10.0...v0.11.0](https://github.com/grimm00/dev-infra/compare/v0.10.0...v0.11.0)
