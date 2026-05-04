# Research Topics — Workflow Decoupling

**Created:** 2026-05-02

---

## 📋 Topics Identified

### Topic 1: Install and Update Mechanism

**Question:** What's the simplest mechanism to install and update workflow files
(commands, skills, agents) in an existing project without introducing package
management complexity?
**Priority:** High
**Context:** The drift problem (issue #73) is the primary pain point; the mechanism
chosen here determines whether existing projects can benefit from workflow evolution.

### Topic 2: Workflow Package Boundaries

**Question:** What exactly goes in the workflow package — just `.cursor/commands/`
and `.claude/skills/`, or also `.agents/`, `.sourcery.yaml`, and other config?
**Priority:** High
**Context:** The command-vs-skill distinction is clear, but the boundary of "what
travels together" needs a definitive answer before any mechanism is built.

### Topic 3: Migration Path for Existing Projects

**Question:** How do projects created before decoupling adopt the new model — and
what happens to their existing (stale) command files?
**Priority:** Medium
**Context:** There are real projects running old snapshots; the migration experience
determines whether decoupling is retroactively useful or only helps new projects.

### Topic 4: Compatibility Contract

**Question:** What guarantees does the workflow package make about which scaffold
versions it works with, and how is that enforced?
**Priority:** Medium
**Context:** Path detection (dev-infra vs template structure) already exists in
commands/skills, but a formal compatibility contract would prevent silent breakage
when workflows or scaffolds evolve independently.

### Topic 5: Manifest Evolution

**Question:** Can `template-sync-manifest.txt` serve as the workflow package
manifest, or does decoupling require a different format?
**Priority:** Low
**Context:** The manifest already lists every synced file; understanding whether it
can be repurposed avoids building a new manifest from scratch.

---

## 🚀 Next Steps

Use `/research --from-explore workflow-decoupling` to investigate these questions.
