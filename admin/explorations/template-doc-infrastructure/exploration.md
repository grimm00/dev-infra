# Exploration: Template Doc Infrastructure

**Status:** ✅ Expanded (Updated with Strategic Insights)  
**Created:** 2026-01-13  
**Expanded:** 2026-01-13  
**Updated:** 2026-01-13

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

### Theme 5: Scripts as Orchestration Layer (Strategic Insight)

**Discovery:** The two-mode pattern in `/explore` (Setup + Conduct) was organically discovering a hybrid architecture where scripts handle structure and AI handles creativity. This extends beyond just doc generation to **full workflow orchestration**.

**The Hybrid Architecture:**

```
Scripts (Guaranteed, 0 tokens)     AI (Creative, targeted tokens)
├── Context gathering              ├── Analysis
├── Structure generation           ├── Insights  
├── Model selection                ├── Connections
├── Cursor CLI invocation          ├── Recommendations
├── Validation                     └── Content fill
└── Side effects (commits, etc.)
```

**Token Efficiency Benefits:**
- **Output tokens:** Scripts generate structure (0 AI tokens), AI only fills placeholders (~40-60% savings)
- **Input tokens:** Scripts gather context into compact manifests, AI reads less (~80-90% savings on context discovery)

**Connections:**
- Validates research findings (shared library, hybrid integration)
- Aligns with `/handoff` context manifest idea
- Transforms "commands as AI guides" to "scripts that orchestrate AI"

**Implications:**
- Each command becomes a script that orchestrates workflow
- Command flags become script flags (programmatic, not AI-interpreted)
- AI becomes a "cognitive function" called by scripts, not the orchestrator
- Significant cost reduction on AI token usage

**Concerns:**
- Complexity of script orchestration
- Cursor CLI capabilities for programmatic invocation
- Where does this tooling live? (dev-toolkit, proj-cli, new repo?)

---

### Theme 6: Model Selection by Task Type

**Discovery:** Different cognitive tasks benefit from different AI models. Scripts can select the optimal model based on task type.

**Model Mapping:**

| Task Type | Model | Reasoning |
|-----------|-------|-----------|
| explore, research, decision | claude-opus-4 | Deep thinking, analysis |
| naming, creative | gemini-2.5-pro | Divergent creativity |
| pr, post-pr, release-prep | claude-sonnet-4 | Structured, routine |
| task-phase, implement, code | composer-1 | Code implementation |

**How it would work:**
```bash
# CLI determines task type from command
dt explore my-topic --conduct
# → Script selects claude-opus-4 for "explore" task type
# → Invokes Cursor with model flag

dt task-phase 3 1
# → Script selects composer-1 for implementation
```

**Connections:**
- Natural extension of orchestration pattern
- Cost optimization (expensive models only for high-value tasks)
- Quality optimization (right model for the job)

**Implications:**
- CLI/scripts need model selection logic
- Configuration for model preferences
- Override flag for special cases (`--model gemini-2.5-pro`)

**Concerns:**
- Cursor CLI model selection capabilities
- Model availability and API access
- Configuration management

---

### Theme 7: Architectural Placement (Four-Arm Question)

**Discovery:** This infrastructure needs a home. The four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod) suggests it should NOT live in dev-infra (template factory), but in a tooling arm.

**Options:**

| Location | Pros | Cons |
|----------|------|------|
| **dev-toolkit** | Existing tooling home, dt-review lives here | May be too general |
| **proj-cli** | Project-specific focus | May be too narrow |
| **New repo** (workflow-tools?) | Clean separation | Yet another repo |
| **dev-infra** | Close to templates | Violates template factory identity |

**Key Question:** Which arm of the architecture should own workflow orchestration scripts?

**Decision Criteria:**
- Aligns with existing tool locations
- Clear ownership and versioning
- Easy for projects to consume
- Supports independent evolution

**Connections:**
- ADR-001 (Project Identity): dev-infra = template factory
- Four-arm architecture research
- Global command distribution research

**This question should be resolved in the decision phase.**

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

### Question 5: Where should this tooling live in the four-arm architecture?

**Context:** The four-arm architecture (dev-infra, dev-toolkit, proj-cli, work-prod) separates concerns. Doc generation/orchestration is workflow tooling, not template structure.

**Sub-questions:**
- Does this belong in dev-toolkit (general tooling)?
- Does this belong in proj-cli (project management)?
- Should this be a new repo (workflow-tools)?
- How do projects consume this tooling?

**Research Approach:** Analyze four-arm architecture, evaluate fit for each arm, consider distribution mechanism.

---

### Question 6: How should scripts invoke Cursor programmatically with model selection?

**Context:** Scripts need to call Cursor CLI with specific models based on task type. This enables cost/quality optimization.

**Sub-questions:**
- What are Cursor CLI capabilities for programmatic invocation?
- How to pass context manifests to AI?
- How to select models via CLI flags?
- How to capture and validate AI output?

**Research Approach:** Investigate Cursor CLI capabilities, prototype invocation pattern.

---

## 💡 Initial Thoughts

The pattern of "generate from template + validate against schema" is well-proven in software development. Config files have schemas, code has linters, tests have assertions. Applying this pattern to workflow documentation addresses a real pain point: **inconsistent docs break automation**.

The `dt-review` and `release-readiness` scripts provide concrete evidence this works in dev-toolkit/dev-infra context. Both are simple shell scripts that have proven valuable. Extending this pattern to all workflow docs is a natural evolution.

**Strategic Insight (2026-01-13):** This exploration has evolved beyond just "doc templates" to a broader vision of **scripts as workflow orchestration**. The hybrid pattern (scripts handle structure + context, AI handles creativity) offers significant token efficiency gains while improving consistency.

**Opportunities:**

- **Reduced friction:** Developers get correct structure automatically, no guessing
- **Reliable automation:** Commands can trust input doc structure
- **Testable docs:** Validation enables CI checks for doc quality
- **Learnable patterns:** Consistent structure across all docs aids understanding
- **AI assistance:** Templates give AI clear target structure to generate
- **Token efficiency:** Scripts generate structure (0 tokens), gather context (reduces input tokens) - estimated 50-60% total savings
- **Model optimization:** Right model for the right task (cost + quality)
- **Programmatic workflows:** Scripts can orchestrate entire workflows, invoking AI only when needed

**Concerns:**

- **Maintenance burden:** Templates need updates when patterns evolve
- **Over-engineering risk:** Could add complexity without proportional value
- **Adoption friction:** Existing docs may need migration
- **Flexibility vs consistency:** Some docs may need custom sections
- **Cursor CLI capabilities:** Unknown if programmatic invocation with model selection is supported
- **Architectural placement:** Where does this tooling live? (four-arm question)

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
- **Key insight:** Two-mode pattern IS the hybrid architecture (setup=script, conduct=AI)

**Strategic Architecture Discussion** (from main dev-infra worktree):
- Validates the hybrid pattern at strategic level
- Raises question of where tooling should live
- See: `tmp/handoff-strategic-architecture-2026-01-13.md`

**Four-Arm Architecture Research:**
- dev-infra, dev-toolkit, proj-cli, work-prod separation
- This feature likely belongs in tooling arm, not dev-infra
- Decision phase should resolve placement

---

## 🚀 Next Steps

1. ✅ ~~Review research topics in `research-topics.md`~~
2. ✅ ~~Conduct research on high-priority topics (Template Inventory, Generation Architecture)~~
3. Review [Research Hub](../../research/template-doc-infrastructure/README.md) with strategic context
4. Use `/decision template-doc-infrastructure --from-research` to make decisions:
   - Template architecture (17 doc types, 5 patterns)
   - Generation script architecture (shared library + templates)
   - **Architectural placement (four-arm question)**
   - Model selection strategy
5. Create transition plan for implementation

---

**Last Updated:** 2026-01-13
