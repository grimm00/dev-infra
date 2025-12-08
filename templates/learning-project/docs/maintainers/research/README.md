# Research Hub

**Purpose:** Research and analysis for architectural decisions  
**Status:** ✅ Active  
**Last Updated:** [DATE]

---

## 📋 Quick Links

### Active Research

*No active research yet. Use `/research [topic]` to start new research.*

---

## 🎯 Overview

This directory contains research documents, analysis, and requirements documentation that inform architectural decisions.

**Workflow:**
1. `/research [topic]` - Conduct structured research
2. `/decision [topic] --from-research` - Make decisions based on research
3. `/transition-plan --from-adr` - Transition to planning

---

## 📁 Directory Structure

```
docs/maintainers/research/
├── README.md                    # 📍 HUB - This file
└── [topic]/                    # Topic-specific research (created by /research command)
    ├── README.md               # Topic research hub
    ├── research-[topic].md    # Research documents for each topic
    ├── research-summary.md     # Summary of all research findings
    └── requirements.md         # Functional and non-functional requirements
```

---

## 🔄 Workflow

### Starting Research

Use the `/research` command to start new research:

```bash
/research [topic-name]
```

Or continue from exploration:

```bash
/research [topic-name] --from-explore [topic-name]
```

This creates:
- `docs/maintainers/research/[topic]/` directory
- Research documents for each research topic
- `research-summary.md` - Summary of all findings
- `requirements.md` - Functional and non-functional requirements
- `README.md` - Topic research hub

### Research → Decision → Planning

1. **Research** (`/research`) - Conduct structured research, extract requirements
2. **Decision** (`/decision`) - Make architectural decisions, create ADRs
3. **Transition** (`/transition-plan`) - Transition to feature planning

---

## 📚 Related Documentation

- **[Explorations Hub](../planning/explorations/README.md)** - Explorations and proof of concepts
- **[Decisions Hub](../decisions/README.md)** - Architecture Decision Records (ADRs)
- **[Feature Planning](../planning/features/README.md)** - Feature planning and implementation

---

**Last Updated:** [DATE]  
**Status:** ✅ Active

