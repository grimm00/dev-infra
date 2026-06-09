# ADR-003: Per-Repo Profile Schema v1

**Status:** 🔴 Proposed
**Decision topic:** `skill-template-separation`

---

## Context

Skills currently hardcode path-detection logic, breaking when they run in repos the authors didn't anticipate. The `ticket-intake/repos/<slug>.yaml` precedent works for one skill but doesn't scale — each skill creating its own `repos/` directory leads to per-skill config sprawl. A unified profile lets all skills resolve paths from one place, enables the installer to work without hardcoding, and gives the per-repo profile a clear home in the XDG config directory.

**Requirements in scope:** FR-PROF-1, FR-PROF-2, FR-PROF-3, FR-PROF-4, FR-PROF-5, FR-PROF-6, NFR-PROF-1, NFR-PROF-2, NFR-PROF-3, C-PROF-1, C-PROF-2

---

## Decision

Adopt a **unified per-repo profile** at `~/.config/agentic-ocean/repos/<slug>.yaml` with the following v1 schema:

```yaml
schema_version: 1
repo: <name>
remote: <git remote url>
detected_from: <agents_md | history | manual>
slug: <optional override if basename collides>

ticket:
  branch_format: "{type}/{slug}"
  pr_title_format: "{type}({scope}): {ticket_id} {description}"
  commit_format: "{type}({scope}): {description}"
  default_branch: main
  type_mapping:
    Story: feat
    Bug: fix
    Chore: chore
  scopes: []
  ticket_prefix: ""

paths:
  review_artifact_root: ".scratch/reviews"
  plan_root: ".scratch/tickets/{ticket}/planning"
  scratch_root: ".scratch"

artifacts:
  location: worktree  # on-disk | worktree | in-repo
```

**Lookup precedence:** invocation flag → AGENTS.md → external profile → skill defaults.

**Slug derivation:** `basename $(git remote get-url origin) .git` with optional `slug:` override field.

**Symlinked to editor:** `~/.config/agentic-ocean/repos/` is symlinked to `~/.cursor/repos/` by the installer (ADR-002) for editor compatibility.

---

## Consequences

### Positive

- Skills resolve paths from one file — no more per-skill `repos/` directories
- Human-editable YAML with inline comments explaining each section
- Additive schema: new sections added without version bumps (NFR-PROF-2)
- Backwards-compatible: reads unified profile first, falls back to `ticket-intake/repos/` (FR-PROF-6)
- Fast: single file read + YAML parse, < 100ms (NFR-PROF-1)
- Controller state separated from user-editable config (C-PROF-2)

### Negative

- Migration needed for 5 existing `ticket-intake/repos/*.yaml` files (low effort, backwards-compat fallback means no urgency)
- Skills that currently hardcode paths need updates to consult the lookup chain (the `skills-path-roots-configurable` int-opp)
- The `artifacts:` section schema depends on deferred Topics 8-9 — v1 ships with `location` field only, expanded later

---

## Alternatives Considered

### A: Per-skill `repos/` directories (current pattern)

Each skill that wants per-repo config creates `~/.cursor/skills/<skill>/repos/<slug>.yaml`.

**Why not chosen:** Doesn't scale. Five skills wanting repo config = five places to configure the same repo. Users can't discover where config lives. Cross-skill defaults (scratch root) get duplicated.

### B: In-repo config only (`.cursor/profile.yaml`)

Configuration committed to each repo, shared with collaborators.

**Why not chosen:** Can't store personal workflow preferences (ticket conventions, artifact paths) in a shared repo without polluting it. The profile carries user-specific operational preferences — it belongs external to the repo. AGENTS.md handles the shared concerns (build commands, architecture, conventions).

### C: `~/.cursor/repos/<slug>.yaml` without XDG (pragmatic v1)

Profile directly at Cursor-specific path, no XDG intermediary.

**Why not chosen (now):** Topic 2 originally recommended this as pragmatic v1, but Theme 10 (XDG correction) clarified that profiles ARE config and belong at `~/.config/`. The installer symlinks to `~/.cursor/repos/` for compatibility — no migration needed later because the canonical location is correct from day one.

---

## Decision Rationale

Interview waived — proceeding from research findings. The decision is backed by:
- Topic 2 Finding 1: two-location pattern is universal (in-repo + external)
- Topic 2 Finding 4: basename slug is sufficient for a single user
- Topic 2 Finding 5: mise's hierarchical config model is instructive
- Topic 2 Finding 6: simple integer schema version is sufficient
- Topic 2 Finding 7: ticket-intake precedent provides the v1 schema seed
- Theme 10: profiles are config → `~/.config/` is the correct home
- `per-repo-skill-profile-unified.md` int-opp: proposed shape validated by research

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-PROF-1 | **Fulfilled** — profile at `~/.config/agentic-ocean/repos/<slug>.yaml`, symlinked to editor path |
| FR-PROF-2 | **Fulfilled** — `schema_version: 1` |
| FR-PROF-3 | **Fulfilled** — ticket, paths, artifacts sections |
| FR-PROF-4 | **Fulfilled** — lookup chain defined (flag → AGENTS.md → profile → defaults) |
| FR-PROF-5 | **Fulfilled** — `slug:` override field |
| FR-PROF-6 | **Activated** — backwards-compat migration task for ticket-intake |
| C-PROF-1 | **Fulfilled** — XDG is primary, `~/.cursor/repos/` is symlink target |
| C-PROF-2 | **Fulfilled** — controller state in separate `_state:` section or file |

---

## References

> Research artifacts (per-topic findings, requirements, exploration) live on the
> `docs/skill-template-separation-research` branch. In-repo links below may not
> resolve on develop until the corpus installation work is landed.

- [Research: Per-Repo Profile Location and Schema](../research/research-per-repo-profile-location-and-schema.md)
- [Int-opp: per-repo-skill-profile-unified.md](../../../../planning/opportunities/internal/dev-infra/improvements/per-repo-skill-profile-unified.md)
- [Int-opp: skills-path-roots-configurable.md](../../../../planning/opportunities/internal/dev-infra/improvements/skills-path-roots-configurable.md)
- [Requirements (Final)](../research/requirements.md)
