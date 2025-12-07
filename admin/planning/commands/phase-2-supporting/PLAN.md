# Phase 2: Supporting Workflow Commands

**Purpose:** Adapt and implement HIGH priority supporting workflow automation commands  
**Status:** 🟠 In Progress  
**Priority:** 🟠 HIGH  
**Estimated Effort:** 14 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

### Command Planning Documents

- **[Fix Review Command](fix-review-command.md)** - Cross-PR fix management (4h)
- **[Post PR Command](post-pr-command.md)** - Post-merge documentation (3h)
- **[PR Validation Command](pr-validation-command.md)** - Sourcery review integration (4h)
- **[Reflection Artifacts Command](reflection-artifacts-command.md)** - Reflection workflow completion (3h)

### Related Documentation

- **[Command Adaptations](../../opportunities/external/work-prod/cursor-commands/adaptations/)** - Detailed adaptation guides
- **[Status Tracking](../STATUS.md)** - Overall command status
- **[Phase 1 Plan](../phase-1-core/PLAN.md)** - Core workflow commands

---

## 🎯 Phase Overview

Phase 2 focuses on supporting workflow commands that complete the automation suite. These commands enhance the core workflows from Phase 1 with additional capabilities for fix management, documentation, validation, and reflection.

### Why These Commands Are Important

1. **`/fix-review`** - Enables cross-PR fix batching and deferred issue management
2. **`/post-pr`** - Automates post-merge documentation updates
3. **`/pr-validation`** - Integrates Sourcery reviews and manual testing
4. **`/reflection-artifacts`** - Completes reflection workflow for phase/release learnings

---

## 📊 Command Breakdown

| Command              | Priority | Effort | Status         | Notes                                    |
| -------------------- | -------- | ------ | -------------- | ---------------------------------------- |
| `/fix-review`        | 🟠 HIGH  | 4h     | 🟠 In Progress | Cross-PR fix management, command adapted |
| `/post-pr`           | 🟠 HIGH  | 3h     | 🟠 In Progress | Post-merge documentation, command adapted |
| `/pr-validation`     | 🟡 MEDIUM| 4h     | 🟠 In Progress | Sourcery review integration, command adapted |
| `/reflection-artifacts` | 🟡 MEDIUM| 3h     | 🔴 Not Started | Reflection workflow completion            |

**Total Effort:** 14 hours

---

## 🔄 Implementation Order

### Step 1: `/fix-review` Command (4h) 🟠 In Progress

**Why First:** Completes fix management workflow  
**Dependencies:** `/fix-plan` ✅, `/fix-implement` ✅  
**Deliverables:**

- ✅ Adapted command file
- ✅ Cross-PR batch generation
- ✅ Deferred issue review
- ✅ Fix batch recommendations
- 🟡 Testing in dev-infra project

**See:** [Fix Review Command](fix-review-command.md)

---

### Step 2: `/post-pr` Command (3h) 🟠 In Progress

**Why Second:** Frequently used after PR merges  
**Dependencies:** `/pr` ✅  
**Deliverables:**

- ✅ Adapted command file
- ✅ Post-merge documentation updates
- ✅ Feature status updates
- ✅ Branch cleanup
- 🟡 Testing in dev-infra project

**See:** [Post PR Command](post-pr-command.md)

---

### Step 3: `/pr-validation` Command (4h) 🟠 In Progress

**Why Third:** Enhances PR workflow  
**Dependencies:** `/pr` ✅  
**Deliverables:**

- ✅ Adapted command file
- ✅ Manual testing integration
- ✅ Sourcery review integration
- ✅ Priority matrix filling
- 🟡 Testing in dev-infra project

**See:** [PR Validation Command](pr-validation-command.md)

---

### Step 4: `/reflection-artifacts` Command (3h)

**Why Last:** Completes reflection workflow  
**Dependencies:** None  
**Deliverables:**

- Adapted command file
- Reflection artifact generation
- Phase/release learnings capture
- Opportunity documentation

**See:** [Reflection Artifacts Command](reflection-artifacts-command.md)

---

## ✅ Success Criteria

### Phase 2 Complete When:

- [ ] All 4 commands adapted for dev-infra
- [ ] Commands work in dev-infra project
- [ ] Commands integrated into templates
- [ ] Documentation complete
- [ ] Cross-command integration tested
- [ ] Fix management workflow complete
- [ ] Post-merge automation working

---

## 📝 Implementation Checklist

### Preparation

- [ ] Review all source commands from work-prod
- [ ] Review Phase 1 adaptations for consistency
- [ ] Understand dev-infra template structure
- [ ] Identify all project-specific assumptions

### Command Adaptation

- [x] Adapt `/fix-review` command 🟠 (ready for testing)
- [x] Adapt `/post-pr` command 🟠 (ready for testing)
- [x] Adapt `/pr-validation` command 🟠 (ready for testing)
- [ ] Adapt `/reflection-artifacts` command

### Testing

- [ ] Test each command in dev-infra project
- [ ] Test command integration with Phase 1 commands
- [ ] Test with new project creation
- [ ] Validate template integration

### Documentation

- [ ] Update command documentation
- [ ] Create usage examples
- [ ] Update template documentation
- [ ] Document adaptation decisions

---

## 🎯 Expected Impact

### Workflow Completion

- **Before:** Manual fix review, post-merge updates, validation
- **After:** Automated fix management, documentation updates, validation workflows
- **Measurement:** Time saved on post-merge tasks, fix management efficiency

### Quality Assurance

- **Before:** Manual validation processes
- **After:** Automated validation with Sourcery integration
- **Measurement:** Review completion rate, issue detection rate

---

## 📚 Related Documentation

**Source Commands:**

- [Work-Prod Commands](../../../../work-prod/.cursor/commands/)

**Adaptation Guides:**

- [Command Adaptation Guide](../../opportunities/external/work-prod/cursor-commands/adaptations/command-adaptation-guide.md)

**Planning:**

- [Commands Hub](../README.md)
- [Status Tracking](../STATUS.md)
- [Phase 1 Plan](../phase-1-core/PLAN.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Test first 3 commands, then adapt `/reflection-artifacts`

