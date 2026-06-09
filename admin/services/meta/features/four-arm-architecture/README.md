# four-arm-architecture

**Purpose:** Define the four-arm architecture (dev-infra, work-prod, project repos, global tools)
**Status:** ✅ Complete
**Created:** 2026-04-24

---

## Phase Directories

- **[research/](research/)** — requirements (promoted to root), summary, 7 topics
- **[decisions/](decisions/)** — 3 ADRs + decisions summary

## Distribution & Corpus Ownership

The four-arm ADRs assumed dev-infra owned command content in templates. [Skill-template-separation ADR-001](../skill-template-separation/decisions/adr-001-separation-model.md) (2026) extends this architecture: the skill corpus is a **separate product**, templates carry only an `expected_skills` manifest, and `proj-cli` validates with warn-not-error semantics. Supersedes the [global-command-distribution](../global-command-distribution/) feature plan.

## Provenance

Promoted from service-level exploration: [../../explorations/four-arm-architecture/](../../explorations/four-arm-architecture/)
