# Manual Testing Guide - Experimental Template

**Feature:** Experimental Template  
**Phases Covered:** 1, 2, 3  
**Last Updated:** 2025-12-15  
**Status:** ✅ Active

---

## 📋 Overview

This guide provides step-by-step instructions for manually verifying the experimental template feature. These tests are designed for **human testers** to validate functionality beyond what automated tests cover.

**Purpose:**

- Verify user-facing functionality works as expected
- Test edge cases and error handling
- Validate documentation and user experience
- Ensure stability warnings are clear and visible

**Prerequisites:**

- Access to the dev-infra repository
- Terminal/command line access
- Temporary directory for test projects (will be created during testing)

---

## 🧪 Phase 1: Template Structure Verification

### Scenario 1.1: Verify Experimental Template Exists

**Objective:** Confirm the experimental-project template was created correctly.

**Steps:**

1. Navigate to the templates directory:

   ```bash
   cd /path/to/dev-infra/templates
   ls -la
   ```

2. Verify `experimental-project/` directory exists alongside `standard-project/` and `learning-project/`.

**Expected Result:** ✅ Three template directories visible:

- `standard-project/`
- `learning-project/`
- `experimental-project/`

---

### Scenario 1.2: Verify Experimental Template Structure

**Objective:** Confirm the experimental template has the same base structure as standard-project.

**Steps:**

1. Compare directory structure:

   ```bash
   # List standard-project structure
   find templates/standard-project -type d | head -20

   # List experimental-project structure
   find templates/experimental-project -type d | head -20
   ```

2. Verify key directories exist in experimental:
   ```bash
   ls templates/experimental-project/
   ```

**Expected Result:** ✅ Both templates should have matching structure:

- `.cursor/commands/`
- `backend/`
- `frontend/`
- `docs/`
- `tests/`
- `scripts/`

---

### Scenario 1.3: Verify Evolving Command Exists

**Objective:** Confirm the `/status` evolving command exists only in experimental template.

**Steps:**

1. Check for status command in experimental:

   ```bash
   ls templates/experimental-project/.cursor/commands/ | grep status
   ```

2. Verify it does NOT exist in standard:
   ```bash
   ls templates/standard-project/.cursor/commands/ | grep status
   ```

**Expected Result:**

- ✅ `status.md` exists in `experimental-project/.cursor/commands/`
- ✅ `status.md` does NOT exist in `standard-project/.cursor/commands/`

---

### Scenario 1.4: Verify Stability Disclaimer in README

**Objective:** Confirm the experimental template README includes stability warnings.

**Steps:**

1. Read the experimental template README:

   ```bash
   cat templates/experimental-project/README.md | head -50
   ```

2. Look for:
   - ⚠️ Warning emoji or "Experimental" in header
   - Stability disclaimer section
   - Explanation of what "experimental" means

**Expected Result:** ✅ README should contain:

- Clear "Experimental Template" or "⚠️" indicator
- Warning about potential breaking changes
- Guidance on when to use experimental vs standard

---

### Scenario 1.5: Verify EXPERIMENTAL.md Documentation

**Objective:** Confirm the experimental-only documentation exists and is informative.

**Steps:**

1. Check EXPERIMENTAL.md exists:

   ```bash
   cat templates/experimental-project/docs/EXPERIMENTAL.md
   ```

2. Verify it contains:
   - List of evolving commands
   - Stability tier explanations
   - Feedback mechanism information

**Expected Result:** ✅ Documentation clearly explains:

- What commands are experimental
- What stability levels mean (🟢/🟠/🔴)
- How users can provide feedback

---

## 🧪 Phase 2: Generator Script Testing

### Scenario 2.1: Interactive Mode - Select Experimental Template

**Objective:** Verify the generator prompts for template type and shows warning.

**Prerequisites:** Create a temporary test directory.

**Steps:**

1. Create test directory:

   ```bash
   mkdir -p /tmp/manual-test-experimental
   cd /tmp/manual-test-experimental
   ```

2. Run generator in interactive mode:

   ```bash
   /path/to/dev-infra/scripts/new-project.sh
   ```

3. When prompted for project name, enter: `test-exp-project`

4. When prompted for template type, observe the options:

   - Should see numbered options including "experimental-project"
   - Option should include ⚠️ warning indicator

5. Select the experimental-project option.

6. Observe:

   - A stability warning should be displayed
   - User should be asked to confirm their choice

7. Confirm the selection.

**Expected Result:** ✅

- Template type menu shows experimental with ⚠️ warning
- Stability warning displayed when experimental selected
- Confirmation requested before proceeding
- Project generated successfully

---

### Scenario 2.2: Verify Generated Experimental Project

**Objective:** Confirm generated project has experimental features.

**Steps:**

1. After generating (from Scenario 2.1), check the project:

   ```bash
   ls test-exp-project/
   ```

2. Verify experimental-specific files exist:

   ```bash
   # Check for status command
   ls test-exp-project/.cursor/commands/ | grep status

   # Check for EXPERIMENTAL.md
   ls test-exp-project/docs/ | grep -i experimental
   ```

3. Check README for stability disclaimer:
   ```bash
   head -30 test-exp-project/README.md
   ```

**Expected Result:** ✅ Generated project contains:

- `/status` command (evolving tier)
- `docs/EXPERIMENTAL.md`
- Stability disclaimer in README

---

### Scenario 2.3: Non-Interactive Mode with Experimental Type

**Objective:** Verify generator accepts experimental type via environment variables in non-interactive mode.

**Steps:**

1. Navigate to test directory:

   ```bash
   cd /tmp/manual-test-experimental
   ```

2. Run generator with environment variables and `--non-interactive` flag:

   ```bash
   PROJECT_NAME="test-nonint-exp" \
   PROJECT_TYPE="experimental-project" \
   TARGET_DIR="/tmp/manual-test-experimental" \
   INIT_GIT="false" \
   /path/to/dev-infra/scripts/new-project.sh --non-interactive
   ```

3. Verify project was created:
   ```bash
   ls test-nonint-exp/
   ```

**Expected Result:** ✅ Project generated without prompts when using `--non-interactive` mode with environment variables

---

### Scenario 2.4: Help Text Shows Experimental Option

**Objective:** Verify help text documents the experimental template option.

**Steps:**

1. Run generator with help flag:

   ```bash
   /path/to/dev-infra/scripts/new-project.sh --help
   ```

2. Look for:
   - `experimental-project` mentioned as valid type
   - Warning about experimental features

**Expected Result:** ✅ Help text includes:

- `experimental-project` as valid template type
- Note about experimental/evolving commands

---

### Scenario 2.5: Compare Standard vs Experimental Generation

**Objective:** Verify differences between standard and experimental generated projects.

**Steps:**

1. Generate both types (using non-interactive mode):

   ```bash
   cd /tmp/manual-test-experimental

   # Generate standard project
   PROJECT_NAME="test-standard" \
   PROJECT_TYPE="standard-project" \
   TARGET_DIR="/tmp/manual-test-experimental" \
   INIT_GIT="false" \
   /path/to/dev-infra/scripts/new-project.sh --non-interactive

   # Generate experimental project
   PROJECT_NAME="test-experimental" \
   PROJECT_TYPE="experimental-project" \
   TARGET_DIR="/tmp/manual-test-experimental" \
   INIT_GIT="false" \
   /path/to/dev-infra/scripts/new-project.sh --non-interactive
   ```

2. Compare command directories:

   ```bash
   # Count commands in each
   ls test-standard/.cursor/commands/ | wc -l
   ls test-experimental/.cursor/commands/ | wc -l
   ```

3. Find the difference:
   ```bash
   diff <(ls test-standard/.cursor/commands/) <(ls test-experimental/.cursor/commands/)
   ```

**Expected Result:** ✅

- Experimental has MORE commands than standard
- Difference should be the evolving tier commands (e.g., `status.md`)

---

## 🧪 Phase 3: Drift Detection Testing

### Scenario 3.1: Run Drift Detection (Templates in Sync)

**Objective:** Verify drift detection passes when templates are synchronized.

**Steps:**

1. Navigate to dev-infra root:

   ```bash
   cd /path/to/dev-infra
   ```

2. Run the drift detection script:
   ```bash
   ./scripts/validate-template-sync.sh
   ```

**Expected Result:** ✅ Output shows:

```
ℹ️ 🔍 Validating template sync...

✅ Template sync validation PASSED
ℹ️ All shared files are in sync
```

---

### Scenario 3.2: Intentionally Introduce Drift

**Objective:** Verify drift detection catches differences in shared files.

**⚠️ Warning:** This test modifies files. Restore them after testing!

**Steps:**

1. Backup a shared file:

   ```bash
   cp templates/standard-project/.gitignore /tmp/gitignore.backup
   ```

2. Modify the file in one template only:

   ```bash
   echo "# Test drift" >> templates/standard-project/.gitignore
   ```

3. Run drift detection:

   ```bash
   ./scripts/validate-template-sync.sh
   ```

4. **Restore the file immediately:**
   ```bash
   cp /tmp/gitignore.backup templates/standard-project/.gitignore
   ```

**Expected Result:** ✅ Script should:

- Exit with non-zero status
- Display "DRIFT DETECTED" message
- List the file(s) that differ (`.gitignore`)

---

### Scenario 3.3: Verify Manifest File

**Objective:** Understand what files are tracked for synchronization.

**Steps:**

1. Read the manifest file:

   ```bash
   cat scripts/template-sync-manifest.txt
   ```

2. Verify it contains:
   - Infrastructure files (`.gitignore`, `.dockerignore`)
   - Core directories (`backend/`, `frontend/`, etc.)
   - Stable commands (individual command files)
   - Comments explaining exclusions

**Expected Result:** ✅ Manifest clearly documents:

- Which files must stay in sync
- Which files are intentionally different (in comments)
- File categories for organization

---

### Scenario 3.4: Verify Sync Documentation

**Objective:** Confirm sync documentation is helpful for users.

**Steps:**

1. Read the sync documentation:

   ```bash
   cat docs/TEMPLATE-SYNC.md
   ```

2. Verify it explains:
   - Why sync matters
   - How to fix drift
   - How to add new shared files
   - Common issues and solutions

**Expected Result:** ✅ Documentation provides clear guidance for:

- Understanding sync requirements
- Fixing drift when detected
- Maintaining templates going forward

---

### Scenario 3.5: Verify CI Integration

**Objective:** Confirm drift detection is integrated into CI workflow.

**Steps:**

1. Check the test workflow:
   ```bash
   grep -A 3 "Validate Template Sync" .github/workflows/test.yml
   ```

**Expected Result:** ✅ Workflow includes:

```yaml
- name: Validate Template Sync
  run: ./scripts/validate-template-sync.sh
```

---

## 🧹 Cleanup

After completing manual testing, clean up test directories:

```bash
rm -rf /tmp/manual-test-experimental
rm -f /tmp/gitignore.backup
```

---

## ✅ Acceptance Criteria Checklist

### Phase 1: Template Structure

- [ ] Experimental template directory exists
- [ ] Structure matches standard-project base
- [ ] Evolving command(s) present in experimental only
- [ ] README includes stability disclaimer
- [ ] EXPERIMENTAL.md documentation complete

### Phase 2: Generator Script

- [ ] Interactive mode shows experimental option with warning
- [ ] Stability warning displayed when selecting experimental
- [ ] Non-interactive mode accepts experimental type
- [ ] Help text documents experimental option
- [ ] Generated projects have correct content

### Phase 3: Drift Detection

- [ ] Script passes when templates are in sync
- [ ] Script fails and reports when drift exists
- [ ] Manifest file is clear and complete
- [ ] Documentation explains sync process
- [ ] CI workflow includes validation step

---

## 📝 Notes for Testers

1. **Restore Files:** Always restore any files you modify during drift testing.

2. **Clean Test Environment:** Use `/tmp` or another temporary location for generated test projects.

3. **Report Issues:** If any scenario fails unexpectedly, document:

   - The exact steps you followed
   - The expected vs actual result
   - Any error messages

4. **Feedback Welcome:** These tests help improve the feature. Suggestions for additional test scenarios are appreciated.

---

## 🔗 Related Documents

- **Feature Plan:** [feature-plan.md](feature-plan.md)
- **Phase Documents:** [phase-1.md](phase-1.md) | [phase-2.md](phase-2.md) | [phase-3.md](phase-3.md)
- **Sync Documentation:** [docs/TEMPLATE-SYNC.md](../../../docs/TEMPLATE-SYNC.md)
- **Template Usage:** [docs/TEMPLATE-USAGE.md](../../../docs/TEMPLATE-USAGE.md)

---

**Last Updated:** 2025-12-15
