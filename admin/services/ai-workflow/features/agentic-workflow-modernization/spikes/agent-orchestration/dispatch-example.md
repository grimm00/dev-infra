# Dispatch Example

How a parent agent would dispatch the group-cycle agent for a real task group.

## The Dispatch Pattern

The parent reads the agent definition, resolves inputs, and sends a single
Task tool call. The subagent receives the full definition + concrete values.

### Example: Dispatching Stage 2, Group 1 (Foundation)

```
Task(
  subagent_type: "generalPurpose",
  description: "Run group cycle: Research Foundation",
  run_in_background: true,
  prompt: """
    You are running the Group Cycle agent pipeline. Follow the pipeline
    steps exactly as defined below.

    ## Resolved Inputs

    - feature: agentic-workflow-modernization
    - service: ai-workflow
    - group: 01-research-foundation
    - base_branch: develop
    - task_file: admin/services/ai-workflow/features/agentic-workflow-modernization/planning/tasks/01-research-foundation.md
    - branch_name: feat/agentic-workflow-stage2-research-foundation

    ## Context

    - Implementation plan: admin/services/ai-workflow/features/agentic-workflow-modernization/planning/implementation-plan.md
    - Status: admin/services/ai-workflow/features/agentic-workflow-modernization/planning/status-and-next-steps.md
    - This is Stage 2 of the agentic-workflow-modernization feature.

    ## Pipeline Definition

    [full contents of group-cycle.agent.md inserted here]

    ## Your Task

    1. Create branch `feat/agentic-workflow-stage2-research-foundation` from develop
    2. Read the task file to understand what needs to be done
    3. Follow the pipeline: expand tasks if needed, execute them, create PR, validate
    4. Report back with the summary template from Step 5
  """
)
```

## Key Observations

1. **The agent definition is the prompt body.** No special runtime needed —
   the definition IS the instruction set. The parent just reads the file,
   fills in the inputs, and sends it.

2. **Resolution happens at dispatch time.** The parent knows the feature,
   group, and service. It resolves file paths and branch names before
   dispatching. The subagent receives concrete paths, not placeholders.

3. **The subagent is stateless.** It has no memory of prior groups. Each
   dispatch is independent. This is a feature — no state leakage between
   group cycles.

4. **Background execution is natural.** `run_in_background: true` means
   the human can do other work while the agent handles ceremony. The
   completion notification is the signal to re-engage.

## What the Parent Agent Needs to Do

1. Read `.agents/group-cycle.agent.md`
2. Determine which group to run (from user input or next incomplete group)
3. Resolve all inputs (feature, service, group, paths, branch name)
4. Construct the Task prompt with definition + resolved inputs
5. Dispatch and wait for completion notification

This is simple enough that the parent doesn't need its own agent definition —
it's just "read the agent file, fill in the blanks, dispatch."

## Open Questions

- Should the agent definition include the skill file contents inline, or
  should the subagent be told to read them? (trade-off: prompt size vs.
  reliability of the subagent finding/reading the right files)
- Should there be a `.agents/` directory convention at the project root,
  or do agent definitions live alongside the feature that uses them?
- Can the pr-validation step work inside a subagent, or does it need
  its own dispatch (nested agent)?
