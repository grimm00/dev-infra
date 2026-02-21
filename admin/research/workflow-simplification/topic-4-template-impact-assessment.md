# Topic 4: Template Impact Assessment - Research Document

**Purpose:** Assess how workflow simplification affects templates and whether it's a breaking change for existing projects  
**Status:** ✅ Complete  
**Created:** 2026-02-13  
**Last Updated:** 2026-02-14

---

## 📋 Quick Links

- **[Workflow Simplification Research Hub](README.md)** - Parent research hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 5 topics
- **[Topic 1: Feature Plan Structure Usage](topic-1-feature-plan-usage.md)** - Foundation for simplification
- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** - Tiered structure details
- **[Topic 5: Command Dependency Analysis](topic-5-command-dependency-analysis.md)** - Refactoring scope

---

## 🎯 Research Goal

**Key Question:** How would workflow simplification affect the standard-project and learning-project templates, and is it a breaking change for existing projects?

**Context:** Templates are the product. Changes to the planning structure directly affect every project generated from these templates. The learning-project template has additional complexity (stage-based progression) that may interact differently with a flat work breakdown.

---

## 🔍 Methodology

**Approach:**

- [x] Map current template planning structure (files, commands, references)
- [x] Identify which files would be removed, renamed, or restructured
- [x] Assess learning-project specific concerns (stages vs. flat tasks)
- [x] Define "breaking change" criteria: what would require existing projects to change?
- [x] Propose migration guidance or backward compatibility strategy
- [x] Web search: how do other template/scaffolding tools handle breaking changes?

**Sources:**

- [x] Template directory structures (both templates)
- [x] Workflow documentation (4 WORKFLOW-*.md files in each template)
- [x] Example documents (example-feature-plan.md)
- [x] Doc-gen templates (planning/*, validation-rules/planning.yaml)
- [x] Template sync manifest
- [x] Web research: Yeoman, Cookiecutter/Cruft, Nx, Next.js migration patterns

---

## 📊 Findings

### Finding 1: Complete Template File Inventory (Affected by Simplification)

Both templates share identical planning structures within `docs/maintainers/`. The affected surface area is:

**Files to be REPLACED (removed and replaced with new equivalents):**

| Current File | Replacement | Notes |
|---|---|---|
| `planning/features/README.md` | Updated version | Remove phase template references, update directory structure example, remove phase-centric checklist |
| `examples/example-feature-plan.md` | `examples/example-implementation-plan.md` | Replace phase-based example with tiered implementation plan |

**Files to be UPDATED (content changes, same location):**

| File | Changes |
|---|---|
| `WORKFLOW-FEATURE-DEVELOPMENT.md` | Replace `/task-phase` → `/task`, phase-based workflow diagram → task-based, phase document instructions → implementation plan, `/pr --phase` → `/pr` |
| `WORKFLOW-OVERVIEW.md` | Update command references (`/task-phase` → `/task`), simplify workflow comparison table |
| `WORKFLOW-EXPLORATION-RESEARCH-DECISION.md` | Update transition plan output description (phase documents → implementation plan), update "What it creates" for `/transition-plan` |
| `WORKFLOW-CICD-IMPROVEMENT.md` | Update `/task-improvement` references if renamed |
| `planning/README.md` | Remove `phases/` from directory structure, simplify planning patterns section |
| `research/requirements-template.md` | No changes needed (phase-independent) |

**Commands to be REPLACED (removed and replaced):**

| Current | Replacement | Template Sync Impact |
|---|---|---|
| `task-phase.md` | `task.md` | Manifest update: remove `task-phase.md`, add `task.md` |
| `pre-phase-review.md` | `plan-review.md` (or similar) | Manifest update: remove `pre-phase-review.md`, add replacement |

**Commands to be ADDED:**

| File | Purpose |
|---|---|
| `task-phase.md` (stub) | Deprecation stub pointing to `/task` |
| `discuss.md` | Already added (24th command) |

**Doc-Gen Templates to be REPLACED:**

| Current | Replacement |
|---|---|
| `planning/feature-plan.md.tmpl` | `planning/implementation-plan.md.tmpl` (simple/medium tier) |
| `planning/phase.md.tmpl` | `planning/implementation-plan-hub.md.tmpl` (complex tier) + `planning/task-group.md.tmpl` (complex group files) |
| `validation-rules/planning.yaml` | Updated with new document types (`implementation_plan`, `task_group`) |

**Source:** Template directory analysis, Topic 5 (command dependencies), Topic 3 (tiered structure)

**Relevance:** Defines the exact scope of template modifications needed.

---

### Finding 2: Both Templates Are Structurally Identical for Planning

The standard-project and learning-project templates share 100% of their planning structure:

- Same `docs/maintainers/` hierarchy
- Same `planning/features/` directory
- Same workflow documentation files (all 4 WORKFLOW-*.md)
- Same example documents
- Same 24 commands (via template-sync-manifest)

The learning-project's unique elements (`stage0-fundamentals/`, `stage1-topic/`, etc., `practice-apps/`, `reference/`) are **content directories**, not planning infrastructure. They have zero interaction with the feature/phase/task planning structure.

**Implication:** Simplification changes to the planning structure apply equally to both templates. There is no learning-project-specific divergence to handle. A change to one template's planning docs is automatically a change to both.

**Source:** Template directory comparison

**Relevance:** Simplifies the impact assessment -- one change set covers both templates.

---

### Finding 3: Learning-Project Stages Are Not Phases

A potential concern was that learning-project "stages" (stage0-fundamentals, stage1-topic, etc.) might conflict with or be confused by the removal of "phase" concepts. Analysis shows they are completely separate:

- **Stages** are content directories (where learning materials live). They are project structure.
- **Phases** are planning documents (how work is broken down). They are workflow structure.
- No command references stages. No stage file references phases.
- The learning-project's `WORKFLOW-FEATURE-DEVELOPMENT.md` is identical to standard-project's -- it describes phases in the planning sense, not stages in the content sense.

**Conclusion:** Stage-based learning progression and flat task planning are orthogonal. A feature to "add stage 4" would have an implementation plan with tasks like "create directory, add README, add exercises" -- no phase files needed.

**Source:** Template structure analysis, learning-project workflow documentation

**Relevance:** Eliminates the concern about learning-project-specific complexity.

---

### Finding 4: Phase References Are Deeply Embedded in Template Documentation

The 4 workflow documentation files contain extensive phase-centric content:

**`WORKFLOW-FEATURE-DEVELOPMENT.md` (435 lines):**
- 42+ references to "phase" as a planning concept
- Workflow diagram: `Feature Plan → Phase Planning → Implementation → PR → Merge`
- Step-by-step process assumes `phase-N.md` creation
- Command examples: `/task-phase 1 1`, `/pr --phase 1`, `/post-pr 42 --phase 1`
- FAQ: "How do I skip phases?", "When do I create a PR?" (answer: after completing phase)
- Phase-centric status tracking throughout

**`WORKFLOW-OVERVIEW.md` (220 lines):**
- Workflow comparison table mentions `/task-phase` and phase docs
- Scenario descriptions reference phase-based workflow
- Integration diagram uses phase concept

**`WORKFLOW-EXPLORATION-RESEARCH-DECISION.md` (403 lines):**
- Transition plan section describes producing `phase-1.md` files
- "What it creates" includes `planning/features/[feature-name]/phase-1.md`
- Phase 4 of the workflow is named "Transition to Planning" and produces phase documents

**`planning/features/README.md` (234 lines):**
- Directory structure shows `phase-1.md`, `phase-2.md`, `phase-N.md`
- Feature Planning Checklist: `[ ] phase-1.md with first phase details`
- Phase Template section with full template content
- Feature Development Pattern: step 2 is "Break into phases, Create phase documents"

**`examples/example-feature-plan.md` (257 lines):**
- 4 explicit phases (OAuth Integration, Token Management, User Features, Testing)
- Progress tracking: "Phase 1: 🔴 Not Started" through "Phase 4: 🔴 Not Started"
- Next steps: "Use `/task-phase 1 1` to begin implementation"

**Estimated documentation rewrite: ~400-500 lines across 5 files** (not a full rewrite -- targeted section updates and terminology changes).

**Source:** Content analysis of template workflow docs

**Relevance:** Quantifies the documentation effort. The changes are substantive but mechanical -- replacing "phase" with "task" or "group" concepts, updating command names and examples, and restructuring workflow diagrams.

---

### Finding 5: Breaking Change Assessment

**Semver context:** Dev-infra is pre-1.0 (currently v0.9.0), so semver technically allows breaking changes at any minor version. However, the project follows a "template factory" identity where generated projects are the product.

**Definition of "breaking change" for dev-infra templates:**

A change is breaking if an existing project generated from a previous template version would:
1. **Have commands that no longer work** (hard break)
2. **Need to restructure files** to use new commands (migration required)
3. **See different behavior from existing commands** (semantic break)

**Assessment against criteria:**

| Criterion | Impact | Severity |
|---|---|---|
| **Commands stop working** | `/task-phase` becomes a deprecation stub. It won't execute -- it tells users to use `/task`. | MODERATE -- stub prevents confusion but command is functionally gone |
| **File restructure needed** | Existing `phase-N.md` files are not deleted by the template change. New features would use `implementation-plan.md`. Old features keep their structure. | LOW -- coexistence possible |
| **Different behavior** | `/pr`, `/post-pr`, `/status` lose `--phase` flag support. Existing workflows that use `--phase` would need adjustment. | MODERATE -- requires workflow adaptation |

**Verdict: This is a MINOR-to-MODERATE breaking change.**

- For **new features** in existing projects: No impact. New planning commands produce the new structure.
- For **in-progress features** using phase files: MODERATE impact. Commands like `/pr --phase 1` stop working. Users need to complete in-progress work under the old system or migrate.
- For **completed features**: No impact. Historical phase files remain as-is.

**Source:** Semver research, template usage patterns

**Relevance:** Determines the version bump and migration strategy needed.

---

### Finding 6: Industry Migration Patterns for Template/Scaffold Tools

Web research reveals three primary patterns for handling template evolution:

**Pattern A: Overwrite with Diff (Yeoman)**
- Re-scaffold the project and diff each file
- User decides file-by-file what to overwrite
- Works for structural changes but tedious for large projects
- No automated merge capability

**Pattern B: Automated Migration (Nx, Next.js)**
- Codemods that programmatically transform files
- Version-specific migration scripts
- `nx migrate --run-migrations` pattern
- Best for code changes; less applicable to documentation-only templates

**Pattern C: Template Sync with Cruft (Cookiecutter)**
- `cruft update` syncs generated project with upstream template changes
- Detects which template files changed and applies diffs
- Best for ongoing template evolution
- Requires `.cruft.json` tracking file in generated project

**Applicability to dev-infra:**

Dev-infra's changes are primarily **documentation and command file replacements**, not code transformations. This means:
- Pattern A (diff-based) is viable for documentation files
- Pattern B (codemods) is overkill -- we're not transforming code
- Pattern C (cruft-style sync) is the ideal long-term solution but requires infrastructure we don't have yet

**Recommended approach for dev-infra:** A **migration guide document** paired with template sync manifest updates. The guide describes what changed and how to update. Since planning docs are documentation (not executable code), the migration is entirely manual and low-risk.

**Source:** Yeoman docs, Cruft docs, Nx migration generators, Next.js codemods

**Relevance:** Informs the migration strategy recommendation.

---

### Finding 7: Doc-Gen and Validation Rule Impact

The doc-gen system has concrete phase-structure encoding:

**`planning.yaml` validation rules:**
- `feature_plan` type: validates `## 📅 Implementation Phases` section. Needs to accept both old (phase list) and new (tiered implementation) formats during transition, then switch to new only.
- `phase` type: validates `phase-*.md` with `PHASE_NUMBER`, `PHASE_FEATURE_REF`, scaffolding markers. This entire type becomes deprecated. Replace with `implementation_plan` and `task_group` types.
- `status_and_next_steps` type: validates `| Phase | Name | Status |` table. Table format changes to tier-aware progress tracking (task counts instead of phase counts).
- `planning_hub` type: validates `## 📊 Phase Status` as optional section. Rename to `## 📊 Progress` or similar.

**Planning templates (4 files):**
- `feature-plan.md.tmpl` → `implementation-plan.md.tmpl` (with YAML frontmatter for blueprint)
- `phase.md.tmpl` → `task-group.md.tmpl` (for complex tier only)
- `README.md.tmpl` → Update directory structure references
- `status-and-next-steps.md.tmpl` → Update progress table format

**Variables (VARIABLES.md):**
- `${PHASE_NUMBER}`, `${PHASE_NAME}`, `${CURRENT_PHASE}` → deprecated
- New: `${TIER}`, `${TASK_COUNT}`, `${GROUP_COUNT}`, `${STRUCTURE}`, `${GROUP_NAME}`, `${TASK_RANGE}`

**Source:** Doc-gen template analysis, planning.yaml, VARIABLES.md

**Relevance:** Confirms Topic 3's tentative doc-gen requirements (FR-23, FR-24) are accurate. The validation rule changes are the most structurally significant -- they define what dev-toolkit's `dt-doc-validate` accepts as valid.

---

### Finding 8: Template Sync Manifest Change Inventory

Current sync manifest (24 commands + `.sourcery.yaml`):

**Commands that change name (remove old, add new):**

| Remove | Add | Notes |
|---|---|---|
| `.cursor/commands/task-phase.md` | `.cursor/commands/task.md` | Core rename |
| `.cursor/commands/pre-phase-review.md` | `.cursor/commands/plan-review.md` | Rename candidate |

**Commands whose content changes (same name):**

- `transition-plan.md` -- produces implementation plan instead of phase files
- `pr.md` -- remove `--phase` flag, update examples
- `post-pr.md` -- remove `--phase` flag
- `pr-validation.md` -- remove phase document checks
- `status.md` -- remove phase operations
- `address-review.md` -- adapted for plan-review
- `fix-implement.md` -- update examples
- `reflect.md` -- update template variables
- `explore.md` -- update handoff examples
- `task-improvement.md` -- align with new `/task` interface if applicable
- `task-release.md` -- update `/task-phase` references

**Commands unchanged:**

- `commit.md`, `cursor-rules.md`, `decision.md`, `discuss.md`, `fix-plan.md`, `fix-review.md`, `handoff.md`, `int-opp.md`, `reflection-artifacts.md`, `research.md`, `review.md`, `spike.md`

**Net effect:** Manifest goes from 24 to 25 entries (24 active + 1 deprecation stub for `task-phase.md`). Or 24 active if stub is not synced. The total command count visible to users stays at 24 (23 active + 1 stub).

**Source:** Template sync manifest analysis, Topic 5 command dependency matrix

**Relevance:** Provides the exact manifest editing scope.

---

## 🔍 Analysis

### Impact Summary by Template Area

| Area | Files Affected | Change Type | Effort |
|---|---|---|---|
| **Commands** | 2 renamed, ~11 content updated, 1 stub added | File rename + content rewrite | HIGH |
| **Workflow Docs** | 4-5 files, ~400-500 lines | Terminology + structure updates | MEDIUM |
| **Planning Docs** | 2 files (features README, planning README) | Section updates | LOW |
| **Examples** | 1 file replaced | New example document | LOW |
| **Doc-Gen Templates** | 4 replaced/updated + validation rules | Template + YAML changes | MEDIUM |
| **Sync Manifest** | 1 file | Entry updates | LOW |
| **Template Structure** | No directory changes | N/A | NONE |

### Key Insights

- [x] **Insight 1: Templates are structurally identical for planning -- one change covers both.** The learning-project's unique structure (stages) is entirely orthogonal to the phase/task planning system. Zero learning-project-specific work is needed.

- [x] **Insight 2: Documentation is the largest change surface, not file structure.** No template directories need to be added or removed. The changes are content updates to existing files (workflow docs, command specs, examples) and file renames (task-phase → task). This is a documentation-heavy change, not a structural one.

- [x] **Insight 3: The breaking change is moderate and manageable.** For new features in existing projects, there's zero impact -- new commands produce new structure. For in-progress features, the `--phase` flags stop working but a deprecation stub provides guidance. Historical features are unaffected.

- [x] **Insight 4: No directory structure changes in templates.** The `planning/features/` directory structure stays the same. What changes is what goes *inside* a feature directory (implementation-plan.md instead of feature-plan.md + phase-N.md). This is significant -- it means `mkdir -p` commands, gitkeep files, and directory validation are all unaffected.

- [x] **Insight 5: Doc-gen validation rules are the structural contract.** `planning.yaml` defines what "valid" looks like. Updating it is the canonical change -- everything else (templates, commands, docs) follows from what the validation rules accept.

---

## 💡 Recommendations

- [x] **Recommendation 1: Treat this as a MINOR version bump (v0.10.0), not MAJOR.** Dev-infra is pre-1.0, so semver allows breaking changes at minor. The `task-phase.md` stub provides backward-compatible guidance. Include a migration section in release notes.

- [x] **Recommendation 2: Ship a migration guide with the release.** Create `docs/MIGRATION-v0.10.md` (or in release notes) covering: what changed, how to update existing projects, how to handle in-progress features. The guide should be short (the migration is manual and documentation-only).

- [x] **Recommendation 3: Update templates atomically.** Since both templates are identical for planning, make all changes to standard-project first, then copy to learning-project via the sync process. Don't try to update them independently.

- [x] **Recommendation 4: Phased deprecation within a single release.** Include both old (`task-phase.md` stub) and new (`task.md`) in the release. The stub provides migration guidance. Remove stub in a subsequent release (v0.11.0 or v1.0.0).

- [x] **Recommendation 5: Update doc-gen validation rules first, then templates, then commands.** The validation rules define the contract. Updating them first ensures templates and commands can be validated against the new structure during development.

- [x] **Recommendation 6: The workflow documentation rewrite is the highest-effort, lowest-risk task.** All 4 WORKFLOW-*.md files need content updates, but they're purely instructional -- no tooling depends on their exact content. This work can be done in parallel with command updates or as a separate task.

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-25: Migration Guide for Existing Projects.** A `docs/MIGRATION-v0.10.md` (or equivalent section in release notes) must document: what changed, how to update an existing project, how to handle in-progress features that use phase files.

- [x] **FR-26: Template Workflow Documentation Update.** 4-5 workflow documentation files across both templates must be updated to replace phase-based workflow descriptions with the new task-based flow. Estimated ~400-500 lines of targeted changes.

- [x] **FR-27: Example Document Replacement.** `example-feature-plan.md` must be replaced with an `example-implementation-plan.md` demonstrating the tiered structure (at least one tier, preferably medium as the most instructive).

- [x] **FR-28: Planning Hub Updates.** `planning/features/README.md` and `planning/README.md` must be updated to remove phase template references, update directory structure examples, and update the Feature Planning Checklist.

- [x] **FR-29: Validation Rule Migration.** `planning.yaml` must be updated: add `implementation_plan` and `task_group` document types, deprecate (then later remove) the `phase` document type, update `status_and_next_steps` progress table validation. During transition, accept both old and new formats.

### Non-Functional Requirements

- [x] **NFR-9: Atomic Template Updates.** Changes must be applied to both templates simultaneously (standard first, then sync to learning). No release should ship with divergent planning structures between templates.

- [x] **NFR-10: Zero Learning-Project Regressions.** Stage-based structure (stage0-N directories, practice-apps, reference) must be completely unaffected by planning simplification changes. No test should fail for learning-project-specific features.

### Constraints

- [x] **C-10: In-Progress Features Coexist with New Structure.** Existing projects may have features using the old phase-N.md structure when they adopt the new template version. Commands must handle encountering old structure gracefully (at minimum, provide clear error messages pointing to migration guide).

### Assumptions

- [x] **A-8: Existing Projects Will Adopt New Structure for New Features Only.** We assume existing projects will use the new structure for new features but won't retroactively convert completed or in-progress features. The migration guide supports this "new features only" approach.

---

## 🔗 Related

- **[Topic 1: Feature Plan Structure Usage](topic-1-feature-plan-usage.md)** — What structure do templates currently use?
- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** — New format for templates
- **[Topic 5: Command Dependency Analysis](topic-5-command-dependency-analysis.md)** — Commands in templates that need changes

---

**Last Updated:** 2026-02-14  
**Status:** ✅ Complete  
**Next:** Finalize research summary; proceed to `/decision` phase
