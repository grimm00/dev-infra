# Decisions — Skill Corpus Installation

**Last Updated:** 2026-06-09

Architecture Decision Records for the skill-corpus-installation feature. The
installation mechanism itself is decided upstream in ADR-002 (skill-template-separation);
decisions here concern how the corpus repo(s) are organized.

---

## Index

| ADR | Title | Status | Summary |
|-----|-------|--------|---------|
| [001](adr-001-corpus-repo-split-model.md) | Corpus Repository Split Model (Core + Personal) | ✅ Accepted | Two repos — core (`ai-workflow`, shareable) + personal (`ai-workflow-personal`, private). Boundary test = general-purpose/durable **or** depended-on-by-core. Invariant: no core→personal deps. `update-pr-description` is core (dependency-forced). Graduation = `git mv` + reinstall. |

---

## Related upstream decisions

- [ADR-002: Installation & Distribution Architecture](../../../../meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md) — symlink farm, three-tier distribution (the mechanism this feature implements)
- [ADR-003: Per-Repo Profile Schema](../../../../meta/features/skill-template-separation/decisions/adr-003-per-repo-profile-schema.md) — separate downstream plan

---

**Last Updated:** 2026-06-09
