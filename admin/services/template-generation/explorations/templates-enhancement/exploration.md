# Templates Enhancement - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 🎯 What Are We Exploring?

Enhancing dev-infra templates to include new workflow automation commands, CI/CD improvement structure, exploration/research/decision workflows, and other improvements discovered during dev-infra development.

**Current State:**
- Templates include basic structure (standard-project, learning-project)
- Templates have planning structure (`docs/maintainers/planning/`)
- Templates don't include workflow automation commands
- Templates don't include CI/CD improvement structure
- Templates don't include exploration/research/decision workflows
- Scripts (`new-project.sh`, `validate-templates.sh`) exist but may need updates

---

## 🤔 Why Explore This?

**Problem:** Templates generated with `new-project.sh` don't include:
- Workflow automation commands (14 commands adapted but not in templates)
- CI/CD improvement structure (learned from Status Tracking Automation)
- Exploration/research/decision workflows (new commands: `/explore`, `/research`, `/decision`)
- Requirements documentation structure
- Other improvements discovered during dev-infra development

**Opportunity:** 
- Templates could include all workflow automation by default
- New projects would have complete workflow structure ready
- Better developer experience from day one
- Templates evolve based on dev-infra learnings

**Context:**
- Dev-infra didn't start with robust workflow structure
- Commands were adapted but not templated
- CI/CD improvements have different structure than features
- New exploration/research/decision commands need templating

---

## 💡 Initial Thoughts

**What exists in templates:**
- `templates/standard-project/` - Standard project template
- `templates/learning-project/` - Learning project template
- `scripts/new-project.sh` - Template generator script
- `scripts/validate-templates.sh` - Template validation script

**What's missing:**
- Workflow automation commands (`.cursor/commands/`)
- CI/CD improvement structure in templates
- Exploration/research/decision structure
- Requirements documentation structure
- Integration of new commands into templates

**What needs research:**
- How to structure commands in templates
- How to integrate CI/CD improvement structure
- How to include exploration/research/decision workflows
- What other enhancements are needed
- How to update generator script for new structures

---

## 🔍 Key Questions

- [ ] What commands should be included in templates?
- [ ] How should commands be organized in templates?
- [ ] What CI/CD improvement structure should templates include?
- [ ] How should exploration/research/decision workflows be structured?
- [ ] What requirements documentation structure is needed?
- [ ] How should generator script be updated?
- [ ] What validation is needed for new structures?
- [ ] What other enhancements are needed?

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research templates-enhancement --from-explore templates-enhancement` to conduct research
3. After research, use `/decision templates-enhancement --from-research` to make decisions
4. Use `/transition-plan --from-adr` to transition to feature planning

---

## 📝 Notes

**Current Templates:**
- `templates/standard-project/` - Has `docs/maintainers/planning/` structure
- `templates/learning-project/` - Has `docs/maintainers/planning/` structure

**Current Scripts:**
- `scripts/new-project.sh` - Generates projects from templates
- `scripts/validate-templates.sh` - Validates template structure

**Commands to Template:**
- 14 workflow automation commands adapted
- 3 new commands: `/explore`, `/research`, `/decision`
- Updated `/transition-plan` with ADR support

**Structures to Add:**
- CI/CD improvement structure
- Exploration/research/decision structure
- Requirements documentation structure

---

**Last Updated:** 2025-12-07

