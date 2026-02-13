# Release Notes - v0.9.0

**Version:** v0.9.0
**Release Date:** 2026-02-13
**Status:** ✅ Final

---

## 🎉 Highlights

v0.9.0 introduces **4 new workflow commands** and **major template infrastructure improvements**. The new commands strengthen the discovery-to-implementation pipeline: `/spike` validates risky assumptions with time-boxed experiments, `/review` + `/commit` force deliberate human review of agentic code changes, and `/handoff` captures session context for continuity. The `/explore` command gains a two-mode pattern with human review checkpoints, and 17 new doc-gen templates provide consistent document generation across all workflow stages.

**Total commands:** 23 (up from 19 in v0.8.0)

---

## ✨ New Features

### Spike Workflow (`/spike`)

Time-boxed technical experiments (2-4 hours) to validate high-risk assumptions before committing to full implementation or research. Produces throwaway prototype code and a learnings document.

**When to use:** When a technical question has high uncertainty and would be expensive to get wrong.

```bash
/spike auth-token-refresh --from-explore auth-system
```

**Integration:** `/explore` now includes spike determination tables that flag HIGH-risk topics for spiking before research.

### Review-then-Commit Workflow (`/review` + `/commit`)

A two-command workflow that forces a deliberate pause between "AI wrote code" and "code is committed." This is the single most impactful workflow pattern for AI-assisted development.

```bash
/review auth-token-refresh    # Stage, capture diff, draft message, STOP
# ... human reviews diff and summary ...
/commit                       # Commit with reviewed message, clean up
```

**Integration:** `/task-phase`, `/fix-implement`, `/task-release`, and `/task-improvement` now recommend `/review` for code changes.

### Handoff Command (`/handoff`)

Session continuity for AI-assisted development. Captures current work state, what was done, what's left, and how to continue.

```bash
/handoff "finished auth endpoints, need to add tests"
/handoff --resume   # In next session: restore context
```

### Explore Two-Mode Pattern (`/explore`)

Reorganized into Setup Mode (scaffolding for human review, ~60-80 lines) and Conduct Mode (full exploration, ~200-300 lines) with an explicit human checkpoint between them.

**Input sources:** Raw text (`--input`), start.txt (`--from-start`), reflections (`--from-reflect`).

**Worktree integration:** Conduct mode prompts for worktree creation, keeping explorations self-contained on feature branches.

### Template-Doc-Infrastructure

Complete document generation infrastructure with 17 templates, placeholder specifications, authoring guides, and type-specific validation rules.

- **FORMAT.md** - Placeholder specification (`{{variable}}`, `{{#section}}...{{/section}}`)
- **VARIABLES.md** - Variable reference for all template types
- **AUTHORING.md** - Template authoring guide with two-mode pattern docs
- **VALIDATION.md** - Common validation rules + type-specific YAML rules

---

## 🔧 Improvements

- **Sourcery configuration** - `.cursor/**` and `docs/**` ignored in dev-infra; `.cursor/**` ignored in templates. Focuses code reviews on actual code assets.
- **Template sync manifest** - Updated to 23 commands (from 19) to include all new commands.
- **Doc-gen template enhancements** - Exploration, research, and decision templates enhanced with structural examples and variable documentation.

---

## ⚠️ Breaking Changes

None in this release. All changes are additive.

---

## 🔄 Migration Guide

No migration required. New commands are available immediately in generated projects via template sync.

**To add new commands to existing projects:**

Copy from templates:
```bash
cp templates/standard-project/.cursor/commands/{spike,review,commit,handoff}.md \
   your-project/.cursor/commands/
```

---

## 📊 Statistics

| Metric | Value |
|--------|-------|
| PRs Merged | 3 |
| New Commands | 4 (/spike, /review, /commit, /handoff) |
| Total Commands | 23 |
| New Doc-Gen Templates | 17 |
| Files Changed | 100+ |

---

## 🔗 Related

- **v0.8.0** - Worktree Feature Workflow (draft PRs, self-contained branches)
- **Workflow Simplification Exploration** - In progress on `feat/workflow-simplification` (targeting v0.10.0+)

---

**Full Changelog:** [v0.8.0...v0.9.0](https://github.com/grimm00/dev-infra/compare/v0.8.0...v0.9.0)
