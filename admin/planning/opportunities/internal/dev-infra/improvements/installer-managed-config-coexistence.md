# Installer Must Coexist with a Managed/Shared Cursor Config

**Source:** /discuss session — skill-corpus-installation Group 4 (2026-06-10)
**Target:** `agentic-ocean` `install.sh` (Group 4) + ADR-002 deployment contexts
**Status:** 🔴 Not Started
**Priority:** MEDIUM (gates safe install on managed/work machines; single-user v1 unaffected)
**Effort:** MEDIUM (collision-mode + `--force` guard + cutover rethink)
**Confidence:** ✅ Clear — the gap is concrete; the user has a managed config at work today.
**Created:** 2026-06-10
**Last Updated:** 2026-06-10

---

## Problem Statement

ADR-002 (and the Group 4 installer) assume `~/.cursor/` is **single-user** — yours to
fill and, at cutover, to replace. But some environments have a **managed/team Cursor
config**: a shared `~/.cursor/` with team-provided skills, rules, and commands (e.g., the
author's work machine). Installing the personal corpus there must be **additive and
non-destructive** — your skills/commands/agents are welcome to layer on, but the
installer must never modify or delete what the managed config already placed.

## What's Already Safe (no change needed)

- **Per-item symlinks** (Group 3 schema decision): the installer links each
  `~/.cursor/skills/<name>` individually, never the whole directory — so personal
  entries sit *alongside* managed ones by construction.
- **Uninstall** removes only links whose `readlink` matches the corpus entry — it cannot
  touch managed (real) files.

## Gaps (what breaks in a managed config)

1. **`collision=error` aborts instead of coexisting.** If a managed `~/.cursor/skills/commit`
   exists and the corpus also has `commit`, the installer errors and stops — so *none* of
   your non-conflicting entries install either. A managed env wants **skip-on-collision**:
   install everything that doesn't conflict, skip + warn the rest, exit success.
2. **`--force` is destructive and context-blind.** `--force` does `rm -rf` on the
   conflicting target and **cannot distinguish your stale original from a team-managed
   file**. In a managed config it could silently delete team-owned content.
3. **Group 5 cutover assumes `~/.cursor/` is yours.** The planned "remove originals,
   replace with symlinks" cutover is unsafe in a managed env — you can only *add*
   non-conflicting links, never remove what you didn't create.
4. **Rules not yet mapped.** A managed config commonly includes `~/.cursor/rules/`; the
   installer maps skills/commands/agents only. Out of current scope but relevant to "don't
   clobber the team config."

## Decision to Pin (conflict-resolution policy)

When the corpus and the managed config both define `X`:

- **(a) Managed wins** — skip yours, warn. *Safe default for "non-destructive."*
- **(b) Yours wins** — only via **explicit per-item override**, never blanket `--force`.
- **(c) Namespace** — avoid collision entirely (heavier; probably overkill for v1).

Recommended default: **(a) managed-wins / skip-on-collision**, with (b) as a deliberate,
per-item exception.

## Proposed Improvements

1. **Add a `skip-on-collision` (additive) mode** to `install.sh` — likely the default, or
   a `--skip-existing` flag; collision becomes a warn-and-continue, not an abort.
   (`agentic-ocean/install.sh`, Task 13 collision logic.)
2. **Guard `--force` against managed configs** — never blanket-`rm -rf`; require explicit
   per-item targeting for an override, and document that `--force` is unsafe against a
   managed config. (`install.sh`.)
3. **Rethink the Group 5 cutover for managed environments** — add-only; never remove
   originals you didn't create. (`tasks/05-source-install-and-multi-machine.md`.)
4. **Consider managed-config detection** — heuristic to recognize a shared `~/.cursor/`
   and auto-select additive mode. (Optional; could be explicit flag instead.)

## Likely Needs an ADR-002 Amendment

This introduces a second **deployment context** ADR-002 didn't enumerate: *single-user
`~/.cursor/`* vs *managed/shared `~/.cursor/`*. The collision/force/cutover semantics
differ by context — worth recording as an ADR-002 amendment (or a small new ADR under
skill-corpus-installation) so the installer's behavior per context is decided, not ad-hoc.

## Related

- ADR-002 (Installation & Distribution Architecture) — deployment-context gap
- `agentic-ocean/install.sh` Task 13 (`--force` = the destructive path flagged during implementation)
- Group 3 per-item-link schema decision (the additive foundation that makes coexistence possible)
- `claude-path-symlink-verification.md` — sibling deferred installer concern

---

**Last Updated:** 2026-06-10
