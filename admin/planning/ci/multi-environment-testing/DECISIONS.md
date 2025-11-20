# Multi-Environment Testing Workflow - Design Decisions

**Last Updated:** 2025-01-27

---

## 🎯 Key Decisions

### 1. Operating Systems: Ubuntu + macOS (Windows Deferred)

**Decision:** Test on Ubuntu and macOS only, defer Windows support

**Rationale:**

- Covers primary development platforms (majority of users)
- Tests critical cross-platform differences (`sed -i` behavior)
- Lower CI/CD cost and complexity
- Windows support can be added later if user demand increases

**Alternatives Considered:**

- Ubuntu + macOS + Windows - Higher cost/complexity, low user base
- Ubuntu only - Misses macOS-specific issues
- Research first - Delays implementation unnecessarily

**Windows Support:**

- Deferred to future task
- Will research Windows BATS compatibility, user demand, cost/benefit
- Can be added if needed

---

### 2. Matrix Strategy: Parallel Execution

**Decision:** Use GitHub Actions matrix strategy for parallel execution

**Rationale:**

- Runs tests on both platforms simultaneously
- Faster overall execution
- Clear visibility into platform-specific issues
- Standard GitHub Actions pattern

**Matrix Configuration:**

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest]
```

**Alternatives Considered:**

- Sequential execution - Slower, less efficient
- Single platform - Misses cross-platform issues

---

### 3. Two-Stage Testing: Quick Checks + Full Tests

**Decision:** Implement two-stage testing (quick checks + full tests)

**Rationale:**

- Quick checks provide fast feedback (unit tests only)
- Full tests ensure comprehensive coverage (all test types)
- Better developer experience (faster iteration)
- Cost-effective (quick checks are fast and cheap)

**Quick Checks:**

- Unit tests only
- Ubuntu only
- 10 minute timeout
- Fast feedback for developers

**Full Tests:**

- All tests (unit, integration, regression)
- Ubuntu + macOS matrix
- 30 minute timeout
- Comprehensive validation

**Alternatives Considered:**

- Single stage (all tests) - Slower feedback
- Three stages - Unnecessary complexity

---

### 4. Concurrency Control: Cancel In-Progress

**Decision:** Add concurrency control to cancel in-progress runs

**Rationale:**

- Prevents duplicate workflow runs
- Saves CI minutes (~50% reduction)
- Faster feedback (only latest run matters)
- Industry best practice

**Configuration:**

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.event.pull_request.head.ref || github.ref }}
  cancel-in-progress: true
```

**Alternatives Considered:**

- No concurrency control - Wastes CI minutes
- Queue instead of cancel - Slower feedback

---

### 5. Path-Based Filtering: Skip Docs/Admin/Markdown

**Decision:** Skip CI for documentation-only changes

**Rationale:**

- Aligns with Git Flow (docs can merge directly)
- Saves CI minutes (~20% reduction)
- Faster feedback for code changes
- Reduces unnecessary runs

**Paths Ignored:**

- `**/*.md` - Markdown files
- `docs/**` - Documentation directory
- `admin/**` - Admin directory (while it exists in main repo)

**Alternatives Considered:**

- No path filtering - Wastes CI minutes on docs-only changes
- More restrictive filtering - May miss important changes

---

### 6. Draft PR Filtering: Skip Full Validation

**Decision:** Skip full validation for draft PRs

**Rationale:**

- Saves CI minutes (~30% reduction)
- Better developer experience (iterate without CI overhead)
- Full validation only when PR is ready
- Cost-effective approach

**Configuration:**

```yaml
if: ${{ github.event.pull_request.draft == false || github.event_name == 'push' }}
```

**Alternatives Considered:**

- No draft filtering - Wastes CI minutes on WIP PRs
- Skip all tests for drafts - May miss issues

---

### 7. Timeout Limits: Prevent Hung Workflows

**Decision:** Add timeout limits to all jobs

**Rationale:**

- Prevents hung workflows
- Fails fast on issues
- Predictable CI times
- Cost control (limits maximum run time)

**Timeout Configuration:**

- Quick checks: 10 minutes
- Full tests: 30 minutes

**Alternatives Considered:**

- No timeouts - Risk of hung workflows
- Longer timeouts - Higher cost risk

---

### 8. Integration with Release: Block on Failure

**Decision:** Make tests block release if they fail

**Rationale:**

- Ensures quality before release
- Prevents broken releases
- Standard practice
- Quality gate for releases

**Configuration:**

```yaml
create-distribution:
  needs: [quick-checks, full-tests]
```

**Alternatives Considered:**

- Tests don't block release - Allows broken releases
- Optional tests - Reduces quality assurance

---

### 9. BATS Installation: Platform-Specific

**Decision:** Install BATS differently on each platform

**Rationale:**

- Ubuntu: `apt-get install bats`
- macOS: `brew install bats-core`
- Platform-specific installation is required
- Standard approach for multi-platform workflows

**Installation:**

```yaml
- name: Install BATS
  run: |
    if [ "${{ runner.os }}" == "Linux" ]; then
      sudo apt-get update && sudo apt-get install -y bats
    elif [ "${{ runner.os }}" == "macOS" ]; then
      brew install bats-core
    fi
```

**Alternatives Considered:**

- Pre-installed BATS - Not available on GitHub runners
- Docker image - Adds complexity

---

### 10. Test Execution: Recursive BATS

**Decision:** Use `bats --recursive tests/` for test execution

**Rationale:**

- Runs all tests in subdirectories
- Matches local development workflow
- Simple and effective
- Standard BATS pattern

**Execution:**

- Quick checks: `bats --recursive tests/unit/`
- Full tests: `bats --recursive tests/`

**Alternatives Considered:**

- Explicit file listing - More maintenance
- Single test file - Doesn't match structure

---

## 📊 Decision Summary

| Decision            | Choice               | Rationale                              |
| ------------------- | -------------------- | -------------------------------------- |
| Operating Systems   | Ubuntu + macOS       | Covers primary platforms, lower cost   |
| Matrix Strategy     | Parallel             | Faster execution, better visibility    |
| Testing Stages      | Two-stage            | Fast feedback + comprehensive coverage |
| Concurrency         | Cancel in-progress   | Saves CI minutes, faster feedback      |
| Path Filtering      | Skip docs/admin      | Aligns with Git Flow, saves minutes    |
| Draft PR Filtering  | Skip full validation | Better UX, cost-effective              |
| Timeout Limits      | 10/30 minutes        | Prevents hung workflows, cost control  |
| Release Integration | Block on failure     | Quality gate, prevents broken releases |
| BATS Installation   | Platform-specific    | Required for multi-platform            |
| Test Execution      | Recursive            | Matches local workflow, simple         |

---

## 🔄 Future Considerations

### Windows Support

- Research Windows BATS compatibility
- Evaluate user demand
- Assess cost/benefit
- Add if needed

### Additional Optimizations

- Test result caching (if beneficial)
- Parallel test execution within jobs (if needed)
- Coverage reporting (nice-to-have)

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Decisions Documented
