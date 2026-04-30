# ADR-001: Workflow Automation Commands Integration

**Status:** Proposed  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## Context

Templates currently don't include workflow automation commands. Dev-infra has 17 commands (14 adapted + 3 new) that provide workflow automation for features, CI/CD improvements, exploration/research/decision workflows, and more. These commands should be available to new projects via templates.

**Related Research:**
- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [Workflow Automation Commands Integration Research](../../research/templates-enhancement/research-workflow-automation-commands-integration.md)

**Related Requirements:**
- [Requirements Document](../../research/templates-enhancement/requirements.md) - FR-1: Workflow Automation Commands Integration

---

## Decision

**Decision:** Include all 17 workflow automation commands in templates. Commands should be copied as-is to `.cursor/commands/` directory in both `standard-project` and `learning-project` templates. No command modification needed - commands already support template structure (`docs/maintainers/` paths).

**Commands to Include:**
1. `/cursor-rules` - Rules management
2. `/decision` - Decision making
3. `/explore` - Exploration
4. `/fix-implement` - Fix implementation
5. `/fix-plan` - Fix planning
6. `/fix-review` - Fix review
7. `/int-opp` - Internal opportunities
8. `/post-pr` - Post-PR documentation
9. `/pre-phase-review` - Pre-phase review
10. `/pr` - PR creation
11. `/pr-validation` - PR validation
12. `/reflect` - Reflection
13. `/reflection-artifacts` - Reflection artifacts
14. `/research` - Research
15. `/task-improvement` - CI/CD improvement tasks
16. `/task-phase` - Feature phase tasks
17. `/task-release` - Release tasks
18. `/transition-plan` - Transition planning

---

## Consequences

### Positive

- New projects have workflow automation ready from day one
- Consistent workflow automation across all projects
- Commands already tested and working in dev-infra
- Commands auto-detect structure, so no modification needed
- Better developer experience with complete command suite

### Negative

- Templates become larger (17 command files)
- Commands may need updates if issues discovered later
- Some commands may not be used by all projects initially

---

## Alternatives Considered

### Alternative 1: Include Subset of Commands

**Description:** Include only essential commands (e.g., `/task-phase`, `/pr`, `/transition-plan`), exclude optional commands.

**Pros:**
- Smaller template size
- Focus on most-used commands
- Less maintenance

**Cons:**
- Projects miss out on useful commands
- Inconsistent command availability
- Users may not discover all available workflows
- Need to decide which commands are "essential"

**Why not chosen:** Research found all commands are useful and commands auto-detect structure, so no reason to exclude any. Full command suite provides best developer experience.

---

### Alternative 2: Test All Commands Before Including

**Description:** Complete formal testing of all 17 commands in dev-infra before including in templates.

**Pros:**
- Higher confidence in command reliability
- Issues found before templating
- Better documentation of command behavior

**Cons:**
- Delays template enhancement significantly (1-2 days testing)
- Blocks new projects from getting commands
- Commands already work with template structure
- Can test incrementally in new projects

**Why not chosen:** Commands already support template structure and have been used successfully. Risk is low, and incremental testing in new projects is acceptable. Speed of value delivery outweighs comprehensive testing.

---

### Alternative 3: Modify Commands for Templates

**Description:** Modify commands to optimize for template structure or add template-specific features.

**Pros:**
- Could optimize for template use cases
- Could add template-specific features

**Cons:**
- Unnecessary - commands already work with template structure
- Creates divergence between dev-infra and template commands
- More maintenance burden
- Risk of breaking existing functionality

**Why not chosen:** Research confirmed commands already support template structure (`docs/maintainers/` paths) and auto-detect structure. No modification needed.

---

## Decision Rationale

**Key Factors:**
- Commands already support template structure (confirmed by research)
- Commands have been used successfully in dev-infra
- All commands are useful and provide value
- Commands auto-detect structure, so no modification needed
- Speed of value delivery is important

**Research Support:**
- Research finding: "Commands integration is straightforward - commands already support template structure"
- Research finding: "All 17 commands should be included in templates - they're all useful and commands auto-detect structure"
- Research finding: "Commands should be copied as-is to `.cursor/commands/` in both templates - standard location"

---

## Requirements Impact

**Requirements Affected:**
- FR-1: Workflow Automation Commands Integration - ✅ Satisfied

**Requirements Refined:**
- Commands must be copied to both `standard-project` and `learning-project` templates
- Template READMEs must document commands
- Commands must work without modification

---

## References

- [Research Summary](../../research/templates-enhancement/research-summary.md)
- [Workflow Automation Commands Integration Research](../../research/templates-enhancement/research-workflow-automation-commands-integration.md)
- [Requirements Document](../../research/templates-enhancement/requirements.md)

---

**Last Updated:** 2025-12-07

