# PR Feedback Automation Research

**Purpose:** Evaluate options for automating PR feedback collection and formatting  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This document evaluates approaches for automating the collection and formatting of PR feedback from Sourcery and Bugbot, comparing GitHub Actions workflows vs dev-toolkit tool approach.

---

## 📋 Current State

### Manual Process

**Current Workflow:**
1. PR is created/updated
2. Sourcery and Bugbot post comments on PR
3. Developer manually:
   - Copies feedback from PR comments
   - Formats into markdown files in `admin/feedback/sourcery/` or `admin/feedback/bugbot/`
   - Creates assessment documents
   - Updates priority matrices
   - Documents decisions

**Files Created:**
- `admin/feedback/sourcery/prXX.md` - Sourcery feedback
- `admin/feedback/bugbot/prXX.md` - Bugbot feedback
- `admin/feedback/sourcery/prXX-assessment.md` - Assessment (when needed)

**Time Investment:**
- ~10-15 minutes per PR for feedback collection and formatting
- Manual copy-paste and formatting
- Risk of missing comments or formatting inconsistencies

### Existing Tool: `dt-review`

**Location:** dev-toolkit project  
**Purpose:** Extract and format Sourcery reviews  
**Status:** Exists but not integrated into dev-infra workflow

**Capabilities (Inferred):**
- Extracts Sourcery review comments
- Formats into markdown
- May support Bugbot (unknown)

---

## 🔍 Option 1: GitHub Actions Workflow

### Approach

Create a GitHub Actions workflow that:
1. Triggers on PR comments or PR events
2. Uses GitHub API to collect comments from Sourcery/Bugbot
3. Formats comments into markdown
4. Commits formatted files to repository
5. Optionally creates PR with formatted feedback

### Implementation Details

**Workflow Trigger:**
```yaml
on:
  issue_comment:
    types: [created]
  pull_request:
    types: [opened, synchronize]
```

**GitHub API Usage:**
- `GET /repos/{owner}/{repo}/pulls/{pull_number}/comments` - PR review comments
- `GET /repos/{owner}/{repo}/issues/{issue_number}/comments` - Issue comments
- Filter by author: `author_association: "NONE"` or specific usernames

**Formatting Logic:**
- Parse comment body for structured feedback
- Extract priority, impact, effort from comments
- Generate markdown with consistent formatting
- Create assessment document if needed

### Pros

✅ **Single Source of Truth** - GitHub is the source  
✅ **Automated** - No manual intervention required  
✅ **Consistent Formatting** - Standardized markdown output  
✅ **Integrated** - Part of dev-infra repository  
✅ **Version Controlled** - Feedback files committed to repo  
✅ **Immediate** - Feedback formatted as soon as comments posted  

### Cons

❌ **Complex Implementation** - Requires GitHub API knowledge  
❌ **Maintenance Burden** - Workflow needs updates for API changes  
❌ **Limited Parsing** - May struggle with unstructured comments  
❌ **GitHub-Specific** - Tied to GitHub platform  
❌ **No Local Tool** - Can't run locally for testing  

### Effort Estimate

- **Initial Implementation:** 🟡 Medium (2-4 hours)
- **Maintenance:** 🟢 Low (occasional updates)
- **Testing:** 🟡 Medium (requires PR testing)

---

## 🔍 Option 2: Dev-Toolkit Tool (`dt-review`)

### Approach

Enhance existing `dt-review` tool in dev-toolkit to:
1. Support both Sourcery and Bugbot
2. Format output consistently
3. Support dev-infra markdown format
4. Can be run locally or in CI/CD

### Implementation Details

**Tool Location:** `dev-toolkit/bin/dt-review`  
**Usage:**
```bash
dt-review <PR_NUMBER> [--format=dev-infra] [--output=admin/feedback/]
```

**Capabilities:**
- Extract comments from GitHub API
- Parse Sourcery/Bugbot comment format
- Generate markdown files
- Support multiple output formats

### Pros

✅ **Reusable** - Can be used across projects  
✅ **Local Testing** - Can run locally for development  
✅ **Flexible** - Supports multiple output formats  
✅ **Maintainable** - Centralized in dev-toolkit  
✅ **Extensible** - Easy to add new features  
✅ **Platform Agnostic** - Not tied to GitHub Actions  

### Cons

❌ **External Dependency** - Requires dev-toolkit installation  
❌ **Manual Execution** - Still requires running command  
❌ **Not Automated** - Not triggered automatically  
❌ **Maintenance Split** - Tool in dev-toolkit, usage in dev-infra  

### Effort Estimate

- **Enhancement:** 🟡 Medium (2-3 hours to add Bugbot support)
- **Integration:** 🟢 Low (document usage, add to workflow)
- **Maintenance:** 🟢 Low (centralized in dev-toolkit)

---

## 🔍 Option 3: Hybrid Approach

### Approach

Combine GitHub Actions workflow with dev-toolkit tool:
1. GitHub Actions workflow triggers on PR comments
2. Workflow calls `dt-review` tool (installed in runner)
3. Tool formats feedback and commits to repository
4. Best of both worlds: automation + reusable tool

### Implementation Details

**Workflow:**
```yaml
- name: Install dev-toolkit
  run: |
    # Install dt-review tool
    
- name: Collect PR feedback
  run: |
    dt-review ${{ github.event.pull_request.number }} --format=dev-infra
    git add admin/feedback/
    git commit -m "docs: collect PR feedback from Sourcery/Bugbot"
    git push
```

### Pros

✅ **Automated** - Triggers automatically  
✅ **Reusable Tool** - Uses dev-toolkit tool  
✅ **Consistent** - Standardized formatting  
✅ **Flexible** - Can run locally too  

### Cons

❌ **Complex Setup** - Requires tool installation in workflow  
❌ **Dependency Management** - Need to manage dev-toolkit version  
❌ **Maintenance** - Both workflow and tool need updates  

### Effort Estimate

- **Initial Setup:** 🟠 High (3-5 hours)
- **Maintenance:** 🟡 Medium (both components)

---

## 📊 Comparison Matrix

| Criteria | GitHub Actions | Dev-Toolkit Tool | Hybrid |
|----------|---------------|------------------|--------|
| **Automation** | ✅ Full | ❌ Manual | ✅ Full |
| **Reusability** | ❌ Dev-infra only | ✅ All projects | ✅ All projects |
| **Local Testing** | ❌ No | ✅ Yes | ✅ Yes |
| **Maintenance** | 🟡 Medium | 🟢 Low | 🟠 High |
| **Implementation** | 🟡 Medium | 🟡 Medium | 🟠 High |
| **Consistency** | ✅ High | ✅ High | ✅ High |
| **Platform Lock-in** | ❌ GitHub only | ✅ Agnostic | ❌ GitHub only |

---

## 🎯 Recommendation

### Recommended Approach: **Option 2 (Dev-Toolkit Tool) with Optional Automation**

**Rationale:**

1. **Reusability** - Tool can be used across all projects, not just dev-infra
2. **Maintainability** - Centralized in dev-toolkit, easier to maintain
3. **Flexibility** - Can run locally for testing, or in CI/CD
4. **Lower Complexity** - Simpler than full GitHub Actions implementation
5. **Future-Proof** - Not tied to GitHub Actions platform

**Implementation Plan:**

1. **Phase 1: Enhance Tool** (dev-toolkit)
   - Add Bugbot support to `dt-review`
   - Add dev-infra markdown format option
   - Test locally

2. **Phase 2: Document Usage** (dev-infra)
   - Document `dt-review` usage in CONTRIBUTING.md
   - Add to PR workflow documentation
   - Create example output

3. **Phase 3: Optional Automation** (dev-infra, future)
   - Add GitHub Actions workflow that calls `dt-review`
   - Make it optional (can still run manually)
   - Document both approaches

### Alternative: Start with Manual, Automate Later

If immediate automation is not critical:
1. **Short-term:** Continue manual process, document `dt-review` usage
2. **Medium-term:** Enhance `dt-review` for dev-infra format
3. **Long-term:** Add optional GitHub Actions automation

---

## 🔧 Implementation Details

### Dev-Toolkit Tool Enhancement

**Required Features:**
- Support Sourcery comment parsing
- Support Bugbot comment parsing
- Generate dev-infra markdown format:
  ```markdown
  # Sourcery Review Analysis
  **PR**: #XX
  **Repository**: owner/repo
  **Generated**: [timestamp]
  
  ## Summary
  Total Individual Comments: X + Overall Comments
  
  ## Individual Comments
  [formatted comments]
  
  ## Overall Comments
  [formatted comments]
  ```

**Optional Features:**
- Priority matrix generation
- Assessment document creation
- Multiple output formats

### GitHub Actions Integration (Future)

**Workflow Structure:**
```yaml
name: Collect PR Feedback

on:
  issue_comment:
    types: [created]
    # Filter for Sourcery/Bugbot comments

jobs:
  collect-feedback:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install dt-review
        run: |
          # Install dev-toolkit/dt-review
      - name: Collect feedback
        run: |
          dt-review ${{ github.event.issue.number }} --format=dev-infra
      - name: Commit feedback
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add admin/feedback/
          git commit -m "docs: collect PR feedback" || exit 0
          git push
```

---

## 📝 Summary

### Current State
- ✅ Manual process works but is time-consuming
- ✅ `dt-review` tool exists but not fully utilized
- ✅ Feedback is consistently formatted

### Recommendation
- **Primary:** Enhance `dt-review` tool in dev-toolkit
- **Secondary:** Document usage in dev-infra
- **Future:** Optional GitHub Actions automation

### Priority
- **High:** Enhance `dt-review` for Bugbot support and dev-infra format
- **Medium:** Document usage and workflow
- **Low:** Add GitHub Actions automation (nice-to-have)

### Effort
- **Tool Enhancement:** 🟡 Medium (2-3 hours)
- **Documentation:** 🟢 Low (1 hour)
- **Automation (Future):** 🟡 Medium (2-3 hours)

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Research Complete

