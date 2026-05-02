# Agent: Group Cycle

Runs the standard group cycle for a task group: plan expansion, task execution,
PR creation, and validation. The human re-enters after validation to review
and merge.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `feature` | yes | Feature name (e.g., `agentic-workflow-modernization`) |
| `group` | yes | Group number or name (e.g., `02-discuss-conversion`) |
| `service` | yes | Service path (e.g., `ai-workflow`) |
| `base_branch` | no | Branch to base work on (default: `develop`) |

## Pipeline

### Step 1: Plan Expansion

If the group's task file has tasks without detailed specs (steps, acceptance
criteria, files), expand them using `/transition-plan --expand --group [group]`.

Skip if all tasks already have detailed specs.

### Step 2: Execute Tasks

For each uncompleted task in the group (in order):

1. Read the task spec
2. Implement the task following the steps and acceptance criteria
3. Verify acceptance criteria are met
4. Mark the task `[x]` in the group file
5. Commit with message: `feat([feature]): complete Task N — [brief description]`

**On failure:** If a task fails (test error, missing dependency, unclear spec)
and 3 attempts don't resolve it, STOP. Report:
- Which task failed
- What was attempted (3 tries)
- The error or blocker
- Suggested resolution for the human

Do NOT skip tasks or reorder them. Do NOT continue past a blocker.

### Step 3: Create PR

Once all tasks in the group are complete:

1. Push the branch
2. Create PR to `develop` using `gh pr create`
3. Title: `feat([feature]): [Group name] (Group N)`
4. Body: Use the `/update-pr-description` skill pattern — summarize what
   changed, list tasks completed, note any discoveries or deviations

### Step 4: PR Validation

Wait 60 seconds for CI to start, then run `/pr-validation [pr-number]`:

1. Check CI status
2. Run Sourcery review (`dt-review`)
3. Fill out priority matrix
4. Fix any CRITICAL/HIGH issues inline
5. Commit fixes if needed

### Step 5: Report

Present a summary to the human:

```
## Group Cycle Complete: [Group Name]

**Tasks:** N/N complete
**PR:** #[number] — [title]
**CI:** [passing/failing]
**Review:** [N comments, N fixed inline, N deferred]

### Discoveries
- [Anything unexpected encountered during execution]

### Needs Human Attention
- [Items requiring judgment, if any]
```

## Behavioral Boundaries

- **Natural discovery is expected.** If a task reveals something unexpected
  (a better approach, a missing prerequisite, a design question), note it
  in the PR description and commit message. Don't suppress it.
- **Ceremony is the agent's job.** Git operations, PR creation, validation
  scaffolding, status updates — these are mechanical. Do them without asking.
- **Judgment is the human's job.** Design decisions, scope changes, "should
  we do this differently?" — flag these in the report, don't resolve them.
- **Three strikes on errors.** Technical failures (test failures, CI errors,
  command errors) get 3 retry attempts. After that, stop and report.
