# Research: Sync Strategy

**Research Topic:** Experimental Template  
**Question:** How do we keep experimental template in sync with standard?  
**Priority:** 🟡 Medium  
**Status:** ✅ Complete  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12  
**Completed:** 2025-12-12

---

## 🎯 Research Question

How do we keep the experimental template in sync with the standard template to prevent drift and minimize maintenance burden?

**The problem:**

- Standard template evolves over time
- Experimental template must include standard changes PLUS experimental features
- Manual sync is error-prone and time-consuming

---

## 🔍 Research Goals

- [x] Goal 1: Evaluate inheritance/extension approaches
- [x] Goal 2: Identify drift detection mechanisms
- [x] Goal 3: Define the sync/update workflow
- [x] Goal 4: Assess automation opportunities

---

## 📚 Research Methodology

**Note:** Research based on established patterns and dev-infra context.

**Sources:**

- [x] Current dev-infra template structure
- [x] Git submodules/subtrees patterns
- [x] Symbolic links for shared files
- [x] CI/CD drift detection approaches
- [x] Template inheritance patterns

---

## 📊 Findings

### Finding 1: Template File Categories

Analysis of `standard-project` shows files fall into categories:

| Category                    | Examples                            | Sync Approach       |
| --------------------------- | ----------------------------------- | ------------------- |
| **Shared Infrastructure**   | `.gitignore`, `README.md` structure | Should be identical |
| **Shared Workflows**        | CI/CD base configs                  | Should be identical |
| **Shared Documentation**    | `docs/` structure                   | Should be identical |
| **Commands (Stable)**       | Essential/Valuable/Advanced         | Should be identical |
| **Commands (Experimental)** | Evolving tier                       | Experimental only   |
| **Template Identity**       | Template name, description          | Different by design |

**Source:** Analysis of `templates/standard-project/`

**Relevance:** Not all files need syncing; categorization enables targeted sync.

---

### Finding 2: Symbolic Links Have Platform Limitations

**Symbolic Links:**

- ✅ Simple to implement
- ✅ Single source of truth
- ❌ Windows compatibility issues
- ❌ Git handling varies
- ❌ Can confuse some tools

**Git Behavior:**

```bash
# Git can store symlinks, but Windows may have issues
git config core.symlinks true
```

**Source:** Git documentation, cross-platform development patterns

**Relevance:** Symlinks work on macOS/Linux but cause Windows issues. Not recommended for dev-infra templates.

---

### Finding 3: Git Submodules Add Complexity

**Git Submodules:**

- ✅ Clear separation of concerns
- ✅ Version pinning
- ❌ Complex update workflow
- ❌ Users unfamiliar with submodules
- ❌ Overkill for internal template sync

**Source:** Git documentation

**Relevance:** Too complex for internal template sync use case.

---

### Finding 4: CI-Based Drift Detection is Most Practical

**Approach:** Compare files in CI, fail if drift detected

```bash
# Example drift detection script
#!/bin/bash
SHARED_FILES=(
  ".gitignore"
  ".github/workflows/base.yml"
  "docs/CONTRIBUTING.md"
)

for file in "${SHARED_FILES[@]}"; do
  if ! diff -q "templates/standard-project/$file" "templates/experimental-project/$file"; then
    echo "DRIFT DETECTED: $file"
    exit 1
  fi
done
```

**Source:** CI/CD patterns, dev-infra existing validation

**Relevance:** Extends existing template validation approach. Detects drift early.

---

### Finding 5: Manual Sync with Checklist is Simple and Effective

**Workflow:**

1. Make change to standard template
2. Check if file is in "shared" category
3. If shared, copy to experimental template
4. CI validates sync

**Checklist Document:**

```markdown
## Shared Files (Must Sync)

- [ ] .gitignore
- [ ] .github/workflows/test.yml
- [ ] docs/CONTRIBUTING.md
- [ ] .cursor/commands/essential-\*.md
- [ ] .cursor/commands/valuable-\*.md
- [ ] .cursor/commands/advanced-\*.md
```

**Source:** Best practice for low-volume sync needs

**Relevance:** Simple, explicit, works with existing workflow.

---

## 📊 Sync Approach Comparison (Updated)

| Approach              | Complexity | Reliability | Automation   | Dev-Infra Fit     |
| --------------------- | ---------- | ----------- | ------------ | ----------------- |
| **Manual Sync**       | 🟢 Low     | 🟠 Medium   | 🔴 None      | 🟡 Acceptable     |
| **Manual + CI Check** | 🟢 Low     | 🟢 High     | 🟢 Detection | ⭐ Best           |
| **Symbolic Links**    | 🟢 Low     | 🟠 Medium   | 🟢 High      | 🔴 Windows issues |
| **Git Submodules**    | 🟠 High    | 🟢 High     | 🟡 Medium    | 🔴 Overkill       |
| **Script Sync**       | 🟡 Medium  | 🟡 Medium   | 🟢 High      | 🟡 Acceptable     |

---

## 🔍 Analysis

**Recommended Approach: Manual Sync + CI Drift Detection**

**Why:**

1. **Low complexity** - No new tooling required
2. **High reliability** - CI catches mistakes
3. **Explicit** - Developers know what's shared
4. **Fits workflow** - Integrates with existing PR process

**Workflow:**

```
Developer updates standard-project
    ↓
Developer checks shared files list
    ↓
If shared: copy to experimental-project
    ↓
CI runs drift detection
    ↓
If drift: PR fails with clear message
    ↓
Developer fixes drift
```

**Key Insights:**

- [x] Insight 1: Not all files need syncing; categorization is key
- [x] Insight 2: CI drift detection is most practical for dev-infra scale
- [x] Insight 3: Symbolic links cause cross-platform issues
- [x] Insight 4: Manual sync with checklist is simple and effective

---

## 💡 Recommendations

- [x] Recommendation 1: Implement CI-based drift detection for shared files
- [x] Recommendation 2: Document shared file categories explicitly
- [x] Recommendation 3: Use manual sync workflow with PR checklist
- [x] Recommendation 4: Avoid symlinks due to Windows compatibility

---

## 📋 Requirements Discovered

- [x] REQ-SS-1: CI validation script to detect template drift
- [x] REQ-SS-2: Documentation of shared vs experimental-only files
- [x] REQ-SS-3: PR checklist for template changes
- [x] REQ-SS-4: Clear error messages when drift detected

---

## 🚀 Next Steps

1. ✅ Research complete
2. Continue with Graduation Path research
3. Implement drift detection in template validation CI

---

**Last Updated:** 2025-12-12
