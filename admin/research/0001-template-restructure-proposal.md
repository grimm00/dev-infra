# 0001: Template Restructure Proposal (Pre‑ADR)

Status: Draft (Research‑Only)

## Motivation
Adopt hub‑and‑spoke documentation across templates and converge maintainer docs into a predictable location, improving discoverability and maintainability.

## Sources
- Internal: `docs/BEST-PRACTICES.md`
- External: `admin/notes/opportunities/external/project_docs_hub_and_spoke_playbook.md`

## Problem Statement
- Mixed audience materials under `admin/` in templates
- Extra root folders (e.g., `migrations/`, `project-index`) increase noise
- Naming of `regular-project` is ambiguous

## Options Considered
1) Keep as‑is
2) Move template maintainer docs to `docs/maintainers/` hubs (planning/decisions/feedback/archived)
3) Rename `regular-project` → `standard-project`
4) Remove non-template root folders from templates

## Evaluation Criteria
- Clarity of navigation (hub visibility)
- Consumer friendliness (surface only essential files)
- Compatibility (generator and links)
- Consistency across templates

## Snapshots
See `admin/research/structure-snapshots/*.tree.txt` for current trees.

## Proposed Direction (Pending Approval)
- Proceed with Options 2, 3, 4 in a release branch after sign‑off
- Keep main repo in `admin/` for now; re‑evaluate `docs/maintainers/` move later

## Migration Notes (Future)
- Update generator menu and template_type for renamed template
- Add redirect stubs from old locations
- Release notes callouts for removed folders

