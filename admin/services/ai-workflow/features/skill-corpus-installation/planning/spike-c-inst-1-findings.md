# Spike Findings: C-INST-1 — Does Cursor load skills through symlinks?

**Feature:** Skill Corpus Installation
**Constraint:** C-INST-1 (ADR-002)
**Status:** ✅ Resolved — **GO**
**Cursor version tested:** 3.7.19
**Date:** 2026-06-09

---

## Decision

**Symlink-based skill discovery WORKS.** Adopt **symlink mode as the primary
installation mechanism** for the symlink farm (Groups 3–4). No copy-mode fallback
required as the default path; it is retained only as a contingency (see below).

This confirms ADR-002 Topic 10 Finding 2: Cursor's known symlink bug
([cursor/plugins#35](https://github.com/cursor/plugins/issues/35)) is in **plugin
discovery**, a different code path from **skill file reading**.

---

## Fixture

Disposable, reversible setup (lives entirely in `/tmp` + editor config):

```bash
# Source dir (throwaway)
/tmp/corpus-spike/skills/spike-probe/SKILL.md

# Symlink into the editor skill path
ln -s /tmp/corpus-spike/skills/spike-probe ~/.cursor/skills/spike-probe
```

Verified:

```
~/.cursor/skills/spike-probe -> /tmp/corpus-spike/skills/spike-probe   (readlink)
```

The real `SKILL.md` exists **only** under `/tmp/corpus-spike/...` — nothing was
copied into `~/.cursor/skills/`. No existing/real skills were modified.

The `~/.claude/` path was **not** mirrored in this spike (optional Task 1 step
skipped).

---

## Observations (evidence)

1. **Discovery through symlink:** `spike-probe` appeared in the agent's
   available-skills list in a live session, with no real file under
   `~/.cursor/skills/` to read except the symlink.
2. **Content read through symlink:** the skill body surfaced to the agent matched
   `/tmp/corpus-spike/skills/spike-probe/SKILL.md` exactly (frontmatter
   description, "What it proves" section, teardown block). Cursor is following the
   link and reading the target, not merely listing the symlink name.
3. **Invocation:** the skill was invokable via `/spike-probe`.
4. **Live-edit (FR-DEV-1) — confirmed GO.** The `description` in the `/tmp`
   source was edited to carry a sentinel (`LIVE-EDIT MARKER 2026-06-09T10:57`
   + `PURPLE-OTTER-42`). Reading back through the **symlink path**
   (`~/.cursor/skills/spike-probe/SKILL.md`, not the `/tmp` path) returned the
   edited text immediately. In a fresh editor scan, Cursor's skill picker
   surfaced the new description **including the `PURPLE-OTTER-42` sentinel**,
   with **no re-copy** — only the `/tmp` source was touched. Zero-friction
   edit→use iteration is verified.

## Caveats / not-yet-proven

- **`~/.claude/` path untested.** If the corpus must also serve the Claude path,
  it needs its own probe.
- **File-explorer invisibility** (ADR-002 Negative consequence) stands: the
  symlinked skill source is not obvious from an `ls` of `~/.cursor/skills/`.

## Contingency (if a future editor/version regresses)

Copy-mode fallback: installer `cp`s corpus → editor paths plus an explicit
re-sync step (edits won't be live), accepting the FR-DEV-1 tradeoff. Mitigate
with a watch/rsync step or a `make sync` target. Not needed for Cursor 3.7.19.

---

## Teardown

```bash
rm ~/.cursor/skills/spike-probe
rm -rf /tmp/corpus-spike
```

---

## Cross-references

- [Task: Symlink Loading Spike](tasks/01-symlink-loading-spike.md)
- [ADR-002: Installation & Distribution Architecture](../../../../meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md) — C-INST-1

**Last Updated:** 2026-06-09
