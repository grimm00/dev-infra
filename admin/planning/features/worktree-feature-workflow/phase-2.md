# Worktree Feature Workflow - Phase 2: Template Updates

**Phase:** 2 - Template Updates  
**Duration:** ~30 minutes  
**Status:** ✅ Complete  
**Completed:** 2026-01-09  
**Prerequisites:** Phase 1 complete

---

## 📋 Overview

Add `.sourcery.yaml` to both project templates and update the template sync manifest.

**Success Definition:** Both templates have `.sourcery.yaml` and it's tracked in sync manifest.

---

## 🎯 Goals

1. **Add to standard-project** - Create .sourcery.yaml with template-appropriate patterns
2. **Add to learning-project** - Create .sourcery.yaml with template-appropriate patterns
3. **Update sync manifest** - Add .sourcery.yaml to template-sync-manifest.txt

---

## 📝 Tasks

### Task 1: Create .sourcery.yaml for standard-project

**Purpose:** Configure Sourcery to ignore process documentation in generated projects.

**Implementation Steps:**

1. **Create the file:**
   - [x] Create `templates/standard-project/.sourcery.yaml`
   - [x] Use template-specific ignore patterns (per ADR-004)

2. **Configure ignore patterns:**
   - [x] Ignore `docs/maintainers/**` (process docs in templates)
   - [x] Ignore `tmp/**` (temporary files)

**Content to Create:**

```yaml
# Sourcery Configuration
# Ignore process documentation to focus code review on actual code
#
# Template projects use docs/maintainers/ for process docs
# (dev-infra uses admin/ instead)

ignore:
  - docs/maintainers/**   # Process docs (planning, feedback, decisions)
  - tmp/**                # Temporary files (handoff docs, scratch)
```

**Requirements Addressed:**
- FR-16: Include in Templates
- NFR-9: Template Consistency

**Checklist:**
- [x] File created at correct location
- [x] Ignore patterns match ADR-004 template section
- [x] Comment explains purpose

---

### Task 2: Create .sourcery.yaml for learning-project

**Purpose:** Same configuration for learning project template.

**Implementation Steps:**

1. **Create the file:**
   - [x] Create `templates/learning-project/.sourcery.yaml`
   - [x] Use same patterns as standard-project

**Content to Create:**

```yaml
# Sourcery Configuration
# Ignore process documentation to focus code review on actual code
#
# Template projects use docs/maintainers/ for process docs
# (dev-infra uses admin/ instead)

ignore:
  - docs/maintainers/**   # Process docs (planning, feedback, decisions)
  - tmp/**                # Temporary files (handoff docs, scratch)
```

**Requirements Addressed:**
- FR-16: Include in Templates
- NFR-9: Template Consistency

**Checklist:**
- [x] File created at correct location
- [x] Content identical to standard-project
- [x] Comment explains purpose

---

### Task 3: Update Template Sync Manifest

**Purpose:** Track `.sourcery.yaml` in sync manifest so CI validates templates stay in sync.

**Implementation Steps:**

1. **Read current manifest:**
   - [x] Check `scripts/template-sync-manifest.txt`
   - [x] Identify appropriate section for new entry

2. **Add entry:**
   - [x] Add `.sourcery.yaml` to manifest
   - [x] Add comment explaining purpose

**Content to Add:**

```txt
# Configuration files
.sourcery.yaml
```

**Location:** After the commands section, before the "Note" about different files.

**Requirements Addressed:**
- FR-17: Add to Template Sync Manifest

**Checklist:**
- [x] Entry added to manifest
- [x] Comment section added
- [x] Entry uses correct relative path

---

### Task 4: Verify Template Sync

**Purpose:** Confirm both templates are in sync and validation passes.

**Verification Steps:**

1. **Run sync validation:**
   - [x] Execute: `./scripts/validate-template-sync.sh`
   - [x] Verify: No errors for `.sourcery.yaml`

2. **Manual verification:**
   - [x] Confirm both files exist
   - [x] Confirm files are identical
   - [x] Confirm manifest includes `.sourcery.yaml`

**Commands to Run:**

```bash
# Check files exist
ls -la templates/standard-project/.sourcery.yaml
ls -la templates/learning-project/.sourcery.yaml

# Compare files (should show no differences)
diff templates/standard-project/.sourcery.yaml templates/learning-project/.sourcery.yaml

# Check manifest
grep ".sourcery.yaml" scripts/template-sync-manifest.txt

# Run sync validation
./scripts/validate-template-sync.sh
```

**Checklist:**
- [x] Both files exist
- [x] Files are identical
- [x] Manifest includes entry
- [x] Validation passes

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: standard-project .sourcery.yaml | ✅ Complete | Created with docs/maintainers/** ignore |
| Task 2: learning-project .sourcery.yaml | ✅ Complete | Identical to standard-project |
| Task 3: Update sync manifest | ✅ Complete | Added to template-sync-manifest.txt |
| Task 4: Verify template sync | ✅ Complete | Validation passes |

---

## ✅ Completion Criteria

- [x] `templates/standard-project/.sourcery.yaml` exists
- [x] `templates/learning-project/.sourcery.yaml` exists
- [x] Files have correct ignore patterns (`docs/maintainers/**`, `tmp/**`)
- [x] Files are identical between templates
- [x] `scripts/template-sync-manifest.txt` includes `.sourcery.yaml`
- [x] Template sync validation passes
- [x] Changes committed

---

## 📦 Deliverables

- `templates/standard-project/.sourcery.yaml`
- `templates/learning-project/.sourcery.yaml`
- Updated `scripts/template-sync-manifest.txt`

---

## 💡 Implementation Notes

### Template vs Dev-Infra Patterns

| Repository | Ignore Pattern | Reason |
|------------|---------------|--------|
| dev-infra | `admin/**` | Dev-infra uses `admin/` for process docs |
| Templates | `docs/maintainers/**` | Generated projects use `docs/maintainers/` |

### Why Different Patterns?

Dev-infra is the "template factory" with its own structure:
- `admin/explorations/`, `admin/research/`, `admin/decisions/`, `admin/planning/`

Generated projects use the standard template structure:
- `docs/maintainers/planning/`, `docs/maintainers/feedback/`, `docs/maintainers/decisions/`

### Sync Manifest Purpose

The sync manifest ensures shared files stay identical between templates:
- CI validates sync on every PR
- Prevents drift between templates
- Documents which files should be identical

---

## 🔗 Dependencies

### Prerequisites

- Phase 1 complete (provides dev-infra .sourcery.yaml reference)

### Blocks

- Phase 3 (Command Updates)

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 1](phase-1.md)
- [Next Phase: Phase 3](phase-3.md)
- [ADR-004: Sourcery Configuration](../../decisions/worktree-feature-workflow/adr-004-sourcery-configuration.md)
- [Template Sync Documentation](../../../../docs/TEMPLATE-SYNC.md)

---

**Last Updated:** 2026-01-09  
**Status:** ✅ Complete  
**Next:** Phase 3 (Command Updates)
