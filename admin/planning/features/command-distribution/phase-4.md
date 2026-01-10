# Command Distribution - Phase 4: Integration Validation

**Phase:** 4 - Integration Validation  
**Duration:** ~2-3 hours  
**Status:** ✅ Expanded  
**Prerequisites:** Phase 2 (dt-cursor-install works) and Phase 3 (standard documented)

---

## 📋 Overview

Validate that the integration architecture meets ADR-003 requirements: all integrations are optional, tools degrade gracefully, and configuration patterns are documented.

**Success Definition:** All integration requirements verified, graceful degradation tested, and configuration guidelines documented.

---

## 🎯 Goals

1. **Verify optional integrations** - Confirm each tool works without the others
2. **Test graceful degradation** - Test scenarios where integrations are unavailable
3. **Document configuration patterns** - Document XDG-compliant configuration guidelines

---

## 📝 Tasks

### Task 1: Create Integration Validation Checklist

**Purpose:** Create a formal validation checklist that can be used for this phase and future releases.

**File:** `docs/INTEGRATION-VALIDATION.md`

**Process:**

1. **Create validation document:**

   ```markdown
   # Integration Validation Checklist

   **Purpose:** Validate that all Four-Arm Architecture integrations meet ADR-003 requirements  
   **Last Validated:** YYYY-MM-DD  
   **Version:** vX.Y.Z (of each tool)

   ---

   ## 📋 Quick Links

   - **[ADR-003: Integration Architecture](../admin/decisions/four-arm-architecture/adr-003-integration-architecture.md)** - Requirements source
   - **[Requirements](../admin/research/four-arm-architecture/requirements.md)** - Full requirements list

   ---

   ## ✅ NFR-IP-1: All Integrations Optional

   **Requirement:** All integrations between tools MUST be optional.

   ### Validation

   | Tool | Without | Expected Behavior | Status |
   |------|---------|-------------------|--------|
   | proj-cli | work-prod API | Clear error message, no crash | ⬜ |
   | dt-cursor-install | dev-infra releases | Clear error message, lists retry options | ⬜ |
   | dt-cursor-install | network | Uses cached version OR clear error | ⬜ |
   | dev-toolkit scripts | proj-cli | Scripts work independently | ⬜ |
   | dev-toolkit scripts | work-prod | Scripts work independently | ⬜ |

   ---

   ## ✅ NFR-IP-2: Offline Core Functionality

   **Requirement:** Tools MUST work offline for core functionality.

   ### Validation

   | Tool | Core Feature | Offline Behavior | Status |
   |------|--------------|------------------|--------|
   | proj-cli | `proj --help` | Works (no API needed) | ⬜ |
   | proj-cli | `proj config` | Works (local config) | ⬜ |
   | dt-cursor-install | `--status` | Shows installed version | ⬜ |
   | dt-cursor-install | `--help` | Works (no network needed) | ⬜ |
   | dev-toolkit | All scripts | No network required for core | ⬜ |

   ---

   ## ✅ NFR-IP-3: XDG Configuration Pattern

   **Requirement:** Configuration MUST follow XDG Base Directory pattern.

   ### Validation

   | Tool | Config Location | Follows XDG? | Notes |
   |------|-----------------|--------------|-------|
   | proj-cli | `~/.config/proj/config.yaml` | ✅ Yes | Supports `XDG_CONFIG_HOME` |
   | dev-toolkit | `~/.dev-toolkit/config.conf` | ⚠️ Custom | Pre-existing pattern, acceptable |
   | dt-cursor-install | `~/.dev-toolkit/cursor-commands-version` | ⚠️ Custom | Data file, could use `~/.local/share/` |

   ### XDG Environment Variables

   ```bash
   # Test XDG_CONFIG_HOME override
   export XDG_CONFIG_HOME="$HOME/.test-config"
   proj config get api_url
   # Should use $HOME/.test-config/proj/config.yaml
   ```

   ---

   ## ✅ NFR-IP-4: No Runtime Dependencies

   **Requirement:** No runtime dependencies between tools.

   ### Validation

   | Tool A | Tool B | Can A run without B installed? | Status |
   |--------|--------|-------------------------------|--------|
   | proj-cli | dev-toolkit | ✅ Yes | ⬜ |
   | proj-cli | dev-infra | ✅ Yes (uses templates at creation) | ⬜ |
   | dev-toolkit | proj-cli | ✅ Yes | ⬜ |
   | dev-toolkit | work-prod | ✅ Yes | ⬜ |
   | dt-cursor-install | proj-cli | ✅ Yes | ⬜ |

   ---

   ## ✅ C-IP-1: No Shared Configuration

   **Constraint:** Tools MUST NOT share configuration files.

   ### Validation

   | Scenario | Expected | Status |
   |----------|----------|--------|
   | proj-cli doesn't read `~/.dev-toolkit/` | Verified | ⬜ |
   | dev-toolkit doesn't read `~/.config/proj/` | Verified | ⬜ |
   | No `~/.dev-infra.yml` or similar shared file | Verified | ⬜ |

   ---

   ## ✅ C-IP-2: No Direct Tool Dependencies

   **Constraint:** Tools MUST NOT have direct dependencies on each other.

   ### Validation

   | Tool | Dependencies | No Cross-Tool Deps? | Status |
   |------|--------------|---------------------|--------|
   | proj-cli | requests, typer, pydantic | ✅ No proj deps | ⬜ |
   | dev-toolkit | bash, git, gh | ✅ No proj deps | ⬜ |
   | dev-infra | bash (scripts only) | ✅ No proj deps | ⬜ |
   | work-prod | Flask, SQLAlchemy | ✅ No proj deps | ⬜ |

   ---

   ## 🧪 Validation Procedures

   ### Procedure 1: proj-cli Without work-prod

   ```bash
   # Ensure work-prod is NOT running
   curl http://localhost:5000/api/projects 2>/dev/null && echo "STOP: work-prod is running"

   # Test proj-cli
   proj list
   # Expected: Error message about API unavailable
   # Expected: Exit code non-zero
   # Expected: No stack trace or crash
   ```

   ### Procedure 2: dt-cursor-install Without Network

   ```bash
   # Simulate network unavailable (Mac)
   # Option A: Disconnect from network
   # Option B: Use invalid URL

   # Test with invalid repo
   DT_TEST_REPO="invalid/repo" dt-cursor-install --list
   # Expected: Clear error about network/repo
   # Expected: Suggests checking network or repo name
   ```

   ### Procedure 3: dt-cursor-install Version Not Found

   ```bash
   dt-cursor-install --install v99.99.99
   # Expected: Error about version not found
   # Expected: Lists available versions
   # Expected: No crash
   ```

   ### Procedure 4: XDG Override

   ```bash
   # Test XDG_CONFIG_HOME override for proj-cli
   export XDG_CONFIG_HOME="/tmp/test-xdg"
   mkdir -p "$XDG_CONFIG_HOME/proj"
   echo "api_url: http://test:9999" > "$XDG_CONFIG_HOME/proj/config.yaml"
   proj config get api_url
   # Expected: http://test:9999
   unset XDG_CONFIG_HOME
   ```

   ---

   ## 📊 Validation Summary

   | Category | Items | Passed | Status |
   |----------|-------|--------|--------|
   | NFR-IP-1: Optional Integrations | 5 | 0 | ⬜ |
   | NFR-IP-2: Offline Core | 5 | 0 | ⬜ |
   | NFR-IP-3: XDG Pattern | 3 | 0 | ⬜ |
   | NFR-IP-4: No Runtime Deps | 5 | 0 | ⬜ |
   | C-IP-1: No Shared Config | 3 | 0 | ⬜ |
   | C-IP-2: No Tool Deps | 4 | 0 | ⬜ |
   | **Total** | **25** | **0** | ⬜ |

   ---

   **Last Validated:** YYYY-MM-DD  
   **Validator:** [Name]  
   **Tools Versions:**
   - proj-cli: vX.Y.Z
   - dev-toolkit: vX.Y.Z
   - dev-infra: vX.Y.Z
   - work-prod: vX.Y.Z
   ```

2. **Update docs/README.md with link:**

   Add to "Integration & Architecture" or similar section:

   ```markdown
   - **[Integration Validation](INTEGRATION-VALIDATION.md)** - ADR-003 compliance checklist
   ```

**Checklist:**

- [ ] INTEGRATION-VALIDATION.md created
- [ ] All NFR-IP and C-IP requirements covered
- [ ] Validation procedures documented
- [ ] docs/README.md updated with link

---

### Task 2: Create Configuration Guidelines

**Purpose:** Document configuration patterns for current and future tools.

**File:** `docs/CONFIGURATION-GUIDELINES.md`

**Process:**

1. **Create guidelines document:**

   ```markdown
   # Configuration Guidelines

   **Purpose:** Standard configuration patterns for Four-Arm Architecture tools  
   **Based On:** ADR-003 Integration Architecture  
   **Last Updated:** YYYY-MM-DD

   ---

   ## 📋 Quick Links

   - **[ADR-003: Integration Architecture](../admin/decisions/four-arm-architecture/adr-003-integration-architecture.md)** - Decision record
   - **[XDG Base Directory Spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)** - Standard reference

   ---

   ## 🎯 Guiding Principles

   1. **Per-Tool Configuration** - Each tool manages its own config
   2. **No Shared Config** - Tools never read each other's config files
   3. **Optional Integrations** - Missing config = graceful defaults
   4. **XDG Compliance** - New tools use XDG Base Directory pattern

   ---

   ## 📁 XDG Base Directory Pattern

   Use these paths for new configuration:

   | Type | Environment Variable | Default | Example |
   |------|---------------------|---------|---------|
   | **Config** | `$XDG_CONFIG_HOME` | `~/.config` | `~/.config/tool/config.yaml` |
   | **Data** | `$XDG_DATA_HOME` | `~/.local/share` | `~/.local/share/tool/data.db` |
   | **Cache** | `$XDG_CACHE_HOME` | `~/.cache` | `~/.cache/tool/cache.json` |

   ### Implementation Pattern

   **Bash:**

   ```bash
   # Get XDG-compliant config path
   CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mytools"
   CONFIG_FILE="$CONFIG_DIR/config.yaml"

   # Ensure directory exists
   mkdir -p "$CONFIG_DIR"
   ```

   **Python:**

   ```python
   import os
   from pathlib import Path

   def get_config_home() -> Path:
       """Get XDG-compliant config directory."""
       xdg_config = os.environ.get("XDG_CONFIG_HOME")
       if xdg_config:
           return Path(xdg_config)
       return Path.home() / ".config"

   CONFIG_DIR = get_config_home() / "mytool"
   CONFIG_FILE = CONFIG_DIR / "config.yaml"
   ```

   ---

   ## 🔧 Current Tool Configurations

   ### proj-cli

   | Type | Location | XDG Compliant |
   |------|----------|---------------|
   | Config | `~/.config/proj/config.yaml` | ✅ Yes |

   **Environment Overrides:**
   - `PROJ_API_URL` - API base URL
   - `XDG_CONFIG_HOME` - Config directory override

   **Example config.yaml:**
   ```yaml
   api_url: http://localhost:5000
   default_format: table
   ```

   ---

   ### dev-toolkit

   | Type | Location | XDG Compliant |
   |------|----------|---------------|
   | Config | `~/.dev-toolkit/config.conf` | ⚠️ Custom |
   | Data | `~/.dev-toolkit/cursor-commands-version` | ⚠️ Custom |

   **Note:** dev-toolkit uses a custom location for historical reasons. This is acceptable as it pre-dates the XDG adoption. New dev-toolkit features should consider XDG paths.

   **Example config.conf:**
   ```bash
   GITHUB_OWNER="grimm00"
   DEFAULT_SOURCERY_REVIEWER="sourcery-ai[bot]"
   ```

   ---

   ### work-prod

   | Type | Location | XDG Compliant |
   |------|----------|---------------|
   | Config | Environment variables | N/A (Flask standard) |
   | Data | `backend/instance/` | N/A (Flask standard) |

   **Environment Variables:**
   - `FLASK_ENV` - development/production
   - `DATABASE_URL` - Database connection (optional)

   ---

   ### dev-infra

   | Type | Location | XDG Compliant |
   |------|----------|---------------|
   | N/A | N/A | N/A (templates only) |

   dev-infra has no runtime configuration. It provides templates that projects instantiate.

   ---

   ## 🚫 Anti-Patterns

   ### ❌ Shared Configuration File

   ```yaml
   # DON'T DO THIS: ~/.dev-infra.yml
   proj-cli:
     api_url: http://localhost:5000
   dev-toolkit:
     github_owner: grimm00
   ```

   **Why:** Creates coupling between tools. Each tool should be independently configurable.

   ---

   ### ❌ Reading Other Tool's Config

   ```python
   # DON'T DO THIS in proj-cli
   dev_toolkit_config = Path.home() / ".dev-toolkit" / "config.conf"
   github_owner = parse_config(dev_toolkit_config)["GITHUB_OWNER"]
   ```

   **Why:** Creates hidden dependency. If user only has proj-cli, it would fail.

   ---

   ### ❌ Hard-Coded Paths

   ```python
   # DON'T DO THIS
   CONFIG_FILE = "/home/user/.config/proj/config.yaml"
   ```

   **Why:** Breaks on different systems. Use `Path.home()` and `XDG_*` variables.

   ---

   ## ✅ Best Practices

   ### ✅ Sensible Defaults

   ```python
   # DO THIS
   api_url = config.get("api_url", "http://localhost:5000")
   ```

   **Why:** Tools work out-of-the-box without configuration.

   ---

   ### ✅ Environment Variable Overrides

   ```python
   # DO THIS
   api_url = os.environ.get("PROJ_API_URL") or config.get("api_url")
   ```

   **Why:** Allows CI/CD and container configuration without files.

   ---

   ### ✅ Graceful Missing Config

   ```python
   # DO THIS
   try:
       config = load_config(CONFIG_FILE)
   except FileNotFoundError:
       config = {}  # Use defaults
   ```

   **Why:** First-run experience is smooth.

   ---

   ## 🔗 Related Documents

   - [ADR-003: Integration Architecture](../admin/decisions/four-arm-architecture/adr-003-integration-architecture.md)
   - [Integration Validation Checklist](INTEGRATION-VALIDATION.md)
   - [proj-cli Config Source](https://github.com/grimm00/proj-cli/blob/main/src/proj/config.py)

   ---

   **Last Updated:** YYYY-MM-DD
   ```

2. **Update docs/README.md with link:**

   ```markdown
   - **[Configuration Guidelines](CONFIGURATION-GUIDELINES.md)** - Tool configuration patterns
   ```

**Checklist:**

- [ ] CONFIGURATION-GUIDELINES.md created
- [ ] XDG pattern documented
- [ ] Current tool configs documented
- [ ] Anti-patterns documented
- [ ] Best practices documented
- [ ] docs/README.md updated

---

### Task 3: Validate dt-cursor-install Graceful Degradation

**Purpose:** Verify that dt-cursor-install handles error scenarios gracefully.

**Prerequisites:** Phase 2 complete (dt-cursor-install implemented)

**Process:**

1. **Test: Network unavailable**

   ```bash
   # Simulate by using invalid repo
   # (Actual implementation depends on dev-toolkit's approach)
   
   # Expected behavior:
   # - Clear error message about network/repo
   # - Exit code non-zero
   # - No stack trace
   # - Suggestions for resolution
   ```

2. **Test: Version not found**

   ```bash
   dt-cursor-install --install v99.99.99
   
   # Expected behavior:
   # - Error: Version v99.99.99 not found
   # - Lists available versions (or suggests --list)
   # - Exit code non-zero
   # - No crash
   ```

3. **Test: No previous install**

   ```bash
   # Remove any cached commands
   rm -rf ~/.cursor/commands
   rm -f ~/.dev-toolkit/cursor-commands-version
   
   dt-cursor-install --status
   
   # Expected behavior:
   # - Message: No commands installed
   # - Suggests dt-cursor-install to install
   # - Exit code 0 (informational, not error)
   ```

4. **Test: Corrupted version file**

   ```bash
   echo "garbage" > ~/.dev-toolkit/cursor-commands-version
   dt-cursor-install --status
   
   # Expected behavior:
   # - Handles gracefully (reports unknown version or re-validates)
   # - No crash
   ```

5. **Document results in INTEGRATION-VALIDATION.md:**

   Update the validation checklist with results.

**Checklist:**

- [ ] Network unavailable tested
- [ ] Version not found tested
- [ ] No previous install tested
- [ ] Corrupted version file tested
- [ ] All tests pass or issues documented
- [ ] INTEGRATION-VALIDATION.md updated with results

---

### Task 4: Validate proj-cli Graceful Degradation

**Purpose:** Verify that proj-cli handles missing work-prod gracefully.

**Prerequisites:** proj-cli installed

**Process:**

1. **Test: work-prod API unavailable**

   ```bash
   # Ensure work-prod is NOT running
   curl http://localhost:5000/api/projects 2>/dev/null && echo "STOP: work-prod running"
   
   # Test proj-cli
   proj list
   
   # Expected behavior:
   # - Error: Cannot connect to API at http://localhost:5000
   # - Suggests: Is work-prod running?
   # - Exit code non-zero
   # - No stack trace
   ```

2. **Test: Config file missing**

   ```bash
   # Backup and remove config
   mv ~/.config/proj/config.yaml ~/.config/proj/config.yaml.bak
   
   proj config get api_url
   
   # Expected behavior:
   # - Uses default: http://localhost:5000
   # - No error (defaults are sensible)
   
   # Restore
   mv ~/.config/proj/config.yaml.bak ~/.config/proj/config.yaml
   ```

3. **Test: Help commands work offline**

   ```bash
   # Should work without any network/API
   proj --help
   proj config --help
   proj list --help
   
   # Expected: All display help text, exit 0
   ```

4. **Document results in INTEGRATION-VALIDATION.md:**

   Update the validation checklist with results.

**Checklist:**

- [ ] API unavailable tested
- [ ] Config file missing tested
- [ ] Help commands tested offline
- [ ] All tests pass or issues documented
- [ ] INTEGRATION-VALIDATION.md updated with results

---

### Task 5: Validate XDG Compliance

**Purpose:** Verify XDG Base Directory compliance for proj-cli.

**Prerequisites:** proj-cli installed

**Process:**

1. **Test: XDG_CONFIG_HOME override**

   ```bash
   # Create test directory
   export XDG_CONFIG_HOME="/tmp/test-xdg-config"
   mkdir -p "$XDG_CONFIG_HOME/proj"
   
   # Create test config
   echo "api_url: http://test-server:9999" > "$XDG_CONFIG_HOME/proj/config.yaml"
   
   # Verify proj-cli uses it
   proj config get api_url
   # Expected: http://test-server:9999
   
   # Cleanup
   rm -rf "$XDG_CONFIG_HOME"
   unset XDG_CONFIG_HOME
   ```

2. **Test: Default XDG paths**

   ```bash
   # Verify default location
   ls -la ~/.config/proj/
   # Expected: config.yaml exists (if ever configured)
   ```

3. **Document results in INTEGRATION-VALIDATION.md:**

   Update XDG compliance section.

**Checklist:**

- [ ] XDG_CONFIG_HOME override tested
- [ ] Default paths verified
- [ ] INTEGRATION-VALIDATION.md updated

---

### Task 6: Final Validation and Documentation Update

**Purpose:** Complete validation checklist and update all documentation.

**Process:**

1. **Complete INTEGRATION-VALIDATION.md checklist:**

   - Fill in all status checkboxes
   - Add validation date
   - Add tool versions tested

2. **Update feature hub status:**

   Update `admin/planning/features/command-distribution/README.md`:
   - Mark Phase 4 as complete
   - Update progress metrics

3. **Update related documentation:**

   - Ensure all cross-links work
   - Update "Last Updated" dates

4. **Create summary:**

   Document any issues found and their resolutions.

**Commit:**

```bash
git add docs/INTEGRATION-VALIDATION.md
git add docs/CONFIGURATION-GUIDELINES.md
git add docs/README.md
git add admin/planning/features/command-distribution/

git commit -m "docs(integration): add integration validation and configuration guidelines

Create ADR-003 compliance documentation:
- docs/INTEGRATION-VALIDATION.md - Validation checklist (25 items)
- docs/CONFIGURATION-GUIDELINES.md - Configuration patterns

Validates:
- NFR-IP-1: All integrations optional
- NFR-IP-2: Offline core functionality
- NFR-IP-3: XDG configuration pattern
- NFR-IP-4: No runtime dependencies
- C-IP-1: No shared configuration
- C-IP-2: No direct tool dependencies

Complete Phase 4 of command-distribution feature."

git push origin develop
```

**Checklist:**

- [ ] INTEGRATION-VALIDATION.md complete
- [ ] CONFIGURATION-GUIDELINES.md complete
- [ ] Feature hub updated
- [ ] All cross-links verified
- [ ] Changes committed
- [ ] Pushed to develop

---

## ✅ Completion Criteria

- [ ] Integration validation checklist created (INTEGRATION-VALIDATION.md)
- [ ] Configuration guidelines documented (CONFIGURATION-GUIDELINES.md)
- [ ] dt-cursor-install graceful degradation verified
- [ ] proj-cli graceful degradation verified
- [ ] XDG compliance verified
- [ ] All documentation cross-linked

---

## 📦 Deliverables

1. **Validation Checklist:** `docs/INTEGRATION-VALIDATION.md`
2. **Configuration Guidelines:** `docs/CONFIGURATION-GUIDELINES.md`
3. **Updated docs hub:** `docs/README.md` with new links
4. **Updated feature hub:** Phase 4 marked complete

---

## 📊 Progress Tracking

| Task | Status | Notes |
|------|--------|-------|
| Task 1: Create Validation Checklist | 🔴 Not Started | Can start now (template) |
| Task 2: Create Configuration Guidelines | 🔴 Not Started | Can start now |
| Task 3: Validate dt-cursor-install | 🔴 Not Started | Needs Phase 2 complete |
| Task 4: Validate proj-cli | 🔴 Not Started | Can test now |
| Task 5: Validate XDG Compliance | 🔴 Not Started | Can test now |
| Task 6: Final Documentation | 🔴 Not Started | After all validation |

---

## 🔗 Dependencies

### Prerequisites

- Phase 2 complete (dt-cursor-install implemented) - for Task 3
- Phase 3 complete (standard documented) - for cross-references

### Blocks

- None (final phase)

---

## 📚 Requirements Addressed

| Requirement | Description | Task |
|-------------|-------------|------|
| NFR-IP-1 | All integrations MUST be optional | Tasks 3, 4 |
| NFR-IP-2 | Tools MUST work offline for core functionality | Tasks 3, 4 |
| NFR-IP-3 | Configuration MUST follow XDG pattern | Tasks 2, 5 |
| NFR-IP-4 | No runtime dependencies between tools | Task 1 |
| C-IP-1 | No shared configuration | Tasks 1, 2 |
| C-IP-2 | No direct tool dependencies | Task 1 |

---

## 🧪 Validation Scenarios Summary

| Scenario | Tool | Test | Expected |
|----------|------|------|----------|
| 1 | proj-cli | Without work-prod API | Clear error, no crash |
| 2 | dt-cursor-install | Without network | Cached version or clear error |
| 3 | dt-cursor-install | Non-existent version | Error with available versions |
| 4 | All | XDG_CONFIG_HOME override | Uses custom path |
| 5 | All | `--help` commands | Works offline |

---

## 🔗 Related Documents

- [Feature Hub](README.md)
- [Transition Plan](transition-plan.md)
- [Previous Phase: Phase 3](phase-3.md)
- [ADR-003: Integration Architecture](../../../decisions/four-arm-architecture/adr-003-integration-architecture.md)
- [Requirements](../../../research/four-arm-architecture/requirements.md) - NFR-IP-1 through NFR-IP-4

---

**Last Updated:** 2025-12-31  
**Status:** ✅ Expanded  
**Next:** Begin implementation with Task 1 (after Phase 2 complete for Task 3)
