# Feature Planning Hub

**Purpose:** Feature-based planning and tracking using hub-and-spoke documentation  
**Status:** ✅ Active  
**Last Updated:** 2025-12-11

---

## 📋 Quick Links

### Active Features

- **[Command Distribution](command-distribution/README.md)** - Implement command distribution from dev-infra to dev-toolkit (🔴 Not Started, 🔴 High Priority) ⭐ **NEW**
  - Phase 1: dev-infra Release Artifacts (~2-3 hrs)
  - Phase 2: dt-cursor-install Implementation (~4-6 hrs)
  - Phase 3: Documentation & Standard (~2-3 hrs)
  - Estimated: ~8-12 hours (cross-project)
  - Source: ADR-001 (Four-Arm Architecture)

- **[Explore Two-Mode](explore-two-mode/README.md)** - Apply two-mode pattern to `/explore` command (🟡 Planned, 🔴 High Priority) ⭐ **NEW**
  - Phase 1: Exploration & Research (~1 hr)
  - Phase 2: Implementation (~2 hrs)
  - Estimated: ~3 hours
  - Source: reflection-transition-plan-two-mode-2025-12-29.md

- **[Decision Two-Mode](decision-two-mode/README.md)** - Apply two-mode pattern to `/decision` command (🟡 Planned, 🟢 Low Priority)
  - Blocked by: explore-two-mode completion
  - Estimated: ~3 hours
  - Source: reflection-transition-plan-two-mode-2025-12-29.md

- **[Reflect Two-Mode](reflect-two-mode/README.md)** - Evaluate two-mode pattern for `/reflect` command (🔴 Needs Evaluation, 🟢 Low Priority)
  - May not be needed - requires evaluation
  - Estimated: ~2.5 hours (if implemented)
  - Source: reflection-transition-plan-two-mode-2025-12-29.md

- **[Transition-Plan Two-Mode](transition-plan-two-mode/README.md)** - Implement two-mode pattern for `/transition-plan` command (✅ Complete)
  - Phase 1: Workflow Overview (~30 min)
  - Phase 2: Setup Mode Workflow (~1-2 hrs)
  - Phase 3: Expand Mode Workflow (~2 hrs)
  - Phase 4: Supporting Content (~1 hr)
  - Estimated: 4-6 hours
  - Source: ADR-001, ADR-002, ADR-003

- **[Experimental Template](experimental-template/README.md)** - Create experimental template with Evolving commands (🔴 Not Started) ⭐ **v0.6.0 Target**
  - Phase 1: Create experimental-project template
  - Phase 2: Update generator script
  - Phase 3: CI drift detection
  - Phase 4: Stability indicators
  - Estimated: 6-10 hours
  - Source: Team project demand + ADR-001/002

- **[Release Automation v2](release-automation-v2/README.md)** - Complete release automation (✅ Complete - v0.5.0)
  - Phase 1: Tag Creation Automation (eliminates manual tagging)
  - Phase 2: Version Reference Automation (eliminates manual updates)

- **[Release Readiness](release-readiness/README.md)** - Implement standardized release readiness assessment and automation (✅ Complete - v0.4.0)
- **[Command Adaptation Template](command-adaptation-template/README.md)** - Document command adaptation pattern as reusable template (✅ Complete)
- **[Command Testing & Template Integration](command-testing-integration/README.md)** - Test and integrate cursor commands into templates (🟡 Planned)
- **[Directory Selection](directory-selection/README.md)** - Allow users to choose target directory for project generation (✅ Complete)
- **[Template Restructure](template-restructure/README.md)** - Restructure templates (admin/ → docs/maintainers/, rename to standard-project) (✅ Complete)

### Template Features

- **[Regular Project Features](regular-project-features/README.md)** - Regular project template features
- **[Learning Project Features](learning-project-features/README.md)** - Learning project template features
- **[Generator Features](generator-features/README.md)** - Project generator features
- **[Validation Features](validation-features/README.md)** - Template validation features

---

## 🎯 Overview

Feature planning organizes development work around user-facing functionality. Each feature has its own directory with hub-and-spoke documentation for clear navigation and focused content.

---

## 📊 Status Documentation

- **[Detailed Status Analysis](STATUS.md)** - Comprehensive analysis of all features, completion status, discrepancies, and next steps

This directory serves two purposes:
1. **Template Features** - Planning for dev-infra template enhancements (template types, generator, validation)
2. **Project Features** - Planning for new functionality in the dev-infra project itself (like directory selection)

### Feature Planning Philosophy

1. **User-Centric** - Features solve real user problems
2. **Hub-and-Spoke** - Clear entry points with detailed documentation
3. **Phase-Based** - Break features into manageable phases
4. **Status Tracking** - Consistent progress monitoring
5. **Fix Integration** - Troubleshooting documentation included
6. **Template-First** - Focus on template quality and usability (for template features)
7. **Automation** - Reduce manual setup and configuration (for template features)

---

## 📁 Feature Directory Structure

### Project Features (New Structure)

```
features/
├── [feature-name]/
│   ├── README.md                    # 📍 HUB - Feature overview
│   ├── feature-plan.md              # High-level plan
│   ├── status-and-next-steps.md     # Current status
│   ├── phase-1.md                   # Phase 1 details
│   ├── phase-2.md                   # Phase 2 details
│   ├── fix/                         # Fix documentation
│   └── testing/                     # Testing documentation
```

### Template Features (Legacy Structure)

```
features/
├── regular-project-features/  # Regular project template features
├── learning-project-features/ # Learning project template features
├── generator-features/        # Project generator features
└── validation-features/       # Template validation features
```

---

## 🎨 Feature Development Pattern

### 1. Feature Discovery

- Identify user problem or opportunity
- Create feature directory
- Write initial feature-plan.md

### 2. Planning Phase

- Define success criteria
- Break into phases
- Create phase documents
- Set up status tracking

### 3. Implementation Phase

- Execute phases sequentially
- Update status documents
- Document decisions and learnings
- Create fix documentation as needed

### 4. Completion Phase

- Document results and metrics
- Archive superseded documents
- Update project roadmap
- Share lessons learned

---

## 📊 Feature Status Overview

### ✅ Completed Features

| Feature | Status | Completed |
|---------|--------|-----------|
| [Template Restructure](template-restructure/README.md) | ✅ Complete | 2025-11-14 (PR #8) |

### ⚠️ Features with Status Discrepancies

| Feature | Status | Issue | See |
|---------|--------|-------|-----|
| [Directory Selection](directory-selection/README.md) | ⚠️ Discrepancy | Implementation appears complete but PR not created, status indicators inconsistent | [STATUS.md](STATUS.md) |

### 🟡 Planned Features

None currently - all features are either complete or have status discrepancies that need resolution.

---

## 🚀 Quick Start

### Creating a New Feature

1. **Create Directory**
   ```bash
   mkdir -p features/[feature-name]
   cd features/[feature-name]
   ```

2. **Create Documents**
   - Create `README.md` hub
   - Create `feature-plan.md` with overview
   - Create `status-and-next-steps.md`
   - Add phase documents as needed

3. **Link to Hub**
   - Add feature to this README.md
   - Update project roadmap
   - Create initial status document

---

**Last Updated:** 2025-12-31  
**Status:** ✅ Active  
**Next:** See individual feature directories for current work
