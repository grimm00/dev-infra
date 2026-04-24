# Research: Template User Needs

**Research Topic:** Dev-Infra Identity & Focus  
**Question:** What do template users actually need from dev-infra templates?  
**Status:** ✅ Complete  
**Created:** 2025-12-11  
**Last Updated:** 2025-12-11

---

## 🎯 Research Question

What do template users actually need from dev-infra templates? Are we over-engineering for our own workflow rather than user needs?

---

## 🔍 Research Goals

- [x] Goal 1: Identify what templates currently provide
- [x] Goal 2: Compare dev-infra commands vs template commands
- [x] Goal 3: Determine essential vs nice-to-have features
- [x] Goal 4: Understand the "minimum viable template"

---

## 📚 Research Methodology

**Sources:**
- [x] Source 1: Current template structure analysis
- [x] Source 2: Command comparison (dev-infra vs templates)
- [x] Source 3: Script analysis (what's in templates vs dev-infra only)
- [x] Source 4: Real project learnings (opportunities directory)

---

## 📊 Findings

### Finding 1: Command Inventory Comparison

**Analysis of command files:**

| Category | Dev-Infra | Templates | Difference |
|----------|-----------|-----------|------------|
| **Total Commands** | 23 | 18 | 5 dev-infra-only |
| **Core Workflow** | 18 | 18 | Same |
| **Release-Specific** | 5 | 0 | All dev-infra-only |

**Dev-infra-only commands:**
- `address-review.md` - Pre-phase review addressing
- `post-release.md` - Post-release cleanup
- `release-finalize.md` - Release finalization
- `release-prep.md` - Release preparation
- `status.md` - Status reporting

**Relevance:** There's already natural separation! Release commands are dev-infra-only because:
1. Templates don't need to manage their own releases
2. These commands evolved for dev-infra's specific release workflow
3. Generated projects have different release needs

### Finding 2: Template Structure

**Both templates (standard/learning) include:**
```
.cursor/commands/           # 18 workflow commands
docs/maintainers/           # Hub-and-spoke documentation
  ├── planning/             # Feature planning
  │   ├── features/
  │   └── explorations/
  ├── research/             # Research documents
  ├── feedback/             # Code review feedback
  └── decisions/            # ADRs
```

**Relevance:** Templates provide a comprehensive development workflow framework, not just project structure.

### Finding 3: Script Inventory

**Dev-infra scripts:**
| Script | Purpose | In Templates? |
|--------|---------|---------------|
| `new-project.sh` | Generate projects | No (meta) |
| `validate-templates.sh` | Validate templates | No (meta) |
| `check-release-readiness.sh` | Release assessment | No |
| `create-release-branch.sh` | Create release branch | No |
| `analyze-releases.sh` | Historical analysis | No |

**Relevance:** All scripts are dev-infra-specific. Templates don't include any scripts by default.

### Finding 4: Real Project Needs (from work-prod)

**From `admin/planning/opportunities/external/work-prod/`:**

Learnings captured from real project usage show templates need:
1. ✅ Hub-and-spoke documentation (working well)
2. ✅ Feature planning structure (valuable)
3. ✅ PR/code review workflow (essential)
4. 🟡 More testing guidance (some gaps)
5. 🟡 CI/CD workflows (need customization)

**Relevance:** Real projects validate the core template structure but don't request more automation.

---

## 🔍 Analysis

**Key Insights:**

### Insight 1: Templates Are Already Workflow-Heavy

The templates include 18 AI commands. This is substantial and may be:
- **Overwhelming** for simple projects
- **Valuable** for projects that use the full workflow
- **Expensive** to maintain (18 files × 2 templates = 36 files to keep in sync)

### Insight 2: Natural Separation Already Exists

The fact that release commands are dev-infra-only suggests:
- Organic separation based on actual need
- Templates don't need everything dev-infra has
- More separation may be beneficial

### Insight 3: Core User Need is Structure, Not Automation

Templates provide value through:
1. **Structure** - Directory organization, file placement
2. **Documentation patterns** - Hub-and-spoke, status tracking
3. **Workflow guidance** - Commands as guides for AI agents

Users don't need:
- Complex release automation (they're not meta-projects)
- Internal tooling (validation scripts, etc.)
- Dev-infra-specific optimizations

### Insight 4: Command Maintenance Burden

18 commands per template means:
- 36 command files to maintain across templates
- Each command update requires updating both templates
- Plus updating dev-infra's own commands

---

## 💡 Recommendations

- [x] **R1: Acknowledge natural separation** - Release commands staying in dev-infra is correct
- [ ] **R2: Consider command tiers** - Essential (5-7) vs Advanced (rest)
- [ ] **R3: Define "minimum viable template"** - Core structure + essential commands
- [ ] **R4: Track template command sync** - Know when templates diverge from dev-infra

---

## 📋 Requirements Discovered

### Functional Requirements

- **FR-1:** Templates should include only workflow commands that apply to all projects
- **FR-2:** Dev-infra-specific commands should stay in dev-infra only
- **FR-3:** Templates should have a way to "upgrade" to advanced commands if needed

### Non-Functional Requirements

- **NFR-1:** Template commands should be stable (minimal changes after release)
- **NFR-2:** Template maintenance burden should be predictable

---

## 🚀 Next Steps

1. Research command maintenance model (see research-command-maintenance.md)
2. Define essential vs advanced command tiers
3. Inform v0.5.0 scope decision

---

**Last Updated:** 2025-12-11

