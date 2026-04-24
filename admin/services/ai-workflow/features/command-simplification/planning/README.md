# Command Simplification - Feature Plan

**Purpose:** Remove graduation overhead, make all commands available in all templates  
**Status:** ✅ Complete  
**Created:** 2025-12-17  
**Priority:** High

---

## 📋 Quick Links

- **[Feature Plan](feature-plan.md)** - Detailed implementation plan
- **[Status](status-and-next-steps.md)** - Current progress

---

## 🎯 Overview

### The Realization

Commands in dev-infra are **guides for AI assistants**, not traditional CLI commands. They:
- Guide AI behavior through markdown instructions
- Are used only by **internal projects** (controlled by the maintainer)
- Don't need maturity gates for internal use
- Should be accessible regardless of "stability level"

### Current Problem

The graduation structure (ADR-004) adds overhead without clear benefit:
- **Experimental template exists** primarily to gate `/status` command
- **Graduation checklist** requires time-in-release cycles that don't add value
- **Template sync manifest** maintains artificial stable/experimental distinction
- **Three template types** when two would suffice (standard + learning)

### Proposed Solution

1. **All templates get ALL commands** - No more stable vs experimental distinction
2. **Dev-infra internal commands stay internal** - Release automation isn't templatized
3. **Archive graduation structure** - Deprecate ADR-004 and related docs
4. **Simplify template types** - Consider merging experimental → standard

---

## 📊 Command Classification (New)

### Template Commands (All Templates)

Commands that guide AI workflow - available to all projects:

| Command | Purpose |
|---------|---------|
| `/cursor-rules` | Update cursor rules |
| `/decision` | Create ADRs |
| `/explore` | Exploration workflow |
| `/fix-implement` | Implement fix batches |
| `/fix-plan` | Create fix plans |
| `/fix-review` | Review for fixes |
| `/int-opp` | Internal opportunity capture |
| `/post-pr` | Post-merge documentation |
| `/pr` | PR creation |
| `/pr-validation` | PR validation |
| `/pre-phase-review` | Review before implementation |
| `/reflect` | Project reflection |
| `/reflection-artifacts` | Reflection artifacts |
| `/research` | Research workflow |
| `/status` | Status tracking (currently "experimental") |
| `/task-improvement` | Task improvement |
| `/task-phase` | Phase implementation |
| `/task-release` | Release task implementation |
| `/transition-plan` | Planning from artifacts |

### Dev-Infra Only Commands

Commands specific to dev-infra's template factory role:

| Command | Purpose | Why Not Template |
|---------|---------|------------------|
| `/address-review` | Address review gaps | dev-infra review workflow |
| `/post-release` | Post-release tasks | Template release automation |
| `/release-finalize` | Finalize releases | Template release automation |
| `/release-prep` | Prepare releases | Template release automation |

---

## 🗄️ Files to Archive/Deprecate

### ADRs

| File | Action | Reason |
|------|--------|--------|
| `admin/decisions/dev-infra-identity-and-focus/adr-004-graduation-process.md` | Supersede | Graduation process no longer needed |

### Template Docs (experimental-project)

| File | Action | Reason |
|------|--------|--------|
| `templates/experimental-project/docs/STABILITY-LEVELS.md` | Remove | No longer using stability levels |
| `templates/experimental-project/docs/GRADUATION-CHECKLIST.md` | Remove | No graduation process |
| `templates/experimental-project/docs/EXPERIMENTAL.md` | Remove | No experimental distinction |

### Sync Manifest

| File | Action | Reason |
|------|--------|--------|
| `scripts/template-sync-manifest.txt` | Update | Remove stable/experimental distinction |

---

## 🤔 Decision Points

### 1. Keep experimental-project template?

**Options:**
- **A) Merge into standard-project** - One template, all commands
- **B) Keep but rename** - "extended-project" with full command set
- **C) Keep as-is** - Different README warnings but same commands

**Recommendation:** Option A - Merge into standard-project. Learning-project serves different purpose (education).

### 2. How to handle existing experimental-project users?

**Options:**
- Migration guide in release notes
- One-time sync script
- Document as "breaking change"

### 3. ADR-004 disposition?

**Options:**
- **Supersede** with new ADR explaining command philosophy
- **Archive** with note explaining why no longer applicable
- **Keep but mark deprecated**

**Recommendation:** Supersede with ADR-00X explaining commands are guides, not products

---

## 📅 Implementation Phases

### Phase 1: Planning & ADR (This Document)

- [x] Document the realization and rationale
- [ ] Create superseding ADR (ADR-00X: Commands as Guides)
- [ ] Review with stakeholder (you)

### Phase 2: Template Consolidation

- [ ] Add `/status` to standard-project template
- [ ] Update template-sync-manifest.txt
- [ ] Remove experimental-only docs from experimental-project

### Phase 3: Template Merge (Optional)

- [ ] Evaluate merging experimental → standard
- [ ] Update `new-project.sh` if merging
- [ ] Update CI validation

### Phase 4: Documentation

- [ ] Update cursor rules (main.mdc)
- [ ] Update release notes
- [ ] Archive superseded ADR

---

## 🎯 Success Criteria

- [ ] All templates have same command set (19 commands)
- [ ] Dev-infra internal commands stay internal (4 commands)
- [ ] No graduation checklist/process
- [ ] Simpler template structure (ideally 2 types: standard, learning)
- [ ] Clear documentation of "commands are guides" philosophy

---

**Last Updated:** 2025-12-17  
**Status:** ✅ Complete  
**Next:** Update CHANGELOG, create release notes

