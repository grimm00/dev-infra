# Topic 6: Dev-Infra Code Boundary - Research Document

**Purpose:** Determine whether dev-infra should maintain executable scripts for generated projects or limit to specs/templates  
**Status:** ✅ Complete  
**Created:** 2026-02-14  
**Last Updated:** 2026-02-14

---

## 📋 Quick Links

- **[Workflow Simplification Research Hub](README.md)** - Parent research hub
- **[Research Topics](../../explorations/workflow-simplification/research-topics.md)** - All 6 topics
- **[Exploration Theme 5](../../explorations/workflow-simplification/exploration.md)** - Dev-infra code boundary theme
- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** - Source of tentative requirements

---

## 🎯 Research Goal

**Key Question:** Should dev-infra maintain executable scripts (like `scaffold-feature.sh`) for generated projects, or should all executable logic live in dev-toolkit?

**Context:** Topic 3 research produced requirements (FR-22 through FR-24, NFR-8, C-8, C-9) assuming dev-infra would host a `scaffold-feature.sh` script. This assumption crosses the template factory boundary (ADR-001). Resolving this unblocks the decision phase.

---

## 🔍 Methodology

- [x] Review the existing dev-infra ↔ dev-toolkit boundary pattern
- [x] Assess whether the tiered blueprint can be a manifest/spec
- [x] Evaluate the gap period -- is "AI follows command spec" sufficient?
- [x] Determine disposition of FR-22-24, NFR-8, C-8, C-9
- [x] Consider "temporary scripts become permanent" risk
- [x] Web search: spec-driven scaffolding patterns in developer tools

**Sources:**

- [x] Dev-infra scripts inventory (`scripts/`)
- [x] ADR-001: Project Identity (`admin/decisions/dev-infra-identity-and-focus/`)
- [x] Exploration Theme 5 (`admin/explorations/workflow-simplification/exploration.md`)
- [x] Doc-gen template system (`scripts/doc-gen/`)
- [x] Validation rules (`scripts/doc-gen/templates/validation-rules/`)
- [x] Web search: spec-driven scaffolding patterns (GitHub Spec Kit, TypeSpec, Bazel Starters)
- [x] Web search: template repo vs CLI tool separation of concerns

---

## 📊 Findings

### Finding 1: Dev-Infra's Existing Boundary Is Clean and Consistent

Dev-infra currently maintains a clear two-repo boundary with dev-toolkit:

| Dev-Infra Owns (Specs) | Dev-Toolkit Owns (Implementation) |
|---|---|
| Doc-gen templates (`.tmpl` files) | `dt-doc-gen` rendering engine |
| Validation rules (`.yaml` files) | `dt-doc-validate` CLI + compiled `.bash` rules |
| Template structures (directories, README files) | `dt-workflow` CLI commands |
| Variable contract (`VARIABLES.md`) | Variable resolution and `envsubst` execution |

The discovery mechanism is well-established: `DT_TEMPLATES_PATH` (defaulting to `~/Projects/dev-infra/scripts/doc-gen/templates`) lets dev-toolkit find dev-infra's specs without tight coupling.

**No dev-infra scripts are shipped to generated projects.** The `templates/standard-project/scripts/` and `templates/learning-project/scripts/` directories contain only a README and placeholder directories (build/, deploy/, database/, utils/). All existing dev-infra scripts (`new-project.sh`, `validate-templates.sh`, release automation scripts) are either core product tools or internal-only tools.

**Source:** Script inventory analysis, doc-gen structure, exploration Theme 5

**Relevance:** Adding `scaffold-feature.sh` to dev-infra would be the first script that crosses this boundary -- running inside generated projects but maintained in the template repo. It breaks the established pattern.

---

### Finding 2: ADR-001 Explicitly Draws the "Template Factory" Line

ADR-001 (Project Identity) establishes that dev-infra's primary identity is "template factory" with clear boundaries:

- *"Internal tooling stays internal -- Release automation, validation scripts remain dev-infra-only"*
- *"Templates are products -- Treated as output, not reflections of dev-infra's internal process"*
- FR-15 in ADR-001: *"Templates should not include dev-infra internal tooling"*

A `scaffold-feature.sh` script falls in an ambiguous zone -- it's not "internal tooling" (it runs in generated projects) and it's not a "template" (it's executable logic). ADR-001 doesn't address this category because the pattern didn't exist before. However, the spirit of ADR-001 is clear: dev-infra defines *what*, dev-toolkit implements *how*.

**Source:** `admin/decisions/dev-infra-identity-and-focus/adr-001-project-identity.md`

**Relevance:** Extending ADR-001's principle to the new tier system means dev-infra should own the tier thresholds, template files, and validation rules -- but not the executable scaffolding logic.

---

### Finding 3: Industry Pattern Confirms Spec/Implementation Separation

Web research reveals a validated industry pattern: **spec-driven development** separates specifications from implementation.

**GitHub Spec Kit (2025)** uses a four-document pattern: Constitution → Spec → Plan → Tasks. The specs are declarative artifacts that AI agents and CLI tools consume -- the spec repo never contains the implementation logic. This mirrors dev-infra's model exactly.

**TypeSpec** uses configuration manifests with interpolation for scaffolding templates. Templates define structure; a separate CLI renders them.

**Bazel Starters** uses template repositories that are "browsable, shareable, copy-paste-friendly" -- but scaffolding logic lives in the Bazel toolchain, not in the template repo.

The consistent pattern: **template repos own the "what" (specs, templates, manifests), CLI tools own the "how" (rendering, scaffolding, validation).**

**Source:** GitHub Spec Kit docs, TypeSpec scaffolding docs, Bazel Starters blog

**Relevance:** Validates that a manifest-only approach in dev-infra is the industry-standard pattern, not a compromise.

---

### Finding 4: The Cursor Command Spec IS the Scaffolding Logic (For Now)

The `/transition-plan` command specification already describes exactly what the tiered output should look like -- YAML frontmatter format, file structure per tier, task numbering, Format B checkboxes. An AI agent reading this spec produces the correct output without any bash script.

This is how *every* command currently works in the system. There is no `task-phase.sh` backing `/task-phase`. There is no `explore.sh` backing `/explore`. The command markdown *is* the specification, and the AI agent is the runtime.

**The "gap" before dev-toolkit implements `dt-scaffold-feature` is:**
- AI reads `/transition-plan` spec → produces correct tier output (current model, proven by all other commands)
- Dev-toolkit reads tier thresholds + templates from dev-infra → produces deterministic output (future model)

Both approaches produce the same output. The difference is determinism (dev-toolkit) vs. intelligence (AI agent). For the small number of projects in this gap period, the AI approach is sufficient.

**Source:** Current command system analysis, all 24 existing commands

**Relevance:** Eliminates the urgency argument for a temporary script. The gap is tolerable because the AI-driven approach already works for all other commands.

---

### Finding 5: "Temporary Scripts Become Permanent" Is a Real Risk

Dev-infra's test infrastructure (110+ Bats tests) sets a high quality bar. A `scaffold-feature.sh` script would need:
- Bats test coverage
- CI integration (Docker test image)
- Template sync (if the script ships in templates)
- Error handling for edge cases (no ADR found, tier override, missing directories)
- Compatibility with both interactive and non-interactive modes

This represents significant development and maintenance effort for something explicitly intended to be replaced by dev-toolkit. The project's history shows that scripts, once tested and working, tend to stay -- `new-project.sh` (300+ lines, 110+ tests) is a good example of a "simple script" that grew into a product.

Additionally, deploying the script to generated projects is unsolved. It can't go in `templates/*/scripts/` (that's for the generated project's own scripts). It can't be a dev-infra internal tool (it needs to run in the generated project context). The deployment mechanism would itself need design work.

**Source:** Script inventory, test infrastructure analysis, `new-project.sh` as precedent

**Relevance:** The cost-benefit ratio is unfavorable. High effort to create, test, and deploy a script that will be intentionally deprecated.

---

### Finding 6: What Dev-Infra Should Own for the Tier System

Based on the existing boundary pattern, dev-infra's ownership for the tier system is:

**Templates (`.tmpl` files):**
- `implementation-plan.md.tmpl` (simple/medium tier)
- `implementation-plan-hub.md.tmpl` (complex tier hub)
- `task-group.md.tmpl` (complex tier group files)
- Updated `status-and-next-steps.md.tmpl`

**Validation rules (`.yaml` files):**
- Updated `planning.yaml` with `implementation_plan` and `task_group` document types
- Tier-aware validation (correct YAML frontmatter, global task numbering)

**Configuration (new):**
- Tier threshold constants (could be in `planning.yaml` or a new `tier-config.yaml`)
- Variable contract updates to `VARIABLES.md`

**Command specs (`.md` files):**
- Updated `/transition-plan` describing tier determination and output format
- Updated `/task` describing how to read the blueprint and navigate tiers

Dev-toolkit then consumes these specs via `DT_TEMPLATES_PATH` and implements the rendering, tier determination, and scaffolding as CLI commands.

**Source:** Existing boundary pattern, doc-gen structure

**Relevance:** Defines exactly what dev-infra needs to produce for the tier system -- all specs, no scripts.

---

## 🔍 Analysis

### The Decision Is Clear

The question is not whether dev-infra *can* maintain scripts -- it clearly can (see `new-project.sh`). The question is whether it *should* for this specific case. The answer is no, for four reinforcing reasons:

1. **Pattern violation:** Every other spec in dev-infra (templates, validation rules, variable contracts) follows the "dev-infra defines, dev-toolkit implements" pattern. A scaffolding script would be the sole exception.

2. **Deployment unsolved:** There's no mechanism to get a dev-infra script into a generated project. The deployment problem would itself require design work.

3. **Gap is tolerable:** The AI-driven approach (reading the command spec) already works for all 24 existing commands. There's no functional gap to bridge.

4. **Cost-benefit unfavorable:** High effort to create, test, and maintain a script that's explicitly temporary.

### Key Insights

- [x] **Insight 1: The boundary pattern is already established and works.** Dev-infra owns specs (templates, validation rules, variable contracts). Dev-toolkit owns implementation (rendering, CLI, compilation). Extending this to tier scaffolding is natural.

- [x] **Insight 2: The command spec IS the scaffolding specification.** The `/transition-plan` markdown describes the exact output format, tier thresholds, and file structure. This is sufficient for AI agents and is the primary consumer in the immediate term.

- [x] **Insight 3: A tier config file is the only new spec dev-infra needs.** The tier thresholds (1-8 = simple, 9-15 = medium, 16+ = complex) should be codified in a machine-readable format that both command specs and dev-toolkit can reference.

- [x] **Insight 4: FR-22 should be revised, not removed.** The requirement is valid -- there should be a single source of truth for tier logic. But the "source of truth" is a specification (template + config), not a script.

---

## 💡 Recommendations

- [x] **Recommendation 1: Do not add `scaffold-feature.sh` to dev-infra.** Keep the boundary clean. Dev-infra owns specs; dev-toolkit owns implementation.

- [x] **Recommendation 2: Revise FR-22 from "scaffolding script" to "tier specification."** The single source of truth is the combination of: tier threshold config + doc-gen templates + validation rules. Dev-toolkit implements the scaffolding CLI by reading these specs.

- [x] **Recommendation 3: Add a `tier-config.yaml` (or extend `planning.yaml`) with machine-readable tier thresholds.** This gives dev-toolkit a deterministic config to consume, and the command spec can reference it for human readability.

- [x] **Recommendation 4: Keep FR-23 (replace planning templates) and FR-24 (new template variables) as-is but remove the tentative status.** The templates and variables are squarely in dev-infra's ownership. Only the rendering/scaffolding logic belongs to dev-toolkit.

- [x] **Recommendation 5: Revise NFR-8 from "script callable from IDE+CLI" to "spec consumable by IDE commands and CLI tools."** The spec (templates + config) is the interface. How it's consumed (AI agent reading a command, CLI tool calling `envsubst`) is the consumer's concern.

---

## 📋 Requirements Discovered

### Revised Requirements

- [x] **FR-22 REVISED:** "Tier Specification as Single Source of Truth." A machine-readable tier configuration in dev-infra (e.g., `tier-config.yaml` or section in `planning.yaml`) defines thresholds (1-8 = simple, 9-15 = medium, 16+ = complex), corresponding file structures, and template mappings. Both Cursor commands and dev-toolkit CLI read this specification. Replaces "Scaffolding Script as Single Source of Truth."

- [x] **FR-23 CONFIRMED:** "Replace Planning Doc-Gen Templates." Remove tentative status. The new templates (`implementation-plan.md.tmpl`, etc.) are squarely dev-infra's responsibility. Ownership is confirmed.

- [x] **FR-24 CONFIRMED:** "New Template Variables for Tier System." Remove tentative status. The variable contract (`${TIER}`, `${TASK_COUNT}`, etc.) is dev-infra's to define. Dev-toolkit consumes it.

- [x] **NFR-8 REVISED:** "Tier Specification Consumable by Both IDE and CLI." The tier spec (templates + config + validation rules) must be readable by AI agents (via command specs), by dev-toolkit CLI (via `DT_TEMPLATES_PATH`), and by CI (for validation). Replaces "Scaffolding Script Callable from Both IDE and CLI."

- [x] **C-8 CONFIRMED:** "Doc-Gen Template Replacement Is a Breaking Change." Remove tentative status. Valid regardless of code boundary decision.

- [x] **C-9 CONFIRMED:** "Dev-Infra Templates Are the Single Source of Truth." Remove tentative status. This research confirms the pattern.

### New Requirements

- [x] **FR-30: Machine-Readable Tier Configuration.** Dev-infra must provide a machine-readable tier configuration (e.g., `tier-config.yaml` or section in `planning.yaml`) that defines: tier thresholds, file structure per tier, template mappings per tier. This config is the contract between dev-infra (producer) and dev-toolkit + Cursor commands (consumers).

- [x] **A-9: AI Agent Sufficiency During Gap Period.** We assume the period between shipping the new planning structure and dev-toolkit implementing `dt-scaffold-feature` is manageable via AI agents reading the `/transition-plan` command spec. No temporary bridge script is needed.

---

## 🔗 Related

- **[Topic 3: Transition Plan Output Format](topic-3-transition-plan-output-format.md)** — Source of tentative requirements
- **[ADR-001: Project Identity](../../decisions/dev-infra-identity-and-focus/adr-001-project-identity.md)** — Template factory identity
- **[Requirements](requirements.md)** — FR-22 through FR-24, NFR-8, C-8, C-9 to be resolved

---

**Last Updated:** 2026-02-14  
**Status:** ✅ Complete  
**Next:** Resolve tentative requirements; update summary; proceed to decision phase
