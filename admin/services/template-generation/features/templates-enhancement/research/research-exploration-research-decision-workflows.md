# Research: Exploration/Research/Decision Workflows

**Research Topic:** Templates Enhancement  
**Question:** How should exploration/research/decision workflows be structured in templates? What directories and files are needed?  
**Status:** 🔴 Research  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 🎯 Research Question

How should exploration/research/decision workflows be structured in templates? What directories and files are needed?

---

## 🔍 Research Goals

- [ ] Goal 1: Understand exploration/research/decision workflow structure
- [ ] Goal 2: Identify what directories and files templates need
- [ ] Goal 3: Determine how workflows integrate with feature planning
- [ ] Goal 4: Identify template/documentation needs

---

## 📚 Research Methodology

**Sources:**
- [ ] Source 1: Current exploration/research/decision structure in dev-infra
- [ ] Source 2: `/explore`, `/research`, `/decision` command documentation
- [ ] Source 3: Template structure analysis
- [ ] Source 4: Workflow integration patterns

---

## 📊 Findings

### Finding 1: Current Exploration/Research/Decision Structure

**Finding:** Dev-infra uses this structure:
```
admin/
├── explorations/[topic]/
│   ├── README.md
│   ├── exploration.md
│   └── research-topics.md
├── research/[topic]/
│   ├── README.md
│   ├── research-[question].md
│   ├── research-summary.md
│   └── requirements.md
└── decisions/[topic]/
    ├── README.md
    ├── adr-[number]-[decision].md
    └── decisions-summary.md
```

**Source:** Current dev-infra structure (`admin/explorations/`, `admin/research/`, `admin/decisions/`)

**Relevance:** Templates should include similar structure but in `docs/maintainers/` paths.

---

### Finding 2: Command Path Detection

**Finding:** Commands support both dev-infra and template structures:

**Dev-Infra:**
- Explorations: `admin/explorations/[topic]/`
- Research: `admin/research/[topic]/`
- Decisions: `admin/decisions/[topic]/`

**Template Structure:**
- Explorations: `docs/maintainers/planning/explorations/[topic]/`
- Research: `docs/maintainers/research/[topic]/`
- Decisions: `docs/maintainers/decisions/[topic]/`

**Source:** `/explore`, `/research`, `/decision` command documentation

**Relevance:** Commands already support template structure, so templates just need directories.

---

### Finding 3: Workflow Integration with Feature Planning

**Finding:** Exploration/research/decision workflows integrate with feature planning via `/transition-plan --from-adr`.

**Workflow:**
1. `/explore` → Creates exploration
2. `/research` → Creates research + requirements
3. `/decision` → Creates ADRs
4. `/transition-plan --from-adr` → Creates feature plan + phases

**Source:** `/transition-plan` command documentation

**Relevance:** Templates need exploration/research/decision structure to support this workflow.

---

### Finding 4: Template Structure Requirements

**Finding:** Templates need these directories:

```
docs/maintainers/
├── planning/
│   └── explorations/[topic]/    # Exploration workflows
├── research/[topic]/              # Research workflows
└── decisions/[topic]/             # Decision workflows
```

**Source:** Command path detection and workflow analysis

**Relevance:** Templates need these directories with hub READMEs.

---

## 🔍 Analysis

**Key Insights:**

- [ ] Insight 1: Templates need `docs/maintainers/planning/explorations/` directory
- [ ] Insight 2: Templates need `docs/maintainers/research/` directory
- [ ] Insight 3: Templates need `docs/maintainers/decisions/` directory
- [ ] Insight 4: Each directory needs hub README.md
- [ ] Insight 5: Commands create topic-specific directories automatically

**Structure Needed:**
- Hub directories with README.md files
- Commands create topic-specific directories
- Templates provide structure, commands populate it

---

## 💡 Recommendations

- [ ] Recommendation 1: Include `docs/maintainers/planning/explorations/` directory with README.md hub
- [ ] Recommendation 2: Include `docs/maintainers/research/` directory with README.md hub
- [ ] Recommendation 3: Include `docs/maintainers/decisions/` directory with README.md hub
- [ ] Recommendation 4: Document exploration/research/decision workflow in template READMEs

---

## 📋 Requirements Discovered

- [ ] Requirement 1: Templates must include `docs/maintainers/planning/explorations/` directory
- [ ] Requirement 2: Templates must include `docs/maintainers/research/` directory
- [ ] Requirement 3: Templates must include `docs/maintainers/decisions/` directory
- [ ] Requirement 4: Each directory must have hub README.md
- [ ] Requirement 5: Workflow documentation must be included

---

## 🚀 Next Steps

1. Create exploration/research/decision directories in templates
2. Create hub README.md files for each directory
3. Document workflow in template READMEs
4. Test commands work with template structure

---

**Last Updated:** 2025-12-07

