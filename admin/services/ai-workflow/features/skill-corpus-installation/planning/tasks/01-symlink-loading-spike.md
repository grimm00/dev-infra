# Symlink Loading Spike

**Feature:** Skill Corpus Installation (ADR-002)
**Group:** Symlink Loading Spike
**Status:** ✅ Expanded
**Last Updated:** 2026-06-09

---

## 📌 Operating Context

This group resolves **C-INST-1** before any installer is built: *does Cursor load skills through symlinks?* ADR-002 adopts a symlink farm (GNU Stow pattern) as the installation mechanism, and Topic 10 Finding 2 argues Cursor's known symlink bug (cursor/plugins#35) is in **plugin discovery**, not **skill file reading** (a different code path). That's a hypothesis, not a verified fact — so this is a **spike**: throwaway, reversible, evidence-producing. Its output is a **go/no-go** that the installer design (Groups 3–4) consumes. Nothing here ships to production; all work happens in disposable dirs + editor config and is torn down.

**Cohort:** investigation/spike — each task is *set up → observe → record*, not TDD.

---

## 📝 Tasks

### Task 1: Build a minimal symlink test fixture

**Purpose:** Create a disposable, reversible setup that symlinks a single recognizable skill from an external source dir into the editor's skill path, so Task 2 can observe discovery behavior without touching the real corpus or installed skills.

**Steps:**

1. Create a throwaway source dir, e.g. `/tmp/corpus-spike/skills/spike-probe/SKILL.md`, with a uniquely named skill (`spike-probe`) whose description/trigger is easy to recognize and invoke.
2. Note (and back up) any existing `~/.cursor/skills/spike-probe` — there should be none; never clobber a real skill.
3. Create the symlink: `ln -s /tmp/corpus-spike/skills/spike-probe ~/.cursor/skills/spike-probe`.
4. Record the exact commands + absolute paths so the fixture is reproducible and removable.
5. (Optional) Mirror the same into `~/.claude/skills/spike-probe` to test the Claude path in parallel.

**Files:**

- None in-repo. The fixture lives in `/tmp/` + editor config; commands are captured in the spike findings note (Task 3).

**Acceptance:**

- A symlink exists at the editor skill path pointing to the external source dir.
- Teardown commands recorded (`rm ~/.cursor/skills/spike-probe`, remove `/tmp/corpus-spike`).
- No existing/real skills modified or clobbered.

---

### Task 2: Verify Cursor loads the symlinked skill in a live session

**Purpose:** Get direct runtime evidence on C-INST-1 — whether Cursor's skill discovery follows symlinks — and whether live edits to the source are seen without a re-copy (the FR-DEV-1 zero-friction claim).

**Steps:**

1. Reload Cursor / start a fresh agent session so skill discovery re-scans `~/.cursor/skills/`.
2. Observe whether `spike-probe` appears as an available skill and is invocable.
3. Invoke it; confirm the `SKILL.md` content is actually read **through** the symlink.
4. Edit the source `SKILL.md` (e.g. change its description), reload, and confirm the change is reflected with no re-copy — this is the FR-DEV-1 zero-friction check.
5. Record a clear **go/no-go** with the observed behavior and the Cursor version tested.

**Files:**

- Spike findings note (created/updated in Task 3).

**Acceptance:**

- An unambiguous yes/no on symlink-based skill discovery, backed by evidence (skill invocable + live-edit reflected), or the specific failure mode documented if no-go.
- Cursor version recorded alongside the result.

---

### Task 3: Define the copy-mode fallback if symlink discovery fails

**Purpose:** Ensure the installer design (Groups 3–4) can proceed regardless of the spike outcome by deciding the installation mode now and recording it against C-INST-1.

**Steps:**

1. Author a short spike findings note (e.g. `planning/spike-c-inst-1-findings.md`) capturing the fixture, the observation, the Cursor version, and the decision.
2. **If Task 2 is go:** record symlink mode as primary; note any caveats (e.g. differences on the `~/.claude/` path, file-explorer invisibility from ADR-002 Negative consequences).
3. **If Task 2 is no-go:** specify copy-mode — installer `cp`s corpus → editor paths plus an explicit re-sync step (since edits won't be live), and note the FR-DEV-1 tradeoff and mitigations (e.g. a watch/rsync step or a `make sync` target).
4. Feed the decision into ADR-002's C-INST-1 row (resolved) for the Group 6 acceptance step.

**Files:**

- `planning/spike-c-inst-1-findings.md` (new) — the recorded outcome + decision.
- Cross-reference: `admin/services/meta/features/skill-template-separation/decisions/adr-002-installation-architecture.md` (C-INST-1).

**Acceptance:**

- A documented installation-mode decision (symlink primary, or copy fallback) with rationale, ready to feed Groups 3–4.
- C-INST-1 resolution captured so Group 6 can mark it in the ADR.

---

## 🎯 Goals

1. Resolve C-INST-1 with runtime evidence before building the symlink farm.
2. Produce a go/no-go (and a fallback) that the installer design (Groups 3–4) depends on.

---

## ✅ Completion Criteria

- [ ] Symlink loading verified in a real Cursor session (or proven not to work), with the Cursor version recorded
- [ ] Go/no-go recorded with evidence in a spike findings note
- [ ] Installation-mode decision made: symlink primary, or copy-mode fallback defined
- [ ] C-INST-1 resolution captured for ADR-002 acceptance (Group 6)

---

## 🔗 Dependencies

- None — this is the first group; everything downstream (corpus structure aside) depends on its go/no-go.

---

**Last Updated:** 2026-06-09
