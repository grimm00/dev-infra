# Exploration: Template Doc Infrastructure

**Status:** ✅ Expanded  
**Created:** 2026-01-13  
**Expanded:** 2026-01-13

---

## 🎯 What We're Exploring

Creating template-based documentation infrastructure that ensures consistent doc structure across all workflows (exploration, research, feature, fix, handoff). The core problem is that inconsistent documentation formats break tooling - for example, when research topics aren't numbered consistently, commands like `/research --topic-num #n` fail silently or produce unexpected results.

This exploration investigates a two-pronged approach: **generation scripts** that pre-create docs with correct structure (similar to how `dt-review` creates review files), and **validation scripts** that ensure required sections are filled out (similar to how `release-readiness` checks release criteria). Together, these would provide a "pit of success" where developers naturally produce consistent, tool-compatible documentation.

The scope extends beyond any single command - this is infrastructure that would support `/explore`, `/research`, `/decision`, `/handoff`, `/task-phase`, and future commands. Getting this right creates a foundation for reliable workflow automation.

---

## 🔍 Themes

### Theme 1: Template-Based Doc Generation

The core idea is that documentation structure should be defined once (in templates) and generated consistently. Currently, commands like `/explore` describe output formats in their markdown documentation, but the actual generation is ad-hoc - each AI session interprets the format slightly differently.

**How it would work:**
- Templates stored in a known location (`scripts/templates/` or `.cursor/templates/`)
- Generation script reads template, expands variables (date, topic name, etc.)
- Output is guaranteed-correct structure
- Commands invoke generation script rather than generating inline

**Connections:**
- Similar pattern to `dt-review` in dev-toolkit (creates review files from template)
- Aligns with `release-readiness` script's `--generate` flag pattern
- Could share infrastructure with `/handoff` context manifest generation

**Implications:**
- Commands become simpler - they orchestrate rather than generate
- Template updates propagate to all generated docs automatically
- Version control on templates provides audit trail
- Testing becomes possible (validate template output)

**Concerns:**
- Template maintenance overhead - who updates templates?
- Balance between flexibility and consistency
- How do AI-generated sections interact with templated structure?

---

### Theme 2: Doc Validation & Completeness Checking

Even with templates, docs can become incomplete or drift from expected format. Validation catches issues before they break tooling - similar to how CI catches code issues before merge.

**How it would work:**
- Validation script checks doc against expected structure
- Required sections must exist (e.g., research-topics.md must have numbered topics)
- Required fields must be filled (e.g., Priority must be High/Medium/Low)
- Warnings for optional but recommended content
- Exit codes enable CI integration

**Connections:**
- `release-readiness` script is the model - checks criteria, reports status
- Similar to schema validation for config files
- Could integrate with pre-commit hooks for early feedback

**Implications:**
- Catches "format drift" before it breaks automation
- Enables confidence in doc-driven workflows
- CI can enforce doc quality alongside code quality
- Documents become "typed" - expected structure is explicit

**Concerns:**
- Overly strict validation could be frustrating
- Need clear error messages that help fix issues
- Balance between enforcement and flexibility
- Performance - validation shouldn't slow down workflows

---

### Theme 3: Per-Workflow Doc Templates

Different workflows need different document types. An exploration has different needs than a feature phase plan. Templates should be workflow-specific while sharing common infrastructure.

**Workflow → Doc Types:**

| Workflow | Doc Types |
|----------|-----------|
| `/explore` | README.md, exploration.md, research-topics.md |
| `/research` | research-{topic}.md, requirements.md, research-summary.md |
| `/decision` | ADR docs (standard ADR template) |
| `/handoff` | handoff.md (with context manifest) |
| `/task-phase` | phase-N.md, status-and-next-steps.md |
| `/fix` | fix-batch.md |

**Connections:**
- Each command in the pipeline has specific doc needs
- Templates define the "contract" between commands
- Status indicators (🔴, 🟡, 🟠, ✅) should be consistent across all docs

**Implications:**
- Commands can be confident about input doc structure
- Handoff between commands becomes reliable
- Documentation patterns become learnable (same structure everywhere)
- New commands can define templates as part of their design

**Concerns:**
- Template proliferation - how many is too many?
- Versioning templates across releases
- Backward compatibility when templates change

---

### Theme 4: Tooling Integration

The ultimate goal is seamless integration with existing commands. Generated docs should work with commands out of the box, and validation should catch issues before commands fail.

**Integration Points:**

| Command | Expectation | Validation |
|---------|-------------|------------|
| `/research --topic-num N` | Topics numbered as "Topic 1:", "Topic 2:" | Check topic numbering pattern |
| `/research --from-explore` | research-topics.md exists with topics | Check file exists, has topics |
| `/decision --from-research` | requirements.md exists | Check file exists, has requirements |
| `/transition-plan --from-adr` | ADR files exist | Check ADR directory, file pattern |

**Connections:**
- This is where generation + validation pay off
- Commands can assume valid input if validation passed
- Reduces error handling complexity in commands
- Enables "fast fail" - know early if docs aren't ready

**Implications:**
- Command documentation can reference template specs
- Testing can validate command → template compatibility
- Breaking changes to templates are detectable
- Commands become more robust and predictable

**Concerns:**
- Coupling between templates and commands
- Migration path when templates change
- Documentation of template contracts

---

## ❓ Key Questions

### Question 1: What doc types need templates and what structure should each have?

**Context:** We need a complete inventory of doc types across all workflows before designing templates. Missing a doc type means inconsistent generation for that type.

**Sub-questions:**
- Which docs are generated by commands vs manually created?
- What sections are required vs optional for each doc type?
- Are there common patterns (hub-and-spoke, status headers) to standardize?
- How do ADRs fit in (they have their own standard format)?

**Research Approach:** Audit existing docs in dev-infra, catalog structure patterns, identify inconsistencies.

---

### Question 2: How should doc generation scripts be structured?

**Context:** Scripts could be standalone (`scripts/gen-exploration.sh`), a shared library (`scripts/lib/doc-gen.sh`), or integrated into commands. Architecture affects maintainability and reuse.

**Sub-questions:**
- Should there be one script per doc type or a unified generator?
- How do scripts get template content (embedded, external files)?
- What variables should be expandable (date, topic, author)?
- How do scripts integrate with Cursor commands?

**Research Approach:** Review `dt-review` pattern, analyze existing script architecture, prototype options.

---

### Question 3: How should doc validation work?

**Context:** Validation could run on-demand (CLI), automatically (pre-commit), or within commands. Each has tradeoffs for feedback timing and enforcement.

**Sub-questions:**
- What validation rules are needed for each doc type?
- How strict should validation be (errors vs warnings)?
- Should validation be blocking (pre-commit) or advisory?
- How do we handle partial docs (WIP status)?

**Research Approach:** Review `release-readiness` validation patterns, design rule set, prototype validator.

---

### Question 4: How do templates integrate with existing commands?

**Context:** Commands currently describe output format inline. Switching to templates requires updating commands to invoke generation scripts and rely on template structure.

**Sub-questions:**
- Which commands need template integration?
- How do commands invoke generation (shell out, source library)?
- What's the migration path for existing command docs?
- How do AI-generated sections work within templates?

**Research Approach:** Audit command definitions, identify generation points, design integration pattern.

---

## 💡 Initial Thoughts

The pattern of "generate from template + validate against schema" is well-proven in software development. Config files have schemas, code has linters, tests have assertions. Applying this pattern to workflow documentation addresses a real pain point: **inconsistent docs break automation**.

The `dt-review` and `release-readiness` scripts provide concrete evidence this works in dev-toolkit/dev-infra context. Both are simple shell scripts that have proven valuable. Extending this pattern to all workflow docs is a natural evolution.

**Opportunities:**

- **Reduced friction:** Developers get correct structure automatically, no guessing
- **Reliable automation:** Commands can trust input doc structure
- **Testable docs:** Validation enables CI checks for doc quality
- **Learnable patterns:** Consistent structure across all docs aids understanding
- **AI assistance:** Templates give AI clear target structure to generate

**Concerns:**

- **Maintenance burden:** Templates need updates when patterns evolve
- **Over-engineering risk:** Could add complexity without proportional value
- **Adoption friction:** Existing docs may need migration
- **Flexibility vs consistency:** Some docs may need custom sections

---

## 🔗 Related Explorations & Dependencies

**`/handoff` command exploration** (in `feat-handoff-command` worktree):
- Handoff docs would use template infrastructure
- Context manifest generation aligns with template generation pattern
- Both share interest in consistent doc structure

**`/explore` command** (completed in 0.8.0):
- Two-mode pattern (Setup + Conduct) already implemented
- Could benefit from template-based scaffolding generation
- Provides model for phased doc creation

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Conduct research on high-priority topics (Template Inventory, Generation Architecture)
3. After research, use `/decision template-doc-infrastructure --from-research` to make decisions
4. Create transition plan for implementation

---

**Last Updated:** 2026-01-13
