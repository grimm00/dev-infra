# ADR-001: Corpus Repository Split Model (Core + Personal)

**Status:** ✅ Accepted
**Decision topic:** `skill-corpus-installation`

---

## Context

ADR-002 (skill-template-separation) establishes that the skill corpus becomes its own
versioned product installed via a symlink farm. When establishing that repo (Group 2),
a boundary question surfaced: the authored corpus at `~/.cursor/` (19 skills, 22
commands, 3 agents — see `planning/corpus-repo-reference.md`) mixes **general-purpose,
durable** tooling (e.g. `commit`, `write-plan`, `update-pr-description`) with
**context-coupled, expirable** tooling (e.g. `apprentice-*`, which is only relevant
during the author's apprenticeship; `ticket-*`, coupled to an employer's conventions).

A single corpus repo would force these together: a shareable core would accumulate
skills that mean nothing to anyone else and that expire, while a private/personal skill
couldn't be kept private separately. The multi-machine driver (the reason this feature
exists) also constrains the answer — any solution that hand-carries a subset reintroduces
the exact problem being solved.

**Interview:** Waived. The decision was deliberated live in a `/discuss` session
(2026-06-09) covering the driver (clean core + relevance/expiration), the
dependency-forced core membership of `update-pr-description`, and the graduation path.
This ADR records that deliberation in lieu of a separate interview file.

---

## Decision

> **Naming note (2026-06-09):** names updated post-acceptance — core `ai-workflow` → **`agentic-ocean`**, personal → **`agentic-ocean-personal`**, and the shared config/family namespace → **`~/.config/agentic-ocean/`** (renamed too, for consistency and to ease any future rename). `agentic-ocean` thus serves as both the core repo name and the family/config namespace.

Split the corpus into **two repositories**, both installed by the same ADR-002 installer:

1. **Core corpus** (`agentic-ocean`) — general-purpose, durable tooling. Shareable
   (public-ish), the basis for any future second consumer.
2. **Personal corpus** (`agentic-ocean-personal`) — context-coupled, expirable, or
   author-private tooling (`apprentice-*`, `ticket-*`, `capture-discussion`, …). Private.

The ADR-002 `installer.yaml` mapping is **repo-agnostic** — it already maps editor paths
to corpus subdirs, so serving two source repos is simply two mapping blocks. Both repos
get identical `git clone → install` multi-machine reproducibility; the personal repo is
private but still git-synced (not hand-carried).

**Boundary test — a skill/command/agent is CORE if either:**
- (a) it is general-purpose and durable (meaningful beyond one project/role, no natural expiration), **or**
- (b) any core skill/command/agent **depends on it**.

Otherwise it is **personal** (self-contained, context-coupled, or expirable).

**Invariant:** dependencies may point core→core or personal→(core | personal), but
**never core→personal**. A core artifact must never require something that lives only in
the personal repo.

**Immediate application:** `update-pr-description` is **core** — `group-cycle.agent.md`
(core) invokes it in its Step 3 PR-body step. Its absence from a personal-only checkout
explains observed gaps when running the agent on another machine. It satisfies both (a)
and (b).

**Graduation:** a personal skill may become core over time. Migration is a `git mv` of
the skill directory from the personal repo into the core repo plus a reinstall — the
symlink target moves, the editor path is unchanged, nothing else notices.

---

## Consequences

### Positive

- Core stays clean and meaningful — no expired/context-bound clutter; suitable for a future second consumer.
- Personal skills keep full git-based multi-machine reproducibility (private repo, not hand-carried).
- No installer changes required — two mapping blocks instead of one (ADR-002 FR-INST-2).
- Graduation is a first-class, one-command operation.
- Privacy boundary is explicit: employer/role-specific tooling never lands in a shareable repo.

### Negative

- Two repos to manage instead of one.
- The core→personal invariant needs enforcement — a "no core→personal references" check at install time (otherwise a violation hides until someone clones core-only).
- Membership is a judgment per the boundary test; borderline skills need a conscious call (mitigated by the dependency rule, which is objective).

---

## Alternatives Considered

### A: Single corpus repo (everything in `agentic-ocean`)

**Why not chosen:** Forces expirable/context-bound skills (`apprentice-*`) into a
shareable core, which rots over time, and provides no way to keep personal tooling
private. Clutter + privacy failure.

### B: Core in git, personal hand-carried / non-git

**Why not chosen:** Reintroduces the multi-machine problem this feature exists to solve
— it's ADR-002's rejected Alternative A ("copy files… no reversibility, divergence")
applied to a subset. The personal repo (Option chosen) gets the same git benefits at no
extra cost.

### C: Personal as a subdirectory of the single repo

**Why not chosen:** Can't make a subdirectory independently private, and still mixes
audiences in one repo. A second repo is the clean separation and costs only one extra
mapping block.

---

## Decision Rationale

The boundary is **principled, not arbitrary** — relevance + expiration + dependency,
not taste. This matters because skill-template-separation **ADR-001 Alternative B**
rejected a core/personal split *for templates* on the grounds that "the boundary is
arbitrary and shifts over time." That objection does not carry here: (1) this is the
**corpus** boundary, not the template boundary; (2) the criterion is objective for the
dependency case; and (3) the split *accepts* that the boundary shifts and makes the shift
a cheap one-command graduation rather than a costly migration.

---

## Requirements Impact

| Concern | Impact |
|---------|--------|
| ADR-002 FR-INST-2 (installer mapping) | **Leveraged** — multi-source mapping; two blocks, no installer change |
| Group 2 (Corpus Repository Structure) | **Shaped** — establishes two repos; core seeded with the dependency-forced set incl. `update-pr-description` |
| Group 4 (Installer Script) | **Adds** — a "no core→personal references" check at install time |
| `update-pr-description` placement | **Resolved** — core (dependency-forced) |

---

## References

- [Corpus repo reference](../planning/corpus-repo-reference.md) — inventory + boundary
- [ADR-002: Installation & Distribution Architecture](../../../../meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md)
- [skill-template-separation ADR-001](../../../../meta/features/skill-template-separation/decisions/adr-001-separation-model.md) — Alternative B (template core/personal split, rejected)
- [Implementation plan](../planning/implementation-plan.md) · [Group 2](../planning/tasks/02-corpus-repository-structure.md)

---

**Last Updated:** 2026-06-09
