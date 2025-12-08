# Multi-Environment Testing Failed Jobs Documentation - PR #30

**Purpose:** Document failed jobs, error messages, and failure patterns for PR #30  
**Status:** 🟡 Under Investigation  
**Last Updated:** 2025-12-08  
**PR:** #30

---

## 📋 Overview

This document captures detailed information about failed jobs in PR #30. The failures appear to be environment-specific or flaky, as all tests pass locally.

---

## 🔴 Failed Jobs

### Job 1: full-tests-ubuntu

**Status:** ❌ Failed  
**Platform:** ubuntu-latest (Docker container)  
**Workflow:** `.github/workflows/test.yml`  
**Workflow Run:** [20036474596](https://github.com/grimm00/dev-infra/actions/runs/20036474596)  
**Created:** 2025-12-08

**Error Details:**

- **Error Type:** Test Failure (suspected)
- **Error Message:** TBD (to be extracted from workflow logs)
- **Failed Step:** Run all tests
- **Exit Code:** 1 (assumed)

**Local Test Results:**

- **Status:** ✅ All 58 tests passing
- **File Presence:** 21/21 passing
- **Link Validation:** 10/10 passing
- **Structure Validation:** 12/12 passing
- **Generation Success:** 15/15 passing

**Analysis:**

- Tests pass locally but fail in CI
- Suggests environment-specific or flaky test issue
- May be related to Docker container environment
- Not blocking PR validation (local tests passing)

**Next Steps:**

- [ ] Extract workflow run ID and logs
- [ ] Identify specific failing tests
- [ ] Compare local vs CI environment
- [ ] Determine if flaky test or environment issue
- [ ] Document root cause

---

### Job 2: full-tests-macos

**Status:** ⏳ Pending  
**Platform:** macos-latest  
**Workflow:** `.github/workflows/test.yml`  
**Workflow Run:** [To be added]  
**Created:** 2025-12-08

**Note:** Job was pending at time of PR validation. Status to be updated when job completes.

---

## 🔍 Failure Patterns

### Pattern 1: Environment-Specific Test Failures

**Symptoms:**

- Tests pass locally
- Tests fail in CI environment
- Platform-specific differences

**Possible Causes:**

- Docker container environment differences
- Tool version differences
- Timing issues
- Flaky tests

**Investigation Needed:**

- Compare local vs CI environment
- Check Docker image contents
- Review test execution logs
- Identify specific failing tests

---

## 📊 Failure Summary

| Job                | Platform | Status   | Error Type      | Priority | Tests Failing |
| ------------------ | -------- | -------- | --------------- | -------- | ------------- |
| full-tests-ubuntu  | Ubuntu   | ❌ Failed | Test Failure    | 🟡 MEDIUM | TBD           |
| full-tests-macos   | macOS    | ⏳ Pending | N/A             | -        | -             |

**Overall Test Status:**

- **Local Tests:** 58/58 passing (100%)
- **CI Tests:** TBD (pending investigation)

---

## 🔗 Related

- **[Known Issues Registry](../known-issues.md)** - Known Issue #1
- **[Multi-Environment Testing Fix Hub](README.md)** - Fix documentation hub
- **[Root Cause Analysis](root-cause-analysis.md)** - Analysis methodology

---

**Status:** 🟡 Under Investigation  
**Next:** Extract workflow run logs and identify root cause

