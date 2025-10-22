# Scripts

**Purpose:** Automation scripts hub  
**Status:** ✅ Template  
**Last Updated:** 2025-01-27

---

## 📋 Quick Links

### Core Scripts
- **[Core](core/README.md)** - Essential operational scripts
- **[Deployment](deployment/README.md)** - Deployment automation
- **[Setup](setup/README.md)** - Environment setup scripts
- **[Monitoring](monitoring/README.md)** - Status and monitoring

### Utilities
- **[Testing](testing/README.md)** - Test automation scripts
- **[Utilities](utilities/README.md)** - Utility and cleanup scripts

---

## 🎯 Overview

The scripts directory contains automation scripts for development, deployment, monitoring, and maintenance tasks.

### Script Categories
- **Core** - Essential operational scripts
- **Deployment** - CI/CD and deployment automation
- **Setup** - Environment and project setup
- **Monitoring** - Status checks and monitoring
- **Testing** - Test automation and validation
- **Utilities** - Cleanup and maintenance scripts

---

## 🚀 Quick Start

### Running Scripts
```bash
# Make script executable
chmod +x scripts/script-name.sh

# Run script
./scripts/script-name.sh

# Run with parameters
./scripts/script-name.sh --param value
```

### Development
```bash
# Test script locally
./scripts/script-name.sh --dry-run

# Debug script
bash -x scripts/script-name.sh
```

---

## 📁 Directory Structure

```
scripts/
├── core/               # Essential scripts
│   ├── health-check.sh
│   └── startup.sh
├── deployment/         # Deployment scripts
│   ├── deploy.sh
│   └── rollback.sh
├── setup/             # Setup scripts
│   ├── install.sh
│   └── configure.sh
├── monitoring/        # Monitoring scripts
│   ├── status-check.sh
│   └── alert.sh
├── testing/           # Test scripts
│   └── run-tests.sh
└── utilities/         # Utility scripts
    └── cleanup.sh
```

---

## 🛠️ Script Development

### Best Practices
- Use descriptive names
- Include error handling
- Provide clear output
- Document parameters
- Test thoroughly

### Script Template
```bash
#!/bin/bash
set -e

# Script description
# Usage: script-name.sh [options]

# Default values
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

# Main script logic
echo "Running script..."
```

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Template  
**Next:** Add project-specific automation scripts
