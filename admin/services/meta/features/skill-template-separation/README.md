# skill-template-separation

**Purpose:** Separate skills/commands/agents from templates as independent concerns, redefine what templates contain, establish per-repo skill profile as enabling substrate
**Status:** 🟠 In Progress — Research
**Created:** 2026-05-06

---

## Phase Directories

- **[research/](research/)** — 7 topics investigating template minimalism, profile schema, ownership model, bundling strategy, migration, requirements audit, and naming

## Provenance

Promoted from service-level exploration: [../../explorations/skill-template-separation/](../../explorations/skill-template-separation/)

## Service Ownership

| Concern | Owner | Rationale |
|---------|-------|-----------|
| This feature (identity shift, template minimalism, initiative naming) | **meta** | Structural evolution of dev-infra's identity and organization |
| Skill substrate (configurable path roots, per-repo profiles) | **ai-workflow** | How skills resolve paths and configure themselves — operational tooling |
| Template products (what ships in `templates/`) | **template-generation** | Product packaging — consumes the decisions made here |
