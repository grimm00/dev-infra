# Research: Symlink-Based Installation — Feasibility and Editor Compatibility

**Status:** ✅ Complete
**Priority:** Medium
**Created:** 2026-05-07
**Completed:** 2026-05-07

---

## Research Question

Can a symlink-based installer (GNU Stow pattern) bridge the canonical XDG package location and editor-specific expected paths, and do Cursor's known symlink handling bugs affect skill/config file loading specifically?

---

## Research Goals

- [x] Confirm GNU Stow pattern viability for this use case (canonical source → symlinked targets)
- [x] Identify known symlink handling issues in Cursor, Claude Code, and related tools
- [x] Determine whether skill files (markdown read by AI) vs. plugins (loaded by editor runtime) use different code paths
- [x] Assess whether directory-level or file-level symlinks are needed
- [x] Identify the installer's responsibility boundary (what it knows, what it doesn't)

---

## Methodology

**Queries executed:**
1. "GNU stow symlink farm package manager pattern dotfiles installation 2025 2026"
2. "symlink-based plugin installation pattern CLI tools editor plugins canonical location 2025 2026"

**Internal sources consulted:**
- Topic 2 findings (profile location, XDG vs. `~/.cursor/`)
- Skill-package-controller exploration Theme 5 (platform convergence, XDG)
- Existing `~/.cursor/skills/` directory structure

---

## Sources

- [x] GNU Stow manual — symlink farm mechanics, tree folding, adoption
- [x] GNU Stow dotfiles guides (msleigh.io, penkin.me) — real-world usage patterns
- [x] GitHub: cursor/plugins#35 — Cursor fails to load symlinked local plugins
- [x] GitHub: openai/codex#18863 — Codex plugin cache silently drops symlinks
- [x] GitHub: anthropics/claude-code#29671 — Claude Code absolute paths break across machines
- [x] GitHub: anomalyco/opencode#23312 — XDG symlink path failures

---

## Findings

### Finding 1: GNU Stow Is the Canonical Prior Art

**Source:** GNU Stow manual (gnu.org/software/stow), Web search: "GNU stow symlink farm"
**Relevance:** GNU Stow (25+ years in production) implements exactly the pattern proposed: packages live in a "stow directory" and appear installed in a "target directory" via symlinks.

Key mechanics:
- **Tree folding:** When no conflicts exist, Stow creates a single symlink to an entire subtree rather than individual file links. When a second package needs the same directory, it "unfolds" into individual links.
- **Stateless:** Stow stores no persistent state between runs — it reads the current symlink state and reconciles.
- **Reversible:** `stow -D <package>` removes all symlinks cleanly.
- **Adopt mode:** `stow --adopt` moves existing files into the package directory and replaces them with symlinks — useful for migrating existing `~/.cursor/skills/` into the canonical location.

**Implication:** The installer can literally be GNU Stow (or a purpose-built equivalent). The command to install: `stow -t ~/.cursor -d ~/.config/ai-workflow skills repos commands agents`. Uninstall: `stow -D -t ~/.cursor -d ~/.config/ai-workflow skills repos commands agents`.

### Finding 2: Cursor Has Symlink Bugs for Plugins, But Skills Aren't Plugins

**Source:** GitHub: cursor/plugins#35 — "Bug Report: Local plugins with symlinks don't load in Cursor"
**Relevance:** Cursor's extension discovery uses `Dirent.isDirectory()` which returns `false` for symlinks pointing to directories. This causes symlinked plugin directories under `~/.cursor/plugins/local/` to be silently skipped during discovery.

However, **skills are not plugins**. Skills are `.md` files read by the AI model at prompt time via the `available_skills` system. The model receives skill paths from the IDE's rule/skill discovery system and reads them via standard file I/O. The question is whether Cursor's skill discovery (`~/.cursor/skills/`) uses the same `Dirent.isDirectory()` pattern or standard `fs.readdir` + `fs.readFile` which follows symlinks transparently.

**Implication:** The plugin bug is real but likely irrelevant for skills. Standard Node.js `fs.readFile()` follows symlinks by default. A quick spike (create one symlinked skill, invoke it) would confirm definitively.

### Finding 3: Codex and Claude Code Also Have Symlink Issues

**Source:** GitHub: openai/codex#18863, anthropics/claude-code#29671
**Relevance:** 
- Codex's `copy_dir_recursive()` handles only directories and regular files — no `is_symlink()` branch — so symlinks are silently dropped during plugin cache installation.
- Claude Code stores absolute paths in `installed_plugins.json`, which break when shared across machines (a problem symlinks could solve but the implementation doesn't support).

**Implication:** These are plugin/package-manager bugs, not file-reading bugs. AI skill files are read as plain text, not loaded as executable plugins. The distinction matters: the installer creates symlinks that look like regular files to anything that reads them (which is how symlinks work at the POSIX level). Only code that explicitly checks `lstat()` or `Dirent.isSymbolicLink()` would notice.

### Finding 4: The Installer's Responsibility Boundary Is Narrow

**Source:** Analysis of GNU Stow model applied to this context
**Relevance:** The installer's knowledge is minimal:

```yaml
# Installer mapping table — the only editor-specific knowledge
cursor:
  skills: ~/.cursor/skills/
  commands: ~/.cursor/commands/
  agents: ~/.cursor/agents/
  repos: ~/.cursor/repos/
  hooks: ~/.cursor/hooks/

# Future editors just add blocks:
# claude-code:
#   skills: ~/.claude/skills/
#   ...
```

The installer:
- **Knows:** which editor expects what at which path (the mapping table above)
- **Does NOT know:** skill schemas, YAML shapes, profile fields, what skills do
- **Operation:** for each entry in the mapping, ensure a symlink exists from the editor path to the canonical location

This means the installer is trivially extensible — supporting a new editor is adding 3-5 lines to a config file, not understanding the package's internals.

### Finding 5: File-Level vs. Directory-Level Symlinks

**Source:** GNU Stow tree folding behavior; Cursor symlink bug analysis
**Relevance:** Two approaches:

| Approach | Pros | Cons |
|----------|------|------|
| Directory symlinks (`~/.cursor/skills/ → canonical/skills/`) | Simplest, one link per category | May hit `isDirectory()` bugs if Cursor checks top-level dirs |
| File/subtree symlinks (`~/.cursor/skills/explore/ → canonical/skills/explore/`) | More granular, avoids top-level dir check | More symlinks to manage, tree folding helps |
| Hybrid: real dirs, symlinked contents | Most compatible, bypasses all dir-check bugs | Slightly more complex, but trivial with Stow |

**Recommendation:** Start with directory-level symlinks (simplest). If Cursor's skill discovery has the same `isDirectory()` bug as plugin discovery, fall back to the hybrid (real `~/.cursor/skills/` directory containing symlinked skill subdirectories). GNU Stow's tree folding handles this automatically.

---

## Analysis

The symlink-based installer pattern is **viable and well-proven**. GNU Stow has managed exactly this pattern for 25+ years in the dotfiles community. The specific concern — Cursor's symlink bugs — applies to plugin loading (`~/.cursor/plugins/`) but almost certainly not to skill reading (`~/.cursor/skills/`), because:

1. Skills are markdown files read via standard `fs.readFile()` which follows symlinks transparently
2. The bug is in `Dirent.isDirectory()` checks during directory enumeration for plugin discovery — a different code path
3. Even if the same bug exists in skill discovery, the hybrid approach (real parent dir, symlinked children) bypasses it

The pattern cleanly separates:
- **Package** (canonical at XDG location) — owns the data
- **Installer** (knows editor mappings) — creates symlinks
- **Editor** (reads from expected paths) — doesn't know about symlinks

This makes the architecture multi-editor-ready from day one without requiring multi-editor *support* on day one.

---

## Recommendations

- [x] Adopt the GNU Stow pattern for skill/command/agent/config installation
- [ ] Canonical package location: `~/.config/ai-workflow/` (XDG-compliant, editor-agnostic)
- [ ] Installer mapping: YAML/TOML config file listing editor → path mappings
- [ ] Start with directory-level symlinks; fall back to hybrid if skill discovery has the `isDirectory()` bug
- [ ] Spike: create `~/.cursor/skills/test-symlink/` as a symlink to a canonical location, invoke the skill, confirm it loads — this is < 5 minutes of work and fully de-risks the approach
- [ ] Consider `stow --adopt` for initial migration: moves existing `~/.cursor/skills/` contents into canonical location and replaces with symlinks in one operation

---

## Requirements Discovered

**FR-INST-1:** The installer MUST create symlinks from editor-specific expected paths to the canonical package location, not copy files.

**FR-INST-2:** The installer MUST support a mapping configuration that defines per-editor path expectations (adding a new editor = adding config, not code).

**FR-INST-3:** The installer MUST support uninstallation (removing all symlinks) without affecting the canonical package.

**FR-INST-4:** The canonical package location SHOULD follow XDG conventions (`~/.config/ai-workflow/` for config, `~/.local/share/ai-workflow/` for data).

**NFR-INST-1:** Installation/uninstallation MUST be idempotent — running twice produces the same result as running once.

**NFR-INST-2:** The installer MUST NOT require knowledge of skill schemas, profile shapes, or package internals — it operates purely on filesystem paths.

**C-INST-1:** If Cursor's skill discovery has the same `isDirectory()` bug as plugin discovery, file-level or subtree-level symlinks MUST be used instead of directory-level.

---

## Next Steps

- Spike: test symlinked skill directory in Cursor to confirm loading works (< 5 min)
- If confirmed, the installer can be as simple as a `stow` invocation with the right flags
- Feeds back into Topic 3 (ownership model) — if the package lives at `~/.config/ai-workflow/`, it's clearly independent of dev-infra's repo structure
- Feeds back into Topic 4 (bundling strategy) — templates don't bundle skills because the installer handles distribution
