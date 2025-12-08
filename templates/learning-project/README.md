# [Learning Project Name]

**Purpose:** [Brief description of what this learning project covers]  
**Version:** v0.1.0  
**Last Updated:** [Date]  
**Status:** 🟡 In Development

---

## 🎯 Learning Objectives

By the end of this project, you will understand:

- [Learning objective 1]
- [Learning objective 2]
- [Learning objective 3]

---

## 📚 Learning Path

This project follows a **stage-based learning approach** with fundamentals before implementation:

### Stage 0: Fundamentals

- [Fundamental concept 1]
- [Fundamental concept 2]
- [Fundamental concept 3]

### Stage 1: [Topic Name]

- [Topic concept 1]
- [Topic concept 2]
- [Hands-on exercises]

### Stage 2: [Topic Name]

- [Advanced concept 1]
- [Advanced concept 2]
- [Complex exercises]

### Stage 3: [Topic Name]

- [Expert concept 1]
- [Expert concept 2]
- [Real-world projects]

---

## 🚀 Quick Start

### Prerequisites

- [Prerequisite 1]
- [Prerequisite 2]
- [Development environment requirements]

### Setup

```bash
# Clone and setup
git clone [repository-url]
cd [project-name]

# Install dependencies
[installation commands]

# Start learning environment
[learning environment commands]
```

### Learning Order

1. **Start with Fundamentals** - Read `stage0-fundamentals/` first
2. **Follow Stage Progression** - Complete stages in order
3. **Practice with Exercises** - Do all exercises in each stage
4. **Reference Materials** - Use `reference/` for quick lookups
5. **Build Practice Apps** - Apply learning in `practice-apps/`

---

## 📁 Project Structure

This learning project uses a **stage-based organization** with progressive complexity:

```
[project-name]/
├── stage0-fundamentals/        # 📍 START HERE - Core concepts
│   ├── README.md              # Fundamentals overview
│   ├── 01-[concept].md        # Individual concept files
│   └── exercise-0.1-*.md      # Fundamental exercises
├── stage1-[topic]/            # 📡 SPOKE - First topic
│   ├── README.md              # Topic overview
│   ├── [topic]-fundamentals.md # Topic concepts
│   ├── exercise-1.1-*.md      # Topic exercises
│   └── [topic]-guide.md       # Implementation guide
├── stage2-[topic]/            # 📡 SPOKE - Second topic
├── stage3-[topic]/            # 📡 SPOKE - Third topic
├── reference/                 # 📡 SPOKE - Quick reference
│   ├── README.md              # Reference hub
│   ├── [tool]-commands.md     # Command references
│   └── [concept]-reference.md # Concept references
├── practice-apps/             # 📡 SPOKE - Hands-on practice
│   ├── README.md              # Practice apps overview
│   └── [app-name]/            # Individual practice apps
└── docs/maintainers/          # 📡 SPOKE - Learning management
    ├── planning/              # Learning roadmap
    ├── research/              # Learning decisions
    └── notes/                 # Learning insights
```

---

## 🎨 Learning Philosophy

### Fundamentals First

- Understand core concepts before implementation
- Build solid foundation before advanced topics
- Clear progression from simple to complex

### Hands-On Learning

- Every concept paired with exercises
- Practice applications for real-world experience
- Immediate application of learned concepts

### Reference Integration

- Quick lookup materials for ongoing reference
- Command references for daily use
- Concept summaries for review

### Progressive Complexity

- Each stage builds on previous knowledge
- Exercises increase in difficulty
- Real-world applications in later stages

---

## 📊 Learning Progress

### ✅ Completed Stages

| Stage   | Topic        | Status      | Duration | Key Learnings  |
| ------- | ------------ | ----------- | -------- | -------------- |
| Stage 0 | Fundamentals | ✅ Complete | X days   | [Key learning] |

### 🟠 Current Stage

| Stage   | Topic   | Progress | Current Exercise | Next            |
| ------- | ------- | -------- | ---------------- | --------------- |
| Stage 1 | [Topic] | 60%      | Exercise 1.3     | [Next exercise] |

### 🟡 Planned Stages

| Stage   | Topic   | Estimated | Prerequisites   |
| ------- | ------- | --------- | --------------- |
| Stage 2 | [Topic] | X days    | [Prerequisites] |

---

## 🛠️ Learning Environment

### Required Tools

- [Tool 1] - [Purpose]
- [Tool 2] - [Purpose]
- [Tool 3] - [Purpose]

### Development Setup

- [Setup instruction 1]
- [Setup instruction 2]
- [Setup instruction 3]

### Practice Environment

- [Practice environment setup]
- [Testing setup]
- [Validation setup]

---

## 🤖 Workflow Automation Commands

This learning project includes workflow automation commands to help organize learning, track progress, and plan learning stages. All commands are located in `.cursor/commands/` and can be used directly in Cursor IDE.

### Quick Reference

| Command | Purpose | Learning Use Case |
|---------|---------|-------------------|
| `/explore` | Start exploration cycles | Research learning topics |
| `/research` | Conduct structured research | Investigate concepts |
| `/decision` | Make learning decisions | Choose learning paths |
| `/transition-plan` | Create transition plans | Plan learning stages |
| `/reflect` | Analyze learning progress | After completing stages |
| `/reflection-artifacts` | Extract planning artifacts | Plan next learning stages |
| `/task-phase` | Implement learning tasks | Hands-on exercises |
| `/pr` | Create pull requests | Document learning work |
| `/post-pr` | Update docs after PR merge | Track learning progress |
| `/cursor-rules` | Manage cursor rules | Update AI config |

### Learning Workflow Commands

#### Exploration and Research

- **`/explore [topic]`** - Start exploration of learning topic
  - Creates exploration documents
  - Identifies research questions
  - Output: `docs/maintainers/planning/explorations/[topic]/`

- **`/research [topic] --from-explore [topic]`** - Research learning topic
  - Reads research topics from exploration
  - Creates research documents
  - Extracts learning requirements
  - Output: `docs/maintainers/research/[topic]/` + `requirements.md`

- **`/decision [topic] --from-research`** - Make learning decisions
  - Reads research documents
  - Creates ADR documents for learning choices
  - Output: `docs/maintainers/decisions/[topic]/` + ADRs

#### Learning Planning

- **`/transition-plan --from-adr`** - Plan learning stages
  - Reads learning decisions
  - Creates learning stage plans
  - Output: Learning plan + stage documents

- **`/task-phase [N]`** - Implement learning tasks
  - Reads from `docs/maintainers/planning/features/[stage-name]/phase-N.md`
  - Implements exercises and practice
  - Tracks learning progress

#### Reflection and Progress

- **`/reflect`** - Reflect on learning progress
  - Reviews completed stages
  - Identifies learning gaps
  - Suggests next steps

- **`/reflection-artifacts --type [type]`** - Extract learning plans
  - Creates plans for next learning stages
  - From reflection documents
  - Ready for implementation

#### Project Management

- **`/pr --phase [N]`** - Create PR for learning work
  - Documents learning progress
  - Creates comprehensive PR description

- **`/post-pr`** - Update learning documentation
  - Updates stage status
  - Updates learning progress
  - Tracks achievements

- **`/cursor-rules`** - Manage cursor rules
  - Updates AI assistant configuration
  - Customizes learning support

### Learning Workflow Examples

**Research a Learning Topic:**
```
/explore python-fundamentals
  → /research python-fundamentals --from-explore python-fundamentals
  → /decision python-fundamentals --from-research
  → /transition-plan --from-adr
```

**Plan Learning Stages:**
```
/reflect
  → /reflection-artifacts --type feature
  → /task-phase 1
  → /pr --phase 1
```

**Track Learning Progress:**
```
/task-phase 1  # Complete exercises
  → /pr --phase 1  # Document progress
  → /post-pr  # Update learning status
```

### Command Documentation

All commands have detailed documentation in `.cursor/commands/`. Each command includes:

- Configuration and path detection
- Workflow overview
- Step-by-step process
- Usage examples
- Learning-specific patterns

---

## 📚 Reference Materials

### Quick References

- **[Commands Reference](reference/commands.md)** - All commands in one place
- **[Concepts Reference](reference/concepts.md)** - Key concepts summary
- **[Troubleshooting](reference/troubleshooting.md)** - Common issues and solutions

### External Resources

- [External resource 1]
- [External resource 2]
- [External resource 3]

---

## 🔄 CI/CD Improvements

This learning project supports CI/CD improvements for process enhancements and workflow automation.

### CI/CD Improvement Structure

**Location:** `docs/maintainers/planning/ci/[improvement-name]/`

**Key Files:**
- `README.md` - Improvement hub
- `improvement-plan.md` - Improvement plan
- `phase-N.md` - Phase documents

**Key Differences from Features:**
- Uses `improvement-plan.md` instead of `feature-plan.md`
- No `status-and-next-steps.md` file (status tracked in README.md)
- Similar phase structure to features
- Use `/task-improvement` command instead of `/task-phase`

### Creating CI/CD Improvements

1. **Create improvement directory:**
   ```bash
   mkdir -p docs/maintainers/planning/ci/[improvement-name]
   ```

2. **Create improvement plan:**
   - Copy `docs/maintainers/planning/ci/improvement-plan-template.md` as `improvement-plan.md`
   - Fill in improvement details
   - Define implementation steps

3. **Create phase documents:**
   - Create `phase-1.md`, `phase-2.md`, etc.
   - Define tasks and deliverables

4. **Implement improvements:**
   - Use `/task-improvement [N]` to implement phases
   - Use `/pr --ci-improvement [name]` to create PRs

---

## 🎯 Exercises Overview

### Stage 0: Fundamentals

- [Exercise 0.1: Basic Concepts](stage0-fundamentals/exercise-0.1-basic-concepts.md)
- [Exercise 0.2: Environment Setup](stage0-fundamentals/exercise-0.2-environment-setup.md)

### Stage 1: [Topic]

- [Exercise 1.1: First Steps](stage1-topic/exercise-1.1-first-steps.md)
- [Exercise 1.2: Intermediate Practice](stage1-topic/exercise-1.2-intermediate-practice.md)

### Stage 2: [Topic]

- [Exercise 2.1: Advanced Concepts](stage2-topic/exercise-2.1-advanced-concepts.md)

### Stage 3: [Topic]

- [Exercise 3.1: Real-World Project](stage3-topic/exercise-3.1-real-world-project.md)

---

## 🏆 Practice Applications

### Beginner Apps

- **[App 1](practice-apps/app-1/README.md)** - [Description]
- **[App 2](practice-apps/app-2/README.md)** - [Description]

### Intermediate Apps

- **[App 3](practice-apps/app-3/README.md)** - [Description]

### Advanced Apps

- **[App 4](practice-apps/app-4/README.md)** - [Description]

---

## 📈 Learning Metrics

- [Learning metric 1]
- [Learning metric 2]
- [Learning metric 3]

---

## 🎊 Key Achievements

1. [Achievement 1]
2. [Achievement 2]
3. [Achievement 3]

---

## 📞 Support

- [Documentation](reference/)
- [Troubleshooting](reference/troubleshooting.md)
- [Issues]([issues-url])

---

**Last Updated:** [Date]  
**Status:** [Status]  
**Next:** [Next learning milestone]
