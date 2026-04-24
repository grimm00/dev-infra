# Directory Restructure — Migration Plan

**Status:** ✅ Ready for execution
**Created:** 2026-04-24
**Last Updated:** 2026-04-24

---

## Service Mapping

Every current admin/ topic maps to one of four services.

### `ai-workflow` — Commands, skills, rules, thinking pipeline

| Topic | Current locations |
|-------|-------------------|
| agentic-workflow-modernization | explorations/, research/, decisions/, designs/, narratives/ |
| workflow-simplification | explorations/, research/, decisions/, planning/features/ |
| command-simplification | planning/features/, decisions/ |
| command-adaptation-template | planning/features/ |
| command-testing-integration | planning/features/ |
| command-distribution | planning/features/ |
| command-branch-workflow | explorations/ |
| explore-two-mode | explorations/, research/, decisions/, planning/features/ |
| decision-two-mode | planning/features/ |
| reflect-two-mode | planning/features/ |
| transition-plan-two-mode | explorations/, research/, decisions/, planning/features/ |
| handoff-command | explorations/ |
| ai-prompt-lifecycle | explorations/, research/ |

### `template-generation` — Templates, new-project.sh, template sync

| Topic | Current locations |
|-------|-------------------|
| template-restructure | planning/features/, decisions/ (0001) |
| template-architecture | explorations/ |
| template-doc-infrastructure | explorations/, research/, decisions/, planning/features/ |
| template-metadata | research/ |
| template-generation-testing-automation | research/, decisions/ |
| templates-enhancement | explorations/, research/, decisions/, planning/features/ |
| directory-selection | planning/features/ |

### `release-management` — Release automation, readiness, distribution

| Topic | Current locations |
|-------|-------------------|
| release-readiness | explorations/, research/, decisions/, planning/features/ |
| release-automation-v2 | planning/features/ |
| ci-cd-workflow-improvements | research/, decisions/ (0002) |

### `meta` — Dev-infra about itself

| Topic | Current locations |
|-------|-------------------|
| dev-infra-identity-and-focus | explorations/, research/, decisions/ |
| four-arm-architecture | explorations/, research/, decisions/ |
| worktree-feature-workflow | explorations/, research/, decisions/, planning/features/ |
| project-model-definition | explorations/, research/, decisions/ |
| directory-restructure | **this work** |
| global-command-distribution | research/ |
| work-prod-integration | explorations/, research/ |
| work-prod-analysis-service | explorations/ |
| proj-cli-focused-role | explorations/ |
| terraform-style-project-management | explorations/, research/ |

### Historical ADRs (migrate into template-generation)

- `admin/decisions/0001-template-restructure.md` → `admin/services/template-generation/features/template-restructure/decisions/0001.md`
- `admin/decisions/0002-cicd-workflow-improvements.md` → `admin/services/release-management/features/cicd-workflow-improvements/decisions/0002.md`
- `admin/decisions/template-restructure-roadmap.md` → `admin/services/template-generation/features/template-restructure/decisions/roadmap.md`

---

## Target Structure Per Topic

For each topic, artifacts consolidate into a single work-unit directory:

```
admin/services/[service]/features/[topic]/
├── requirements.md              ← from admin/research/[topic]/requirements.md (if exists)
├── v1-scope.md                  ← from admin/decisions/[topic]/v1-scope.md (if exists)
├── exploration.md               ← from admin/explorations/[topic]/exploration.md (if exists)
├── research/                    ← from admin/research/[topic]/
│   ├── README.md
│   ├── research-summary.md
│   └── topic-*.md
├── decisions/                   ← from admin/decisions/[topic]/
│   ├── README.md
│   ├── decision-interview.md
│   └── adr-*.md
├── designs/                     ← from admin/designs/[topic]/ (if exists)
│   └── design.md
├── narrative.md                 ← from admin/narratives/[topic]/narrative.md (if exists)
├── planning/                    ← from admin/planning/features/[topic]/
│   ├── feature-plan.md
│   ├── implementation-plan.md
│   └── phase-*.md
└── spikes/                      ← from admin/explorations/[topic]/spike/ (if exists)
```

Note: `exploration.md` and `narrative.md` are single-file phases and live at the feature root. `research/`, `decisions/`, `designs/`, `planning/`, `spikes/` are subdirectories.

---

## Migration Sequence

Order minimizes broken state at each step:

### Phase 1: Bootstrap (done)

- [x] Create `admin/services/meta/`
- [x] Create `admin/services/meta/maintenance/directory-restructure/`
- [x] Service enumeration validated

### Phase 2: Service Scaffolding

- [ ] Create `admin/services/ai-workflow/README.md` + subdirectories (explorations/, features/, maintenance/)
- [ ] Create `admin/services/template-generation/README.md` + subdirectories
- [ ] Create `admin/services/release-management/README.md` + subdirectories

### Phase 3: Migrate One Feature End-to-End (Validation)

Pick one feature — **agentic-workflow-modernization** is a good candidate because it has the most artifacts and we know the shape well. Migrate it fully:

- [ ] Create `admin/services/ai-workflow/features/agentic-workflow-modernization/`
- [ ] Move `admin/research/agentic-workflow-modernization/*` → `features/agentic-workflow-modernization/research/`
- [ ] Move `admin/decisions/agentic-workflow-modernization/*` → `features/agentic-workflow-modernization/decisions/`
- [ ] Move `admin/designs/agentic-workflow-modernization/*` → `features/agentic-workflow-modernization/designs/`
- [ ] Move `admin/narratives/agentic-workflow-modernization/narrative.md` → `features/agentic-workflow-modernization/narrative.md`
- [ ] Move `admin/explorations/agentic-workflow-modernization/exploration.md` → `features/agentic-workflow-modernization/exploration.md`
- [ ] Move `admin/explorations/agentic-workflow-modernization/spike/*` → `features/agentic-workflow-modernization/spikes/`
- [ ] Move `admin/explorations/agentic-workflow-modernization/spike-learnings.md` → `features/agentic-workflow-modernization/spikes/spike-learnings.md`
- [ ] Promote `requirements.md` from `research/` to feature root
- [ ] Promote `v1-scope.md` from `decisions/` to feature root
- [ ] Update internal markdown links within the feature directory
- [ ] Verify all files accessible, no broken links within the migrated feature

**Checkpoint:** At this point we have one feature fully in the new structure. Evaluate whether the pattern feels right before continuing.

### Phase 4: Migrate Remaining Features by Service

- [ ] Remaining `ai-workflow` features (12 topics)
- [ ] All `template-generation` features (7 topics)
- [ ] All `release-management` features (3 topics)
- [ ] Remaining `meta` features (4+ topics)

Within each service, migrate one feature at a time with git mv + link rewrites.

### Phase 5: Update External References

- [ ] Update `.cursor/commands/*.md` path references (6-7 commands)
- [ ] Update CI scripts that scan `admin/`
- [ ] Update `scripts/template-sync-manifest.txt` if needed
- [ ] Update `docs/` references to `admin/`

### Phase 6: Template Parallel Restructure

- [ ] Restructure `templates/standard-project/docs/maintainers/` in parallel
- [ ] Restructure `templates/learning-project/docs/maintainers/` in parallel
- [ ] Update template sync manifest

### Phase 7: Verification

- [ ] Run each workflow command against a migrated feature to verify path resolution
- [ ] Check for broken links across the entire admin/ tree
- [ ] Verify CI passes
- [ ] Update CURSOR rules if any reference old paths

### Phase 8: Cleanup

- [ ] Remove empty directories from old structure (`admin/research/`, `admin/decisions/`, etc.)
- [ ] Archive or delete the migration scaffolding (`directory-restructure/` can stay as a learnings/completed record)

---

## Cross-Service Features Not Identified

Based on the enumeration, all current features cleanly fit one service. No features span multiple services. If one emerges during migration, apply **primary service + cross-reference** pattern per the int-opp.

---

## Links That Need Updating

Rough count from a quick grep:

- Internal cross-references in admin/ markdown: ~100+ places
- Command path references: 6-7 files in .cursor/commands/
- CI scripts: 2-3 files
- Template sync manifest: 1 file
- docs/ references: handful

Strategy: fix links within a feature as part of that feature's migration. Fix command paths in a dedicated phase after all features migrate.

---

## Risks

1. **Missed cross-reference.** A link points to `admin/research/[topic]/foo.md` after migration, now broken. Mitigation: grep after each feature migration for any path starting with `admin/research/`, `admin/decisions/`, etc. that doesn't point to an expected location.

2. **CI breaks mid-migration.** A script expects old path, feature already moved. Mitigation: commit per-feature migrations individually, verify CI before proceeding.

3. **Command breaks mid-migration.** A command tries to scaffold under old path. Mitigation: update commands in Phase 5 (after features migrate). During Phase 3-4, commands may produce artifacts in wrong locations — that's temporary and we clean up.

4. **Template sync drift.** Templates and dev-infra diverge during migration. Mitigation: do template restructure in Phase 6 after dev-infra is stable.

---

**Last Updated:** 2026-04-24
