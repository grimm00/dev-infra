# Research: Template Skill Bundling Strategy

**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-05-06
**Completed:** 2026-05-08

---

## Research Question

After separation, do templates still bundle a subset of skills (as release snapshots), or do they rely entirely on global installs and just document which skills they expect?

---

## Research Goals

- [x] Define "bundling" precisely: full skill copy in template vs. manifest/lockfile referencing skills
- [x] Evaluate Model A (snapshot at release): templates include skills at release time, generated projects start with them
- [x] Evaluate Model B (no bundling): templates carry no skills, document expected global installs instead
- [x] Evaluate Model C (manifest only): templates include a skill manifest that a setup command resolves
- [x] Assess self-containment tradeoff: can a generated project work without global installs?
- [x] Determine what the `workflow-decoupling` exploration's "package manager question" means for each model
- [x] Assess version drift: if templates snapshot skills, how quickly do they go stale?

---

## Methodology

**Queries executed:**
1. "template project scaffold bundling dependencies vs manifest declaration package.json vs lock file pattern dependency declaration 2025 2026"

**Internal sources consulted:**
- `scripts/template-sync-manifest.txt` — current sync surface (commands + .sourcery.yaml)
- `workflow-decoupling` exploration — Themes 1-5 (drift, velocity layers, package manager question)
- Topic 1 findings — FR-MVPC-6 ("templates MUST NOT bundle skills")
- Topic 3 findings — FR-OWN-1 ("skill corpus is a separate product")
- Topic 10-11 findings — symlink dev-mode, plugin distribution

---

## Sources

- [x] Current `template-sync-manifest.txt` — lists commands synced between templates (already notes skills are NOT synced via this manifest)
- [x] `workflow-decoupling` exploration — Theme 4 (package manager question), Theme 5 (versioning/compatibility)
- [x] Topic 1: FR-MVPC-6 — "templates MUST NOT bundle skills/commands/agents"
- [x] Topic 3: FR-OWN-1 — "skill corpus is a separate product with own repo"
- [x] Web search: package.json vs. lock file pattern, dependency declaration vs. bundling in scaffolds

---

## Findings

### Finding 1: Prior Research Already Decided This — Templates Don't Bundle

**Source:** Topic 1 (FR-MVPC-6), Topic 3 (FR-OWN-1, FR-OWN-2)
**Relevance:** Two prior findings from this same research track have already converged on the answer:

- FR-MVPC-6: "The minimal template MUST NOT bundle skills, commands, or agents (these are global installs with independent lifecycle)"
- FR-OWN-2: "Dev-infra MUST NOT contain authoritative copies of skills. It MAY contain a manifest listing expected skills for template validation"

The question is answered: **Model B (no bundling) with a manifest listing**.

### Finding 2: The Workflow-Decoupling Exploration Confirms the Pattern

**Source:** `workflow-decoupling` exploration, Themes 1-4
**Relevance:** The exploration (from the template-generation service perspective) identified:

- Theme 1: "Every generated project is now silently stranded on a stale workflow set" — bundling causes drift
- Theme 2: Three velocity layers (scaffold=slow, commands=medium, skills=fast) — bundling forces the slowest to gate the fastest
- Theme 4: "If workflows decouple from scaffolding, something needs to install and update them" — the package manager question

The exploration concluded that the `template-sync-manifest.txt` could evolve into the workflow package manifest. With the skill-template-separation research findings (Topics 1, 3, 10, 11), the answer is clearer: the manifest doesn't resolve to bundled copies but to the globally installed corpus.

### Finding 3: The Manifest Pattern from Package Ecosystems

**Source:** Web search: npm package.json, lock files, scaffold manifests
**Relevance:** Package ecosystems distinguish:

| Concept | In npm | In template context |
|---------|--------|---------------------|
| Declaration | `package.json` (what you need, version ranges) | Skill manifest (what skills this template expects) |
| Lock | `package-lock.json` (exact versions that worked) | Not needed — skills are globally installed, not per-project |
| Bundle | `bundledDependencies` (vendored copies in the package) | Old model — skill copies in the template |

The npm pattern shows bundling is a *special case* for offline use or when you can't trust the registry. For skills:
- There's no "registry" to not trust — they're locally installed
- There's no "offline" concern — the installer (symlinks) already ran before the template was generated
- The manifest is purely informational: "this template works best with these skills"

### Finding 4: The `template-sync-manifest.txt` Is Already Dead

**Source:** Internal: `scripts/template-sync-manifest.txt` content analysis
**Relevance:** The current manifest reveals its own obsolescence:

- It lists commands for syncing between `standard-project` and `learning-project`
- It explicitly notes "Claude skills are NOT synced via this manifest"
- Many entries are already marked as archived
- The comment says "all templates now receive all commands — no stable/experimental distinction"

If templates stop bundling commands/skills entirely (per FR-MVPC-6), this file's purpose disappears. It's not "evolving into" the workflow package manifest — it's being replaced by a simpler declaration.

### Finding 5: What the Manifest Looks Like

**Source:** Analysis combining Topic 1 (AGENTS.md is the centerpiece), Topic 3 (corpus is separate), and npm's `peerDependencies` pattern
**Relevance:** The manifest should be:

1. **Lightweight** — a list, not a bundled copy
2. **Informational** — tells the user/`proj-cli` what's expected, doesn't install anything
3. **Located in AGENTS.md or .dev-infra.yml** — not a separate file (minimal template has 7-9 files)

Possible form in `.dev-infra.yml`:
```yaml
template_version: "2.0"
expected_skills:
  - explore
  - research
  - write-plan
  - decision
  - commit
  - pre-commit-review
  - handoff
expected_agents:
  - group-cycle
```

Or in AGENTS.md as a human-readable section:
```markdown
## Expected Skills
This project works best with the ai-workflow skill corpus installed globally.
Required: explore, research, write-plan, decision, commit, pre-commit-review, handoff
```

The `proj-cli` validation step can check "are expected skills installed?" and warn if not.

---

## Analysis

### The Three Models — Final Assessment

| Model | Verdict | Rationale |
|-------|---------|-----------|
| **A: Snapshot at release** | ❌ Rejected | Creates drift (workflow-decoupling Theme 1), stale within weeks (theme 2), contradicts FR-MVPC-6 and FR-OWN-1 |
| **B: No bundling, manifest only** | ✅ Selected | Cleanly separates concerns, zero drift, manifest is informational not operational |
| **C: Manifest that resolves (package manager)** | ❌ Over-engineered for now | Skills are already installed globally via symlinks; there's nothing to "resolve." A resolver adds complexity for zero benefit when the install mechanism (Topics 10-11) handles it |

### Self-Containment Tradeoff

Can a generated project work without global skill installs? **Yes** — AGENTS.md provides enough for AI agents to operate (Topic 1, Finding 2: 28.6% runtime reduction). Skills enhance the workflow but aren't *required*. A project without skills still has:
- A README (human orientation)
- AGENTS.md (agent orientation)
- `.dev-infra.yml` (proj-cli management)
- `.gitignore` (scratch hygiene)

Without skills, the agent uses its own judgment instead of following structured workflows. It's degraded but functional — like a new developer without process docs.

### Version Drift — No Longer a Concern

With no bundling, there's no snapshot to go stale. The globally installed corpus updates independently. The manifest's `expected_skills` list changes rarely (only when the template's AGENTS.md references new workflow patterns that require specific skills).

---

## Recommendations

- [x] Adopt Model B: templates carry NO skill/command/agent copies
- [ ] Include an `expected_skills` declaration in `.dev-infra.yml` (for `proj-cli` validation) listing the skills the template workflow assumes
- [ ] Include a human-readable note in AGENTS.md that the project expects the ai-workflow corpus to be installed
- [ ] Retire `template-sync-manifest.txt` — its purpose (syncing commands between templates) is eliminated when templates stop bundling commands
- [ ] The `proj-cli` setup flow should check for expected skills and warn (not error) if missing: "This project expects the ai-workflow skills. Install with: [command]"
- [ ] No "package manager" is needed — the installer (Topic 10: symlinks from canonical XDG location) is the install mechanism. The template just says "I expect these to be there"

---

## Requirements Discovered

**FR-BNDL-1:** Templates MUST NOT bundle skills, commands, or agents. They MAY include a manifest declaring expected skills.

**FR-BNDL-2:** The expected-skills manifest SHOULD live in `.dev-infra.yml` as an `expected_skills` list (machine-readable for `proj-cli` validation).

**FR-BNDL-3:** `proj-cli` setup SHOULD validate that expected skills are installed and warn (not error) if missing, providing install guidance.

**FR-BNDL-4:** `template-sync-manifest.txt` SHOULD be retired once templates stop bundling commands.

**NFR-BNDL-1:** A generated project MUST function (CI passes, agents can orient via AGENTS.md) even without the expected skills installed — skills enhance the workflow but are not a hard dependency.

---

## Next Steps

- This finding obsoletes most of Topic 6 (global-command-distribution requirements audit) — the old feature assumed bundling, which is now rejected. Topic 6 becomes a quick "mark as superseded" task.
- The `workflow-decoupling` exploration in template-generation can be considered resolved by these findings — its package manager question (Theme 4) is answered: no package manager needed, symlinks + manifest.
- Template modification (removing bundled skills/commands) is an implementation task, not further research.
