# Concerns Migration Triage — Source Artifact

**Source:** `/discuss` session 2026-06-22 (chat transcript)
**Purpose:** Input artifact for `write-plan-setup` of feature
`agentic-ocean-concerns-intake`. Classifies every open agentic-workflow concern
in dev-infra (remote issues + int-opps) by where it should land now that the
core corpus lives in `grimm00/agentic-ocean`.

---

## Scoping rule

> **Concern follows the artifact it modifies.** If it modifies both repos, file
> in agentic-ocean with the corpus part and keep dev-infra context for the
> template/process part. If the corpus split has made it moot, close in dev-infra
> rather than migrate.

## Recommendation legend

- **MIGRATE** — file a new issue in `grimm00/agentic-ocean`
- **STAY** — keep in dev-infra (template / repo-process / non-corpus concern)
- **BOTH** — corpus-side issue in agentic-ocean + dev-infra record kept and cross-linked
- **MOOT** — corpus split is the architectural answer; close in dev-infra with a pointer
- **HISTORICAL** — completed or retrospective; leave as record, not actionable

---

## Remote issues (`grimm00/dev-infra`)

| # | Title | Recommendation | Reason |
|---|-------|---------------|--------|
| [#71](https://github.com/grimm00/dev-infra/issues/71) | Add `/manual-testing` command (plan + log) and slim `/pr-validation` | **MIGRATE** | Both `manual-testing` (new) and `pr-validation` (existing) belong in `corpus/commands/` |
| [#73](https://github.com/grimm00/dev-infra/issues/73) | Projects created from template get outdated `.cursor/commands` | **MOOT** | The corpus + symlink installer is the architectural answer. Close as superseded with pointer to agentic-ocean `install.sh` |
| [#74](https://github.com/grimm00/dev-infra/issues/74) | `/task`: STOP or warn when group is still scaffolding | **MIGRATE** | `/task` lives in `corpus/commands/` |
| [#76](https://github.com/grimm00/dev-infra/issues/76) | Document portable `.cursor/commands` across repos | **MOOT** | Installer model supersedes the curl workflow. Close with pointer |
| [#77](https://github.com/grimm00/dev-infra/issues/77) | Replace `start.txt` static form with interview-driven seed | **STAY** | Pure template scaffolding concern, not agentic |
| [#78](https://github.com/grimm00/dev-infra/issues/78) | Dogfooding: PiHole-DNS layers × tracks, research consolidation, QA catalog fit | **BOTH** | QA-catalog overlay touches `/design` + `/research` skills (corpus); layers/tracks roadmap is template guidance (dev-infra). **Split before migrating** |
| [#79](https://github.com/grimm00/dev-infra/issues/79) | `/decision`: prevent manufactured "Alternatives Considered" | **MIGRATE** | `/decision` skill in corpus |
| [#101](https://github.com/grimm00/dev-infra/issues/101) | Research scaffolding: include Stage N in doc titles | **MIGRATE** | `research-setup` skill output convention |
| [#102](https://github.com/grimm00/dev-infra/issues/102) | Agent architecture: directory-based agents w/ skill manifests + unified dispatch | **MIGRATE** | Entirely about `corpus/agents/` layout. **Note:** rewrite the issue's own "Recommended Approach" section, which currently routes work back to dev-infra |
| [#105](https://github.com/grimm00/dev-infra/issues/105) | `/task` skill: commit responsibility contradictory | **MIGRATE** | `/task` skill in corpus. Cross-links to #74 |
| [#113](https://github.com/grimm00/dev-infra/issues/113) | Patterns hub for "shoppable" patterns (+ thin-launchpad motivation) | **BOTH** | Patterns hub is potentially a new product (possibly third repo); thin-launchpad is a template concern. **Split before migrating** |
| [#114](https://github.com/grimm00/dev-infra/issues/114) | Research workflow: topic directories and conduct chunks | **MIGRATE** | `research-setup` / `research-conduct` skill family redesign |

**Subtotals:** 8 MIGRATE, 2 MOOT-close, 2 BOTH-split, 1 STAY.

---

## Int-opps — improvements (`admin/planning/opportunities/internal/dev-infra/improvements/`)

| File | Recommendation | Reason |
|------|---------------|--------|
| `artifact-emission-strategy.md` | **MIGRATE** | Skill design contract: "should the files exist at all?" |
| `claude-path-symlink-verification.md` | **MIGRATE** | Explicit `Target: skill corpus repo / installer` in header |
| `conventions-md-gap.md` | **BOTH** | CONVENTIONS.md split from AGENTS.md — ships in dev-infra templates but encodes contracts the corpus relies on |
| `corpus-update-sync-lifecycle.md` | **MIGRATE** | Corpus lifecycle, definitionally |
| `decision-command-human-involvement.md` | **MIGRATE** | `/decision` skill design |
| `design-step-in-pipeline.md` | **MIGRATE** | Adds a new `/design` skill to the pipeline |
| `feature-first-directory-structure.md` | **STAY** | About dev-infra's `admin/` layout — not a corpus concern |
| `feature-work-bypassed-pr-via-docs-allowance.md` | **BOTH** | Git Flow convention (dev-infra) + a `/task` nudge (corpus) |
| `installer-managed-config-coexistence.md` | **MIGRATE** | Installer concern |
| `pipeline-phase-start-signals.md` | **MIGRATE** | Pipeline I/O = skill behaviors and outputs |
| `post-pr-worktree-support.md` | **MIGRATE** | `/post-pr` command in corpus |
| `pr-body-generation-primitive.md` | **MIGRATE** | `/pr` command + `update-pr-description` skill, both in corpus |
| `quality-attribute-catalog.md` | **MIGRATE** | New `/design` skill reference content |
| `research-consolidate-exploration-reconciliation.md` | **HISTORICAL** | Marked ✅ Complete |
| `research-prior-art-audit.md` | **MIGRATE** | `/research` conduct mode change |
| `rules-layer-exploration.md` | **STAY** (lean) | `.mdc` rules are Cursor-specific template surface; the AGENTS.md crossover lives in `conventions-md-gap.md` |
| `skill-config-rendering.md` | **MIGRATE** | Skill mechanics |
| `skill-toolbelt-colocated-scripts.md` | **MIGRATE** | Skill mechanics — directly informs #102 |
| `transition-plan-two-mode-pattern.md` | **HISTORICAL** | Marked ✅ Complete |
| `README.md` | n/a | Hub |

**Subtotals:** 13 MIGRATE, 2 BOTH, 2 STAY, 2 HISTORICAL.

---

## Int-opps — learnings (`admin/planning/opportunities/internal/dev-infra/learnings/`)

| File / dir | Recommendation | Reason |
|------|---------------|--------|
| `agentic-workflow-stage3-pipeline-synthesis-gap.md` | **MIGRATE (as concern)** | Three live sub-concerns: no synthesis step in `group-cycle.agent`; `narrative`/`int-opp`/`reflect` have no pipeline trigger; int-opp is outward-facing only |
| `orchestrating-from-develop-and-chat-as-agent-learnings.md` | **MIGRATE (as concern)** | `/agent-dispatch` pre-flight check + handoff↔dispatch cross-link |
| `research-artifact-lifecycle-learnings.md` | **MIGRATE (as concern)** | "Never re-read my own research topic files" — open `/research` design question; intersects with #114 |
| `requirements-and-design-prior-art.md` | **STAY** | Reference material for `design-step-in-pipeline.md`, not a concern itself |
| `decision-interview-exercise-learnings.md` | **HISTORICAL** | First-run retrospective; Complete |
| `cursor-commands-integration-learnings.md` | **HISTORICAL** | ✅ Complete (2025-12) |
| `command-adaptation-template-learnings.md` | **HISTORICAL** | ✅ Complete |
| `fix-management-workflow-learnings.md` | **HISTORICAL** | ✅ Complete |
| `status-tracking-automation-learnings.md` | **HISTORICAL** | ✅ Complete |
| `ci-git-configuration/` | **STAY** | dev-infra CI |
| `experimental-template/` | **STAY** | Template |
| `explore-two-mode/` | **HISTORICAL** | Two-mode pattern shipped |
| `release-automation-v2/` | **STAY** | dev-infra release process |
| `release-readiness/` | **STAY** | dev-infra release process |
| `template-doc-infrastructure/` | **STAY** | Templates |
| `template-generation-testing-automation/` | **STAY** | Templates |
| `template-sync-drift-fix/` | **STAY** | Templates |
| `templates-enhancement/` | **STAY** | Templates |
| `transition-plan-two-mode/` | **HISTORICAL** | Shipped |
| `worktree-feature-workflow/` | **BOTH** (probable — needs Group 8 skim) | Worktree pattern is dev-infra process; `group-cycle.agent.md` is the consumer in corpus |

**Subtotals:** 3 MIGRATE-as-concern, 1 BOTH-probable, 8 STAY, 8 HISTORICAL.

---

## Migration totals

| Bucket | Count |
|--------|-------|
| MIGRATE (corpus issues to file) | 8 remote + 13 improvement + 3 learning = **24** |
| BOTH (cross-linked corpus issues) | 2 split remote + 2 improvement + 1 probable learning = **5** |
| MOOT (close in dev-infra) | 2 remote |
| STAY (leave in dev-infra) | 1 remote + 2 improvement + 8 learning = **11** |
| HISTORICAL (record only) | 2 improvement + 8 learning = **10** |
| Splits required before migrate | 2 remote (#78, #113) |

**Total new agentic-ocean issues expected:** ~29 (24 MIGRATE + 5 BOTH).

---

## Open decisions (resolved during execution)

1. **Concerns channel shape in agentic-ocean** — three candidates (co-located
   under each `corpus/<kind>/<name>/concerns/`, a dev-infra-mirroring
   `admin/planning/opportunities/...` tree, or a flat top-level
   `concerns/` directory). Resolved in Group 1 via `/decision`.

2. **Are HISTORICAL learnings ported as record-only refs in agentic-ocean?**
   Not in this plan. Leave in dev-infra; revisit only if a follow-up concern
   surfaces from one of them.

---

**Last Updated:** 2026-06-22
