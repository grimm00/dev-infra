# ADR 0002: CI/CD Workflow Improvements

**Status:** 🟡 Proposed  
**Date:** 2025-01-27  
**Deciders:** Dev-Infra Maintainers  
**Tags:** ci-cd, workflows, testing, automation

---

## Context

The dev-infra project currently has:
- Manual test execution (no automated CI/CD testing)
- Release distribution workflow with basic validation
- No multi-environment testing
- No workflow optimizations (concurrency, path filtering, etc.)
- Manual version updates in README
- Manual PR feedback collection

Research has identified opportunities to:
1. Add automated multi-environment testing
2. Optimize workflows with industry best practices
3. Enhance release distribution validation
4. Automate version management
5. Improve PR feedback collection (future)

---

## Decision

We will implement the following CI/CD workflow improvements:

### 1. Multi-Environment Testing

**Decision:** Implement automated testing with Ubuntu + macOS matrix strategy

**Implementation:**
- Create `.github/workflows/test.yml` with matrix strategy
- Test on `ubuntu-latest` and `macos-latest`
- Integrate tests into release workflow (block release if tests fail)
- Windows support deferred - research as later task

**Rationale:**
- Covers primary development platforms
- Tests critical cross-platform differences (`sed -i` behavior)
- Represents majority of users
- Lower CI/CD cost and complexity than Windows

### 2. External CI/CD Patterns (Optimizations)

**Decision:** Implement industry best practices for workflow optimization

**Implementation:**
- Add concurrency control to all workflows (~50% CI minute savings)
- Add path-based filtering (skip `docs/**`, `admin/**`, `**/*.md` changes)
- Add draft PR filtering (skip full validation for draft PRs)
- Add timeout limits to all workflows (prevent hung workflows)

**Rationale:**
- Significant cost savings (~50% reduction in CI minutes)
- Better developer experience (faster feedback, less noise)
- Aligns with Git Flow practices (docs can merge directly)
- Prevents wasted CI minutes on duplicate runs

### 3. Release Distribution Validation

**Decision:** Enhance workflow validation for distribution packages

**Implementation:**
- Add validation for `.gitignore`, `.dockerignore` exclusion
- Add validation for `tests/` directory exclusion
- Keep workflow validation separate from `validate-templates.sh`

**Rationale:**
- `validate-templates.sh` validates source templates (development tool)
- Workflow validation validates distribution packages (release tool)
- Different purposes, both needed
- Prevents accidental inclusion of internal files

### 4. Auto-Update README Version

**Decision:** Automate README version updates from release tag

**Implementation:**
- Add workflow step to update README.md from release tag
- Keep tags as single source of truth
- No `.version` file needed (current approach sufficient)

**Rationale:**
- Eliminates manual README update step
- Prevents version drift between tag and README
- Simple and effective (no new files to manage)
- Current tag-based approach works well

### 5. PR Feedback Automation (Future)

**Decision:** Enhance `dt-review` tool in dev-toolkit for PR feedback collection

**Implementation:**
- Enhance `dt-review` tool for Bugbot support
- Add dev-infra markdown format option
- Document usage in dev-infra
- Defer GitHub Actions automation (future consideration)

**Rationale:**
- Reusable across projects (not just dev-infra)
- Centralized in dev-toolkit (easier maintenance)
- Can run locally for testing
- Lower complexity than full GitHub Actions automation

---

## Consequences

### Positive

- ✅ **Automated Testing** - Catch issues before release, multi-platform validation
- ✅ **Cost Savings** - ~50% reduction in CI minutes through optimizations
- ✅ **Better Developer Experience** - Faster feedback, less noise, predictable CI
- ✅ **Quality Assurance** - Multiple validation layers, comprehensive coverage
- ✅ **Reduced Manual Work** - Auto-update README, automated testing
- ✅ **Future-Proof** - Scalable approach for growth

### Negative

- ⚠️ **Initial Setup** - Requires creating new workflows and updating existing ones
- ⚠️ **Maintenance** - Additional workflows to maintain
- ⚠️ **Learning Curve** - Team needs to understand new workflow patterns

### Neutral

- Windows support deferred (research as later task)
- PR feedback automation deferred (after dev-toolkit enhancement)
- No breaking changes to existing workflows

---

## Rationale

These decisions are based on:

1. **Research Analysis** - Comprehensive evaluation of current state and opportunities
2. **Industry Best Practices** - External CI/CD patterns from proven workflows
3. **Cost-Benefit Analysis** - Low-to-medium effort with high value
4. **Separation of Concerns** - Different tools for different purposes (validate-templates.sh vs workflow)
5. **Pragmatic Approach** - Defer complex features (Windows, full automation) until needed

The recommendations balance:
- Immediate value (testing, optimizations)
- Future flexibility (deferred features)
- Cost efficiency (optimizations save money)
- Developer experience (faster feedback, less manual work)

---

## Alternatives Considered

### Alternative 1: Windows Testing Now
**Deferred because:**
- Low user base on Windows
- Higher complexity (WSL, Git Bash, path handling)
- Can be added later if demand increases
- Ubuntu + macOS covers critical cross-platform differences

### Alternative 2: GitHub Actions PR Feedback Automation
**Deferred because:**
- More complex than dev-toolkit approach
- Less reusable across projects
- dev-toolkit tool already exists, just needs enhancement
- Can be added later if needed

### Alternative 3: `.version` File Approach
**Rejected because:**
- Current tag-based approach works well
- No need for additional file management
- Auto-update README is sufficient enhancement
- Can be reconsidered if release frequency increases

### Alternative 4: validate-templates.sh for Distribution Validation
**Rejected because:**
- Different purposes: source templates vs distribution package
- Workflow validation is appropriate for distribution packages
- Both tools should coexist (defense in depth)
- Separation of concerns is clearer

---

## References

- **[CI/CD Workflow Improvements Research](../research/ci-cd-workflow-improvements/README.md)** - Research hub
- **[Multi-Environment Testing](../research/ci-cd-workflow-improvements/multi-environment-testing.md)** - Testing strategy
- **[External Patterns Analysis](../research/ci-cd-workflow-improvements/external-patterns-analysis.md)** - Industry best practices
- **[Release Distribution Validation](../research/ci-cd-workflow-improvements/release-distribution-validation.md)** - Validation analysis
- **[Version Management](../research/ci-cd-workflow-improvements/version-management.md)** - Versioning approach
- **[PR Feedback Automation](../research/ci-cd-workflow-improvements/pr-feedback-automation.md)** - Automation options
- **[Consolidated Recommendations](../research/ci-cd-workflow-improvements/recommendations.md)** - Implementation roadmap

---

## Implementation

### Phase 1: Quick Wins (6-8 hours)

1. **Multi-Environment Testing** (2-3 hours)
   - Create `.github/workflows/test.yml`
   - Add Ubuntu + macOS matrix
   - Integrate with release workflow

2. **External CI/CD Patterns** (2-3 hours)
   - Add concurrency control to all workflows
   - Add path-based filtering (docs/admin/markdown)
   - Add draft PR filtering
   - Add timeout limits

3. **Release Distribution Validation** (1-2 hours)
   - Add validation for hidden files exclusion
   - Add validation for tests exclusion

4. **Auto-Update README Version** (1 hour)
   - Add workflow step to update README from tag

### Phase 2: Tool Enhancement (2-3 hours, Future)

1. **Enhance dt-review Tool** (dev-toolkit)
   - Add Bugbot support
   - Add dev-infra markdown format
   - Test locally

2. **Document Usage** (dev-infra)
   - Document `dt-review` usage in CONTRIBUTING.md
   - Add to PR workflow documentation

### Phase 3: Future Enhancements (As Needed)

1. **Windows Testing** (if user demand increases)
2. **GitHub Actions PR Feedback Automation** (if manual process becomes burden)
3. **Automated Version Bumping** (if release frequency increases)

---

## Success Criteria

- [ ] Tests run automatically on all PRs
- [ ] Tests block release if they fail
- [ ] Release validation catches excluded files
- [ ] README version updates automatically
- [ ] Workflows optimized with concurrency control and path filtering
- [ ] CI minutes reduced by ~50%
- [ ] Developer experience improved (faster feedback, less noise)

---

**Last Updated:** 2025-01-27  
**Status:** 🟡 Proposed  
**Next:** Review and approval, then Phase 1 implementation

