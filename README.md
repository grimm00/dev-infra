# Dev-Infra

[![Release](https://img.shields.io/github/v/release/grimm00/dev-infra)](https://github.com/grimm00/dev-infra/releases)
[![License](https://img.shields.io/github/license/grimm00/dev-infra)](LICENSE)

**Purpose:** Standardized development infrastructure templates and best practices  
**Version:** v0.11.0  
**Last Updated:** 2026-05-14  
**Status:** ✅ Active

---

## Why dev-infra Exists

Dev-infra grew out of an apprenticeship where the job was to explore broadly — instructors assigned topics across different domains, from DNS infrastructure to CLI tooling to file servers, with access to company infrastructure and the encouragement to leverage open-source tools and just figure things out. That freedom was valuable, but it created a real problem: projects multiplied faster than they could be tracked. Each new investigation meant a new repo, a new structure, a new set of conventions to remember. Some were active, some were experiments, some should have been archived months ago. Without a consistent approach, the breadth became sprawl.

The initial trigger was noticing that the same patterns kept emerging across unrelated projects. A full-stack app (Pokehub), a command-line tool (dev-toolkit), and a learning project (Containers) all converged on similar organizational structures, similar documentation approaches, similar planning workflows. The thought was: it would be useful to start new projects, revisit old ones, and read others' projects with a systematic way of understanding them — a consistent landing surface regardless of tech stack, domain, or level of activity.

But the project quickly became more than templates. Alongside the need to manage project lifecycles, there was a parallel need to develop workflows for refining thinking itself — structured approaches to exploring problems, conducting research, making architectural decisions, and planning implementation before writing code. These two needs started as one ("I need structure") and dev-infra is where they converge: the templates provide consistent project organization, while the workflow system (skills like explore, research, decide, plan) encodes engineering rigor into repeatable patterns.

The visible output is a couple of opinionated project templates. The actual product is the system that produces them — a living project with 1,100+ commits, 14 architectural decisions, and patterns running in production across multiple real projects.

### How the Project Found Its Focus

That dual nature — templates and workflows — created a real tension as the project grew. Dev-infra had organically become three things at once: a **laboratory** for experimenting with workflow automation, a **factory** for producing project templates, and a **reference implementation** that used its own tools to build itself. Every improvement became a question: is this a template feature that downstream projects need, or is this internal tooling that only dev-infra uses?

The answer came through a formal decision process (the same explore → research → decide pipeline that dev-infra encodes for other projects). The conclusion: dev-infra's primary identity is **template factory**. Templates are products, not reflections of the internal process. Internal tooling — release automation, validation scripts, the workflow experiments — stays internal. Features have to prove themselves in real use before they graduate into templates.

That decision clarified everything. It meant fewer, more stable template features instead of shipping every experiment. It meant a two-tier system where dev-infra is deliberately more capable than the templates it produces — and that's by design, not by accident. It also meant the project could iterate on its own workflows without every change rippling into downstream projects.

### What dev-infra Has Produced

The proof that the patterns work isn't in the templates themselves — it's in the projects running on them. Dev-infra's templates and workflows are the foundation for a growing ecosystem of real projects across different domains and tech stacks:

- **proj-cli** — A command-line tool for project management, built on the standard project template
- **pihole-dns** — DNS infrastructure using Pi-hole, structured with dev-infra's hub-and-spoke documentation and planning workflows
- **ourfileserver** — A file server project using dev-infra's feature-based planning and consistent project organization
- **work-prod** — Work/production integration, using dev-infra workflows to bridge personal and professional tooling
- **support-shark** — A support tool leveraging dev-infra's standard project structure and AI-friendly organization

Each of these projects started from a dev-infra template and inherited the same documentation patterns, planning workflows, and organizational conventions. That consistency is what makes it possible to context-switch between a DNS project and a CLI tool without re-learning how the project is organized — the original problem that dev-infra was built to solve.

---

## Quick Start

### 1. Get dev-infra

**Option A: Download Distribution (Recommended)**
```bash
curl -L https://github.com/grimm00/dev-infra/releases/download/v0.7.0/dev-infra-0.7.0.tar.gz | tar -xz
cd dev-infra-0.7.0
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
./scripts/new-project.sh
```

Choose your project type:

- **Standard Project** — Applications, tools, services, APIs
- **Learning Project** — Tutorials, courses, exercises

### 3. Customize

- Update `start.txt` with project details and goals
- Customize `README.md` with your technology stack
- Configure CI/CD workflows
- Remove unused directories, add project-specific ones

---

## Project Templates

### Standard Project

For applications, tools, services, and APIs. Includes hub-and-spoke documentation, feature-based planning, backend/frontend separation, centralized testing, and CI/CD workflows.

```
project/
├── docs/
│   └── maintainers/  # Project management hub
├── backend/          # Backend application
├── frontend/         # Frontend application
├── tests/            # Centralized testing
├── scripts/          # Automation
└── .github/          # CI/CD workflows
```

### Learning Project

For tutorials, courses, and exercises. Uses stage-based progression from fundamentals through implementation, with reference materials and practice applications.

```
project/
├── stage0-fundamentals/  # Core concepts
├── stage1-[topic]/       # Learning stages
├── stage2-[topic]/
├── reference/            # Quick reference
├── practice-apps/        # Hands-on practice
└── docs/
    └── maintainers/      # Learning management
```

---

## Design Philosophy

### Hub-and-Spoke Documentation

Every template uses a hub-and-spoke documentation pattern: hub files (README.md) serve as entry points with quick links, spoke directories contain focused single-topic content, and progressive disclosure guides readers from overview to detail.

### Patterns from Real Projects

Templates incorporate patterns learned from real projects — Pokehub (full-stack structure), dev-toolkit (CLI organization), and Containers (learning progression). These aren't theoretical best practices; they're patterns that survived contact with real codebases.

### Flexibility

Not all directories are required for every project. Templates are designed to be trimmed (remove what you don't need) or extended (add project-specific directories) while maintaining core structural principles.

---

## Dev-Toolkit Integration

Dev-infra integrates with dev-toolkit for version-pinned template management:

```bash
DEVINFRA_VERSION="0.7.0"
curl -L "https://github.com/grimm00/dev-infra/archive/v${DEVINFRA_VERSION}.tar.gz" | tar -xz
```

See [Integration Guide](docs/INTEGRATION.md) for complete examples.

---

## Documentation

- **[Template Usage Guide](docs/TEMPLATE-USAGE.md)** — How to use templates
- **[Project Types Guide](docs/PROJECT-TYPES.md)** — Standard vs Learning comparison
- **[Best Practices Guide](docs/BEST-PRACTICES.md)** — Template best practices
- **[Customization Guide](docs/CUSTOMIZATION.md)** — Advanced customization
- **[Standard Project Template](templates/standard-project/)** — Application template source
- **[Learning Project Template](templates/learning-project/)** — Educational template source

---

## Contributing

1. Fork the repository
2. Create a feature branch (`feat/improve-templates`)
3. Make changes following hub-and-spoke patterns
4. Test templates using `./scripts/new-project.sh` and `./scripts/validate-templates.sh`
5. Submit a pull request

---

## Project Structure

```
dev-infra/
├── templates/              # Project templates
│   ├── standard-project/   # Application template
│   └── learning-project/   # Educational template
├── scripts/                # Automation scripts
├── docs/                   # User documentation
├── admin/                  # Dev-infra project management
│   └── services/           # Service-first organization
└── .cursor/                # IDE configuration
```

---

**Last Updated:** 2026-05-14  
**Status:** ✅ Active  
**Next:** [Template Usage Guide](docs/TEMPLATE-USAGE.md)
