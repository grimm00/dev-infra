# Template Structure Options (As‑Is vs Proposed)

## Context
This document compares current structures with a proposed hub‑and‑spoke alignment, informed by `admin/notes/opportunities/external/project_docs_hub_and_spoke_playbook.md` and `docs/BEST-PRACTICES.md`.

## Current (Snapshots)
- See `admin/research/structure-snapshots/*.tree.txt`

## Issues Observed
- Maintainer docs spread across `admin/` with mixed audiences
- Template root includes non-template operational dirs (e.g., `migrations/`, `project-index/`)
- Inconsistent hubs across templates

## Proposed (No implementation yet)
1. Main repo: keep `admin/` for now; consider `docs/maintainers/` in future
2. Templates: replace `admin/` with `docs/maintainers/` hubs
3. Rename `regular-project` → `standard-project`
4. Remove `migrations/` and `project-index/` from template root

## Pros / Cons
### Pros
- Clear separation of user docs vs maintainer docs
- Consistent hub‑and‑spoke navigation
- Reduced template noise for consumers

### Cons / Risks
- Link updates required
- Generator references must be updated if rename proceeds
- Consumers might rely on removed folders

## Open Questions
- Scope of move for main repo: full move vs staged? 
- Naming alternatives: `standard-project` vs others

## Next Steps
- Validate with maintainers
- Draft ADR with decision criteria and migration plan
