# Research: Minimum Viable Tooling

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** What is the minimum dev-infra needs to be an excellent template factory?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

What is the minimum dev-infra needs to be an excellent template factory? Helps identify what to cut and what's essential.

---

## 🔍 Research Goals

- [x] Goal 1: Inventory current tooling
- [x] Goal 2: Categorize as essential vs nice-to-have
- [x] Goal 3: Define minimum viable template factory
- [x] Goal 4: Identify potential cuts

---

## 📊 Findings

### Finding 1: Current Tooling Inventory

**Scripts (5):**
| Script | Purpose | Essential? |
|--------|---------|------------|
| `new-project.sh` | Generate projects | ✅ Core function |
| `validate-templates.sh` | Validate structure | ✅ Quality assurance |
| `check-release-readiness.sh` | Assess releases | 🟡 Nice to have |
| `create-release-branch.sh` | Create branches | 🟡 Nice to have |
| `analyze-releases.sh` | Track history | 🟢 Nice to have |

**Commands (23):**
| Category | Count | Essential? |
|----------|-------|------------|
| Core Workflow | 6 | ✅ Essential |
| Planning | 4 | 🟡 Valuable |
| Review | 4 | 🟡 Valuable |
| Reflection | 3 | 🟢 Nice to have |
| Release | 5 | 🔵 Dev-infra only |
| Misc | 1 | 🟢 Nice to have |

**Tests:**
| Category | Count | Essential? |
|----------|-------|------------|
| Template validation | 94+ tests | ✅ Essential |
| Script unit tests | ~50 tests | ✅ Essential |

### Finding 2: Minimum Viable Template Factory

**Absolutely Essential (cannot function without):**

| Component | Why |
|-----------|-----|
| `new-project.sh` | Core function - generates projects |
| `validate-templates.sh` | Quality assurance - ensures templates work |
| Template directories | The actual product |
| Template validation tests | Prevents broken releases |

**Highly Valuable (significant degradation without):**

| Component | Why |
|-----------|-----|
| CI/CD workflows | Automates validation |
| Hub-and-spoke docs | Project organization |
| Core workflow commands | Development efficiency |
| Release process | Version management |

**Nice to Have (optional enhancement):**

| Component | Why |
|-----------|-----|
| Release readiness scripts | Automation |
| Historical tracking | Analysis |
| Advanced commands | Power features |
| Reflection workflows | Meta-improvement |

### Finding 3: Essential Command Set

**If templates should have minimal stable commands:**

**Tier 1 - Essential (5 commands):**
1. `/pr` - Core PR workflow
2. `/task-phase` - Phase implementation
3. `/fix-plan` - Issue triage
4. `/fix-implement` - Issue fixing
5. `/reflect` - Project reflection

**Tier 2 - Valuable (6 commands):**
6. `/explore` - Exploration workflow
7. `/research` - Research workflow
8. `/decision` - ADR creation
9. `/pre-phase-review` - Quality check
10. `/pr-validation` - PR review
11. `/post-pr` - Post-merge cleanup

**Tier 3 - Advanced (7 commands):**
12. `/transition-plan` - Planning from artifacts
13. `/reflection-artifacts` - Extract artifacts
14. `/int-opp` - Capture opportunities
15. `/address-review` - Address reviews
16. `/task-release` - Release tasks
17. `/cursor-rules` - Rule management
18. `/fix-review` - Fix batch review

**Not for templates (5 commands):**
19. `/release-prep` - Dev-infra only
20. `/release-finalize` - Dev-infra only
21. `/post-release` - Dev-infra only
22. `/status` - Dev-infra only
23. `/task-improvement` - CI-specific

### Finding 4: Potential Cuts

**Safe to remove from templates:**
- Release-specific commands (already not included)
- CI-specific commands
- Commands with low usage

**Questionable value in templates:**
- Reflection workflows (valuable but complex)
- Research/decision workflows (may be overkill for simple projects)

**Cannot cut:**
- Core PR/task workflow
- Basic documentation patterns

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Templates Are Over-Featured

18 commands in templates may be:
- Overwhelming for new users
- Hard to maintain
- Creating complexity without proportional value

### Insight 2: Tiered Approach Could Work

Instead of all-or-nothing:
- Essential tier (5 commands) for all projects
- Valuable tier (6 commands) for most projects
- Advanced tier (7 commands) for complex projects

### Insight 3: Template "Editions"

Possible approach:
- **Lite Template:** Structure + Essential commands only
- **Standard Template:** Structure + Essential + Valuable
- **Full Template:** Structure + All commands

### Insight 4: Simplicity Has Value

For template users:
- Simpler = easier to understand
- Simpler = easier to customize
- Simpler = easier to maintain

---

## 💡 Recommendations

- [ ] **R9: Define essential command set** - 5-7 core commands
- [ ] **R10: Consider template editions** - Lite/Standard/Full
- [ ] **R11: Document command tiers** - Help users understand options
- [ ] **R12: Focus dev-infra on quality, not quantity** - Better templates, not more features

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-13:** Templates should have explicit command tiers
- **FR-14:** Essential command set should be ≤7 commands

### Non-Functional Requirements

- **NFR-11:** Template complexity should be justified by user value
- **NFR-12:** Simpler templates should be an option

---

## 🚀 Next Steps

1. Review current template commands against tiers
2. Consider template editions for v2.0
3. Document command usage recommendations

---

**Last Updated:** 2025-12-11

