# Research: Workflow Automation Commands Integration

**Research Topic:** Templates Enhancement  
**Question:** How should workflow automation commands be integrated into templates? What commands should be included, and how should they be organized?  
**Status:** 🔴 Research  
**Created:** 2025-12-07  
**Last Updated:** 2025-12-07

---

## 🎯 Research Question

How should workflow automation commands be integrated into templates? What commands should be included, and how should they be organized?

---

## 🔍 Research Goals

- [ ] Goal 1: Determine which commands should be included in templates
- [ ] Goal 2: Understand how commands should be organized in templates
- [ ] Goal 3: Identify command documentation requirements
- [ ] Goal 4: Determine template structure for commands

---

## 📚 Research Methodology

**Sources:**
- [ ] Source 1: Current commands in `.cursor/commands/` (17 commands total)
- [ ] Source 2: Command Testing & Template Integration feature plan
- [ ] Source 3: Template structure analysis
- [ ] Source 4: Command usage patterns in dev-infra

---

## 📊 Findings

### Finding 1: Current Command Inventory

**Finding:** Dev-infra has 17 commands total:
- 14 adapted commands from work-prod
- 3 new commands: `/explore`, `/research`, `/decision`

**Commands:**
1. `/cursor-rules` - Rules management
2. `/decision` - Decision making (NEW)
3. `/explore` - Exploration (NEW)
4. `/fix-implement` - Fix implementation
5. `/fix-plan` - Fix planning
6. `/fix-review` - Fix review
7. `/int-opp` - Internal opportunities
8. `/post-pr` - Post-PR documentation
9. `/pre-phase-review` - Pre-phase review
10. `/pr` - PR creation
11. `/pr-validation` - PR validation
12. `/reflect` - Reflection
13. `/reflection-artifacts` - Reflection artifacts
14. `/research` - Research (NEW)
15. `/task-improvement` - CI/CD improvement tasks
16. `/task-phase` - Feature phase tasks
17. `/task-release` - Release tasks
18. `/transition-plan` - Transition planning

**Source:** `.cursor/commands/` directory listing

**Relevance:** All commands should potentially be included in templates, but need to determine which are essential vs optional.

---

### Finding 2: Command Testing & Template Integration Plan

**Finding:** Feature plan exists for command testing and template integration, but focuses on testing first, then integration.

**Key Points:**
- Phase 1: Test all commands in dev-infra
- Phase 2: Copy commands to templates
- Phase 3: Documentation and examples

**Source:** `admin/planning/features/command-testing-integration/feature-plan.md`

**Relevance:** Provides roadmap but doesn't specify which commands to include or how to organize them.

---

### Finding 3: Template Structure Analysis

**Finding:** Templates currently don't have `.cursor/commands/` directory. Commands would need to be added.

**Current Template Structure:**
- `templates/standard-project/` - Has `docs/maintainers/planning/` but no `.cursor/commands/`
- `templates/learning-project/` - Has `docs/maintainers/planning/` but no `.cursor/commands/`

**Source:** Template directory listing

**Relevance:** Commands need to be added to templates, but structure needs to be determined.

---

### Finding 4: Command Path Detection Patterns

**Finding:** Commands support multiple path detection patterns:
- Dev-infra structure: `admin/` paths
- Template structure: `docs/maintainers/` paths
- Project-wide structure: `docs/maintainers/` paths

**Key Pattern:** Commands auto-detect structure based on what exists.

**Source:** Command documentation (e.g., `/explore`, `/research`, `/decision`)

**Relevance:** Commands are already designed to work with template structure (`docs/maintainers/`), so integration should be straightforward.

---

## 🔍 Analysis

**Key Insights:**

- [ ] Insight 1: All 17 commands should be included in templates - they're all useful and commands auto-detect structure
- [ ] Insight 2: Commands should be in `.cursor/commands/` directory in templates - standard location
- [ ] Insight 3: Commands already support `docs/maintainers/` paths - no path changes needed
- [ ] Insight 4: Command documentation should be included - commands are self-documenting

**Command Organization:**
- Commands should be copied as-is to `templates/standard-project/.cursor/commands/`
- Commands should be copied as-is to `templates/learning-project/.cursor/commands/`
- No modification needed - commands auto-detect structure

**Command Selection:**
- Include all 17 commands - they're all useful
- Commands are self-contained and work with template structure
- No subset needed - full command suite provides best developer experience

---

## 💡 Recommendations

- [ ] Recommendation 1: Include all 17 commands in templates - they're all useful and commands auto-detect structure
- [ ] Recommendation 2: Copy commands to `.cursor/commands/` in both templates - standard location
- [ ] Recommendation 3: No command modification needed - commands already support template structure
- [ ] Recommendation 4: Include command documentation in template READMEs - help users discover commands

---

## 📋 Requirements Discovered

- [ ] Requirement 1: Templates must include `.cursor/commands/` directory
- [ ] Requirement 2: All 17 commands must be copied to templates
- [ ] Requirement 3: Commands must work with `docs/maintainers/` structure (already supported)
- [ ] Requirement 4: Template READMEs must document commands

---

## 🚀 Next Steps

1. Copy all 17 commands to `templates/standard-project/.cursor/commands/`
2. Copy all 17 commands to `templates/learning-project/.cursor/commands/`
3. Update template READMEs with command documentation
4. Test template generation includes commands

---

**Last Updated:** 2025-12-07

