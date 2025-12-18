# Release Distribution Workflow - Testing Strategy

**Last Updated:** 2025-01-27

---

## 🎯 Testing Goals

1. Validate workflow logic before deploying
2. Ensure distribution contains correct files
3. Verify validation catches problems
4. Test user download experience
5. Confirm cross-platform compatibility

---

## 🧪 Testing Phases

### Phase 1: Local Testing (Before PR)

**Test workflow logic locally:**

```bash
# Simulate workflow steps
PACKAGE_NAME="dev-infra-test"
mkdir -p "${PACKAGE_NAME}"

# Copy files (as workflow does)
cp -r templates/ scripts/ docs/ README.md CHANGELOG.md CONTRIBUTING.md "${PACKAGE_NAME}/"

# Create archives
tar -czf "${PACKAGE_NAME}.tar.gz" "${PACKAGE_NAME}/"
zip -r "${PACKAGE_NAME}.zip" "${PACKAGE_NAME}/"

# Run validation
TEST_DIR="/tmp/test-dist"
mkdir -p "${TEST_DIR}"
tar -xzf "${PACKAGE_NAME}.tar.gz" -C "${TEST_DIR}"

# Check contents
ls -la "${TEST_DIR}/${PACKAGE_NAME}/"
[ -d "${TEST_DIR}/${PACKAGE_NAME}/templates" ] && echo "✅ templates present"
[ ! -d "${TEST_DIR}/${PACKAGE_NAME}/admin" ] && echo "✅ admin excluded"
[ ! -d "${TEST_DIR}/${PACKAGE_NAME}/.cursor" ] && echo "✅ .cursor excluded"

# Cleanup
rm -rf "${TEST_DIR}" "${PACKAGE_NAME}" "${PACKAGE_NAME}.tar.gz" "${PACKAGE_NAME}.zip"
```

### Phase 2: Draft Release Testing (After Merge to Develop)

**Create draft release to test workflow:**

```bash
# Create test tag
git tag -a v1.0.1-test -m "Test release for distribution workflow"
git push origin v1.0.1-test

# Create draft release
gh release create v1.0.1-test --draft --title "Test Release" --notes "Testing distribution workflow"

# Watch Actions tab for workflow execution
# Verify distribution assets are uploaded
# Download and test distributions

# Clean up
gh release delete v1.0.1-test --yes
git tag -d v1.0.1-test
git push origin :refs/tags/v1.0.1-test
```

### Phase 3: User Experience Testing

**Test as end user:**

**Linux/Mac:**
```bash
# Download tar.gz
curl -L "https://github.com/grimm00/dev-infra/releases/download/v0.1.1/dev-infra-0.1.1.tar.gz" -o dev-infra.tar.gz
tar -xzf dev-infra.tar.gz
cd dev-infra-0.1.1

# Verify structure
ls -la
./scripts/new-project.sh  # Should work
./scripts/validate-templates.sh  # Should work
```

**Windows:**
```powershell
# Download zip
curl -L "https://github.com/grimm00/dev-infra/releases/download/v0.1.1/dev-infra-0.1.1.zip" -o dev-infra.zip
Expand-Archive dev-infra.zip
cd dev-infra-0.1.1

# Verify structure
dir
bash scripts/new-project.sh  # Should work (if bash installed)
```

---

## ✅ Validation Checklist

### Required Files Present
- [ ] templates/ directory exists
- [ ] templates/regular-project/ exists
- [ ] templates/learning-project/ exists
- [ ] scripts/ directory exists
- [ ] scripts/new-project.sh exists
- [ ] scripts/validate-templates.sh exists
- [ ] docs/ directory exists
- [ ] docs/README.md exists
- [ ] docs/TEMPLATE-USAGE.md exists
- [ ] docs/INTEGRATION.md exists
- [ ] README.md exists
- [ ] CHANGELOG.md exists
- [ ] CONTRIBUTING.md exists

### Internal Files Excluded
- [ ] admin/ directory NOT present
- [ ] .cursor/ directory NOT present
- [ ] .github/ directory NOT present
- [ ] start.txt NOT present
- [ ] .git/ directory NOT present

### Package Quality
- [ ] tar.gz extracts successfully
- [ ] zip extracts successfully
- [ ] Scripts are executable
- [ ] File permissions preserved
- [ ] Checksums are valid
- [ ] Package size ~50% of full source

### Functional Tests
- [ ] Can run new-project.sh
- [ ] Can run validate-templates.sh
- [ ] Templates are complete
- [ ] Documentation links work

---

## 🐛 Error Scenarios to Test

### Missing Files
- Remove required file before packaging
- Verify validation catches it

### Extra Files
- Include internal file in distribution
- Verify validation catches it

### Corrupted Archive
- Test handling of extraction failures

### Wrong Version
- Test with mismatched version tags

---

## 📊 Success Criteria

- ✅ Workflow completes successfully
- ✅ Distribution assets uploaded
- ✅ Validation passes all checks
- ✅ User can download and extract
- ✅ User can run scripts
- ✅ Package size significantly smaller
- ✅ Checksums validate correctly

---

**Status:** 📋 Planning Complete  
**Next:** Implementation on `ci/release-distribution` branch
