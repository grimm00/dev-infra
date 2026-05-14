# Dev-Infra

[![Release](https://img.shields.io/github/v/release/grimm00/dev-infra)](https://github.com/grimm00/dev-infra/releases)
[![License](https://img.shields.io/github/license/grimm00/dev-infra)](LICENSE)

**Purpose:** Standardized development infrastructure templates and best practices  
**Version:** v0.7.0-dev  
**Last Updated:** 2025-12-18  
**Status:** ✅ Active

---

## Why Dev-Infra Exists

Dev-infra grew out of an apprenticeship where the job was to explore broadly — instructors assigned topics across different domains, from DNS infrastructure to CLI tooling to file servers, with access to company infrastructure and the encouragement to leverage open-source tools and just figure things out. That freedom was valuable, but it created a real problem: projects multiplied faster than they could be tracked. Each new investigation meant a new repo, a new structure, a new set of conventions to remember. Some were active, some were experiments, some should have been archived months ago. Without a consistent approach, the breadth became sprawl.

The initial trigger was noticing that the same patterns kept emerging across unrelated projects. A full-stack app (Pokehub), a command-line tool (dev-toolkit), and a learning project (Containers) all converged on similar organizational structures, similar documentation approaches, similar planning workflows. The thought was: it would be useful to start new projects, revisit old ones, and read others' projects with a systematic way of understanding them — a consistent landing surface regardless of tech stack, domain, or level of activity.

But the project quickly became more than templates. Alongside the need to manage project lifecycles, there was a parallel need to develop workflows for refining thinking itself — structured approaches to exploring problems, conducting research, making architectural decisions, and planning implementation before writing code. These two needs started as one ("I need structure") and dev-infra is where they converge: the templates provide consistent project organization, while the workflow system (skills like explore, research, decide, plan) encodes engineering rigor into repeatable patterns.

The visible output is a couple of opinionated project templates. The actual product is the system that produces them — a living project with 1,100+ commits, 14 architectural decisions, and patterns running in production across multiple real projects.

### How the Project Found Its Focus

That dual nature — templates and workflows — created a real tension as the project grew. Dev-infra had organically become three things at once: a **laboratory** for experimenting with workflow automation, a **factory** for producing project templates, and a **reference implementation** that used its own tools to build itself. Every improvement became a question: is this a template feature that downstream projects need, or is this internal tooling that only dev-infra uses?

The answer came through a formal decision process (the same explore → research → decide pipeline that dev-infra encodes for other projects). The conclusion: dev-infra's primary identity is **template factory**. Templates are products, not reflections of the internal process. Internal tooling — release automation, validation scripts, the workflow experiments — stays internal. Features have to prove themselves in real use before they graduate into templates.

That decision clarified everything. It meant fewer, more stable template features instead of shipping every experiment. It meant a two-tier system where dev-infra is deliberately more capable than the templates it produces — and that's by design, not by accident. It also meant the project could iterate on its own workflows without every change rippling into downstream projects.

---

## 🚀 Quick Start

### 1. Get Dev-Infra

**Option A: Download Distribution (Recommended)**
```bash
# Download clean package (Linux/Mac)
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.6.0/dev-infra-0.6.0.tar.gz | tar -xz
cd dev-infra-0.6.0

# Or download for Windows
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.6.0/dev-infra-0.6.0.zip -o dev-infra.zip
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
DEVINFRA_VERSION="0.6.0"
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

**Last Updated:** 2025-12-18  
**Status:** ✅ Active  
**Next:** [Template Usage Guide](docs/TEMPLATE-USAGE.md)
