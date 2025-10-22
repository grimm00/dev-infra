# Integration Guide

**Purpose:** Guide for integrating dev-infra templates with external tools and projects  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This guide provides comprehensive instructions for integrating dev-infra templates with external tools and projects, with a focus on dev-toolkit integration.

### What You'll Learn
- Integration options and trade-offs
- Version-pinned download approach (recommended)
- Implementation examples for dev-toolkit
- Update mechanisms and strategies
- Troubleshooting common integration issues

---

## 📋 Quick Links

### Integration Approaches
- **[Version-Pinned Downloads](version-pinned.md)** - Recommended approach for production use
- **[Git Submodule Integration](git-submodule.md)** - For development and collaboration
- **[Dev-Toolkit Integration](dev-toolkit.md)** - Specific examples for dev-toolkit

### Support
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions
- **[Best Practices](best-practices.md)** - Integration best practices

---

## 🚀 Recommended Approach

### Version-Pinned Downloads

**Best for:** Production use, version control, stability

**Quick Start:**
```bash
# Download specific version
DEVINFRA_VERSION="1.0.0"
curl -L "https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz" | tar -xz
```

**Benefits:**
- No git dependencies
- Fast download and extraction
- Version control and stability
- Easy updates when ready
- Works offline once downloaded

---

## 🔧 Integration Options

### Option 1: Version-Pinned Downloads (Recommended)
- **Best for:** Production use, version control, stability
- **Approach:** Download specific release archives
- **Benefits:** No git dependencies, fast, version controlled

### Option 2: Git Submodule Integration
- **Best for:** Development, always latest, collaboration
- **Approach:** Add dev-infra as git submodule
- **Benefits:** Always latest version, easy updates

### Option 3: Direct Git Clone Integration
- **Best for:** Simple integration, temporary use
- **Approach:** Clone repository on demand
- **Benefits:** Simple implementation, always latest

---

## 🎯 Dev-Toolkit Integration

Dev-infra is designed for seamless integration with dev-toolkit projects:

### Configuration
```bash
# config/dev-infra.conf
DEVINFRA_VERSION="1.0.0"
DEVINFRA_REPO="grimm00/dev-infra"
DEVINFRA_URL="https://github.com/${DEVINFRA_REPO}/archive/v${DEVINFRA_VERSION}.tar.gz"
```

### Commands
```bash
# Dev-toolkit new commands
dev-toolkit install-templates [version]
dev-toolkit new-project --template regular
dev-toolkit new-project --template learning
dev-toolkit update-templates
```

See [Dev-Toolkit Integration](dev-toolkit.md) for complete examples.

---

## 📚 Related Documentation

- **[Template Usage Guide](../TEMPLATE-USAGE.md)** - How to use templates effectively
- **[Project Types Guide](../PROJECT-TYPES.md)** - Regular vs Learning comparison
- **[Best Practices Guide](../BEST-PRACTICES.md)** - Comprehensive best practices
- **[Customization Guide](../CUSTOMIZATION.md)** - Advanced customization instructions

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Version-Pinned Downloads](version-pinned.md)
