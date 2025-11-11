# Directory Selection Feature

**Purpose:** Allow users to choose target directory for project generation  
**Status:** 🟡 Planned  
**Last Updated:** 2025-11-10

---

## 📋 Quick Links

- **[Feature Plan](feature-plan.md)** - High-level implementation plan
- **[Status & Next Steps](status-and-next-steps.md)** - Current progress
- **[Phase 1: Directory Selection Prompt](phase-1-directory-prompt.md)** - Initial implementation
- **[Phase 2: Path Handling Updates](phase-2-path-handling.md)** - Function updates
- **[Phase 3: Validation & Testing](phase-3-validation-testing.md)** - Validation and testing
- **[Manual Testing Fixes](fix/README.md)** - Fixes for issues found during manual testing

---

## 🎯 Overview

This feature enhances the `new-project.sh` script to allow users to specify a target directory where their project will be generated, instead of always creating it in the current working directory. The feature includes support for absolute and relative paths, with a sensible default (`$HOME/Projects/`), comprehensive validation, and proper path handling throughout the script.

### Key Benefits

- **Flexibility** - Users can organize projects in their preferred directory structure
- **Convenience** - Default to `$HOME/Projects/` (common convention)
- **Validation** - Comprehensive checks for directory existence, permissions, and validity
- **User Experience** - Clear prompts and helpful error messages

---

## 📊 Current Status

**Status:** 🟡 Planned  
**Current Phase:** Planning  
**Progress:** 0%  
**Next Step:** Begin Phase 1 implementation

---

## 🔗 Related Documentation

- **[Best Practices Guide](../../../../docs/BEST-PRACTICES.md)** - Hub-and-spoke documentation patterns
- **[Template Usage Guide](../../../../docs/TEMPLATE-USAGE.md)** - How to use templates
- **[Script: new-project.sh](../../../../scripts/new-project.sh)** - Current implementation

---

**Last Updated:** 2025-11-10  
**Status:** 🟡 Planned  
**Next:** [Feature Plan](feature-plan.md)

