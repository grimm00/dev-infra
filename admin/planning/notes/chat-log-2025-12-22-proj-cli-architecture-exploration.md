# Chat Log: proj-cli Architecture Exploration

**Date:** 2025-12-22  
**Topic:** proj-cli as unified CLI for dev-infra templates  
**Repos Involved:** dev-infra, proj-cli

---

## Summary

This session established a key architectural insight: **proj-cli should be the unified CLI that consumes dev-infra as a "template layer."**

Rather than building CLI tooling into dev-infra (which was being explored as Research Topic 6: CLI vs Script), we leverage the existing proj-cli project which already has:
- Work-prod API integration
- Python CLI with Typer + Pydantic
- XDG-compliant configuration
- Rich terminal output

---

## Key Decisions

### 1. Architecture Split

```
┌─────────────────────────────────────────────────────────┐
│                      proj-cli                            │
│         (User-Facing CLI - installed globally)           │
│                                                          │
│  Commands:                                               │
│  • proj new [name] --template standard  (NEW)            │
│  • proj list / get / create (work-prod API)              │
│  • proj inv scan / analyze                               │
│  • proj sync (NEW)                                       │
└─────────────────────────────────────────────────────────┘
                          │
           ┌──────────────┼──────────────┐
           ▼              ▼              ▼
┌─────────────────┐ ┌─────────────┐ ┌─────────────────┐
│ dev-infra       │ │ work-prod   │ │ ~/.dev-infra/   │
│ (Templates)     │ │ (API)       │ │ (Local Registry)│
└─────────────────┘ └─────────────┘ └─────────────────┘
```

### 2. Role Clarification

| Component | Role |
|-----------|------|
| **proj-cli** | CLI layer - user-facing commands, registry operations |
| **dev-infra** | Template layer - templates, sync rules, metadata format |
| **work-prod** | API layer - cloud project registry |
| **~/.dev-infra/** | Local state - registry.json, config |

### 3. Research Topic 6 Resolved

**Question:** Should sync be a dedicated CLI tool or bash scripts?  
**Answer:** Use proj-cli. It already exists with the right infrastructure.

---

## Work Completed

### In proj-cli repo

Created exploration: `docs/maintainers/planning/explorations/proj-cli-architecture/`

- `README.md` - Exploration hub with architecture diagram
- `exploration.md` - Main exploration with initial thoughts
- `research-topics.md` - 6 research topics:
  1. Template Fetching Strategy (High)
  2. `proj new` Command Design (High)
  3. Local Registry Integration (High)
  4. Sync Command Design (Medium)
  5. Work-prod API Integration (Medium)
  6. Offline Support (Medium)

### In dev-infra repo

Updated exploration: `admin/explorations/dev-infra-identity-and-focus/` (v2 → v3)

- Added Scenario 5: proj-cli Integration
- Resolved Research Topic 6: CLI vs Script → use proj-cli
- Updated identity: dev-infra is NOT a CLI tool, it's a template layer
- Added cross-links to proj-cli exploration

---

## Connection to Previous Research

This builds on completed research in dev-infra:

1. **Template Metadata Research** (`admin/research/template-metadata/`)
   - Defines `.dev-infra.yml` format
   - Essential fields: template, version, created, sync rules

2. **Work-prod Integration Research** (`admin/research/work-prod-integration/`)
   - Local registry at `~/.dev-infra/registry.json`
   - JSON format with jq support
   - Schema: project_id, path, template, version, work_prod_id

---

## Next Steps

### For proj-cli

1. **Conduct research** on the 6 topics in `research-topics.md`
2. **Design `proj new` command** - how it fetches templates, interactive vs flags
3. **Implement local registry** - use schema from work-prod-integration research
4. **Create ADR** for template integration architecture

### For dev-infra

1. **Continue template metadata research** - finalize `.dev-infra.yml` format
2. **Define sync rules** - what files sync automatically vs manually
3. **Version compatibility** - how to handle template version upgrades

---

## Files Changed

### proj-cli (committed & pushed)

```
docs/maintainers/planning/explorations/proj-cli-architecture/README.md (new)
docs/maintainers/planning/explorations/proj-cli-architecture/exploration.md (new)
docs/maintainers/planning/explorations/proj-cli-architecture/research-topics.md (new)
docs/maintainers/planning/explorations/README.md (updated)
```

### dev-infra (committed & pushed)

```
admin/explorations/dev-infra-identity-and-focus/README.md (updated to v3)
admin/explorations/dev-infra-identity-and-focus/exploration.md (updated to v3)
admin/explorations/dev-infra-identity-and-focus/research-topics.md (Topic 6 resolved)
admin/research/work-prod-integration/research-local-registry-format.md (formatting)
```

---

## Key Insight

The realization that proj-cli should handle template operations came from recognizing:

1. **proj-cli already exists** with work-prod API integration
2. **Creating a separate dev-infra CLI** would duplicate effort
3. **Unified CLI is better UX** - one tool for all project operations
4. **dev-infra's strength is templates** - not CLI tooling

This aligns with dev-infra's identity as a "Template Factory" (ADR-001).

---

**Last Updated:** 2025-12-22

