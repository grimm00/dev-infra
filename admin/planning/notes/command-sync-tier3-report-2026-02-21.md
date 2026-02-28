# Command Sync Report: Tier 3 Divergent Commands

**Generated:** 2026-02-21
**Source of truth:** `dev-infra/templates/standard-project/.cursor/commands/`

These commands differ between the template and the project version.
The project version is larger, suggesting improvements made during actual use.
Review these manually to determine whether project improvements should flow back to dev-infra.

---

## proj-cli

**Identical with template:** 11 commands
  - commit.md, discuss.md, explore.md, fix-implement.md, handoff.md, research.md, review.md, spike.md, task-improvement.md, task-phase.md, task-release.md

### Project version is LARGER (12 commands) -- review for backport to dev-infra

| Command | Template | Project | Delta | Action |
|---------|----------|---------|-------|--------|
| `int-opp.md` | 18,839B | 25,874B | +7,035B | Review |
| `pr-validation.md` | 22,177B | 27,230B | +5,053B | Review |
| `pr.md` | 31,939B | 36,018B | +4,079B | Review |
| `post-pr.md` | 26,062B | 29,085B | +3,023B | Review |
| `transition-plan.md` | 29,660B | 31,350B | +1,690B | Review |
| `decision.md` | 12,701B | 13,981B | +1,280B | Review |
| `reflect.md` | 13,479B | 14,558B | +1,079B | Review |
| `status.md` | 13,289B | 13,997B | +708B | Review |
| `cursor-rules.md` | 9,652B | 10,228B | +576B | Review |
| `reflection-artifacts.md` | 16,169B | 16,732B | +563B | Review |
| `fix-plan.md` | 26,447B | 26,704B | +257B | Review |
| `fix-review.md` | 11,553B | 11,794B | +241B | Review |

### Template version is LARGER (1 command) -- consider overwriting

| Command | Template | Project | Delta | Action |
|---------|----------|---------|-------|--------|
| `pre-phase-review.md` | 11,709B | 11,701B | -8B | Review |

---

## dev-toolkit

**Identical with template:** 12 commands
  - commit.md, discuss.md, explore.md, fix-implement.md, handoff.md, pre-phase-review.md, research.md, review.md, spike.md, task-improvement.md, task-phase.md, task-release.md

### Project version is LARGER (12 commands) -- review for backport to dev-infra

| Command | Template | Project | Delta | Action |
|---------|----------|---------|-------|--------|
| `pr-validation.md` | 22,177B | 46,256B | +24,079B | Review |
| `transition-plan.md` | 29,660B | 43,681B | +14,021B | Review |
| `int-opp.md` | 18,839B | 25,997B | +7,158B | Review |
| `reflect.md` | 13,479B | 18,734B | +5,255B | Review |
| `decision.md` | 12,701B | 17,440B | +4,739B | Review |
| `pr.md` | 31,939B | 36,082B | +4,143B | Review |
| `post-pr.md` | 26,062B | 29,073B | +3,011B | Review |
| `fix-review.md` | 11,553B | 13,390B | +1,837B | Review |
| `reflection-artifacts.md` | 16,169B | 16,875B | +706B | Review |
| `cursor-rules.md` | 9,652B | 10,342B | +690B | Review |
| `status.md` | 13,289B | 13,587B | +298B | Review |
| `fix-plan.md` | 26,447B | 26,741B | +294B | Review |

---

## Recommended Workflow

For each divergent command:

1. Open the template version and project version side by side
2. Identify what the project version added (usually workflow learnings, edge cases, or refinements)
3. Decide: merge project improvements into the template, or overwrite with template
4. After merging improvements back to dev-infra template, re-sync to all projects

---

## Quick Stats

- **work-prod:** 24/24 commands identical with template (fully synced)
- **proj-cli:** 11/24 commands identical with template (13 divergent)
- **dev-toolkit:** 12/24 commands identical with template (12 divergent)
