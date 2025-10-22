# Contributing to Dev-Infra

**Purpose:** Guidelines for contributing to dev-infra templates and documentation  
**Status:** ✅ Active  
**Last Updated:** 2025-01-27

---

## 🎯 How to Contribute

Dev-infra welcomes contributions that improve templates, documentation, and automation. This guide explains how to contribute effectively.

### Types of Contributions

- **Template Improvements** - Enhance existing templates
- **New Templates** - Add new project types
- **Documentation** - Improve guides and examples
- **Automation** - Enhance scripts and workflows
- **Examples** - Add real project examples
- **Bug Fixes** - Fix issues and improve reliability

---

## 🚀 Getting Started

### Prerequisites

- Git and GitHub account
- Basic understanding of project structure
- Familiarity with hub-and-spoke documentation pattern

### Development Setup

1. **Fork the repository**

   ```bash
   # Fork on GitHub, then clone
   git clone https://github.com/your-username/dev-infra.git
   cd dev-infra
   ```

2. **Test existing templates**

   ```bash
   # Test project generator
   ./scripts/new-project.sh
   # Create test project to verify templates work
   ```

3. **Make changes**
   - Follow hub-and-spoke documentation pattern
   - Test changes with generator script
   - Update documentation as needed

---

## 📋 Contribution Process

### 1. Create Feature Branch

```bash
# Create descriptive branch name
git checkout -b feat/improve-regular-template
git checkout -b fix/generator-script-bug
git checkout -b docs/add-customization-guide
```

### 2. Make Changes

**Template Changes:**

- Update template files in `templates/`
- Test with `./scripts/new-project.sh`
- Verify all links and navigation work
- Update related documentation

**Documentation Changes:**

- Follow hub-and-spoke pattern
- Update quick links in README.md files
- Maintain consistent status indicators
- Include last updated dates

**Script Changes:**

- Test generator script thoroughly
- Handle edge cases and errors
- Provide clear user feedback
- Update usage documentation

### 3. Test Changes

```bash
# Test project generation
./scripts/new-project.sh

# Verify template structure
cd test-project
# Check all README.md files have quick links
# Verify navigation works
# Test git integration
```

### 4. Submit Pull Request

**PR Requirements:**

- Clear, descriptive title
- Detailed description of changes
- Testing instructions
- Screenshots (if applicable)
- Link to related issues

**PR Template:**

```markdown
## Description

[Describe what this PR does]

## Changes Made

- [ ] Template changes
- [ ] Documentation updates
- [ ] Script improvements
- [ ] Other changes

## Testing

- [ ] Tested with generator script
- [ ] Verified template structure
- [ ] Checked documentation links
- [ ] Tested edge cases

## Screenshots

[If applicable]

## Related Issues

Closes #[issue-number]
```

---

## 🎨 Contribution Guidelines

### Template Development

**Structure Requirements:**

- Follow hub-and-spoke documentation pattern
- Every major directory needs README.md hub
- Spoke documents should be focused (< 400 lines)
- Use progressive disclosure: Overview → Plan → Details

**Content Requirements:**

- Clear purpose statements in all documents
- Consistent status indicators (🔴 Not Started, 🟡 Planned, 🟠 In Progress, ✅ Complete)
- Last updated dates on all documents
- Cross-references between related documents

**Testing Requirements:**

- Test template generation with script
- Verify all navigation links work
- Check that customization works properly
- Ensure git integration functions correctly

### Documentation Standards

**Hub-and-Spoke Pattern:**

```markdown
# Directory Hub

**Purpose:** [One sentence description]
**Status:** [Current status]
**Last Updated:** [Date]

## 📋 Quick Links

- **[Spoke 1](spoke-1/README.md)** - [Description]
- **[Spoke 2](spoke-2/README.md)** - [Description]

## 🎯 Overview

[2-3 sentence overview]

## 📚 Related Documents

[Links to related content]
```

**Status Indicators:**

- 🔴 Not Started
- 🟡 Planned
- 🟠 In Progress
- ✅ Complete
- ❌ Cancelled/Blocked

### Code Quality

**Scripts:**

- Use descriptive variable names
- Include error handling
- Provide clear user feedback
- Follow bash best practices

**Templates:**

- Use consistent naming conventions
- Include placeholder text for customization
- Maintain consistent structure
- Follow established patterns

---

## 🔧 Development Workflow

### Branch Naming

- `feat/` - New features or improvements
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Testing improvements

### Commit Messages

**Format:**

```
type(scope): description

[Optional body]

[Optional footer]
```

**Types:**

- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Formatting
- `refactor` - Code refactoring
- `test` - Testing
- `chore` - Maintenance

**Examples:**

```
feat(templates): add learning project template
fix(generator): handle empty project names
docs(usage): add customization examples
```

### Testing Checklist

**Before Submitting PR:**

- [ ] Generator script works correctly
- [ ] Templates create valid project structure
- [ ] All README.md files have quick links
- [ ] Navigation works between documents
- [ ] Git integration functions properly
- [ ] Documentation is up to date
- [ ] No broken links or references

---

## 📚 Template Development

### Adding New Templates

1. **Create template directory**

   ```bash
   mkdir -p templates/new-template-type
   ```

2. **Follow structure pattern**

   - Create README.md hub
   - Add spoke directories
   - Include example files
   - Follow hub-and-spoke pattern

3. **Update generator script**

   - Add new template type option
   - Update customization logic
   - Test thoroughly

4. **Update documentation**
   - Add to project types guide
   - Update usage documentation
   - Include examples

### Improving Existing Templates

**Regular Project Template:**

- Enhance admin structure
- Improve CI/CD workflows
- Add new directory types
- Update documentation patterns

**Learning Project Template:**

- Add new stage types
- Improve exercise templates
- Enhance reference materials
- Update learning progression

---

## 🐛 Bug Reports

### Reporting Issues

**Required Information:**

- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Screenshots (if applicable)

**Issue Template:**

```markdown
## Bug Description

[Clear description of the bug]

## Steps to Reproduce

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Expected Behavior

[What should happen]

## Actual Behavior

[What actually happens]

## Environment

- OS: [Operating system]
- Shell: [Shell type]
- Git: [Git version]
- Other: [Relevant tools]

## Additional Context

[Any other relevant information]
```

### Fixing Bugs

1. **Reproduce the issue**
2. **Create fix branch** (`fix/issue-description`)
3. **Implement fix**
4. **Test thoroughly**
5. **Submit PR with clear description**

---

## 💡 Feature Requests

### Suggesting Features

**Feature Request Template:**

```markdown
## Feature Description

[Clear description of the feature]

## Use Case

[Why is this feature needed?]

## Proposed Solution

[How should this work?]

## Alternatives Considered

[Other approaches you've considered]

## Additional Context

[Any other relevant information]
```

### Implementing Features

1. **Discuss in issue first**
2. **Get approval for approach**
3. **Create feature branch**
4. **Implement with tests**
5. **Update documentation**
6. **Submit PR**

---

## 📖 Documentation Contributions

### Types of Documentation

- **User Guides** - How to use templates
- **Best Practices** - Recommended approaches
- **Examples** - Real project examples
- **Troubleshooting** - Common issues and solutions

### Documentation Standards

- Follow hub-and-spoke pattern
- Use clear, concise language
- Include practical examples
- Keep information current
- Cross-reference related content

---

## 🎯 Review Process

### PR Review Criteria

**Template Changes:**

- [ ] Follows hub-and-spoke pattern
- [ ] All navigation links work
- [ ] Documentation is complete
- [ ] Generator script works
- [ ] No breaking changes

**Documentation Changes:**

- [ ] Clear and accurate
- [ ] Follows established patterns
- [ ] Includes examples
- [ ] Cross-references updated
- [ ] Status indicators current

**Script Changes:**

- [ ] Handles edge cases
- [ ] Provides clear feedback
- [ ] Includes error handling
- [ ] Follows best practices
- [ ] Documentation updated

### Review Timeline

- **Initial Review** - Within 48 hours
- **Feedback** - Within 72 hours
- **Final Review** - Within 24 hours of fixes
- **Merge** - After approval and tests pass

---

## 🎊 Recognition

### Contributors

Contributors are recognized in:

- README.md contributors section
- Release notes
- Documentation acknowledgments

### Types of Recognition

- **Template Contributors** - Major template improvements
- **Documentation Contributors** - Significant documentation updates
- **Bug Fixers** - Critical bug fixes
- **Feature Contributors** - New features and enhancements

---

## 📞 Getting Help

### Questions and Discussion

- **GitHub Discussions** - General questions and ideas
- **GitHub Issues** - Bug reports and feature requests
- **Pull Request Comments** - Specific to PR changes

### Resources

- [Template Usage Guide](docs/TEMPLATE-USAGE.md)
- [Project Types Guide](docs/PROJECT-TYPES.md)
- [Best Practices Guide](docs/BEST-PRACTICES.md)
- [Real Project Examples](admin/notes/examples/)

---

## 📄 Code of Conduct

### Our Standards

- **Be respectful** - Treat everyone with respect
- **Be constructive** - Provide helpful feedback
- **Be collaborative** - Work together toward common goals
- **Be patient** - Remember that everyone is learning

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or inflammatory comments
- Personal attacks or insults
- Spam or off-topic discussions

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Active  
**Next:** [Template Usage Guide](docs/TEMPLATE-USAGE.md)
