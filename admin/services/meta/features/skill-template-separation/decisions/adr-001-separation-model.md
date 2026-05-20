# ADR-001: Skill-Template Separation Model

**Status:** 🔴 Proposed
**Decision topic:** `skill-template-separation`

---

## Context

Dev-infra is a template factory (ADR-001 from four-arm-architecture). Skills, commands, and agents are personal operational tooling that run across all repos. These two concerns have different audiences, lifecycles, and evolution pressures. Currently, 76% of the corpus exists only as global installs — dev-infra's template copies are a stale 24% subset that creates drift (workflow-decoupling Theme 1). The template-sync-manifest is already obsolete.

**Requirements in scope:** FR-OWN-1, FR-OWN-2, FR-BNDL-1, FR-BNDL-2, FR-BNDL-3, FR-BNDL-4, NFR-OWN-1, NFR-OWN-2, NFR-BNDL-1, C-OWN-1

---

## Decision

The skill corpus (skills, commands, agents) becomes a **separate product** with its own git repository and independent versioning. Dev-infra templates carry **no bundled copies** — only an `expected_skills` manifest in `.dev-infra.yml` that `proj-cli` validates with a warning (not error) when skills are missing.

---

## Consequences

### Positive

- Eliminates template drift — no stale skill copies to go out of date
- Skills evolve continuously without gating on template release cadence
- Clear ownership: one repo = one product = one versioning story
- Templates shrink from 89 files to 7-9 (91% reduction per Topic 1)
- Generated projects function without skills (graceful degradation via AGENTS.md)

### Negative

- Dev-infra's `templates/standard-project/.claude/skills/` tree must be removed (breaking change for that directory, though already mass-deleted in working tree)
- `template-sync-manifest.txt` needs retirement (minor cleanup task)
- `proj-cli` needs an `expected_skills` validation step added (small feature)

---

## Alternatives Considered

### A: Skills stay in dev-infra (same repo, different release cadence)

Internal separation via directory boundaries. Skills continue to live in `templates/standard-project/.claude/skills/`.

**Why not chosen:** The working tree has already mass-deleted these files. 76% of skills exist only globally. Forcing them back into dev-infra is fighting reality. The release cadence problem remains — skills can't ship independently.

### B: Hybrid model (core skills in dev-infra, personal skills outside)

Dev-infra keeps "core" skills (explore, research, write-plan), personal skills (ticket-intake, apprentice-*) live elsewhere.

**Why not chosen:** Explicitly rejected by Topic 3 analysis. Creates ambiguity about where to author/find skills. The "core vs. personal" boundary is arbitrary and shifts over time. One repo for the whole corpus is simpler.

---

## Decision Rationale

Interview waived — proceeding from research findings. The decision is backed by:
- Topic 3 Finding 1: 76% of corpus already exists only globally
- Topic 3 Finding 2: corpus and templates are different products with different lifecycles
- Topic 4 Finding 1: prior findings (Topics 1, 3) converge on no-bundling
- Topic 4 Finding 4: template-sync-manifest is already obsolete
- C-OWN-1: no migration deadline — current installs work, formalization is incremental

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-OWN-1 | **Fulfilled** — corpus is declared a separate product |
| FR-OWN-2 | **Fulfilled** — dev-infra carries manifest only |
| FR-BNDL-1 | **Fulfilled** — no bundling, manifest allowed |
| FR-BNDL-2 | **Activated** — `.dev-infra.yml` gains `expected_skills` field |
| FR-BNDL-3 | **Activated** — proj-cli gains validation step |
| FR-BNDL-4 | **Activated** — template-sync-manifest retirement task created |
| NFR-BNDL-1 | **Constraint** — template must remain functional without skills |

---

## References

- [Research: Skill Corpus Ownership Model](../research/research-skill-corpus-ownership-model.md)
- [Research: Template Skill Bundling Strategy](../research/research-template-skill-bundling-strategy.md)
- [Research: Minimum Viable Project Contract](../research/research-minimum-viable-project-contract.md)
- [Research: global-command-distribution Audit](../research/research-global-command-distribution-requirements-audit.md)
- [Requirements (Final)](../research/requirements.md)
