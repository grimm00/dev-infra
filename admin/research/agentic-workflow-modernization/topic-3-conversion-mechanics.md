# Research: Command-to-Skill Conversion Mechanics

**Research Topic:** Agentic Workflow Modernization
**Question:** What does it concretely look like to convert a complex dev-infra command into a Cursor skill?
**Status:** ✅ Complete (with caveats -- see Finding 7, Finding 8)
**Priority:** High
**Created:** 2026-03-25
**Completed:** 2026-03-25
**Amended:** 2026-03-25 -- added gaps from post-research /discuss: accuracy evidence caveat (Finding 7), nested directory instability (Finding 8), disable-model-invocation portability gap (Finding 9)

---

## 🎯 Research Question

How do complex multi-mode commands (like `/explore` with setup/amend/conduct modes, 500+ lines) decompose
into the skill format? How do reference files, 500-line limits, marketplace metadata, and template sync interact?

**Pre-answered by Spike B:** The `/discuss` command (behavioral archetype) converts cleanly at 267→143 lines.
The question now focuses on the procedural archetype with complex multi-mode structure and reference file needs.

---

## 🔍 Research Goals

- [x] Design the skill equivalent of `/explore` (post-issue-#72): SKILL.md core, reference files for templates, `plugin.json` marketplace metadata
- [x] Determine how multi-mode commands (setup/amend/conduct) decompose -- one skill with modes, or multiple separate skills?
- [x] Determine where doc-gen templates live in the skill structure (as reference files = structural schemas connection)
- [x] Assess template sync validation: how does dev-infra's existing sync mechanism extend to cover skills?
- [x] Define the `plugin.json` format and what marketplace metadata is required

---

## 📚 Research Methodology

**Sources:**
- [x] Reviewed `update-pr-description` skill and `plugin.json` (known-good procedural example, 208 lines)
- [x] Reviewed Cursor Agent Skills documentation (trycursor.com/docs/context/skills)
- [x] Reviewed Agent Layer Skill Design Guide (agent-layer.dev/skill-design/) -- empirically grounded
- [x] Analyzed `/explore` command (1375 lines, 3 modes) as the primary conversion target
- [x] Analyzed dev-infra's `template-sync-manifest.txt` for sync extension requirements
- [x] Web search: multi-mode skill decomposition patterns (2026)

---

## 📊 Findings

### Finding 1: Reference Files Are Progressive Disclosure, Not Mode Branches

The official Cursor skills specification documents three optional directories alongside `SKILL.md`:

```
skill-name/
├── SKILL.md           ← ≤500 lines; must be operationally complete on its own
├── scripts/           ← executable code agents can run (bash, python, etc.)
├── references/        ← additional documentation loaded on demand
└── assets/            ← static resources: templates, config files, etc.
```

**Key specification constraint (Agent Layer):** "Core behavior cannot depend on companion files today. Every skill must remain operationally understandable from SKILL.md alone."

This means reference files are for **progressive disclosure of detail within a single workflow** -- not for housing alternate mode branches. A `references/conduct-mode.md` that contains the entire conduct workflow, loaded from a routing stub in SKILL.md, would violate this constraint. The agent must be able to execute the skill even if companion files fail to load.

**Correct use of reference files:**

- An `explore-conduct` skill with `references/exploration-templates.md` containing doc-gen templates the agent fills in during conduct. The skill works without the templates (it can generate from memory); the reference provides the exact canonical format.
- An `explore-conduct` skill with `references/artifact-guide.md` containing examples for each exploration section. Supplementary, not load-bearing.

**Source:** [Cursor Agent Skills docs](https://www.trycursor.com/docs/context/skills); [Agent Layer Skill Design Guide](https://agent-layer.dev/skill-design/)

---

### Finding 2: Empirical Evidence Strongly Against Multi-Mode Single Skills

The Agent Layer Skill Design Guide synthesizes empirical research that directly contradicts the Strategy A
decomposition hypothesis from Topic 2 (FR-7):

> "Multi-mode skills with conditional branching create exactly the composition types that models handle worst."

The evidence:

| Finding | Source | Impact |
|---------|--------|--------|
| Flat AND composition: 0.881 accuracy | ComplexBench, NeurIPS 2024 | Baseline: single-mode skill |
| Nested multi-layer composition: 0.083 accuracy | ComplexBench, NeurIPS 2024 | ~10x degradation for multi-mode |
| Input 250→3,000 tokens: accuracy drops 0.92→0.68 | Same Task, More Tokens, ACL 2024 | Long skills are actively harmful |
| Middle-positioned content: 52.9% vs 56.1% closed-book | Lost in the Middle, TACL 2023 | Mode branches buried mid-file are worse than absent |
| All 20 models show primacy effect for instructions | IFScale, 2025 | Later instructions (mode 2, 3) are dropped more often |

**The "one skill, one workflow" principle** from the spec is not a style preference -- it reflects how instruction composition actually degrades model performance. "If mode X / if mode Y" branching in a single SKILL.md is the anti-pattern, not Strategy A's solution to it.

**Source:** [Agent Layer Skill Design Guide](https://agent-layer.dev/skill-design/)

---

### Finding 3: Multi-Mode Commands Decompose Into Multiple Separate Skills

The correct decomposition for multi-mode commands is **separate skills with separate names** -- not a single skill with a `references/` directory per mode.

**`/explore` decomposition (3 modes → 3 skills):**

| Current command | Skill name | Trigger description | Lines estimate |
|----------------|------------|--------------------|-|
| `/explore [topic]` | `explore` | "Start an exploration for a new topic or idea. Use when scaffolding is needed before detailed investigation." | ~150 lines |
| `/explore [topic] --conduct` | `explore-conduct` | "Expand existing exploration scaffolding into full detailed analysis. Use when scaffolding is ready and direction is validated." | ~200 lines |
| `/explore [topic] --amend` | `explore-amend` | "Append a new theme or question to an existing expanded exploration. Use after research or spikes surface new questions." | ~100 lines |

**`/research` decomposition (4 modes → 4 skills):**

| Current command | Skill name | Lines estimate |
|----------------|------------|---|
| `/research --from-explore` | `research` | ~150 lines |
| `/research --conduct` | `research-conduct` | ~200 lines |
| `/research --add-topic` | `research-add-topic` | ~80 lines |
| `/research --consolidate` | `research-consolidate` | ~150 lines |

**Implication for user experience:** The slash command surface changes from `/explore --conduct` to `/explore-conduct`. This is a breaking change in command names but a user experience improvement: the description field now precisely matches what the user wants, reducing misrouting.

**Source:** [Agent Layer Skill Design Guide](https://agent-layer.dev/skill-design/) -- Principle 2 ("One skill, one workflow") and Anti-patterns table

---

### Finding 4: Doc-Gen Templates Belong in `assets/`, Not `references/`

The three optional directories have distinct roles:

| Directory | Purpose | Load behavior |
|-----------|---------|---------------|
| `scripts/` | Executable code -- deterministic tasks faster to run than describe | Agent executes on demand |
| `references/` | Additional documentation -- supplementary guidance, examples | Agent reads on demand for detail |
| `assets/` | Static resources -- templates, config files, data files | Agent reads and fills in / copies |

Doc-gen templates (the document templates dev-infra's commands currently embed inline) are **static resources** the agent fills in, not documentation the agent reads for understanding. They belong in `assets/`.

**Example for `explore-conduct`:**

```
explore-conduct/
├── SKILL.md
├── assets/
│   ├── exploration-template.md       ← canonical exploration.md structure
│   └── research-topics-template.md   ← canonical research-topics.md structure
└── references/
    └── section-guidance.md           ← optional: what belongs in each section
```

The SKILL.md instructs the agent: "Create exploration.md using the template at `assets/exploration-template.md`." The agent reads the asset and fills in the placeholders. If the asset is unavailable, the agent can fall back to generating the structure from the SKILL.md description -- but the canonical form is in the asset.

**Connection to Theme 4 (Structural Schemas):** This is where structural schemas land in practice. Templates-as-assets define the expected artifact shape, giving downstream agents (and the template sync validator) a formal contract to check against.

**Source:** [Cursor Agent Skills docs](https://www.trycursor.com/docs/context/skills)

---

### Finding 5: `plugin.json` Format Is Lightweight -- Marketplace Metadata Only

From the `update-pr-description` known-good example:

```json
{
  "name": "update-pr-description",
  "description": "Generate structured PR descriptions from branch diffs...",
  "version": "1.0.0",
  "repository": "https://...",
  "author": { "name": "...", "email": "..." },
  "license": "MIT",
  "keywords": ["pr-description", "pull-request", "git", "github", "code-review", "productivity"]
}
```

**Key observations:**
- `plugin.json` is marketplace registry metadata -- it connects the skill to discovery and installation
- The behavioral contract lives entirely in `SKILL.md` -- `plugin.json` carries no behavioral fields
- `name` in `plugin.json` must match the `name` in SKILL.md frontmatter and the parent folder name
- `keywords` are discovery tags for the marketplace -- they're separate from the `description` used for auto-invocation routing

**Relationship to the C-3 constraint:** `disable-model-invocation: true` in SKILL.md interacts with marketplace delivery. The bug (confirmed as of March 2026) causes the flag to hide the skill from the command palette when installed via marketplace. For dev-infra's explicit-only skills, this means marketplace distribution remains blocked until the bug is resolved, regardless of `plugin.json` quality.

**Source:** Direct audit of `update-pr-description/plugin.json`

---

### Finding 6: Template Sync Must Extend to Skill Directory Trees

Dev-infra's current `template-sync-manifest.txt` tracks flat files:

```
.cursor/commands/explore.md
.cursor/commands/research.md
...
```

When commands migrate to skills, the structure changes from flat files to directories:

```
.agents/skills/explore/SKILL.md
.agents/skills/explore/assets/exploration-template.md
.agents/skills/explore-conduct/SKILL.md
.agents/skills/explore-conduct/assets/exploration-template.md
```

The manifest format needs to support **skill directories**, not just individual files. Options:

**Option A: List SKILL.md explicitly (minimal change)**

```
.agents/skills/explore/SKILL.md
.agents/skills/explore/assets/exploration-template.md
```

Pros: No change to manifest format or validation script. Cons: `assets/` drift is not automatically caught -- a template added to one template's skill but not the other would be missed.

**Option B: Directory-level tracking (sync script extension)**

```
# skill: explore
.agents/skills/explore/
```

The sync script would compare directory trees recursively. This requires extending `validate-template-sync.sh` to support directory comparison mode. This gives full drift detection for skill directories.

**Recommendation:** Option A initially (progressive) -- list each file individually. Upgrade to Option B (Option B) as part of a dedicated skills-migration release when the full directory structure is stable.

**Source:** Audit of `scripts/template-sync-manifest.txt` and `validate-template-sync.sh` approach

---

### Finding 7: The Accuracy Degradation Claim for References-as-Branches Is Inferred, Not Directly Measured

**Status: Gap -- spike needed before FR-10 is treated as a hard requirement.**

Finding 2 cited ComplexBench (NeurIPS 2024) to argue that externalizing mode branches to `references/` still causes accuracy degradation because "instruction composition degrades at the model level, not the disk level." This is a reasonable extrapolation, but it is an extrapolation. ComplexBench measures nested boolean constraint composition in a single prompt -- not specifically the pattern of a routing stub in SKILL.md loading mode-specific reference files.

**What the evidence directly supports:**
- Long instruction sets cause accuracy degradation (Same Task, More Tokens, ACL 2024: 0.92→0.68 from 250→3K tokens)
- A single 1375-line `/explore` as one skill is harmful -- this is solidly supported
- Separate skills per workflow are lighter, unambiguous, and well-supported by the spec

**What requires empirical validation:**
- Whether a 200-line SKILL.md routing stub that progressively loads mode-specific reference files causes measurable degradation vs. separate skills
- Whether the model reliably loads and follows reference file content when instructed to do so mid-workflow
- Whether the user experience (one skill name with internal mode dispatch) is actually worse than three separate skill names

**Implication for FR-10:** The *length* argument alone justifies separate skills for commands with 1000+ lines. But the specific claim that "references-as-branches fails even for shorter skills" needs a spike before it becomes a hard architectural rule. FR-10 should be treated as a strong recommendation with a pending spike to validate or falsify the references-as-branches pattern at realistic skill sizes (~300-400 lines total).

**Proposed spike:** Convert `/explore` twice -- once as a 3-skill family, once as a single `explore` skill with `references/setup-mode.md`, `references/conduct-mode.md`, `references/amend-mode.md` -- and compare invocation reliability and output quality across 10 invocations each.

**Source:** Post-research /discuss session; [agentskills.io/specification](https://agentskills.io/specification); SkillsBench (2026) shows skills help +13-23% but doesn't address multi-mode patterns

---

### Finding 8: Nested Skill Directory Discovery Is Unstable in Cursor

The Cursor community forum (January--February 2026) documents that skills in subdirectories (e.g., `./frontend/.cursor/frontend-guidelines/SKILL.md`) worked intermittently in Cursor 2.4 but broke again in 2.4.36 for multiple users. The issue has no official resolution.

**Implication:** The user's instinct to package a skill family (e.g., `explore`, `explore-conduct`, `explore-amend`) in a parent `explore/` directory as nested skills is attractive but unreliable today. The agentskills.io spec doesn't explicitly forbid nesting but all examples and guidance assume flat structure under the skills directory. The spec note "keep file references one level deep from SKILL.md" further suggests deep nesting is not the intended pattern.

**Safe packaging approach:** Use naming convention for family grouping (`explore`, `explore-conduct`, `explore-amend` as flat siblings), not directory nesting. The `explore/` base skill's `assets/` directory can hold shared templates; sibling skills reference them via relative paths if needed (though this goes one level outside spec's strict file reference guidance).

**Source:** [Cursor forum: Skill from subdirectories?](https://forum.cursor.com/t/skill-from-subdirectories/149657); [agentskills.io/specification](https://agentskills.io/specification)

---

### Finding 9: `disable-model-invocation` Is Cursor-Specific -- Not in the agentskills.io Spec

The agentskills.io specification (confirmed from the live spec) defines these frontmatter fields: `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`. There is **no `disable-model-invocation` field in the portable spec**.

`disable-model-invocation: true` is a Cursor extension. This has a direct portability consequence: a skill authored with this flag for explicit-only invocation in Cursor will not have that behavior enforced when installed in Claude Code, Codex, or other spec-compliant agents. Those agents will apply their own auto-invocation heuristics.

**Implication for Topic 5 (Cross-Platform Portability):** This is a significant finding for the portability topic. The explicit-only guarantee from FR-1 and FR-4 is Cursor-specific. The closest portable equivalent is the description field -- writing descriptions that clearly say "only use when explicitly invoked by the user via /skill-name" may influence other agents' routing, but it's not enforced.

**Implication for FR-1 and FR-4:** These requirements are implementable in Cursor but their enforcement is platform-dependent. The requirements should be annotated as "Cursor-specific enforcement; description-based guidance for other platforms."

**Source:** Direct review of [agentskills.io/specification](https://agentskills.io/specification) -- `disable-model-invocation` absent from field table; confirmed Cursor-only via [trycursor.com/docs/context/skills](https://www.trycursor.com/docs/context/skills)

---

## 🔍 Analysis

### The Core Insight: Strategy A Is Likely the Wrong Model (Spike Needed to Confirm)

Topic 2 (FR-7) proposed "Strategy A: SKILL.md core + `references/` per mode." Finding 2 argues this is still a multi-mode skill -- just with the mode branches externalized into reference files. Finding 7 adds an important caveat: the accuracy degradation claim specifically for the references-as-branches pattern is inferred from general instruction composition research, not directly measured.

**What is confirmed:** The length argument is solid. A single 1375-line `/explore` as one skill is harmful by direct evidence. Separate skills each under 250 lines solve the length problem definitively.

**What needs a spike:** Whether a 200-300 line routing stub + reference files causes meaningful degradation compared to separate skills at the same total line count. This is the specific claim in FR-10 that goes beyond the length evidence.

**Recommendation stance:** Treat separate skills as the strongly preferred pattern -- it solves the length problem, the routing ambiguity problem, and aligns with the "one skill, one workflow" principle. But hold FR-10 as a recommendation pending a spike rather than a hard architectural constraint. The spike (Finding 7) should be run as part of the `/explore` pilot conversion.

The correct decomposition is **separate skills per workflow** (Finding 3). This:
- Eliminates mode-switching entirely -- each skill description is unambiguous routing signal
- Brings each skill within 150-250 lines -- well below the 500-line limit
- Allows reference files (`assets/`, `references/`) to serve their proper role (progressive detail, not parallel branches)
- Makes activation evaluation straightforward (positive/negative trigger prompts per skill)

### The `/explore` Skill Family as Reference Architecture

`/explore` is the highest-complexity command to convert (1375 lines, 3 modes, doc-gen templates). It should be the reference architecture for the migration:

1. **`explore` skill** (setup mode, ~150 lines) -- creates scaffolding + `research-topics.md`; assets contain the canonical scaffold template
2. **`explore-conduct` skill** (~200 lines) -- expands scaffolding to full exploration; assets contain the canonical exploration and research-topics templates; `references/` contains section guidance
3. **`explore-amend` skill** (~100 lines) -- appends theme to existing exploration; no assets needed (template structure already exists on disk)

This family totals ~450 lines across 3 SKILL.md files, vs. 1375 lines in a single command. Each is below 250 lines. Each routes unambiguously on user intent.

### The Template Sync Problem Is Manageable

The manifest is currently 26 flat command files. After migration, it becomes ~60-80 skill files across ~30 skill directories (one per current command, many split into 2-4 skills). The flat-file tracking approach (Option A) can handle this with no tooling changes -- the manifest just grows. Full directory tracking (Option B) is the right end state but not urgent for the first migration wave.

**Key Insights:**
- [x] Insight 1: Long skills (1000+ lines) are empirically harmful; one skill, one workflow is the correct decomposition unit -- though the specific references-as-branches variant needs a spike to confirm
- [x] Insight 2: Reference files are progressive disclosure within a workflow, not mode branches
- [x] Insight 3: Doc-gen templates belong in `assets/`, structural guidance in `references/`
- [x] Insight 4: `plugin.json` is marketplace metadata only -- behavioral contract lives in SKILL.md
- [x] Insight 5: Template sync can extend to skills incrementally using the existing flat-file approach
- [x] Insight 6: `disable-model-invocation` is Cursor-specific -- not in the portable agentskills.io spec; explicit-only enforcement is platform-dependent
- [x] Insight 7: Nested skill directory discovery in Cursor is unstable; flat naming convention is the safe packaging approach for skill families

---

## 💡 Recommendations

- [x] **Revise FR-7**: Replace "Strategy A (SKILL.md core + references per mode)" with "one skill, one workflow -- split multi-mode commands into separate skills per workflow, not per flag argument." The 500-line limit is the safety backstop, not the primary decomposition driver.
- [x] **`/explore` as pilot**: Convert `/explore` to a 3-skill family (`explore`, `explore-conduct`, `explore-amend`) as the first concrete migration. This validates the decomposition pattern and produces the reference architecture for all other complex commands.
- [x] **Use `assets/` for doc-gen templates**: Move all document templates (currently inline in commands) to `assets/` within the relevant skill. This is where the structural schemas insight materializes in practice.
- [x] **Extend template sync manifest incrementally**: List each skill file explicitly in `template-sync-manifest.txt`. No tooling change needed initially. Plan directory-level tracking as a separate improvement.
- [x] **`plugin.json` per skill, not per command family**: Each skill in a family (`explore`, `explore-conduct`, `explore-amend`) gets its own `plugin.json` with its own name, description, and keywords. They can share the same `repository` and `author` fields.

---

## 📋 Requirements Discovered

- [x] **FR-10: Multi-Mode Commands Should Decompose Into Separate Skills, One Per Workflow** -- supersedes FR-7's "Strategy A." Commands with distinct modes (setup/conduct/amend, etc.) should become separate skills with distinct names and descriptions. Mode parameter flags (`--conduct`, `--amend`) become separate skill names (`explore-conduct`, `explore-amend`). Shared logic between skills is accepted duplication until three or more real consumers exist.
  - Source: Finding 2, Finding 3
  - **Caveat (Finding 7):** The accuracy degradation argument for references-as-branches specifically is inferred, not directly measured. The length argument alone (1000+ line commands) is sufficient justification for the largest commands. Treat as strong recommendation; confirm via spike before applying to shorter multi-mode commands (~300-400 lines total).
  - Priority: High for commands >500 lines; Medium for shorter multi-mode commands pending spike validation

- [x] **FR-11: Doc-Gen Templates Must Live in Skill `assets/` Directories** -- document templates currently embedded inline in commands must be externalized to `assets/` within the owning skill directory. The SKILL.md must instruct the agent to use the canonical template from `assets/`, with a fallback to memory-generated structure. This makes templates independently versionable and validatable.
  - Source: Finding 1, Finding 4
  - Priority: Medium

- [x] **FR-12: SKILL.md Must Be Operationally Complete Without Companion Files** -- the core workflow of any skill must be understandable and executable from SKILL.md alone, even if `assets/`, `references/`, and `scripts/` fail to load. Companion files are supplementary, not load-bearing. Skills that require a reference file to function violate this constraint.
  - Source: Finding 1 (Agent Layer spec constraint)
  - Priority: High

- [x] **FR-13: Template Sync Manifest Must Track Skill Files** -- when commands migrate to skills, `template-sync-manifest.txt` must be updated to track skill files (`SKILL.md`, asset templates) instead of command files. Initial approach: list each file individually. Future: directory-level tracking.
  - Source: Finding 6
  - Priority: Medium (required at migration time, not before)

- [x] **Note: FR-7 Must Be Revised** -- FR-7 ("Strategy A decomposition") should be superseded by FR-10. The revision should be applied during `--consolidate` to avoid conflicting requirements.

- [x] **Note: FR-1 and FR-4 Are Cursor-Specific** (Finding 9) -- `disable-model-invocation: true` is not in the portable agentskills.io spec. FR-1 ("Explicit-Only Skills Must Suppress Auto-Detection") and FR-4 ("Workflow Skills Must Disable Auto-Detection") are implementable and enforced in Cursor but not portable. During `--consolidate`, annotate both FRs with: "Cursor enforcement: `disable-model-invocation: true`; portable mitigation: description field guidance." This has direct implications for Topic 5 (Cross-Platform Portability).

- [x] **Spike Candidate: References-as-Branches vs. Separate Skills** (from Finding 7) -- Convert `/explore` in both forms and compare reliability across 10 invocations. This validates or falsifies FR-10's application to shorter multi-mode commands. Add to spike-only items in `research-topics.md`.

---

**Last Updated:** 2026-03-25
