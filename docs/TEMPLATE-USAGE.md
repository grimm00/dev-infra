# Template Usage Guide

**Purpose:** Comprehensive guide for using dev-infra templates  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This guide explains how to use the dev-infra templates to create new projects with consistent structure, workflows, and documentation patterns.

### What You'll Learn

- How to choose the right template type
- How to use the project generator script
- How to customize templates for your needs
- How to maintain template structure over time

---

## 📋 Quick Start

### 1. Choose Template Type

- **Standard Project**: For applications, tools, services
- **Learning Project**: For tutorials, exercises, reference materials
- **Experimental Project**: For early access to experimental/evolving commands

### 2. Generate Project

```bash
cd /path/to/dev-infra
./scripts/new-project.sh
```

### 3. Follow Prompts

- Enter project name and description
- Select project type
- Customize settings
- Initialize git repository

### 4. Start Development

- Review and customize `start.txt`
- Update `README.md` with project details
- Begin development following template structure

---

## 🎨 Template Types

### Standard Project Template

**Best For:**

- Web applications
- Command-line tools
- APIs and services
- Libraries and frameworks

**Key Features:**

- Hub-and-spoke documentation
- Admin directory for project management
- Feature-based planning
- CI/CD workflows
- Testing structure

**Structure:**

```
project-name/
├── docs/
│   └── maintainers/          # Project management
├── backend/                  # Backend application
├── frontend/                 # Frontend application
├── tests/                    # Centralized testing
├── scripts/                  # Automation
├── docs/                     # User documentation
└── .github/workflows/        # CI/CD
```

### Learning Project Template

**Best For:**

- Tutorials and courses
- Exercise collections
- Reference materials
- Skill development projects

**Key Features:**

- Stage-based learning progression
- Fundamentals before implementation
- Hands-on exercises
- Reference materials
- Practice applications

**Structure:**

```
project-name/
├── stage0-fundamentals/      # Core concepts
├── stage1-[topic]/          # First learning stage
├── stage2-[topic]/          # Second learning stage
├── stage3-[topic]/          # Third learning stage
├── reference/               # Quick reference
├── practice-apps/           # Hands-on practice
└── docs/maintainers/        # Learning management
```

### Experimental Project Template

**Best For:**

- Internal team projects wanting early access to new features
- Projects comfortable with potential breaking changes
- Testing and providing feedback on evolving commands
- Rapid prototyping with latest features

**Key Features:**

- All features from Standard Project template
- Access to experimental/evolving commands
- Early access to new features before stabilization
- Clearly marked experimental commands with stability indicators
- Explicit opt-in to experimental features

**Structure:**

Same as Standard Project, plus:

```
project-name/
├── .cursor/
│   └── commands/
│       └── [evolving-tier commands]  # Experimental commands
└── docs/
    └── EXPERIMENTAL.md          # Experimental guide
```

**Important Notes:**

- ⚠️ Commands may change without notice
- ⚠️ May have incomplete documentation
- ⚠️ Provides early access to new features
- ⚠️ Best for internal team projects, not production-critical applications

**When to Use:**

- Starting new internal team projects
- Want to leverage latest features
- Comfortable with potential instability
- Can provide feedback on evolving features

**When NOT to Use:**

- Production-critical applications requiring maximum stability
- Projects where breaking changes cannot be tolerated
- Learning projects (use `learning-project` instead)

---

## 🚀 Project Generator

### Interactive Generator

The `new-project.sh` script provides an interactive way to create new projects:

```bash
./scripts/new-project.sh
```

**Features:**

- Interactive prompts for project details
- Template type selection
- Automatic file customization
- Git repository initialization
- GitHub repository creation (optional)

### Generator Options

**Project Information:**

- Project name (validated for directory creation)
- Project description
- Author name (defaults to git config)

**Project Type:**

- Standard Project (1)
- Learning Project (2)
- Experimental Project (3) ⚠️

**Git Integration:**

- Initialize local git repository
- Create GitHub repository
- Set up remote origin
- Initial commit

---

## 🛠️ Customization

### Required Customizations

**1. Update start.txt**

- Fill in problem statement
- Define project scope
- Select relevant preferences
- Add project-specific notes

**2. Customize README.md**

- Update project description
- Add technology stack details
- Include setup instructions
- Document project-specific workflows

**3. Configure CI/CD**

- Update `.github/workflows/ci.yml`
- Add project-specific testing
- Configure deployment workflows
- Set up external integrations

### Optional Customizations

**Remove Unused Directories:**

- Not all projects need all directories
- Remove unused sections from templates
- Update README.md to reflect actual structure

**Add Project-Specific Directories:**

- Add directories specific to your project
- Follow hub-and-spoke pattern
- Update navigation in README.md files

**Customize Admin Structure:**

- Adapt planning structure to your needs
- Add project-specific planning areas
- Customize feedback and research directories

---

## 📁 Directory Structure

### Hub-and-Spoke Pattern

Every major directory follows the hub-and-spoke pattern:

```
directory/
├── README.md              # 📍 HUB - Entry point with quick links
├── subdirectory-1/        # 📡 SPOKE - Focused content
├── subdirectory-2/        # 📡 SPOKE - Focused content
└── specific-file.md       # 📡 SPOKE - Focused content
```

**Benefits:**

- Clear navigation
- Focused documents
- Easy to maintain
- AI-friendly structure

### Navigation Philosophy

1. **Start at Hub** - Each directory's README.md explains purpose
2. **Navigate to Spokes** - Follow links to specific content
3. **Return to Hub** - Use hub files to understand bigger picture

---

## 🔧 Maintenance

### Keeping Structure Current

**Regular Tasks:**

- Update README.md files when adding new directories
- Maintain quick links in hub files
- Archive superseded documents instead of deleting
- Keep status indicators current

**Documentation Updates:**

- Update last modified dates
- Keep status indicators accurate
- Maintain cross-references between documents
- Archive old versions in `archived/` directories

### Template Evolution

**When Templates Change:**

- Review new template versions
- Update existing projects as needed
- Migrate to new patterns gradually
- Document migration decisions

---

## 📚 Best Practices

### Project Setup

1. **Start with Generator** - Use `new-project.sh` for consistency
2. **Customize Thoroughly** - Fill in all template placeholders
3. **Test Structure** - Verify all links and navigation work
4. **Document Decisions** - Record why you made specific choices

### Development Workflow

1. **Follow Hub-and-Spoke** - Maintain clear navigation
2. **Update Status** - Keep progress indicators current
3. **Document Changes** - Record decisions and rationale
4. **Archive Old Docs** - Preserve history without clutter

### Team Collaboration

1. **Share Structure** - Ensure team understands navigation
2. **Maintain Consistency** - Follow established patterns
3. **Document Processes** - Record team-specific workflows
4. **Regular Reviews** - Keep structure aligned with needs

---

## 🎯 Common Use Cases

### Web Application

```bash
./scripts/new-project.sh
   # Choose: Standard Project
# Name: my-web-app
# Description: Full-stack web application
```

**Customizations:**

- Update backend/ and frontend/ directories
- Configure CI/CD for web deployment
- Set up testing for web-specific scenarios

### Learning Course

```bash
./scripts/new-project.sh
# Choose: Learning Project
# Name: docker-fundamentals
# Description: Docker containerization course
```

**Customizations:**

- Rename stage directories to match topics
- Add course-specific exercises
- Create practice applications

### Command-Line Tool

```bash
./scripts/new-project.sh
   # Choose: Standard Project
# Name: my-cli-tool
# Description: Command-line utility
```

**Customizations:**

- Focus on scripts/ directory
- Remove frontend/ directory
- Add CLI-specific documentation

### Internal Team Project (with Experimental Features)

```bash
./scripts/new-project.sh
# Choose: Experimental Project ⚠️
# Name: my-team-app
# Description: Internal team application
```

**Customizations:**

- Access to evolving commands
- Test experimental features
- Provide feedback on new commands
- Review `docs/EXPERIMENTAL.md` for command stability

---

## 🚨 Troubleshooting

### Common Issues

**Template Not Found:**

- Ensure you're in the dev-infra directory
- Check that templates/ directory exists
- Verify script permissions (`chmod +x scripts/new-project.sh`)

**GitHub Repository Creation Fails:**

- Ensure GitHub CLI is installed (`gh --version`)
- Authenticate with GitHub (`gh auth login`)
- Check repository name availability

**Customization Issues:**

- Verify file permissions
- Check for template placeholders
- Ensure all required fields are filled

### Getting Help

**Documentation:**

- [Project Types Guide](PROJECT-TYPES.md)
- [Best Practices Guide](BEST-PRACTICES.md)
- [Customization Guide](CUSTOMIZATION.md)

**Examples:**

- [Admin Examples](../admin/notes/examples/)
- [Template Examples](../templates/)

---

## 📈 Success Metrics

### Template Adoption

- Projects created using templates
- Time saved in project setup
- Consistency across projects
- Team satisfaction with structure

### Project Quality

- Documentation completeness
- Navigation effectiveness
- Maintenance ease
- Development velocity

---

## 🎊 Key Benefits

1. **Consistency** - All projects follow proven patterns
2. **Speed** - Quick project setup with generator
3. **Quality** - Built-in best practices and structure
4. **Maintenance** - Easy to keep documentation current
5. **Collaboration** - Clear structure for team members
6. **AI-Friendly** - Structure optimized for AI assistance

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Project Types Guide](PROJECT-TYPES.md)
