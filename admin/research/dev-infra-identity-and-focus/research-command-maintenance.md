# Research: Command Maintenance Model

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** What's the appropriate maintenance model for AI commands vs traditional code?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

What's the appropriate maintenance model for AI commands vs traditional code? Commands are guides for AI agents, not compiled code. They may need different versioning, testing, and maintenance approaches.

---

## 🔍 Research Goals

- [x] Goal 1: Understand how AI commands differ from traditional code
- [x] Goal 2: Identify current command maintenance challenges
- [x] Goal 3: Determine appropriate versioning strategy
- [x] Goal 4: Define testing approach for commands

---

## 📚 Research Methodology

**Sources:**
- [x] Source 1: Analysis of current command structure
- [x] Source 2: Command update history (from git)
- [x] Source 3: Comparison with traditional code maintenance
- [x] Source 4: Dev-infra's own experience maintaining commands

---

## 📊 Findings

### Finding 1: AI Commands Are Documentation, Not Code

**Characteristics of AI commands:**

| Aspect | Traditional Code | AI Commands |
|--------|------------------|-------------|
| **Execution** | Machine executes | AI interprets |
| **Testing** | Unit tests, CI/CD | Manual verification |
| **Versioning** | Semantic versioning | Document versioning? |
| **Breaking Changes** | Compile errors | Silent behavior changes |
| **Consumers** | Software systems | AI agents |

**Relevance:** Commands need documentation-style maintenance, not code-style maintenance.

### Finding 2: Command Maintenance Burden

**Current state:**
- Dev-infra: 23 commands
- Standard template: 18 commands
- Learning template: 18 commands
- **Total: 59 command files**

**Sync challenges:**
- When dev-infra improves a command, templates may not get updated
- No automated way to detect drift
- No test suite for command behavior

**Relevance:** High maintenance burden with no automation.

### Finding 3: Commands Have Different Stability Needs

**Command Categories by Stability:**

| Category | Commands | Stability Need |
|----------|----------|----------------|
| **Core Workflow** | pr, task-phase, fix-plan, fix-implement | 🔴 Very Stable |
| **Planning** | explore, research, decision, transition-plan | 🟡 Moderately Stable |
| **Reflection** | reflect, reflection-artifacts, int-opp | 🟡 Moderately Stable |
| **Review** | pre-phase-review, address-review, pr-validation | 🟢 Can Evolve |
| **Release** | release-prep, release-finalize, post-release | 🔵 Dev-infra Only |

**Relevance:** Not all commands need the same maintenance approach.

### Finding 4: Testing Commands Is Different

**Traditional code testing:**
```bash
# Clear pass/fail
bats tests/unit/script.bats
```

**Command "testing":**
- Manual execution with AI agent
- Verify AI follows workflow correctly
- Subjective evaluation of output quality
- No automated regression testing

**Relevance:** Can't apply traditional testing to commands.

### Finding 5: Command Evolution Pattern

**Observation from dev-infra history:**

1. **Birth:** Command created for dev-infra need
2. **Maturation:** Command refined through usage
3. **Stabilization:** Command reaches stable state
4. **Templatization:** Command copied to templates
5. **Drift:** Dev-infra version evolves, template version stagnates

**The Problem:** Step 5 creates divergence without tracking.

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Commands Need "Graduated" Stability

Commands should have explicit stability levels:

```markdown
**Stability:** 🔴 Stable | 🟡 Evolving | 🟢 Experimental
```

- **Stable:** In templates, minimal changes
- **Evolving:** In dev-infra, being refined
- **Experimental:** Dev-infra only, not ready for templates

### Insight 2: Template Commands Should Be Stable Subset

Templates should only include **Stable** commands:
- Reduces maintenance burden
- Provides reliable base for projects
- Dev-infra can experiment without affecting templates

### Insight 3: Command Sync Needs Process, Not Automation

Instead of automated sync:
- **Release checkpoint:** Review command changes during release prep
- **Intentional graduation:** Explicitly promote commands to templates
- **Changelog tracking:** Note command changes in releases

### Insight 4: "Testing" Commands Means Documentation Quality

For AI commands, "testing" means:
- [ ] Command document is complete
- [ ] All steps are clear and actionable
- [ ] Examples are accurate
- [ ] Integration points are documented
- [ ] Manual testing checklist exists

---

## 💡 Recommendations

- [x] **R1: Add stability metadata to commands** - Mark each command's stability level
- [ ] **R2: Define "essential" command set** - 5-7 core commands for templates
- [ ] **R3: Create command graduation process** - How commands move from dev-infra to templates
- [ ] **R4: Track command versions separately** - Not tied to project version

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-4:** Commands must have explicit stability levels
- **FR-5:** Template commands must be at "Stable" level
- **FR-6:** Command graduation requires manual review

### Non-Functional Requirements

- **NFR-3:** Command changes should be tracked in releases
- **NFR-4:** Essential command set should be ≤7 commands

---

## 🚀 Next Steps

1. Define essential command set for templates
2. Add stability metadata to dev-infra commands
3. Create command graduation criteria

---

**Last Updated:** 2025-12-11

