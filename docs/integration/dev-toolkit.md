# Dev-Toolkit Integration

**Purpose:** Specific integration examples and guidance for dev-toolkit projects  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This guide provides specific examples and implementation details for integrating dev-infra templates with dev-toolkit projects using the version-pinned download approach.

### What You'll Learn
- Dev-toolkit specific configuration
- Implementation examples
- Command integration
- Update mechanisms
- Best practices for dev-toolkit

---

## 🚀 Recommended Implementation

### Configuration

**Create `config/dev-infra.conf`:**
```bash
# Dev-infra configuration for dev-toolkit
DEVINFRA_VERSION="1.0.0"
DEVINFRA_REPO="grimm00/dev-infra"
DEVINFRA_URL="https://github.com/${DEVINFRA_REPO}/archive/v${DEVINFRA_VERSION}.tar.gz"
DEVINFRA_CACHE_DIR="./cache/dev-infra"
DEVINFRA_TEMPLATES_DIR="./templates/dev-infra"
```

### Download Script

**Create `scripts/download-devinfra.sh`:**
```bash
#!/bin/bash
# download-devinfra.sh - Download dev-infra templates for dev-toolkit

set -e

# Load configuration
source config/dev-infra.conf

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
if [ -d "${DEVINFRA_TEMPLATES_DIR}" ] && [ -f "${DEVINFRA_TEMPLATES_DIR}/.version" ]; then
    CURRENT_VERSION=$(cat "${DEVINFRA_TEMPLATES_DIR}/.version")
    if [ "$CURRENT_VERSION" = "$DEVINFRA_VERSION" ]; then
        print_success "Dev-infra v${DEVINFRA_VERSION} already installed"
        exit 0
    fi
fi

print_status "Downloading dev-infra v${DEVINFRA_VERSION}..."
curl -L "${DEVINFRA_URL}" -o "${DEVINFRA_CACHE_DIR}/dev-infra-${DEVINFRA_VERSION}.tar.gz"

print_status "Extracting templates..."
tar -xzf "${DEVINFRA_CACHE_DIR}/dev-infra-${DEVINFRA_VERSION}.tar.gz" -C /tmp
mkdir -p "${DEVINFRA_TEMPLATES_DIR}"
cp -r "/tmp/dev-infra-${DEVINFRA_VERSION}/templates/"* "${DEVINFRA_TEMPLATES_DIR}/"

# Save version info
echo "${DEVINFRA_VERSION}" > "${DEVINFRA_TEMPLATES_DIR}/.version"

print_status "Cleaning up..."
rm -rf "/tmp/dev-infra-${DEVINFRA_VERSION}"

print_success "Dev-infra templates v${DEVINFRA_VERSION} installed to ${DEVINFRA_TEMPLATES_DIR}"
```

### Template Commands

**Create `scripts/new-project.sh`:**
```bash
#!/bin/bash
# new-project.sh - Create new project using dev-infra templates

set -e

# Load configuration
source config/dev-infra.conf

# Check if templates are installed
if [ ! -d "${DEVINFRA_TEMPLATES_DIR}" ]; then
    echo "Dev-infra templates not found. Installing..."
    ./scripts/download-devinfra.sh
fi

# Get project details
read -p "Project name: " PROJECT_NAME
read -p "Project description: " PROJECT_DESCRIPTION
read -p "Project type (regular/learning): " PROJECT_TYPE

# Validate project type
if [ "$PROJECT_TYPE" != "regular" ] && [ "$PROJECT_TYPE" != "learning" ]; then
    echo "Error: Project type must be 'regular' or 'learning'"
    exit 1
fi

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

### Update Command

**Create `scripts/update-templates.sh`:**
```bash
#!/bin/bash
# update-templates.sh - Update dev-infra templates

set -e

# Load configuration
source config/dev-infra.conf

# Check for latest version
LATEST_VERSION=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
CURRENT_VERSION=$(cat "${DEVINFRA_TEMPLATES_DIR}/.version" 2>/dev/null || echo "0.0.0")

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

## 🔧 Dev-Toolkit Command Integration

### Add to Main Dev-Toolkit Script

**Update main dev-toolkit script:**
```bash
#!/bin/bash
# dev-toolkit - Main dev-toolkit script

case "$1" in
    "install-templates")
        VERSION="${2:-1.0.0}"
        ./scripts/download-devinfra.sh "$VERSION"
        ;;
    "new-project")
        TEMPLATE="${2:-regular}"
        ./scripts/new-project.sh "$TEMPLATE"
        ;;
    "update-templates")
        ./scripts/update-templates.sh
        ;;
    "list-templates")
        echo "Available templates:"
        echo "  regular  - Applications, tools, services"
        echo "  learning - Tutorials, courses, exercises"
        ;;
    *)
        echo "Usage: dev-toolkit {install-templates|new-project|update-templates|list-templates}"
        ;;
esac
```

### Command Examples

```bash
# Install specific version
dev-toolkit install-templates 1.0.0

# Create new regular project
dev-toolkit new-project regular

# Create new learning project
dev-toolkit new-project learning

# Update to latest version
dev-toolkit update-templates

# List available templates
dev-toolkit list-templates
```

---

## 📦 Project Structure

**Recommended dev-toolkit structure:**
```
dev-toolkit/
├── config/
│   └── dev-infra.conf          # Dev-infra configuration
├── scripts/
│   ├── download-devinfra.sh    # Download script
│   ├── new-project.sh          # Project creation
│   └── update-templates.sh     # Update script
├── templates/
│   └── dev-infra/              # Downloaded templates
├── cache/
│   └── dev-infra/              # Cached downloads
└── projects/                   # Generated projects
    ├── my-app/
    └── my-course/
```

---

## 🔄 Update Strategies

### Strategy 1: Manual Updates

**Configuration:**
```bash
# config/dev-infra.conf
DEVINFRA_VERSION="1.0.0"  # Change this to update
```

**Update Process:**
```bash
# Update version in config
sed -i 's/DEVINFRA_VERSION="1.0.0"/DEVINFRA_VERSION="1.1.0"/' config/dev-infra.conf

# Re-download templates
./scripts/download-devinfra.sh
```

### Strategy 2: Automated Updates

**Daily Check Script:**
```bash
#!/bin/bash
# check-updates-daily.sh

# Check for updates daily
LATEST_VERSION=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
CURRENT_VERSION=$(cat "./templates/dev-infra/.version")

if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo "New dev-infra version available: v${LATEST_VERSION}"
    # Send notification or log update
fi
```

### Strategy 3: Staged Updates

**Environment Configuration:**
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

---

## 📋 Integration Checklist

### Pre-Integration
- [ ] Set up dev-infra configuration file
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

## 🔗 Related Documentation

- **[Version-Pinned Downloads](version-pinned.md)** - Detailed version-pinned approach
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions
- **[Best Practices](best-practices.md)** - Integration best practices

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Troubleshooting](troubleshooting.md)
