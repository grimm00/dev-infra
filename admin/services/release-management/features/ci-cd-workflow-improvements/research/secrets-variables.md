# CI/CD Secrets and Variables

**Purpose:** Document required secrets and variables for CI/CD workflows  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This document lists all secrets and variables required for dev-infra CI/CD workflows, including:
- Current requirements
- Future requirements (if adding new features)
- Setup instructions
- Security considerations

---

## 📋 Current Workflows

### Release Distribution Workflow

**File:** `.github/workflows/release-distribution.yml`

**Secrets Used:**

| Secret | Required | Purpose | Default |
|--------|----------|---------|---------|
| `PAT_TOKEN` | Optional | Personal Access Token for uploading to manually-created releases | Falls back to `GITHUB_TOKEN` |
| `GITHUB_TOKEN` | Automatic | GitHub Actions default token (provided automatically) | Always available |

**Variables Used:**

| Variable | Source | Purpose |
|----------|--------|---------|
| `github.event.release.tag_name` | GitHub Actions | Release tag name |
| `github.repository` | GitHub Actions | Repository name (owner/repo) |
| `GITHUB_OUTPUT` | GitHub Actions | Workflow step outputs |

**Setup Instructions:**

1. **PAT_TOKEN (Optional):**
   - Create Personal Access Token with `repo` scope
   - Add to repository secrets: Settings → Secrets → New repository secret
   - Name: `PAT_TOKEN`
   - Only needed if manually creating releases (not using GitHub UI)

2. **GITHUB_TOKEN (Automatic):**
   - Provided automatically by GitHub Actions
   - No setup required
   - Has permissions for repository operations

---

## 🔍 Test Workflow (Future)

### Planned Test Workflow

**File:** `.github/workflows/test.yml` (to be created)

**Secrets Required:**

| Secret | Required | Purpose | Default |
|--------|----------|---------|---------|
| None | N/A | Tests use mocks, no real API calls | N/A |

**Variables Used:**

| Variable | Source | Purpose |
|----------|--------|---------|
| `matrix.os` | GitHub Actions | Operating system (ubuntu-latest, macos-latest) |
| `runner.os` | GitHub Actions | Runner operating system |

**Setup Instructions:**

- **No secrets required** - Tests use mocks for external dependencies
- **No setup needed** - All variables provided by GitHub Actions

---

## 🔐 Security Considerations

### Secret Management

**Best Practices:**

1. **Never Commit Secrets**
   - ✅ Use GitHub Secrets for sensitive data
   - ❌ Never hardcode secrets in workflows
   - ❌ Never commit secrets to repository

2. **Least Privilege**
   - Use minimal required permissions
   - `GITHUB_TOKEN` has default permissions (can be restricted)
   - `PAT_TOKEN` should have minimal required scopes

3. **Secret Rotation**
   - Rotate `PAT_TOKEN` periodically (if used)
   - Monitor secret usage
   - Revoke unused secrets

### Token Scopes

**PAT_TOKEN Required Scopes:**
- `repo` - Full repository access (for uploading release assets)

**GITHUB_TOKEN Permissions:**
- `contents: write` - Required for uploading release assets
- `id-token: write` - Required for some GitHub API operations

**Workflow Permissions:**
```yaml
permissions:
  contents: write  # Required to upload release assets
  id-token: write # Required for some GitHub API operations
```

---

## 📊 Future Requirements

### Potential Future Secrets

**If Adding Real API Tests:**

| Secret | Purpose | When Needed |
|--------|---------|-------------|
| `GITHUB_TOKEN` | Real GitHub API tests | If adding real API integration tests |
| `TEST_GITHUB_USERNAME` | Test account username | If adding real authentication tests |

**Recommendation:**
- **Current:** No additional secrets needed
- **Future:** Add secrets only if implementing real API tests
- **Documentation:** Document that mocks are used, no secrets required

### Potential Future Variables

**If Adding PR Feedback Automation:**

| Variable | Purpose | When Needed |
|----------|---------|-------------|
| `github.event.issue.number` | PR number | If adding automated PR feedback collection |
| `github.event.comment.body` | Comment content | If parsing PR comments |

**Recommendation:**
- **Current:** Not needed
- **Future:** Add if implementing PR feedback automation
- **Documentation:** Document in PR feedback automation research

---

## 🔧 Setup Checklist

### Repository Secrets

- [ ] **PAT_TOKEN** (Optional)
  - [ ] Create Personal Access Token
  - [ ] Add to repository secrets
  - [ ] Verify token has `repo` scope
  - [ ] Test workflow with token

### Workflow Permissions

- [ ] **Release Distribution Workflow**
  - [ ] Verify `contents: write` permission
  - [ ] Verify `id-token: write` permission
  - [ ] Test release asset upload

### Test Workflow (Future)

- [ ] **Test Workflow**
  - [ ] No secrets required (mocks used)
  - [ ] Verify matrix strategy works
  - [ ] Test on Ubuntu and macOS

---

## 📝 Summary

### Current Requirements

**Secrets:**
- ✅ `PAT_TOKEN` (optional) - For manual release uploads
- ✅ `GITHUB_TOKEN` (automatic) - Provided by GitHub Actions

**Variables:**
- ✅ All variables provided by GitHub Actions
- ✅ No custom variables needed

### Future Requirements

**Secrets:**
- ⏳ None planned (tests use mocks)
- ⏳ Add only if implementing real API tests

**Variables:**
- ⏳ None planned
- ⏳ Add only if implementing new features

### Setup Priority

- **High:** Verify `GITHUB_TOKEN` permissions (automatic)
- **Medium:** Add `PAT_TOKEN` if manually creating releases
- **Low:** Future secrets (only if needed)

---

## 🔗 Related Documentation

- **[Release Distribution Workflow](../../planning/ci/release-distribution/README.md)** - Release workflow details
- **[Multi-Environment Testing](multi-environment-testing.md)** - Test workflow requirements
- **[GitHub Actions Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)** - Official secrets documentation

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Documentation Complete

