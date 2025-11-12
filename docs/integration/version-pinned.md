# Version-Pinned Downloads

**Purpose:** Detailed guide for version-pinned download integration approach  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

Version-pinned downloads are the recommended approach for integrating dev-infra templates. This method downloads specific release archives, providing version control, stability, and reliability.

### Why Version-Pinned Downloads?

- **Version Control** - Pin to specific stable versions
- **Reliability** - No network dependencies after download
- **Stability** - Tested releases, not bleeding edge
- **Simplicity** - Easy to implement and maintain
- **Performance** - Fast download and extraction

---

## 📦 Download Options

### Option 1: Distribution Package (Recommended)

**Clean package with only user-facing files** - no internal planning or development files.

**For Linux/Mac:**
```bash
curl -L "https://github.com/grimm00/dev-infra/releases/download/v1.2.0/dev-infra-1.2.0.tar.gz" -o dev-infra.tar.gz
tar -xzf dev-infra.tar.gz
cd dev-infra-1.2.0
```

**For Windows:**
```powershell
curl -L "https://github.com/grimm00/dev-infra/releases/download/v1.2.0/dev-infra-1.2.0.zip" -o dev-infra.zip
Expand-Archive dev-infra.zip
cd dev-infra-1.2.0
```

**Verify checksum:**
```bash
# Download checksum
curl -L "https://github.com/grimm00/dev-infra/releases/download/v1.2.0/dev-infra-1.2.0.tar.gz.sha256" -o checksum.txt

# Verify (Linux/Mac)
sha256sum -c checksum.txt

# Verify (Windows PowerShell)
(Get-FileHash dev-infra-1.2.0.tar.gz -Algorithm SHA256).Hash -eq (Get-Content checksum.txt).Split()[0]
```

### Option 2: Full Source (For Contributors)

**Includes internal planning and development files.**

```bash
curl -L "https://github.com/grimm00/dev-infra/archive/v1.2.0.tar.gz" -o dev-infra-full.tar.gz
```

### What's the Difference?

**Distribution Package (`dev-infra-1.2.0.tar.gz`):**
- ✅ Templates
- ✅ Scripts  
- ✅ Documentation
- ✅ README, CHANGELOG, CONTRIBUTING
- ❌ Admin directory (internal planning)
- ❌ .cursor directory (AI rules)
- ❌ start.txt (our setup file)
- **Size:** ~50% smaller
- **Use case:** Using dev-infra templates

**Full Source (`archive/v1.2.0.tar.gz`):**
- ✅ Everything (all files and directories)
- **Use case:** Contributing to dev-infra development

---

## 🚀 Implementation

### Basic Implementation

```bash
#!/bin/bash
# download-devinfra.sh - Download dev-infra templates

DEVINFRA_VERSION="${1:-1.2.0}"
DOWNLOAD_URL="https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz"
TEMP_DIR="/tmp/dev-infra-$$"
TARGET_DIR="./templates/dev-infra"

echo "Downloading dev-infra v${DEVINFRA_VERSION}..."
curl -L "${DOWNLOAD_URL}" -o "${TEMP_DIR}.tar.gz"

echo "Extracting templates..."
tar -xzf "${TEMP_DIR}.tar.gz" -C /tmp
mkdir -p "${TARGET_DIR}"
cp -r "/tmp/dev-infra-${DEVINFRA_VERSION}/templates/"* "${TARGET_DIR}/"

echo "Cleaning up..."
rm -rf "${TEMP_DIR}.tar.gz" "/tmp/dev-infra-${DEVINFRA_VERSION}"

echo "✅ Dev-infra templates v${DEVINFRA_VERSION} installed"
```

### Advanced Implementation with Caching

```bash
#!/bin/bash
# download-devinfra-cached.sh - Cached version

DEVINFRA_VERSION="${1:-1.2.0}"
DOWNLOAD_URL="https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz"
CACHE_DIR="./cache"
TEMPLATES_DIR="./templates"

# Create cache directory
mkdir -p "${CACHE_DIR}"

# Download if not cached
CACHE_FILE="${CACHE_DIR}/dev-infra-${DEVINFRA_VERSION}.tar.gz"
if [ ! -f "${CACHE_FILE}" ]; then
    echo "Downloading dev-infra v${DEVINFRA_VERSION}..."
    curl -L "${DOWNLOAD_URL}" -o "${CACHE_FILE}"
fi

# Extract templates
echo "Extracting templates..."
tar -xzf "${CACHE_FILE}" -C /tmp
mkdir -p "${TEMPLATES_DIR}"
cp -r "/tmp/dev-infra-${DEVINFRA_VERSION}/templates/"* "${TEMPLATES_DIR}/"

# Clean up
rm -rf "/tmp/dev-infra-${DEVINFRA_VERSION}"

echo "✅ Dev-infra templates v${DEVINFRA_VERSION} installed"
```

---

## 🔄 Update Strategies

### Strategy 1: Manual Updates

**Approach:**
- Change version number in configuration
- Re-download and extract templates
- Test new templates before using

**Implementation:**
```bash
# Update version in config
DEVINFRA_VERSION="1.1.0"

# Re-download templates
./scripts/download-devinfra.sh "$DEVINFRA_VERSION"
```

### Strategy 2: Automated Updates

**Approach:**
- Check for new releases periodically
- Download and test automatically
- Notify when updates are available

**Implementation:**
```bash
#!/bin/bash
# check-updates.sh

LATEST_VERSION=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
CURRENT_VERSION=$(cat "./templates/dev-infra/.version" 2>/dev/null || echo "0.0.0")

echo "Current version: ${CURRENT_VERSION}"
echo "Latest version: ${LATEST_VERSION}"

if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo "New version available: v${LATEST_VERSION}"
    echo "Update by changing DEVINFRA_VERSION in your configuration"
fi
```

### Strategy 3: Staged Updates

**Approach:**
- Test new versions in development
- Promote to staging after testing
- Deploy to production after validation

**Implementation:**
```bash
# Development environment
DEVINFRA_VERSION="1.1.0-beta"

# Staging environment
DEVINFRA_VERSION="1.1.0"

# Production environment
DEVINFRA_VERSION="1.1.0"
```

---

## 🛠️ Integration Examples

### Example 1: Simple Download and Extract

```bash
#!/bin/bash
# Simple integration example

DEVINFRA_VERSION="1.1.0"
DOWNLOAD_URL="https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz"
TEMP_DIR="/tmp/dev-infra-$$"
TARGET_DIR="./templates"

echo "Downloading dev-infra v${DEVINFRA_VERSION}..."
curl -L "${DOWNLOAD_URL}" -o "${TEMP_DIR}.tar.gz"

echo "Extracting templates..."
tar -xzf "${TEMP_DIR}.tar.gz" -C /tmp
mkdir -p "${TARGET_DIR}"
cp -r "/tmp/dev-infra-${DEVINFRA_VERSION}/templates/"* "${TARGET_DIR}/"

echo "Cleaning up..."
rm -rf "${TEMP_DIR}.tar.gz" "/tmp/dev-infra-${DEVINFRA_VERSION}"

echo "✅ Dev-infra templates v${DEVINFRA_VERSION} installed"
```

### Example 2: Version-Pinned Installation

```bash
#!/bin/bash
# Version-pinned installation

# Configuration
DEVINFRA_VERSION="1.1.0"
DEVINFRA_REPO="grimm00/dev-infra"
DEVINFRA_URL="https://github.com/${DEVINFRA_REPO}/archive/v${DEVINFRA_VERSION}.tar.gz"
CACHE_DIR="./cache"
TEMPLATES_DIR="./templates"

# Create cache directory
mkdir -p "${CACHE_DIR}"

# Download if not cached
CACHE_FILE="${CACHE_DIR}/dev-infra-${DEVINFRA_VERSION}.tar.gz"
if [ ! -f "${CACHE_FILE}" ]; then
    echo "Downloading dev-infra v${DEVINFRA_VERSION}..."
    curl -L "${DEVINFRA_URL}" -o "${CACHE_FILE}"
fi

# Extract templates
echo "Extracting templates..."
tar -xzf "${CACHE_FILE}" -C /tmp
mkdir -p "${TEMPLATES_DIR}"
cp -r "/tmp/dev-infra-${DEVINFRA_VERSION}/templates/"* "${TEMPLATES_DIR}/"

# Clean up
rm -rf "/tmp/dev-infra-${DEVINFRA_VERSION}"

echo "✅ Dev-infra templates v${DEVINFRA_VERSION} installed"
```

---

## 🎯 Best Practices

### Version Management
- **Pin to specific versions** - Don't use "latest" in production
- **Test before deploying** - Always test new versions
- **Document version changes** - Keep track of what changed
- **Plan rollback strategy** - Be ready to revert if needed

### Performance Optimization
- **Cache downloads** - Don't re-download unnecessarily
- **Parallel extraction** - Use multiple cores when possible
- **Clean up temp files** - Remove temporary files after use
- **Monitor disk usage** - Templates can be large

### Security Considerations
- **Verify downloads** - Check file integrity
- **Use HTTPS** - Always use secure connections
- **Validate templates** - Run validation scripts
- **Review changes** - Check what changed in new versions

### Error Handling
- **Graceful failures** - Handle errors without crashing
- **Informative messages** - Tell users what went wrong
- **Retry logic** - Retry failed downloads
- **Fallback options** - Provide alternatives when possible

---

## 📋 Integration Checklist

### Pre-Integration
- [ ] Choose integration approach (version-pinned recommended)
- [ ] Set up configuration file
- [ ] Create download script
- [ ] Test download and extraction
- [ ] Verify template structure

### Implementation
- [ ] Implement template commands
- [ ] Add error handling
- [ ] Test with different project types
- [ ] Verify file customization
- [ ] Test git initialization

### Post-Integration
- [ ] Document integration process
- [ ] Create update mechanism
- [ ] Test update process
- [ ] Add monitoring/logging
- [ ] Train team on new workflow

### Maintenance
- [ ] Monitor for new releases
- [ ] Test new versions before deploying
- [ ] Update documentation as needed
- [ ] Gather feedback from users
- [ ] Optimize performance

---

## 🔗 Related Documentation

- **[Dev-Toolkit Integration](dev-toolkit.md)** - Specific dev-toolkit examples
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions
- **[Best Practices](best-practices.md)** - Integration best practices

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Dev-Toolkit Integration](dev-toolkit.md)
