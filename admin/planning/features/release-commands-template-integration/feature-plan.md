# Release Commands Template Integration - Feature Plan

**Feature:** Release Commands Template Integration  
**Priority:** 🟡 Medium  
**Status:** 🟡 Planned  
**Created:** 2025-12-11  
**Source:** reflection-v1.4.0-release-cycle-2025-12-11.md

---

## 📋 Overview

Integrate release commands and scripts into project templates so that generated projects can use the complete release automation system. Currently, release commands exist only in dev-infra and are not available to projects generated from templates.

**Problem:**
- Release automation only available in dev-infra
- Generated projects must use manual release processes
- Templates less valuable without release automation
- Release commands work for dev-infra but not tested in other contexts

**Solution:**
- Add release scripts to standard-project template
- Add release commands to template `.cursor/commands/`
- Update command paths for template structure
- Test release workflow in generated project
- Document template-specific customization

---

## 🎯 Success Criteria

- [ ] Release scripts integrated into `templates/standard-project/`
- [ ] Release commands integrated into template `.cursor/commands/`
- [ ] Path detection works for template structure
- [ ] Release workflow tested in generated project
- [ ] Template validation tests include release commands
- [ ] Documentation explains release automation in templates
- [ ] Generated projects can execute full release cycle

---

## 📅 Implementation Phases

### Phase 1: Script Integration

**Goal:** Add release readiness scripts to standard-project template

**Tasks:**
1. Copy scripts to template:
   - `scripts/check-release-readiness.sh`
   - `scripts/create-release-branch.sh`
   - `scripts/analyze-releases.sh`

2. Update script paths for template structure:
   - Change `admin/planning/releases/` → `docs/maintainers/planning/releases/`
   - Update other path references

3. Add script permissions to template

4. Test scripts work in template context

**Estimated:** 2-3 hours

---

### Phase 2: Command Integration

**Goal:** Add release commands to template

**Tasks:**
1. Copy commands to template:
   - `.cursor/commands/release-prep.md`
   - `.cursor/commands/release-finalize.md`
   - `.cursor/commands/post-release.md`

2. Update command path detection:
   - Support both dev-infra and template paths
   - Document path detection logic
   - Test path detection in both contexts

3. Add command documentation to template

4. Test commands work in template context

**Estimated:** 2-3 hours

---

### Phase 3: Test in Generated Project

**Goal:** Validate release workflow in generated project

**Tasks:**
1. Generate new test project from template
2. Execute release workflow:
   - `/release-prep v0.1.0`
   - `/release-finalize v0.1.0`
   - `/pr --release`
   - (Mock merge and tag)
   - `/post-release v0.1.0`

3. Document any issues found
4. Fix issues
5. Re-test until successful

**Estimated:** 2-3 hours

---

### Phase 4: Documentation

**Goal:** Document release automation in templates

**Tasks:**
1. Update template README with release automation section
2. Create release automation guide in template docs:
   - `docs/RELEASE-AUTOMATION.md` or similar
   - Explain release commands
   - Show example release workflow
   - Document customization options

3. Update `docs/TEMPLATE-USAGE.md` to mention release automation
4. Add release automation to template features list

**Estimated:** 1-2 hours

---

### Phase 5: Validation

**Goal:** Ensure template validation includes release commands

**Tasks:**
1. Add template validation tests for:
   - Scripts exist and are executable
   - Commands exist and are formatted correctly
   - Path detection works

2. Update `scripts/validate-templates.sh` to check release components
3. Add to CI/CD template validation
4. Test validation passes

**Estimated:** 1-2 hours

---

## 🚀 Next Steps

1. **Phase 1: Script Integration** (Start here)
   - Copy scripts to template
   - Update paths
   - Test in template context

2. **Phase 2: Command Integration**
   - Copy commands to template
   - Update path detection
   - Test in template context

3. **Phase 3: Test in Generated Project**
   - Generate test project
   - Execute full release workflow
   - Fix any issues

4. **Phase 4: Documentation**
   - Document release automation
   - Update template usage guide
   - Add examples

5. **Phase 5: Validation**
   - Add validation tests
   - Update CI/CD checks
   - Verify everything passes

---

## 🎯 Benefits

### For Template Users

- **Complete Release Automation** - Generated projects get full release automation out of the box
- **Professional Release Process** - Consistent, tested release workflow
- **Time Savings** - No need to build release automation from scratch
- **Best Practices Encoded** - Templates include proven release practices

### For dev-infra

- **Validation in Multiple Contexts** - Release commands tested in different project structures
- **Template Value Increase** - Templates become significantly more valuable
- **Cross-Project Consistency** - All projects use same release automation
- **Dogfooding Complete** - Release automation truly battle-tested

---

## 📊 Effort Estimates

| Phase | Estimated Effort |
|-------|-----------------|
| Phase 1: Script Integration | 2-3 hours |
| Phase 2: Command Integration | 2-3 hours |
| Phase 3: Test in Generated Project | 2-3 hours |
| Phase 4: Documentation | 1-2 hours |
| Phase 5: Validation | 1-2 hours |
| **Total** | **8-13 hours (1-2 days)** |

---

## 🔗 Related

**Related Features:**
- Release Readiness (completed v1.4.0)
- Template Enhancement (completed v1.4.0)

**Related Scripts:**
- `scripts/check-release-readiness.sh`
- `scripts/create-release-branch.sh`
- `scripts/analyze-releases.sh`

**Related Commands:**
- `/release-prep`
- `/release-finalize`
- `/post-release`

**Related Documents:**
- `templates/standard-project/` - Target template
- `docs/TEMPLATE-USAGE.md` - Template documentation
- `scripts/validate-templates.sh` - Template validation

---

## 🚨 Risks & Mitigations

### Risk: Path Detection Complexity

**Risk:** Supporting multiple path structures (dev-infra vs template) may be complex

**Mitigation:**
- Use consistent path detection pattern across all commands
- Document path detection clearly
- Test thoroughly in both contexts
- Keep path detection logic simple and maintainable

---

### Risk: Template Validation Overhead

**Risk:** Adding more components to templates may slow down validation

**Mitigation:**
- Optimize validation tests
- Run validation in parallel where possible
- Focus on critical validation only
- Balance thoroughness with speed

---

### Risk: Template Size Growth

**Risk:** Adding scripts and commands increases template size

**Mitigation:**
- Accept increase as valuable functionality
- Scripts are text files (minimal size impact)
- Document what's included and why
- Consider optional vs. required components

---

## 📈 Success Metrics

**Track:**
- Template generation success rate (target: 100%)
- Release automation adoption in generated projects (track usage)
- Template validation test pass rate (target: 100%)
- User feedback on release automation value

**Measure:**
- Time saved for projects using template release automation
- Number of projects successfully using release commands
- Issues reported with template release automation

---

**Last Updated:** 2025-12-11  
**Status:** 🟡 Planned  
**Next:** Begin Phase 1 - Script Integration

