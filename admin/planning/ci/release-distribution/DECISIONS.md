# Release Distribution Workflow - Design Decisions

**Last Updated:** 2025-01-27

---

## 🎯 Key Decisions

### 1. Trigger: Release Publication vs Tag Creation

**Decision:** Trigger on `release: types: [published]`

**Rationale:**
- Only runs for actual releases, not every tag
- Allows draft releases for testing
- More intentional and controlled
- Matches user expectation (distribution appears when release is public)

**Alternatives Considered:**
- `push: tags: v*` - Too broad, runs on every tag
- Manual trigger - Defeats purpose of automation

---

### 2. Package Formats: tar.gz + zip

**Decision:** Create both `.tar.gz` and `.zip` formats

**Rationale:**
- tar.gz is standard for Linux/Mac users
- zip is standard for Windows users
- Small overhead to create both
- Better user experience across platforms

**Alternatives Considered:**
- tar.gz only - Windows users less familiar
- zip only - Linux/Mac users prefer tar.gz

---

### 3. Validation: Before Upload

**Decision:** Validate distribution structure before uploading

**Rationale:**
- Catch errors before users see them
- Fail fast if something goes wrong
- Ensures quality and consistency
- No way to "undo" a release asset upload easily

**Validation Checks:**
- Required files present
- Internal files excluded
- Package structure correct
- Both templates included
- Key documentation present

---

### 4. Checksums: SHA256

**Decision:** Generate SHA256 checksums for both packages

**Rationale:**
- Industry standard
- Security best practice
- Allows users to verify download integrity
- Low overhead to generate

---

### 5. Workflow Location: .github/workflows/

**Decision:** Standard GitHub Actions location

**Rationale:**
- GitHub convention
- Easy to find
- Automatically recognized by GitHub

---

### 6. Branch Strategy: Two-Phase Approach

**Decision:** 
1. Planning on `docs/release-distribution` → direct merge to develop
2. Implementation on `ci/release-distribution` → PR to develop

**Rationale:**
- Documentation changes can merge directly (per Git Flow)
- CI changes require PR and review (per Git Flow)
- Separates planning from implementation
- Allows feedback on plan before coding

---

### 7. Distribution Contents: User-Focused Only

**Decision:** Include only user-facing files, exclude internal

**Rationale:**
- Users don't need internal planning docs
- Smaller download size
- Cleaner, more professional
- Less confusing for users
- Full source still available for contributors

---

### 8. Manual Backfill: v1.0.0

**Decision:** Manually create distribution for v1.0.0

**Rationale:**
- v1.0.0 already released
- Can't trigger workflow retroactively
- Provides complete set of distributions
- Tests manual process as backup

---

## 📝 Implementation Notes

### What to Exclude
- `admin/` - Internal planning and management
- `.cursor/` - AI assistant configuration
- `.github/` - CI/CD workflows (internal)
- `start.txt` - Our internal project setup
- `.git/` - Git history
- Hidden files - `.gitignore`, `.dockerignore`, etc. (debatable)

### What to Include
- `templates/` - ALL project templates
- `scripts/` - ALL automation scripts
- `docs/` - ALL user documentation
- `README.md` - Main readme
- `CHANGELOG.md` - Version history
- `CONTRIBUTING.md` - How to contribute
- `LICENSE` - License file (if present)

---

**Status:** 📋 Decisions Documented  
**Next:** Implementation Phase
