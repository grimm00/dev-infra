# Phase 3: Template Integration ❌ DEFERRED

**Phase:** 3 of 3  
**Status:** ⏸️ Deferred  
**Priority:** ~~🟡 Medium~~ → Deferred  
**Effort:** ~~8-13 hours (1-2 days)~~ → N/A for v1.5.0  
**Dependencies:** Phase 1 & 2 recommended (includes their outputs)

---

## ⏸️ Deferral Notice

**Decision:** [ADR-002: Release Automation v2 Scope](../../../decisions/dev-infra-identity-and-focus/adr-002-release-automation-v2-scope.md)

**Reason:** This phase conflicts with the template factory identity (ADR-001). Release automation is internal tooling that should not be automatically templatized.

**Reconsideration:** v1.6.0+ after meeting graduation criteria:
- [ ] ≥1 release cycle in dev-infra
- [ ] No major changes in 2+ weeks
- [ ] Documentation 100% complete
- [ ] Demonstrated user need

**Original scope preserved below for future reference.**

---

## 🎯 Goal

Integrate release automation scripts and commands into the standard-project template so that generated projects can use the complete release workflow out of the box.

---

## 📋 Current State

- Release automation only exists in dev-infra
- Generated projects have no release automation
- Templates don't include release scripts or commands
- Projects must build release automation from scratch

---

## 🎯 Target State

- Standard-project template includes release scripts
- Template includes release commands
- Path detection works for template structure
- Generated projects can run full release workflow
- Template validation tests cover release components

---

## 📅 Sub-Phases

### Sub-Phase 3.1: Script Integration (2-3 hours)

**Goal:** Add release scripts to template

**Tasks:**

- [ ] Copy scripts to template `scripts/`:
  - `check-release-readiness.sh`
  - `create-release-branch.sh`
  - `analyze-releases.sh`
  - `update-version-references.sh` (from Phase 2)

- [ ] Update script paths for template structure:
  - `admin/planning/releases/` → `docs/maintainers/planning/releases/`
  - Other path references

- [ ] Make scripts executable in template

- [ ] Test scripts work in template context

**File Locations:**
```
templates/standard-project/
├── scripts/
│   ├── check-release-readiness.sh
│   ├── create-release-branch.sh
│   ├── analyze-releases.sh
│   └── update-version-references.sh
```

---

### Sub-Phase 3.2: Command Integration (2-3 hours)

**Goal:** Add release commands to template

**Tasks:**

- [ ] Copy commands to template `.cursor/commands/`:
  - `release-prep.md`
  - `release-finalize.md`
  - `post-release.md`

- [ ] Update command path detection:
  - Support both dev-infra and template paths
  - Add path detection logic
  - Document path patterns

- [ ] Add command README or index

- [ ] Test commands work in template context

**File Locations:**
```
templates/standard-project/
├── .cursor/
│   └── commands/
│       ├── release-prep.md
│       ├── release-finalize.md
│       └── post-release.md
```

---

### Sub-Phase 3.3: Test in Generated Project (2-3 hours)

**Goal:** Validate full workflow in generated project

**Tasks:**

- [ ] Generate new test project from template
- [ ] Run complete release workflow:
  - `/release-prep v0.1.0`
  - `/release-finalize v0.1.0`
  - Create release PR
  - (Mock merge and tag)
  - `/post-release v0.1.0`

- [ ] Document any issues found
- [ ] Fix issues and re-test
- [ ] Confirm end-to-end success

**Test Project:**
```bash
./scripts/new-project.sh test-release-automation --template standard-project
cd test-release-automation
# Run release workflow
```

---

### Sub-Phase 3.4: Documentation (1-2 hours)

**Goal:** Document release automation in templates

**Tasks:**

- [ ] Update template README with release automation section
- [ ] Create release automation guide:
  - `docs/RELEASE-AUTOMATION.md` in template
  - Explain commands and workflow
  - Show example release cycle

- [ ] Update `docs/TEMPLATE-USAGE.md` in dev-infra
- [ ] Add release automation to template features list

**Documentation Location:**
```
templates/standard-project/
├── docs/
│   └── RELEASE-AUTOMATION.md  # New file
├── README.md                   # Update with release section
```

---

### Sub-Phase 3.5: Validation Tests (1-2 hours)

**Goal:** Add template validation for release components

**Tasks:**

- [ ] Add tests to `tests/unit/new-project.bats`:
  - Script files exist
  - Scripts are executable
  - Command files exist
  - Command files are valid markdown

- [ ] Update `scripts/validate-templates.sh`:
  - Check release scripts present
  - Check release commands present
  - Check paths are correct

- [ ] Run validation and fix any issues

**Test Examples:**
```bash
@test "template includes release scripts" {
    [ -f "$TEMPLATE_DIR/scripts/check-release-readiness.sh" ]
    [ -x "$TEMPLATE_DIR/scripts/check-release-readiness.sh" ]
}

@test "template includes release commands" {
    [ -f "$TEMPLATE_DIR/.cursor/commands/release-prep.md" ]
}
```

---

## ✅ Definition of Done

- [ ] Scripts added to standard-project template
- [ ] Commands added to template
- [ ] Path detection works for template structure
- [ ] Full workflow tested in generated project
- [ ] Documentation created
- [ ] Validation tests pass
- [ ] Template generation still works
- [ ] All existing template tests pass

---

## 🚨 Risks & Mitigations

### Risk: Path Detection Complexity

**Risk:** Commands may have hardcoded dev-infra paths  
**Mitigation:**
- Review all commands for path references
- Add path detection logic
- Test in both contexts

### Risk: Template Size Growth

**Risk:** Adding scripts/commands increases template size  
**Mitigation:**
- Accept as valuable functionality
- Document what's included and why
- Scripts are text (minimal size impact)

### Risk: Maintenance Burden

**Risk:** Two copies of scripts/commands to maintain  
**Mitigation:**
- Document template sync process
- Consider future automation
- Accept some duplication for value delivered

---

## 📝 Notes

### Path Detection Strategy

Commands should support both structures:

```markdown
**Dev-Infra Structure:**
- Releases: `admin/planning/releases/[version]/`
- Scripts: `scripts/`

**Template Structure:**
- Releases: `docs/maintainers/planning/releases/[version]/`
- Scripts: `scripts/`
```

**Detection Logic:**
1. Check if `admin/planning/releases/` exists → dev-infra mode
2. Check if `docs/maintainers/planning/releases/` exists → template mode
3. Use appropriate paths based on detection

---

### Learning Project Template

**Deferred:** Learning project template can get release automation in future:
- Less common use case
- Focus on standard-project first
- Can copy pattern later if needed

---

**Migrated From:** `admin/planning/features/release-commands-template-integration/feature-plan.md`  
**Last Updated:** 2025-12-11

