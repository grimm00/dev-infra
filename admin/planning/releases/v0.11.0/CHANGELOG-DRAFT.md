# CHANGELOG Draft - v0.11.0

**Draft Created:** 2026-05-04
**Status:** 🔴 Draft - Needs Review

---

## [0.11.0] - 2026-05-XX

### Added

- **Agentic Workflow Skills (v1)** — Complete thinking pipeline converted from `.cursor/commands/` to `.claude/skills/`. 19 SKILL.md files across 16 skill directories, organized by role group (PRs #81–#99):
  - **Stage 1 — Thinker:** AGENTS.md + CLAUDE.md context redistribution, slimmed `.mdc` rules (~50 lines from ~1,500), discuss skill, explore family (explore-start, explore-amend), int-opp, narrative (PRs #81–#85)
  - **Stage 2 — Researcher:** research family (research-setup, research-conduct, research-consolidate), spike, reflect (PRs #86–#89)
  - **Stage 3 — Planner:** decision (with interview workflow), write-plan family (write-plan-setup, write-plan-expand), plan-review (PRs #92–#96)
  - **Stage 4 — Reviewer:** pre-commit-review (hybrid: procedural staging + behavioral diff analysis), commit (review-coupled), handoff (session continuity) (PRs #97–#99)
- **`assets/` + `references/structure.yaml` convention** — Skills can include copyable templates in `assets/` and a declarative I/O contract in `references/structure.yaml`. Introduced in Stage 3, applied to all Stage 3–4 skills from day one (PR #94)
- **`.agents/` directory with `group-cycle.agent.md`** — Pipeline agent definition for dispatching task groups as subagents: plan expansion → task execution → PR creation → Sourcery review → report (PR #86)
- **`/agent-dispatch` command** — Pre-flight checklist for dispatching `group-cycle.agent.md`: git sync, worktree cleanup, prior group status, input assembly (PR #86)
- **GitHub Release automation** — CI workflow to automatically create GitHub Releases from release tags (PR #70)

### Changed

- **Context redistribution** — Always-on context reduced from ~1,500 lines to ~50 (`.cursor/rules/cursor-config.mdc`). Workflow content moved to on-demand skills. AGENTS.md carries portable project conventions (~115 lines); CLAUDE.md is a pointer to AGENTS.md (PR #81)
- **`group-cycle.agent.md` Sourcery polling** — Evolved from fixed 60s wait → 15s interval `gh api` polling → `dt-review` polling with 15s initial wait and substantive content checking (iterative fixes across Stages 2–4)
- **`group-cycle.agent.md` Step 0** — Prior group closeout now uses `plan-review` skill instead of deprecated `pre-phase-review` command (PR #98)
- **Admin directory restructure** — Migrated to service-first organization under `admin/services/` with four services: `ai-workflow`, `template-generation`, `release-management`, `meta`
- **Template sync manifest** — Updated to reflect skills replacing commands; archived command paths removed from sync entries

### Removed

- **All thinking pipeline commands** — `discuss`, `explore`, `research`, `decision`, `transition-plan`, `plan-review`, `review`, `commit`, `handoff` commands archived to `admin/archived/commands/` (by stage: `stage1-thinker/`, `stage2-researcher/`, `stage3-planner/`, `stage4-reviewer/`)
- **Three `.mdc` rule files** — `main.mdc`, `workflow.mdc`, `template.mdc` replaced by single `cursor-config.mdc`
- **Mutable project state from always-on context** — Feature progress, current state, and workflow procedures no longer load on every message

### Documentation

- **Stage narratives** — `admin/services/ai-workflow/narratives/agentic-workflow-stage3/` and `agentic-workflow-stage4/`
- **Pipeline synthesis gap** — Int-opp documenting missing triggers for narrative/int-opp/reflect in the agent pipeline
- **Complete planning tree** — `planning-stage1/` through `planning-stage4/` with implementation plans, status docs, task files, plan reviews, and audit artifacts

---

## PRs Included

| PR | Title | Merged |
|----|-------|--------|
| #99 | feat(agentic-workflow-modernization): Cutover and v1 Final Quality Gate (Group 3) | 2026-05-04 |
| #98 | feat(agentic-workflow-modernization): Commit and Handoff Skills (Group 2) | 2026-05-04 |
| #97 | feat(agentic-workflow-modernization): Review Skill (Group 1) | 2026-05-03 |
| #96 | feat(agentic-workflow-modernization): Cutover and Quality Gate (Group 5) | 2026-05-03 |
| #95 | feat(agentic-workflow-modernization): Plan-Review Skill (Group 4) | 2026-05-03 |
| #94 | feat(agentic-workflow-modernization): Skill Family Restructure (Group 3) | 2026-05-03 |
| #93 | feat(agentic-workflow-modernization): Write-Plan Skill (Group 2) | 2026-05-03 |
| #92 | feat(agentic-workflow-modernization): Decision Skill (Group 1) | 2026-05-03 |
| #89 | feat(agentic-workflow-modernization): Cutover and Quality Gate (Group 4) | 2026-05-03 |
| #88 | feat(agentic-workflow-modernization): Standalone Skills — Spike & Reflect (Group 3) | 2026-05-03 |
| #87 | feat(agentic-workflow-modernization): Research Child Skills (Group 2) | 2026-05-02 |
| #86 | feat(agentic-workflow-modernization): Research Family Foundation (Group 1) | 2026-05-02 |
| #85 | feat(agentic-workflow-modernization): Stage 1 cutover (Group 5) | 2026-05-02 |
| #84 | feat(agentic-workflow-modernization): convert int-opp and narrative to skills (Group 4) | 2026-05-02 |
| #83 | feat(agentic-workflow-modernization): convert explore family to skill (Group 3) | 2026-05-02 |
| #82 | feat(agentic-workflow-modernization): convert /discuss command to skill (Group 2) | 2026-05-01 |
| #81 | feat: Agentic Workflow Modernization — Stage 1 Foundation (Group 1) | 2026-04-30 |
| #70 | ci: automate GitHub Release creation from release tags | 2026-03-03 |

---

## Review Checklist

- [ ] All PRs listed
- [ ] Categorization correct (Added/Changed/Removed)
- [ ] Descriptions accurate and concise
- [ ] Breaking changes noted (if any)
- [ ] Ready to merge into CHANGELOG.md
