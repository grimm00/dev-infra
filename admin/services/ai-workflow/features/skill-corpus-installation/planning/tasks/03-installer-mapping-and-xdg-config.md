# Installer Mapping & XDG Config

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Installer Mapping & XDG Config
**Status:** 🟠 In Progress (Tasks 8–9 ✅; Task 10 — config-vs-corpus doc — remains)
**Last Updated:** 2026-06-09

---

## 📌 Operating Context

Group 3 defines **how** the installer knows what to link where — the declarative
`installer.yaml` mapping — and stands up the XDG config home that holds it. It does
**not** build `install.sh` (that's Group 4); it produces the contract Group 4 consumes.

**Inputs settled:** symlink mode (C-INST-1 GO); two source repos (ADR-001), each with
payload under **`corpus/`** (`corpus/{skills,commands,agents}/`); config/family
namespace = `agentic-ocean` → `~/.config/agentic-ocean/`.

**Cohort:** schema/config design + docs (not TDD; the schema is exercised by Group 4's
Bats tests, not here).

---

## 📝 Tasks

### Task 8: Define the `installer.yaml` multi-source mapping schema

**Purpose:** A declarative, human-editable mapping so the installer hardcodes nothing
and can serve **two** source repos (core + personal) — and N editors later.

**Steps:**

1. Design the schema — a `sources` list, each source = a repo's `corpus/` root plus
   per-kind editor targets. Proposed shape:
   ```yaml
   schema_version: 1
   sources:
     - name: agentic-ocean            # core
       root: ~/Projects/agentic-ocean/corpus
       links:
         skills:   ~/.cursor/skills
         commands: ~/.cursor/commands
         agents:   ~/.cursor/agents
     - name: agentic-ocean-personal   # personal
       root: ~/Projects/agentic-ocean-personal/corpus
       links:
         skills:   ~/.cursor/skills
         commands: ~/.cursor/commands
         agents:   ~/.cursor/agents
   ```
2. Decide **link granularity = per-item under each kind** (matches the spike): for each
   source × kind, symlink each *entry* (`corpus/skills/<name>`) into the editor target
   dir (`~/.cursor/skills/<name>`). This is what lets *both* repos populate the same
   `~/.cursor/skills/` without replacing the directory.
3. Define **collision semantics:** if two sources expose the same entry name into the
   same target, **error** (don't silently clobber). The ADR-001 boundary should prevent
   core/personal name clashes; the installer surfaces violations instead of hiding them.
4. Map from `<repo>/corpus/<kind>/` (the 2026-06-09 payload root), never the repo root.
5. Document the schema (fields, granularity, collision rule, `schema_version`).

**Files:**
- Schema doc in the **core repo** (e.g. `agentic-ocean/docs/installer-schema.md` or a README section).
- An example `installer.yaml` shipped in the core repo for new machines to copy.

**Acceptance:**
- Schema supports ≥2 sources and per-item linking under each kind.
- Collision behavior defined (error, not clobber).
- Maps from `corpus/`, editor targets parameterized (not hardcoded in install.sh).
- Example `installer.yaml` is valid YAML and documented.

---

### Task 9: Establish `~/.config/agentic-ocean/` config home + real mapping

**Purpose:** Create the XDG config home and the **actual** `installer.yaml` this machine
uses, separate from the corpus project(s).

**Steps:**

1. Create `~/.config/agentic-ocean/` (honor `$XDG_CONFIG_HOME`, default `~/.config`).
2. Author the real `installer.yaml` there with the two live sources (core + personal
   `corpus/` roots) → `~/.cursor/{skills,commands,agents}`.
3. Document the lookup the installer will use: `$XDG_CONFIG_HOME/agentic-ocean/installer.yaml`
   then `~/.config/agentic-ocean/installer.yaml`.
4. Reserve `~/.config/agentic-ocean/repos/` for ADR-003 per-repo profiles (out of scope;
   just note the slot).

**Files:**
- `~/.config/agentic-ocean/installer.yaml` (real, this machine).
- Example copy in the core repo (from Task 8) as the new-machine starting point.

**Acceptance:**
- `~/.config/agentic-ocean/installer.yaml` exists, valid, maps both repos' `corpus/` → editor paths.
- Lookup order documented; `repos/` slot noted for ADR-003.

---

### Task 10: Document XDG config vs corpus-project separation

**Purpose:** Make Theme 10 explicit for maintainers and any second consumer — config is
config, corpus is a project; the installer bridges them.

**Steps:**

1. Outline the separation: config (`~/.config/agentic-ocean/`, machine-specific paths/mapping)
   vs corpus (`~/Projects/agentic-ocean/`, the versioned content).
2. Explain why: the mapping is per-machine (paths differ across machines/editors); the
   corpus is shared/versioned. That's why `installer.yaml` lives in XDG config, not in the repo.
3. Link from the core repo README / install docs; verify the reference reads correctly.

**Files:**
- Core repo docs (install/README section).
- Cross-link to ADR-002 (Theme 10) + this feature.

**Acceptance:**
- Doc explains config-vs-corpus separation and where each lives.
- Cross-linked; reads cleanly.

---

## 🎯 Goals

1. A declarative, human-editable, **multi-source** mapping drives installation (no hardcoded paths).
2. Config lives at the XDG-correct location (`~/.config/agentic-ocean/`), separate from the corpus.

---

## ✅ Completion Criteria

- [x] `installer.yaml` schema defined + documented (multi-source, per-item, collision=error, maps from `corpus/`) — `agentic-ocean/docs/installer-schema.md` + `installer.example.yaml` (`aec198d`)
- [x] `~/.config/agentic-ocean/installer.yaml` established with both live sources (validated; roots resolve); `repos/` slot reserved; lookup order documented in the schema doc
- [ ] Config-vs-corpus separation documented + cross-linked

---

## 🔗 Dependencies

- Group 2 ✅ — mapping targets the `corpus/{skills,commands,agents}/` payload defined there (both repos live).
- Group 1 ✅ — symlink mode (the mapping assumes symlinks; copy-mode is the documented contingency).
- Feeds Group 4 — `install.sh` reads this `installer.yaml` and enforces the core→personal check.

---

**Last Updated:** 2026-06-09
