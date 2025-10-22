# Project Types Guide

**Purpose:** Detailed comparison and guidance for choosing between Regular and Learning project templates  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

Dev-infra provides two distinct project templates, each optimized for different use cases. This guide helps you choose the right template and understand the differences.

### Template Types

- **Regular Project** - For applications, tools, and services
- **Learning Project** - For tutorials, courses, and educational content

---

## 🔄 Regular vs Learning Projects

### Quick Comparison

| Aspect            | Regular Project           | Learning Project         |
| ----------------- | ------------------------- | ------------------------ |
| **Purpose**       | Build applications/tools  | Teach concepts/skills    |
| **Structure**     | Feature-based development | Stage-based learning     |
| **Documentation** | Technical specs, APIs     | Tutorials, exercises     |
| **Workflow**      | Development cycles        | Learning progression     |
| **Audience**      | End users, developers     | Students, learners       |
| **Timeline**      | Ongoing development       | Structured learning path |

---

## 🏗️ Regular Project Template

### When to Use

**Perfect For:**

- Web applications (React, Vue, Angular)
- Backend services (Node.js, Python, Go)
- Command-line tools and utilities
- APIs and microservices
- Libraries and frameworks
- Desktop applications
- Mobile applications

**Characteristics:**

- Production-ready code
- User-facing functionality
- Ongoing maintenance
- Feature development
- Bug fixes and updates

### Structure Overview

```
regular-project/
├── admin/                    # 📍 Project management hub
│   ├── planning/            # Feature planning, releases
│   ├── feedback/            # Code reviews, external feedback
│   ├── chat-logs/           # AI conversation history
│   ├── testing/             # Testing strategies
│   ├── docs/                # Admin documentation
│   └── research/            # Decision documentation
├── backend/                  # 📍 Backend application hub
│   ├── models/              # Data models
│   ├── routes/              # API endpoints
│   ├── services/            # Business logic
│   ├── utils/               # Utility functions
│   └── tests/               # Backend tests
├── frontend/                 # 📍 Frontend application hub
│   ├── src/                 # Source code
│   ├── components/          # React components
│   ├── pages/               # Page components
│   ├── services/            # API services
│   └── __tests__/           # Frontend tests
├── tests/                    # 📍 Centralized testing hub
│   ├── unit/                # Unit tests
│   ├── integration/         # Integration tests
│   ├── performance/         # Performance tests
│   └── fixtures/            # Test data
├── scripts/                  # 📍 Automation hub
│   ├── core/                # Essential scripts
│   ├── deployment/          # Deployment automation
│   ├── setup/               # Setup scripts
│   └── monitoring/          # Monitoring scripts
├── docs/                     # 📍 User documentation hub
│   ├── guides/              # User guides
│   ├── api/                 # API documentation
│   └── deployment/          # Deployment guides
└── .github/workflows/        # CI/CD automation
```

### Key Features

**Project Management:**

- Feature-based planning with hub-and-spoke docs
- Release management with version tracking
- External feedback integration (Sourcery, Bugbot)
- AI conversation history for context

**Development Structure:**

- Clear separation of backend/frontend
- Centralized testing with multiple test types
- Automation scripts for common tasks
- Comprehensive documentation

**CI/CD Integration:**

- Branch-based workflows (feat/, fix/, docs/, etc.)
- Automated testing and validation
- External review integration
- Deployment automation

---

## 📚 Learning Project Template

### When to Use

**Perfect For:**

- Tutorials and courses
- Skill development programs
- Exercise collections
- Reference materials
- Workshop content
- Educational projects
- Documentation sites

**Characteristics:**

- Structured learning progression
- Hands-on exercises
- Reference materials
- Practice applications
- Educational content

### Structure Overview

```
learning-project/
├── stage0-fundamentals/      # 📍 Core concepts hub
│   ├── README.md            # Fundamentals overview
│   ├── 01-the-big-picture.md # Overall understanding
│   ├── 02-[concept]-fundamentals.md # Core concepts
│   ├── 03-[concept]-fundamentals.md # Core concepts
│   ├── 04-[concept]-fundamentals.md # Core concepts
│   ├── 05-tools-overview.md # Available tools
│   └── exercise-0.1-*.md    # Fundamental exercises
├── stage1-[topic]/          # 📍 First learning stage hub
│   ├── README.md            # Stage overview
│   ├── [topic]-fundamentals.md # Topic concepts
│   ├── exercise-1.1-*.md    # Stage exercises
│   └── [topic]-guide.md     # Implementation guide
├── stage2-[topic]/          # 📍 Second learning stage hub
├── stage3-[topic]/          # 📍 Third learning stage hub
├── reference/               # 📍 Quick reference hub
│   ├── README.md            # Reference overview
│   ├── [tool]-commands.md   # Command references
│   ├── [concept]-reference.md # Concept references
│   └── troubleshooting.md   # Common issues
├── practice-apps/           # 📍 Hands-on practice hub
│   ├── README.md            # Practice apps overview
│   └── [app-name]/          # Individual practice apps
└── admin/                   # 📍 Learning management hub
    ├── planning/            # Learning roadmap
    ├── research/            # Learning decisions
    └── notes/               # Learning insights
```

### Key Features

**Learning Progression:**

- Stage-based organization with clear progression
- Fundamentals before implementation
- Hands-on exercises for each concept
- Practice applications for real-world experience

**Reference Integration:**

- Quick lookup materials
- Command references for daily use
- Concept summaries for review
- Troubleshooting guides

**Educational Structure:**

- Clear learning objectives
- Progressive complexity
- Immediate application of concepts
- Comprehensive coverage

---

## 🎯 Choosing the Right Template

### Decision Matrix

**Choose Regular Project If:**

- [ ] Building an application or tool
- [ ] Need production-ready code
- [ ] Have ongoing development cycles
- [ ] Need feature-based planning
- [ ] Require CI/CD workflows
- [ ] Building for end users
- [ ] Need backend/frontend separation

**Choose Learning Project If:**

- [ ] Creating educational content
- [ ] Teaching concepts or skills
- [ ] Need structured learning progression
- [ ] Want hands-on exercises
- [ ] Building reference materials
- [ ] Creating tutorials or courses
- [ ] Need stage-based organization

### Hybrid Approaches

**Learning + Regular:**

- Start with Learning Project for course content
- Create Regular Project for practice applications
- Link between learning materials and working code

**Regular + Learning:**

- Use Regular Project for main application
- Add Learning Project for documentation/tutorials
- Create educational content about your project

---

## 🔧 Customization Examples

### Regular Project Customizations

**Web Application:**

```bash
# Keep: admin/, backend/, frontend/, tests/, scripts/, docs/
# Customize: Add specific frameworks, update CI/CD
# Remove: Unused directories based on tech stack
```

**CLI Tool:**

```bash
# Keep: admin/, scripts/, docs/, tests/
# Customize: Focus on scripts/ directory
# Remove: frontend/, backend/ (if not needed)
```

**API Service:**

```bash
# Keep: admin/, backend/, tests/, docs/
# Customize: Focus on backend/ structure
# Remove: frontend/ (if API-only)
```

### Learning Project Customizations

**Programming Course:**

```bash
# Rename: stage1-basics, stage2-intermediate, stage3-advanced
# Customize: Add language-specific exercises
# Add: More practice applications
```

**DevOps Tutorial:**

```bash
# Rename: stage1-docker, stage2-kubernetes, stage3-cicd
# Customize: Add infrastructure exercises
# Add: Real-world deployment scenarios
```

**Design Course:**

```bash
# Rename: stage1-principles, stage2-tools, stage3-projects
# Customize: Add design exercises
# Add: Portfolio practice applications
```

---

## 📊 Template Comparison

### Development Workflow

**Regular Project:**

1. Plan features in admin/planning/features/
2. Develop in backend/ and frontend/
3. Test in tests/ directory
4. Deploy using scripts/
5. Document in docs/

**Learning Project:**

1. Start with stage0-fundamentals/
2. Progress through stages sequentially
3. Complete exercises in each stage
4. Practice with practice-apps/
5. Reference materials in reference/

### Documentation Approach

**Regular Project:**

- Technical documentation
- API references
- User guides
- Development workflows
- Deployment instructions

**Learning Project:**

- Educational content
- Exercise instructions
- Concept explanations
- Learning objectives
- Reference materials

### Maintenance Patterns

**Regular Project:**

- Feature updates
- Bug fixes
- Performance improvements
- Security updates
- User feedback integration

**Learning Project:**

- Content updates
- Exercise improvements
- New learning materials
- Reference updates
- Student feedback integration

---

## 🚀 Getting Started

### For Regular Projects

1. **Generate Project**

   ```bash
   ./scripts/new-project.sh
   # Choose: Regular Project
   ```

2. **Customize Structure**

   - Update start.txt with project details
   - Configure technology stack in README.md
   - Set up CI/CD workflows

3. **Start Development**
   - Create first feature in admin/planning/features/
   - Set up development environment
   - Begin feature development

### For Learning Projects

1. **Generate Project**

   ```bash
   ./scripts/new-project.sh
   # Choose: Learning Project
   ```

2. **Customize Content**

   - Rename stage directories to match topics
   - Update learning objectives
   - Create first exercises

3. **Start Learning**
   - Begin with stage0-fundamentals/
   - Follow learning progression
   - Complete exercises as you go

---

## 📚 Related Documentation

- [Template Usage Guide](TEMPLATE-USAGE.md) - How to use templates
- [Best Practices Guide](BEST-PRACTICES.md) - Template best practices
- [Customization Guide](CUSTOMIZATION.md) - Advanced customization

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Best Practices Guide](BEST-PRACTICES.md)
