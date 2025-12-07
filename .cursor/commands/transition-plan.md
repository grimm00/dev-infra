# Transition Plan Command

Creates transition planning documents from reflection artifacts or directly from reflection documents. Plans the next stage of the project (feature, release, infrastructure) based on reflection insights.

---

## Configuration

**Path Detection:**

This command supports multiple project organization patterns:

1. **Feature-Specific Structure (default):**
   - Artifacts: `docs/maintainers/planning/features/[feature-name]/feature-plan.md`
   - Transition plans: `docs/maintainers/planning/features/[feature-name]/transition-plan.md`

2. **Project-Wide Structure:**
   - Artifacts: `docs/maintainers/planning/releases/[version]/checklist.md`
   - Transition plans: `docs/maintainers/planning/releases/[version]/transition-plan.md`

**Feature Detection:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for artifact files in each
  - If no features exist, use project-wide structure

**Artifact Paths:**

- **Release Artifacts:** `docs/maintainers/planning/releases/[version]/checklist.md` or `release-notes.md`
- **Feature Artifacts:** `docs/maintainers/planning/features/[feature-name]/feature-plan.md`
- **CI/CD Artifacts:** `docs/maintainers/planning/ci/[improvement-name]/improvement-plan.md`
- **Infrastructure Artifacts:** `docs/maintainers/planning/infrastructure/[improvement-name]/improvement-plan.md` (if exists)

---

## Workflow Overview

**When to use:**

- After creating reflection artifacts with `/reflection-artifacts`
- To plan transition to next stage (feature, release, infrastructure)
- When ready to move from reflection to implementation planning

**Key principle:** Transform reflection artifacts into actionable transition plans ready for implementation, following established planning patterns. For feature transitions, also create detailed phase documents (`phase-#.md`) following work-prod's comprehensive phase structure.

---

## Usage

**Command:** `/transition-plan [--from-artifacts|--from-reflection] [options]`

**Examples:**

- `/transition-plan --from-reflection reflection-2025-12-07-mvp-complete.md` - Create transition plan from reflection (auto-generates artifacts first)
- `/transition-plan --from-artifacts releases/v0.1.0/checklist.md` - Create transition plan from specific artifact
- `/transition-plan --type release` - Force release transition type
- `/transition-plan --type feature` - Force feature transition type
- `/transition-plan --feature my-feature` - Specify feature name
- `/transition-plan --dry-run` - Show transition plan without creating files

**Options:**

- `--from-reflection FILE` - Use reflection file (auto-generates artifacts first, then creates plans)
- `--from-artifacts PATH` - Use specific artifact file (e.g., `releases/v0.1.0/checklist.md`)
- `--feature [name]` - Specify feature name (overrides auto-detection)
- `--type TYPE` - Force transition type (`feature`, `release`, `ci-cd`, `infrastructure`, `auto`)
- `--dry-run` - Show transition plan without creating files

---

## Step-by-Step Process

### Mode Selection

**Two modes of operation:**

1. **Artifact Mode (default):** Create plans from existing artifacts
   - Use: `/transition-plan --from-artifacts [path]`
   - Reads: Artifact files created by `/reflection-artifacts`
   - Creates: Transition planning documents

2. **Reflection Mode:** Create plans from reflection (auto-generates artifacts first)
   - Use: `/transition-plan --from-reflection [file]`
   - Reads: Reflection document
   - Internally calls `/reflection-artifacts` first
   - Then creates transition plans from artifacts

**If `--from-reflection` is specified, skip to "From Reflection Mode" section below.**

---

### 1. Identify Artifact File (Artifact Mode)

**Detect feature name:**

- Use `--feature` option if provided
- Otherwise, auto-detect:
  - Check if `docs/maintainers/planning/features/` exists
  - If single feature exists, use that feature name
  - If multiple features exist, search for artifact files in each
  - If no features exist, use project-wide structure

**Default behavior:**

- If no artifact specified, look for latest artifacts in planning directories
- Check `docs/maintainers/planning/releases/` for latest release
- Check `docs/maintainers/planning/features/[feature-name]/` for latest feature
- Use most recent artifact

**Manual specification:**

- Use provided artifact path
- Verify artifact file exists and is readable

**Commands:**

```bash
# Find latest release artifact
ls -t docs/maintainers/planning/releases/v*/checklist.md | head -1

# Find latest feature artifact (feature-specific)
ls -t docs/maintainers/planning/features/[feature-name]/feature-plan.md | head -1

# Find latest feature artifact (project-wide)
ls -t docs/maintainers/planning/features/*/feature-plan.md | head -1

# Check if artifact exists
ls docs/maintainers/planning/releases/v0.1.0/checklist.md
```

**Checklist:**

- [ ] Feature name detected or specified
- [ ] Artifact file identified (or using default)
- [ ] File exists and is readable
- [ ] Artifact type determined (release, feature, ci-cd, infrastructure)

---

### 2. Determine Transition Type

**Auto-detection logic:**

1. **Release Transition:**
   - Artifact path contains `releases/`
   - Artifact filename is `checklist.md` or `release-notes.md`
   - Artifact content mentions "release", "version", "tag"

2. **Feature Transition:**
   - Artifact path contains `features/`
   - Artifact filename is `feature-plan.md`
   - Artifact content mentions "feature", "implementation", "phases"

3. **CI/CD Transition:**
   - Artifact path contains `ci/`
   - Artifact filename is `improvement-plan.md`
   - Artifact content mentions "ci", "cd", "pipeline", "automation"

4. **Infrastructure Transition:**
   - Artifact path contains `infrastructure/`
   - Artifact filename is `improvement-plan.md`
   - Artifact content mentions "infrastructure", "monitoring", "logging"

**Manual override:**

- Use `--type` option to force specific type
- Useful when auto-detection is ambiguous

**Checklist:**

- [ ] Transition type determined (or forced with `--type`)
- [ ] Type is appropriate for artifact
- [ ] Type matches project needs

---

### 3. Parse Artifact Content

**Extract from artifact:**

- Overview/description
- Success criteria
- Implementation steps
- Next steps
- Priority and effort
- Benefits

**Parse implementation steps:**

- Extract actionable steps
- **Extract ALL phases** from artifact (Phase 1, Phase 2, Phase 3, etc.)
- Organize into logical phases (if feature)
- Preserve phase structure, goals, tasks, deliverables, and effort estimates
- Identify dependencies between phases
- Estimate effort per phase

**Example parsing:**

```markdown
## Implementation Steps

1. Create release directory structure
2. Create release checklist template
3. Create release notes template
4. Document version tagging process
5. Prepare MVP release (v0.1.0)
```

**For Feature Artifacts with Phases:**

- Extract **ALL phases** from artifact (e.g., Phase 1, Phase 2, Phase 3, Phase 4, etc.)
- Preserve phase structure: Goal, Tasks, Deliverables, Estimated Effort
- Include prerequisites between phases
- Maintain phase numbering and naming

**Checklist:**

- [ ] Artifact content parsed
- [ ] **ALL phases extracted** (not just Phase 1 and Phase 2)
- [ ] Implementation steps extracted
- [ ] Phase structure preserved (goals, tasks, deliverables, effort)
- [ ] Dependencies identified
- [ ] Effort estimated

---

### 4. Create Transition Planning Documents

**For Release Transition:**

**Location:** `docs/maintainers/planning/releases/vX.Y.Z/`

**Documents created:**

- `transition-plan.md` - Detailed transition plan
- Update `checklist.md` - Add transition-specific checklist items

**Transition Plan Template:**

```markdown
# Release Transition Plan - vX.Y.Z

**Version:** vX.Y.Z  
**Status:** 🔴 Not Started  
**Created:** YYYY-MM-DD  
**Source:** [artifact-file]  
**Type:** Release

---

## Overview

[Extracted from artifact overview]

## Transition Goals

[Extracted from artifact success criteria]

## Pre-Transition Checklist

- [ ] All prerequisites met
- [ ] Release artifacts reviewed
- [ ] Release checklist complete
- [ ] Release notes prepared

## Transition Steps

[Extracted from artifact implementation steps, organized chronologically]

**IMPORTANT:** Extract **ALL steps** from the artifact. Do not limit to just 2 steps.

1. **Step 1: [Name]**
   - [ ] Task 1
   - [ ] Task 2
   - Estimated: [X] hours

2. **Step 2: [Name]**
   - [ ] Task 1
   - [ ] Task 2
   - Estimated: [X] hours

3. **Step 3: [Name]**
   - [ ] Task 1
   - [ ] Task 2
   - Estimated: [X] hours

[Continue extracting ALL steps from artifact. Include Step 3, Step 4, Step 5, etc. as they exist in the artifact.]

## Post-Transition

- [ ] Release tagged
- [ ] Release notes published
- [ ] Documentation updated
- [ ] Monitoring active (if applicable)

## Definition of Done

- [ ] All transition steps complete
- [ ] Release successful
- [ ] Post-transition tasks complete
- [ ] Ready for next stage
```

---

**For Feature Transition:**

**Location:** `docs/maintainers/planning/features/[feature-name]/`

**Documents created:**

- `transition-plan.md` - Detailed transition plan
- `phase-1.md`, `phase-2.md`, `phase-3.md`, etc. - Detailed phase documents (one per phase)
- Update `feature-plan.md` - Add transition-specific details

**Transition Plan Template:**

```markdown
# Feature Transition Plan - [Feature Name]

**Feature:** [Feature Name]  
**Status:** 🔴 Not Started  
**Created:** YYYY-MM-DD  
**Source:** [artifact-file]  
**Type:** Feature

---

## Overview

[Extracted from artifact overview]

## Transition Goals

[Extracted from artifact success criteria]

## Pre-Transition Checklist

- [ ] Feature plan reviewed
- [ ] Prerequisites identified
- [ ] Dependencies resolved
- [ ] Resources allocated

## Transition Steps

[Extracted from artifact implementation steps, organized into phases]

**IMPORTANT:** Extract **ALL phases** from the artifact (Phase 1, Phase 2, Phase 3, Phase 4, etc.). Do not stop at Phase 2.

### Phase 1: [Phase Name]

**Goal:** [Extracted from artifact phase goal]

**Estimated Effort:** [X] hours/days

**Prerequisites:**
- [ ] [Prerequisite 1]
- [ ] [Prerequisite 2]

**Tasks:**
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

**Deliverables:**
- [Deliverable 1]
- [Deliverable 2]

**Definition of Done:**
- [ ] All tasks complete
- [ ] Deliverables created
- [ ] Ready for Phase 2

---

### Phase 2: [Phase Name]

**Goal:** [Extracted from artifact phase goal]

**Estimated Effort:** [X] hours/days

**Prerequisites:**
- [ ] Phase 1 complete
- [ ] [Additional prerequisites]

**Tasks:**
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

**Deliverables:**
- [Deliverable 1]
- [Deliverable 2]

**Definition of Done:**
- [ ] All tasks complete
- [ ] Deliverables created
- [ ] Ready for Phase 3 (or post-transition if last phase)

---

### Phase 3: [Phase Name]

[Continue extracting ALL phases from artifact. Include Phase 3, Phase 4, Phase 5, etc. as they exist in the artifact.]

**Goal:** [Extracted from artifact phase goal]

**Estimated Effort:** [X] hours/days

**Prerequisites:**
- [ ] Phase 2 complete
- [ ] [Additional prerequisites]

**Tasks:**
- [ ] Task 1
- [ ] Task 2

**Deliverables:**
- [Deliverable 1]

**Definition of Done:**
- [ ] All tasks complete
- [ ] Deliverables created
- [ ] Ready for post-transition (if last phase)

## Post-Transition

- [ ] Feature complete
- [ ] Documentation updated
- [ ] Tests passing
- [ ] Ready for next feature

## Definition of Done

- [ ] All phases complete
- [ ] Feature implemented
- [ ] Tests passing
- [ ] Documentation updated
```

---

**For CI/CD Transition:**

**Location:** `docs/maintainers/planning/ci/[improvement-name]/`

**Documents created:**

- `transition-plan.md` - Detailed transition plan

**Transition Plan Template:**

```markdown
# CI/CD Transition Plan - [Improvement Name]

**Improvement:** [Improvement Name]  
**Status:** 🔴 Not Started  
**Created:** YYYY-MM-DD  
**Source:** [artifact-file]  
**Type:** CI/CD

---

## Overview

[Extracted from artifact overview]

## Transition Goals

[Extracted from artifact benefits]

## Pre-Transition Checklist

- [ ] Improvement plan reviewed
- [ ] CI/CD infrastructure ready
- [ ] Dependencies identified
- [ ] Rollback plan prepared (if applicable)

## Transition Steps

[Extracted from artifact implementation steps]

**IMPORTANT:** Extract **ALL steps** from the artifact. Do not limit to just 2 steps.

1. **Step 1: [Name]**
   - [ ] Task 1
   - [ ] Task 2
   - Estimated: [X] hours

2. **Step 2: [Name]**
   - [ ] Task 1
   - [ ] Task 2
   - Estimated: [X] hours

3. **Step 3: [Name]**
   - [ ] Task 1
   - [ ] Task 2
   - Estimated: [X] hours

[Continue extracting ALL steps from artifact. Include Step 3, Step 4, Step 5, etc. as they exist in the artifact.]

## Post-Transition

- [ ] Improvement deployed
- [ ] CI/CD pipeline verified
- [ ] Documentation updated
- [ ] Monitoring active (if applicable)

## Definition of Done

- [ ] All steps complete
- [ ] CI/CD improvement active
- [ ] Tests passing
- [ ] Documentation updated
```

---

### 5. Create Phase Documents (Feature Transitions Only)

**When to create:** Only for feature transitions with phases

**Process:**

1. **Extract phases from transition plan:**
   - Parse `transition-plan.md` for phase sections
   - Extract phase number, name, goal, tasks, deliverables, prerequisites, effort
   - Identify all phases (Phase 1, Phase 2, Phase 3, etc.)

2. **For each phase, create `phase-#.md` file:**
   - Use phase document template (see `docs/PHASE-DOCUMENT-TEMPLATE.md`)
   - Populate with extracted phase information
   - Expand tasks with TDD flow structure (RED → GREEN → REFACTOR)
   - Add project-specific implementation notes

3. **Phase document structure:**
   - Header: Phase number, name, duration, status, prerequisites
   - Overview: What phase delivers, success definition
   - Goals: Numbered list of phase goals
   - Tasks: Detailed TDD flow with sub-tasks
   - Completion Criteria: Checklist of completion requirements
   - Deliverables: What gets created/delivered
   - Dependencies: Prerequisites, external dependencies, blocks
   - Risks: Risk assessment with mitigation (if applicable)
   - Progress Tracking: Status tracking by category
   - Implementation Notes: TDD workflow, patterns, examples
   - Related Documents: Links to related docs

**File locations:**

- Feature-specific: `docs/maintainers/planning/features/[feature-name]/phase-N.md`
- Project-wide: `docs/maintainers/planning/phases/phase-N.md`

**Phase document template:**

Reference: `docs/PHASE-DOCUMENT-TEMPLATE.md`

**Key sections to populate:**

- **Header:** Extract from transition plan phase header
- **Overview:** Expand phase goal into detailed overview with success definition
- **Goals:** Extract and expand phase goals
- **Tasks:** Expand transition plan tasks into detailed TDD flow:
  - Group tasks into RED/GREEN pairs where applicable
  - Add detailed sub-tasks with checkboxes
  - Include code examples where applicable
  - Add testing commands and manual testing steps
- **Completion Criteria:** Extract from transition plan "Definition of Done"
- **Deliverables:** Extract from transition plan deliverables
- **Dependencies:** Extract prerequisites, add external dependencies if known
- **Risks:** Add risk assessment if applicable
- **Progress Tracking:** Add status tracking sections
- **Implementation Notes:** Add TDD workflow guidance, patterns, examples
- **Related Documents:** Link to previous/next phases, feature plan, hub

**Checklist:**

- [ ] All phases extracted from transition plan
- [ ] Phase documents created (`phase-1.md`, `phase-2.md`, etc.)
- [ ] Phase documents follow template structure
- [ ] Tasks expanded with TDD flow
- [ ] Implementation notes added
- [ ] Related documents linked
- [ ] Phase documents are detailed (~300+ lines)

**Note:** Phase documents should be comprehensive and actionable, following work-prod's phase document structure. They serve as the primary implementation guide for each phase.

---

### 6. Update Planning Hubs

**Update relevant hub files:**

1. **Release Hub:**
   - File: `docs/maintainers/planning/releases/README.md`
   - Update release status
   - Add transition plan link

2. **Feature Hub:**
   - File: `docs/maintainers/planning/features/README.md` (if exists)
   - Update feature status
   - Add transition plan link
   - Add phase document links (if created)

3. **CI/CD Hub:**
   - File: `docs/maintainers/planning/ci/README.md` (if exists)
   - Update improvement status
   - Add transition plan link

**Checklist:**

- [ ] Release hub updated (if release transition)
- [ ] Feature hub updated (if feature transition)
- [ ] Phase document links added to feature hub (if phase documents created)
- [ ] CI/CD hub updated (if CI/CD transition)
- [ ] Hub links verified

---

### 7. Summary Report

**Present to user:**

```markdown
## Transition Plan Complete

**Source:** [artifact-file or reflection-file]
**Type:** [Release/Feature/CI/CD/Infrastructure]

### Transition Planning Documents Created

- `transition-plan.md` - Detailed transition plan
- `phase-1.md`, `phase-2.md`, `phase-3.md`, etc. - Detailed phase documents (for feature transitions)
- Updated artifact files with transition details

### Transition Steps

- [N] steps/phases identified
- Estimated effort: [X] hours
- Estimated duration: [Y] days

### Phase Documents (Feature Transitions)

- [N] phase documents created
- Each phase document includes: Overview, Goals, Tasks (TDD flow), Completion Criteria, Deliverables, Dependencies, Implementation Notes
- Phase documents follow work-prod structure (~300+ lines each)

### Next Steps

1. Review transition plan
2. Review phase documents (if created)
3. Begin implementation when ready
4. Use `/task-phase` to implement phases (reads `phase-#.md` files)
5. Use `/task-release` or `/pr` commands for releases
```

---

## From Reflection Mode

**When to use:**

- When reflection exists but artifacts haven't been created yet
- To streamline workflow (one command instead of two)
- When starting fresh from reflection

**Key principle:** Internally calls `/reflection-artifacts` first, then creates transition plans from generated artifacts.

---

### 1. Load Reflection File

**File location:**

- Feature-specific: `docs/maintainers/planning/features/[feature-name]/reflections/reflection-*.md`
- Project-wide: `docs/maintainers/planning/notes/reflections/reflection-*.md`
- Alternative: `docs/maintainers/planning/reflections/reflection-*.md`
- Manual: `--from-reflection reflection-2025-12-07-mvp-complete.md`

**Extract from reflection:**

- "Actionable Suggestions" section
- "Recommended Next Steps" section
- Current state information

**Checklist:**

- [ ] Reflection file found
- [ ] File is readable and well-formatted
- [ ] Actionable suggestions identified

---

### 2. Generate Artifacts (Internal Call)

**Process:**

1. Internally call `/reflection-artifacts` workflow
2. Generate artifacts from reflection
3. Store artifacts in appropriate directories
4. Continue with transition plan creation

**Artifacts generated:**

- Release artifacts (if release suggestions found)
- Feature artifacts (if feature suggestions found)
- CI/CD artifacts (if CI/CD suggestions found)

**Checklist:**

- [ ] Artifacts generated successfully
- [ ] Artifacts placed in correct directories
- [ ] Artifact types determined

---

### 3. Create Transition Plans from Artifacts

**Process:**

- Use generated artifacts as input
- Follow "Artifact Mode" workflow (steps 2-6 above)
- Create transition plans from artifacts

**Checklist:**

- [ ] Transition plans created from artifacts
- [ ] Plans follow appropriate templates
- [ ] Plans are actionable

---

## Common Issues

### Issue: No Artifacts Found

**Solution:**

- Run `/reflection-artifacts` first to generate artifacts
- Or use `--from-reflection` to auto-generate artifacts
- Check artifact directory paths

### Issue: Transition Type Ambiguous

**Solution:**

- Use `--type` option to force specific type
- Review artifact content to determine type
- Check artifact file path for type hints

### Issue: Artifact Content Incomplete

**Solution:**

- Review artifact file for completeness
- Update artifact with additional context
- Re-run `/reflection-artifacts` if needed

---

## Tips

### Before Running

- Ensure artifacts exist (or use `--from-reflection`)
- Review artifact content for completeness
- Determine desired transition type

### During Planning

- Review extracted steps for accuracy
- Organize steps chronologically
- Identify dependencies between steps

### After Planning

- Review transition plan for completeness
- Update plan with additional context if needed
- Begin implementation when ready

---

## Reference

**Artifact Files:**

- Releases: `docs/maintainers/planning/releases/vX.Y.Z/checklist.md`
- Features: `docs/maintainers/planning/features/[feature-name]/feature-plan.md`
- CI/CD: `docs/maintainers/planning/ci/[improvement-name]/improvement-plan.md`

**Reflection Files:**

- Feature-specific: `docs/maintainers/planning/features/[feature-name]/reflections/reflection-*.md`
- Project-wide: `docs/maintainers/planning/notes/reflections/reflection-*.md`

**Transition Plans:**

- `docs/maintainers/planning/releases/vX.Y.Z/transition-plan.md`
- `docs/maintainers/planning/features/[feature-name]/transition-plan.md`
- `docs/maintainers/planning/ci/[improvement-name]/transition-plan.md`

**Related Commands:**

- `/reflection-artifacts` - Generate artifacts from reflection (run first, or auto-called)
- `/reflect` - Create reflection documents (if available)
- `/task-phase` - Implement phase tasks (reads `phase-#.md` files created by this command)
- `/task-release` - Implement release transition tasks
- `/pre-phase-review` - Review phase plans before implementation

**Related Templates:**

- `docs/PHASE-DOCUMENT-TEMPLATE.md` - Template for phase documents (used when creating phase-#.md files)
- `/pr` - Create PRs for completed work

---

**Last Updated:** 2025-12-07  
**Status:** ✅ Active  
**Next:** Use after `/reflection-artifacts` to create transition plans, or use `--from-reflection` to streamline workflow (supports feature-specific and project-wide structures)

