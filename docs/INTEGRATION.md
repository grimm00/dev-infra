# Integration Guide

**Purpose:** Guide for integrating dev-infra templates with external tools and projects  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This guide provides comprehensive instructions for integrating dev-infra templates with external tools and projects, with a focus on dev-toolkit integration. It covers multiple integration approaches, implementation examples, and best practices.

### What You'll Learn
- Integration options and trade-offs
- Version-pinned download approach (recommended)
- Implementation examples for dev-toolkit
- Update mechanisms and strategies
- Troubleshooting common integration issues

---

## 🔧 Integration Options

### Option 1: Version-Pinned Downloads (Recommended)

**Best for:** Production use, version control, stability

**Approach:**
- Download specific release archives
- Extract templates to temporary location
- Use templates for project generation
- Update by changing version number

**Benefits:**
- No git dependencies
- Fast download and extraction
- Version control and stability
- Easy updates when ready
- Works offline once downloaded

### Option 2: Git Submodule Integration

**Best for:** Development, always latest, collaboration

**Approach:**
- Add dev-infra as git submodule
- Always get latest templates
- Easy to update with submodule commands

**Benefits:**
- Always latest version
- Easy to update
- Maintains version history
- No duplication of files

**Drawbacks:**
- Requires git submodule knowledge
- Can be complex for some users
- Network dependency

### Option 3: Direct Git Clone Integration

**Best for:** Simple integration, temporary use

**Approach:**
- Clone repository on demand
- Extract templates
- Clean up after use

**Benefits:**
- Simple implementation
- Always latest version
- No dependencies

**Drawbacks:**
- Network dependency
- No version control
- Slower for repeated use

---

## 🚀 Dev-Toolkit Integration

### Recommended Implementation

**Configuration:**
```bash
# config/dev-infra.conf
DEVINFRA_VERSION="1.0.0"
DEVINFRA_REPO="grimm00/dev-infra"
DEVINFRA_URL="https://github.com/${DEVINFRA_REPO}/archive/v${DEVINFRA_VERSION}.tar.gz"
DEVINFRA_CACHE_DIR="./cache/dev-infra"
DEVINFRA_TEMPLATES_DIR="./templates/dev-infra"
```

**Download Script:**
```bash
#!/bin/bash
# scripts/download-devinfra.sh

set -e

# Configuration
DEVINFRA_VERSION="${1:-1.0.0}"
DOWNLOAD_URL="https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz"
TEMP_DIR="/tmp/dev-infra-$$"
TARGET_DIR="./templates/dev-infra"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if version already exists
if [ -d "${TARGET_DIR}" ] && [ -f "${TARGET_DIR}/.version" ]; then
    CURRENT_VERSION=$(cat "${TARGET_DIR}/.version")
    if [ "$CURRENT_VERSION" = "$DEVINFRA_VERSION" ]; then
        print_success "Dev-infra v${DEVINFRA_VERSION} already installed"
        exit 0
    fi
fi

print_status "Downloading dev-infra v${DEVINFRA_VERSION}..."
curl -L "${DOWNLOAD_URL}" -o "${TEMP_DIR}.tar.gz"

print_status "Extracting templates..."
tar -xzf "${TEMP_DIR}.tar.gz" -C /tmp
mkdir -p "${TARGET_DIR}"
cp -r "/tmp/dev-infra-${DEVINFRA_VERSION}/templates/"* "${TARGET_DIR}/"

# Save version info
echo "${DEVINFRA_VERSION}" > "${TARGET_DIR}/.version"

print_status "Cleaning up..."
rm -rf "${TEMP_DIR}.tar.gz" "/tmp/dev-infra-${DEVINFRA_VERSION}"

print_success "Dev-infra templates v${DEVINFRA_VERSION} installed to ${TARGET_DIR}"
```

**Template Commands:**
```bash
#!/bin/bash
# scripts/new-project.sh

set -e

# Configuration
DEVINFRA_TEMPLATES_DIR="./templates/dev-infra"
PROJECT_TYPE="${1:-regular}"

# Check if templates are installed
if [ ! -d "${DEVINFRA_TEMPLATES_DIR}" ]; then
    echo "Dev-infra templates not found. Installing..."
    ./scripts/download-devinfra.sh
fi

# Get project details
read -p "Project name: " PROJECT_NAME
read -p "Project description: " PROJECT_DESCRIPTION

# Create project directory
PROJECT_DIR="./projects/${PROJECT_NAME}"
mkdir -p "${PROJECT_DIR}"

# Copy template
if [ "$PROJECT_TYPE" = "learning" ]; then
    cp -r "${DEVINFRA_TEMPLATES_DIR}/learning-project/"* "${PROJECT_DIR}/"
else
    cp -r "${DEVINFRA_TEMPLATES_DIR}/regular-project/"* "${PROJECT_DIR}/"
fi

# Customize files
cd "${PROJECT_DIR}"
find . -name "*.md" -exec sed -i "s/{{PROJECT_NAME}}/${PROJECT_NAME}/g" {} \;
find . -name "*.md" -exec sed -i "s/{{PROJECT_DESCRIPTION}}/${PROJECT_DESCRIPTION}/g" {} \;
find . -name "*.md" -exec sed -i "s/{{CURRENT_DATE}}/$(date '+%Y-%m-%d')/g" {} \;

# Initialize git
git init
git add .
git commit -m "Initial commit: ${PROJECT_NAME}"

echo "✅ Project ${PROJECT_NAME} created successfully!"
```

**Update Command:**
```bash
#!/bin/bash
# scripts/update-templates.sh

set -e

# Check for latest version
LATEST_VERSION=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
CURRENT_VERSION=$(cat "./templates/dev-infra/.version" 2>/dev/null || echo "0.0.0")

echo "Current version: ${CURRENT_VERSION}"
echo "Latest version: ${LATEST_VERSION}"

if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo "New version available! Updating..."
    ./scripts/download-devinfra.sh "$LATEST_VERSION"
    echo "✅ Updated to dev-infra v${LATEST_VERSION}"
else
    echo "✅ Already up to date"
fi
```

---

## 📦 Implementation Examples

### Example 1: Simple Download and Extract

```bash
#!/bin/bash
# Simple integration example

DEVINFRA_VERSION="1.0.0"
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
DEVINFRA_VERSION="1.0.0"
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

### Example 3: Update Check

```bash
#!/bin/bash
# Check for new releases

# Get latest version from GitHub API
LATEST_VERSION=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
CURRENT_VERSION="1.0.0"  # Your current version

echo "Current version: ${CURRENT_VERSION}"
echo "Latest version: ${LATEST_VERSION}"

if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo "New version available: v${LATEST_VERSION}"
    echo "Update by changing DEVINFRA_VERSION in your configuration"
else
    echo "✅ Already up to date"
fi
```

---

## 🔄 Update Strategies

### Strategy 1: Manual Updates

**Approach:**
- Change version number in configuration
- Re-download and extract templates
- Test new templates before using

**Benefits:**
- Full control over updates
- Can test before deploying
- Easy to rollback

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

**Benefits:**
- Always up to date
- Minimal manual intervention
- Can be automated

**Implementation:**
```bash
#!/bin/bash
# Automated update check

# Check for updates daily
LATEST_VERSION=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
CURRENT_VERSION=$(cat "./templates/dev-infra/.version")

if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo "New dev-infra version available: v${LATEST_VERSION}"
    # Send notification or log update
fi
```

### Strategy 3: Staged Updates

**Approach:**
- Test new versions in development
- Promote to staging after testing
- Deploy to production after validation

**Benefits:**
- Risk mitigation
- Thorough testing
- Gradual rollout

**Implementation:**
```bash
# Development environment
DEVINFRA_VERSION="1.1.0-beta"

# Staging environment
DEVINFRA_VERSION="1.1.0"

# Production environment
DEVINFRA_VERSION="1.0.0"
```

---

## 🛠️ Troubleshooting

### Common Issues

**Issue: Download fails**
```bash
# Check network connectivity
curl -I https://github.com/grimm00/dev-infra/releases/latest

# Verify version exists
curl -s "https://api.github.com/repos/grimm00/dev-infra/releases" | grep '"tag_name"'
```

**Issue: Extraction fails**
```bash
# Check tar command
tar --version

# Verify archive integrity
tar -tzf dev-infra-1.0.0.tar.gz | head -10
```

**Issue: Templates not found**
```bash
# Check if templates directory exists
ls -la ./templates/dev-infra/

# Verify template structure
find ./templates/dev-infra/ -name "README.md" | head -5
```

**Issue: Version mismatch**
```bash
# Check current version
cat ./templates/dev-infra/.version

# Check latest version
curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"'
```

### Debug Mode

**Enable debug output:**
```bash
#!/bin/bash
# Enable debug mode
set -x  # Enable debug output
set -e  # Exit on error

# Your integration script here
```

**Verbose download:**
```bash
# Verbose curl output
curl -L -v "https://github.com/grimm00/dev-infra/archive/v1.0.0.tar.gz" -o dev-infra.tar.gz
```

**Check file permissions:**
```bash
# Check script permissions
ls -la ./scripts/download-devinfra.sh

# Make executable if needed
chmod +x ./scripts/download-devinfra.sh
```

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

## 📚 Related Documentation

- **[Template Usage Guide](TEMPLATE-USAGE.md)** - How to use templates effectively
- **[Project Types Guide](PROJECT-TYPES.md)** - Regular vs Learning comparison
- **[Best Practices Guide](BEST-PRACTICES.md)** - Comprehensive best practices
- **[Customization Guide](CUSTOMIZATION.md)** - Advanced customization instructions
- **[Template Files Guide](TEMPLATE-FILES.md)** - Standard files reference

---

## 🔗 External Resources

- **[Dev-Infra Repository](https://github.com/grimm00/dev-infra)** - Source repository
- **[GitHub Releases](https://github.com/grimm00/dev-infra/releases)** - Release downloads
- **[GitHub API](https://api.github.com/repos/grimm00/dev-infra/releases)** - Release information
- **[Semantic Versioning](https://semver.org/)** - Version numbering standard

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Template Usage Guide](TEMPLATE-USAGE.md)
