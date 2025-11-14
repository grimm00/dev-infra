# Dev-Infra

[![Release](https://img.shields.io/github/v/release/grimm00/dev-infra)](https://github.com/grimm00/dev-infra/releases)
[![License](https://img.shields.io/github/license/grimm00/dev-infra)](LICENSE)

**Purpose:** Standardized development infrastructure templates and best practices  
**Version:** v1.2.0  
**Last Updated:** 2025-11-12  
**Status:** ✅ Active

---

## 🚀 Quick Start

### 1. Get Dev-Infra

**Option A: Download Distribution (Recommended)**
```bash
# Download clean package (Linux/Mac)
curl -L https://github.com/grimm00/dev-infra/releases/download/v1.2.0/dev-infra-1.2.0.tar.gz | tar -xz
cd dev-infra-1.2.0

# Or download for Windows
curl -L https://github.com/grimm00/dev-infra/releases/download/v1.2.0/dev-infra-1.2.0.zip -o dev-infra.zip
```

**Option B: Clone Repository**
```bash
git clone https://github.com/grimm00/dev-infra.git
cd dev-infra
```

**Option C: For Dev-Toolkit Integration**
See [Integration Guide](docs/INTEGRATION.md) for version-pinned download approach.

### 2. Create Your Project

```bash
# Generate new project
./scripts/new-project.sh

# Validate templates
./scripts/validate-templates.sh
```

**Choose your project type:**

- **Standard Project** - Applications, tools, services
- **Learning Project** - Tutorials, courses, exercises

---

## 🚀 What is Dev-Infra?

Dev-infra provides standardized project templates that incorporate proven patterns from real-world projects. It eliminates the need to recreate project structure and workflows from scratch, ensuring consistency and quality across all your projects.

### Key Benefits

- **🏗️ Consistent Structure** - Every project starts with proven organization
- **⚡ Quick Setup** - Interactive generator creates projects in minutes
- **📚 Best Practices** - Built-in patterns from successful projects
- **🤖 AI-Friendly** - Structure optimized for AI assistance
- **🔧 Flexible** - Adapt templates to your specific needs
- **📖 Well-Documented** - Comprehensive guides and examples

---

## 📁 Project Templates

### Standard Project Template

**For:** Applications, tools, services, APIs

**Features:**

- Hub-and-spoke documentation pattern
- Feature-based planning and tracking
- Backend/frontend separation
- Centralized testing structure
- CI/CD workflows
- Maintainers directory for project management

**Structure:**

```
project/
├── docs/
│   └── maintainers/  # Project management hub
├── backend/          # Backend application (includes instance/)
├── frontend/         # Frontend application
├── tests/            # Centralized testing
├── scripts/          # Automation
├── docs/             # User documentation
└── .github/          # CI/CD workflows
```

### Learning Project Template

**For:** Tutorials, courses, exercises, reference materials

**Features:**

- Stage-based learning progression
- Fundamentals before implementation
- Hands-on exercises
- Reference materials
- Practice applications
- Educational content structure

**Structure:**

```
project/
├── stage0-fundamentals/  # Core concepts
├── stage1-[topic]/      # First learning stage
├── stage2-[topic]/      # Second learning stage
├── stage3-[topic]/      # Third learning stage
├── reference/           # Quick reference
├── practice-apps/       # Hands-on practice
└── docs/
    └── maintainers/     # Learning management
```

---

## 🎨 Design Philosophy

### Hub-and-Spoke Documentation

Every template uses a hub-and-spoke documentation pattern:

- **Hub Files** (README.md) serve as entry points with quick links
- **Spoke Directories** contain focused, single-topic content
- **Progressive Disclosure** from overview to detailed implementation
- **Consistent Navigation** across all project types

### Best Practices Integration

Templates incorporate patterns learned from real projects:

- **Pokehub** - Full-stack application structure
- **Dev-toolkit** - Command-line tool organization
- **Containers** - Learning project progression

### Flexibility and Adaptation

- Not all directories required for every project
- Easy to remove unused sections
- Simple to add project-specific directories
- Maintains core structural principles

---

## 🔗 Dev-Toolkit Integration

Dev-infra is designed for seamless integration with dev-toolkit projects:

### Version-Pinned Downloads (Recommended)
```bash
# In dev-toolkit configuration
DEVINFRA_VERSION="1.0.0"
curl -L "https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz" | tar -xz
```

### Integration Commands
```bash
# Dev-toolkit new commands
dev-toolkit install-templates [version]
dev-toolkit new-project --template regular
dev-toolkit new-project --template learning
dev-toolkit update-templates
```

### Benefits
- **No Git Dependencies** - Download and extract approach
- **Version Control** - Pin to specific stable versions
- **Fast Integration** - Quick download and setup
- **Easy Updates** - Change version number to update

See [Integration Guide](docs/INTEGRATION.md) for complete implementation examples.

---

## 🛠️ Technology Stack

### Core Technologies

- **Documentation** - Markdown with hub-and-spoke pattern
- **Version Control** - Git with Git Flow branching
- **CI/CD** - GitHub Actions with branch-based workflows
- **AI Integration** - Cursor IDE with custom rules
- **Automation** - Bash scripts for project generation

### External Integrations

- **Sourcery AI** - Code review and quality analysis
- **Bugbot** - Bug detection and prevention
- **GitHub CLI** - Repository management
- **Dev-toolkit** - Workflow automation

---

## 📊 Template Statistics

- **Templates Available** - 2 (Regular, Learning)
- **Example Projects Analyzed** - 3 (Pokehub, dev-toolkit, containers)
- **Documentation Patterns** - Hub-and-spoke, progressive disclosure
- **Automation Scripts** - 1 (Interactive project generator)
- **CI/CD Workflows** - 1 (Branch-based automation)

---

## 🚀 Getting Started

### 1. Generate New Project

```bash
# Interactive project creation
./scripts/new-project.sh

# Follow prompts:
# - Enter project name and description
# - Choose project type (Regular/Learning)
# - Customize settings
# - Initialize git repository
```

### 2. Customize Template

**Required:**

- Update `start.txt` with project details
- Customize `README.md` with technology stack
- Configure CI/CD workflows

**Optional:**

- Remove unused directories
- Add project-specific directories
- Customize admin structure

### 3. Start Development

**Standard Projects:**

- Create first feature in `docs/maintainers/planning/features/`
- Set up development environment
- Begin feature development

**Learning Projects:**

- Start with `stage0-fundamentals/`
- Follow learning progression
- Complete exercises as you go

---

## 📚 Documentation

### User Guides

- **[Template Usage Guide](docs/TEMPLATE-USAGE.md)** - How to use templates
- **[Project Types Guide](docs/PROJECT-TYPES.md)** - Regular vs Learning comparison
- **[Best Practices Guide](docs/BEST-PRACTICES.md)** - Template best practices
- **[Customization Guide](docs/CUSTOMIZATION.md)** - Advanced customization

### Template Examples

- **[Standard Project Template](templates/standard-project/)** - Application template
- **[Learning Project Template](templates/learning-project/)** - Educational template

### Real Project Examples

- **[Hub-and-Spoke Patterns](admin/notes/examples/hub-and-spoke-documentation-best-practices.md)** - Documentation patterns
- **[Project Structures](admin/notes/examples/)** - Structure examples from real projects
- **[CI/CD Workflows](admin/notes/examples/ci.yml.example)** - Workflow patterns
- **[AI Rules](admin/notes/examples/main.mdc.example)** - Cursor IDE rules

---

## 🔧 Development

### Project Structure

```
dev-infra/
├── templates/              # Project templates
│   ├── standard-project/   # Application template
│   └── learning-project/  # Educational template
├── scripts/               # Automation scripts
│   └── new-project.sh     # Project generator
├── docs/                  # User documentation
├── admin/                 # Dev-infra management
│   ├── planning/          # Template roadmap
│   ├── research/          # Design decisions
│   └── notes/examples/    # Real project examples
└── .cursor/               # AI assistant rules
    └── rules/main.mdc     # Cursor IDE configuration
```

### Contributing

1. **Fork the repository**
2. **Create feature branch** (`feat/improve-templates`)
3. **Make changes** following hub-and-spoke pattern
4. **Test templates** using generator script
5. **Submit pull request** with clear description

### Template Evolution

Templates evolve based on:

- Real project experience
- User feedback
- Best practice discoveries
- Tool integration improvements

---

## 🎯 Use Cases

### Individual Developers

- Consistent project structure
- Quick project setup
- Built-in best practices
- AI-optimized workflows

### Teams

- Standardized workflows
- Shared documentation patterns
- Consistent CI/CD processes
- Reduced onboarding time

### Educational

- Structured learning progression
- Hands-on exercise framework
- Reference material organization
- Practice application templates

---

## 📈 Success Metrics

### Template Adoption

- Projects created using templates
- Time saved in project setup
- Consistency across projects
- User satisfaction ratings

### Project Quality

- Documentation completeness
- Navigation effectiveness
- Maintenance ease
- Development velocity

---

## 🎊 Key Achievements

1. **Comprehensive Templates** - Complete project structures for both types
2. **Best Practices Integration** - Learned from real project examples
3. **Automation** - Interactive project generator with customization
4. **Documentation Patterns** - Hub-and-spoke structure for navigation
5. **Flexibility** - Templates adapt to different project needs
6. **AI Optimization** - Structure designed for AI assistance

---

## 📞 Support

### Documentation

- [Template Usage Guide](docs/TEMPLATE-USAGE.md)
- [Project Types Guide](docs/PROJECT-TYPES.md)
- [Best Practices Guide](docs/BEST-PRACTICES.md)

### Examples

- [Real Project Examples](admin/notes/examples/)
- [Template Examples](templates/)

### Issues

- [GitHub Issues]([issues-url])
- [Discussions]([discussions-url])

---

## 📄 License

[License information]

---

**Last Updated:** 2025-11-10  
**Status:** ✅ Active  
**Next:** [Template Usage Guide](docs/TEMPLATE-USAGE.md)
