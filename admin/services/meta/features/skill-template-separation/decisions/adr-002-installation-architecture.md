# ADR-002: Installation & Distribution Architecture

**Status:** 🔴 Proposed
**Decision topic:** `skill-template-separation`

---

## Context

With the corpus living in its own repo (ADR-001), skills need a mechanism to appear at editor-specific paths (`~/.cursor/skills/`, etc.) without manual copying. The author needs zero-friction iteration (edit → use immediately). Future consumers need versioned distribution. The multi-machine story must work (clone repo on new machine → one command → working).

**Requirements in scope:** FR-INST-1, FR-INST-2, FR-INST-3, FR-INST-4, FR-INST-5, FR-INST-6, FR-DEV-1, FR-DIST-1, FR-DIST-2, NFR-INST-1, NFR-INST-2, C-INST-1, C-DEV-1

---

## Decision

Adopt a **symlink farm** (GNU Stow pattern) as the installation mechanism:

1. **Corpus** lives at a normal project directory (e.g., `~/Projects/ai-workflow/`)
2. **Config** (installer mapping, per-repo profiles) lives at `~/.config/ai-workflow/`
3. **Installer** reads mapping from config, creates symlinks from editor paths → corpus
4. **Three-tier distribution:**
   - Tier 1 (Author): symlinks from editor paths to local corpus repo — zero-friction iteration
   - Tier 2 (Source install): `git clone` + `./install.sh` — one command for a second dev
   - Tier 3 (Plugin publish): Cursor/Claude plugin marketplace — deferred until external audience exists

---

## Consequences

### Positive

- Zero-step iteration: edit a skill file, next AI invocation sees the change (FR-DEV-1)
- Multi-editor ready from day one: adding Claude Code = adding a mapping block, not migrating data
- Reversible: `stow -D` (or script equivalent) removes all symlinks without touching the corpus
- Idempotent: running the installer twice produces the same result
- Self-contained: the repo carries its own install script (tier-2 ready immediately)
- XDG-compliant: config is config, corpus is a project — correct semantics

### Negative

- Cursor has a known symlink bug for plugins (C-INST-1) — but skills use a different code path; the C-INST-1 spike confirmed Cursor 3.7.19 discovers and reads skills through symlinks (GO)
- Adds a one-time setup step on new machines (clone + install) vs. the current "files just exist" state
- Symlinks are invisible in file explorers — can confuse users who `ls` and see files but can't find the "real" source

---

## Alternatives Considered

### A: Copy files to editor paths (current ad-hoc state)

Manual or scripted `cp -R` from the corpus to `~/.cursor/skills/` etc.

**Why not chosen:** Breaks FR-DEV-1 (zero-friction). Every edit requires a re-copy. Creates divergence between source and installed version. No reversibility.

### B: Cursor plugin system only (no symlinks)

Package the corpus as a Cursor plugin installed via `~/.cursor/plugins/local/`.

**Why not chosen:** Cursor has confirmed symlink bugs in plugin discovery (cursor/plugins#35). The workaround (copy on every change) violates FR-DEV-1. Plugins add manifest overhead that's premature for a sole author. However, this IS the correct tier-3 mechanism — it's additive when needed (FR-DIST-1, FR-DIST-2).

### C: XDG as canonical with no symlinks (direct reads from `~/.config/`)

Skills live at `~/.config/ai-workflow/skills/` and editors read from there directly.

**Why not chosen:** Editors expect specific paths (`~/.cursor/skills/`). XDG `~/.config/` is for config, not application source code (Theme 10 correction). And editors can't be told to look elsewhere without symlinks or plugins.

---

## Decision Rationale

Interview waived — proceeding from research findings. The decision is backed by:
- Topic 10 Finding 1: GNU Stow proves the pattern (25+ years, stateless, reversible)
- Topic 10 Finding 2: Cursor's symlink bug is in plugin discovery, not skill file reading (different code path)
- Topic 11 Finding 2: AI skill testing is impractical — usage-as-testing requires zero-friction edit cycle
- Topic 11 Finding 5: transition trigger is "second consumer" — plugin publish deferred until then
- Theme 10: XDG correction separates config from corpus — installer bridges them
- Theme 11: three-tier model provides natural graduation without rework

---

## Requirements Impact

| Requirement | Impact |
|-------------|--------|
| FR-INST-1 | **Fulfilled** — symlink-based, with copy fallback if needed |
| FR-INST-2 | **Fulfilled** — mapping in `~/.config/ai-workflow/installer.yaml` |
| FR-INST-3 | **Fulfilled** — uninstall = remove symlinks |
| FR-INST-4 | **Fulfilled** — config at XDG, corpus at project path |
| FR-INST-5 | **Fulfilled** — repo carries install script |
| FR-INST-6 | **Fulfilled** — installer reads from XDG config |
| FR-DEV-1 | **Fulfilled** — symlinks = zero-step iteration |
| FR-DIST-1 | **Deferred** — plugin publish additive when needed |
| FR-DIST-2 | **Deferred** — Cursor/Claude plugin system used at tier 3 |
| C-INST-1 | **Resolved (GO)** — Cursor 3.7.19 loads skills via symlinks; symlink mode primary. See [spike findings](../../../../ai-workflow/features/skill-corpus-installation/planning/spike-c-inst-1-findings.md) |

---

## References

> Research artifacts (per-topic findings, requirements, exploration) live on the
> `docs/skill-template-separation-research` branch. In-repo links below may not
> resolve on develop until the corpus installation work is landed.

- [Research: Symlink-Based Installation](../research/topic-10-symlink-based-installation.md)
- [Research: Dev Mode vs. Distribution Mode](../research/topic-11-dev-mode-vs-distribution-mode.md)
- [Research: Per-Repo Profile Location and Schema](../research/research-per-repo-profile-location-and-schema.md)
- [Requirements (Final)](../research/requirements.md)
- GNU Stow manual: https://www.gnu.org/software/stow/manual/stow.html
- Cursor symlink bug: https://github.com/cursor/plugins/issues/35
