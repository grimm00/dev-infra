# Phase 1: Core Workflow Commands

**Purpose:** Adapt and implement CRITICAL workflow automation commands  
**Status:** 🟡 Planned  
**Priority:** 🔴 CRITICAL  
**Estimated Effort:** 28 hours  
**Last Updated:** 2025-12-07

---

## 📋 Quick Links

### Command Planning Documents

- **[PR Command](pr-command.md)** - Centralized PR creation (8h)
- **[Fix Implement Command](fix-implement-command.md)** - Fix implementation workflow (6h)
- **[Task Phase Command](task-phase-command.md)** - Phase implementation with TDD (8h)
- **[Fix Plan Command](fix-plan-command.md)** - Fix batching workflow (6h)

### Related Documentation

- **[Command Adaptations](../../opportunities/external/work-prod/cursor-commands/adaptations/)** - Detailed adaptation guides
- **[Status Tracking](../../commands/STATUS.md)** - Overall command status

---

## 🎯 Phase Overview

Phase 1 focuses on the 4 most critical commands that form the core of development workflows. These commands automate the most frequently used and error-prone processes.

### Why These Commands Are Critical

1. **`/pr`** - Most frequently used command, central to all workflows
2. **`/fix-implement`** - Core fix management workflow
3. **`/task-phase`** - TDD automation for phase implementation
4. **`/fix-plan`** - Intelligent fix batching from reviews

---

## 📊 Command Breakdown

| Command          | Priority    | Effort | Status         | Adaptation Doc                                                                                                      |
| ---------------- | ----------- | ------ | -------------- | ------------------------------------------------------------------------------------------------------------------- |
| `/pr`            | 🔴 CRITICAL | 8h     | 🟠 In Progress | Command adapted, ready for testing                                                                                  |
| `/fix-implement` | 🔴 CRITICAL | 6h     | 🟠 In Progress | Command adapted, ready for testing                                                                                  |
| `/task-phase`    | 🔴 CRITICAL | 8h     | 🟠 In Progress | Command adapted, ready for testing                                                                                  |
| `/fix-plan`      | 🟠 HIGH     | 6h     | 🟡 Documented  | [fix-plan-adaptation.md](../../opportunities/external/work-prod/cursor-commands/adaptations/fix-plan-adaptation.md) |

**Total Effort:** 28 hours

---

## 🔄 Implementation Order

### Step 1: `/fix-plan` Command (6h)

**Why First:** Already documented, foundational for fix workflow  
**Dependencies:** None  
**Deliverables:**

- Adapted command file
- Generic fix tracking paths
- Configurable feature context
- Template integration

**See:** [Fix Plan Command](fix-plan-command.md)

---

### Step 2: `/fix-implement` Command (6h) 🟠 In Progress

**Why Second:** Depends on `/fix-plan` for fix structure  
**Dependencies:** `/fix-plan` command ✅  
**Deliverables:**

- ✅ Adapted command file
- ✅ Generic fix plan paths
- ✅ TDD workflow enforcement
- ✅ Fix PR creation
- 🟡 Testing in dev-infra project
- 🟡 Template integration

**See:** [Fix Implement Command](fix-implement-command.md)

---

### Step 3: `/task-phase` Command (8h) 🟠 In Progress

**Why Third:** Core phase implementation workflow  
**Dependencies:** None ✅  
**Deliverables:**

- ✅ Adapted command file
- ✅ Generic phase structure
- ✅ TDD workflow (RED → GREEN → REFACTOR)
- ✅ Phase PR creation
- 🟡 Testing in dev-infra project
- 🟡 Template integration

**See:** [Task Phase Command](task-phase-command.md)

---

### Step 4: `/pr` Command (8h) 🟠 In Progress

**Why Last:** Integrates with all other commands  
**Dependencies:** `/fix-implement` ✅, `/task-phase` ✅  
**Deliverables:**

- ✅ Adapted command file
- ✅ Generic PR templates
- ✅ Configurable validation checklists
- ✅ Manual testing integration
- 🟡 Testing in dev-infra project
- 🟡 Template integration

**See:** [PR Command](pr-command.md)

---

## ✅ Success Criteria

### Phase 1 Complete When:

- [ ] All 4 commands adapted for dev-infra
- [ ] Commands work in dev-infra project
- [ ] Commands integrated into templates
- [ ] Documentation complete
- [ ] New project creation validates commands
- [ ] Cross-command integration tested

---

## 📝 Implementation Checklist

### Preparation

- [ ] Review all source commands from work-prod
- [ ] Review existing adaptation documents
- [ ] Understand dev-infra template structure
- [ ] Identify all project-specific assumptions

### Command Adaptation

- [x] Adapt `/fix-plan` command ✅
- [x] Adapt `/fix-implement` command 🟠 (ready for testing)
- [x] Adapt `/task-phase` command 🟠 (ready for testing)
- [x] Adapt `/pr` command 🟠 (ready for testing)

### Testing

- [ ] Test each command in dev-infra project
- [ ] Test command integration
- [ ] Test with new project creation
- [ ] Validate template integration

### Documentation

- [ ] Update command documentation
- [ ] Create usage examples
- [ ] Update template documentation
- [ ] Document adaptation decisions

---

## 🎯 Expected Impact

### Development Velocity

- **Before:** Manual workflow management, inconsistent processes
- **After:** Automated workflows, 2-3x faster development cycles
- **Measurement:** Time to complete phases, PR creation time

### Code Quality

- **Before:** Inconsistent testing, manual review processes
- **After:** Automated TDD enforcement, consistent review processes
- **Measurement:** Test coverage, review completion rate

---

## 📚 Related Documentation

**Source Commands:**

- [Work-Prod Commands](../../../../work-prod/.cursor/commands/)

**Adaptation Guides:**

- [Command Adaptation Guide](../../opportunities/external/work-prod/cursor-commands/adaptations/command-adaptation-guide.md)
- [Fix Plan Adaptation](../../opportunities/external/work-prod/cursor-commands/adaptations/fix-plan-adaptation.md)
- [Task Phase Adaptation](../../opportunities/external/work-prod/cursor-commands/adaptations/task-phase-adaptation.md)

**Planning:**

- [Commands Hub](../README.md)
- [Status Tracking](../STATUS.md)

---

**Last Updated:** 2025-12-07  
**Status:** 🟠 In Progress  
**Next:** Start implementation - begin with `/fix-plan` command adaptation
