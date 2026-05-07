# Skill-Template Separation

**Purpose:** Explore the structural separation of skills/commands/agents from templates, and the downstream question of what templates should actually contain  
**Status:** ✅ Promoted to feature  
**Created:** 2026-05-06

---

## 📋 Quick Links

- **[Exploration](exploration.md)** — Themes, questions, spike assessment
- **[Research Topics](research-topics.md)** — Prioritized questions for investigation
- **[Feature (promoted)](../../features/skill-template-separation/)** — Research proceeds here
- **[Outcomes](outcomes.md)** — Promotion record

---

## 🏢 Service Ownership

| Concern | Owner | Rationale |
|---------|-------|-----------|
| This exploration (identity shift, template minimalism, initiative naming) | **meta** | Structural evolution of dev-infra's identity and organization |
| Skill substrate (configurable path roots, per-repo profiles) | **ai-workflow** | How skills resolve paths and configure themselves — operational tooling |
| Template products (what ships in `templates/`) | **template-generation** | Product packaging — consumes the decisions made here |

The exploration lives in `meta` because it's about what dev-infra *is*. The implementation of enabling substrate (Theme 3) is dispatched to `ai-workflow`. Template changes resulting from minimalism decisions go to `template-generation`.

---

## 🔗 Related

- **Prior art:** `admin/services/meta/features/global-command-distribution/` (December 2025, stalled at requirements/research — superseded by this exploration's broader framing)
- **Substrate (ai-workflow):** `admin/planning/opportunities/internal/dev-infra/improvements/per-repo-skill-profile-unified.md` (⚠️ Unsorted → ai-workflow backlog)
- **Substrate (ai-workflow):** `admin/planning/opportunities/internal/dev-infra/improvements/skills-path-roots-configurable.md` (⚠️ Unsorted → ai-workflow backlog)
- **Learning:** `admin/planning/opportunities/internal/dev-infra/learnings/skills-shape-not-location.md` (⚠️ Unsorted → ai-workflow backlog)
- **Identity:** `admin/services/meta/features/dev-infra-identity-and-focus/` (ADR-001: "template factory")
- **Informing:** See `📎 Related Int-Opps and Prior Art` section in [exploration.md](exploration.md) for additional int-opps that feed into research

---

**Last Updated:** 2026-05-06
