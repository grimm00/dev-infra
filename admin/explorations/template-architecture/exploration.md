# Template Architecture - Exploration

**Status:** 🔴 Exploration  
**Created:** 2025-12-12  
**Last Updated:** 2025-12-12

---

## 🎯 What Are We Exploring?

Alternative directory structures and organizational patterns for project templates that better reflect the diversity of real-world software projects, beyond the current `frontend/backend` paradigm.

**Current State:**
```
standard-project/
├── backend/          # Single backend service
├── frontend/         # Single frontend app
├── tests/            # Centralized tests
├── scripts/          # Automation scripts
└── docs/             # Documentation
```

**Observed Reality:** Real-world projects often have:
- Multiple services (not just one backend)
- Multiple clients (web, mobile, CLI, desktop)
- Infrastructure code (Terraform, Kubernetes, Docker)
- Shared libraries/packages
- Background workers/jobs
- Different architectural patterns entirely

---

## 🤔 Why Explore This?

**Problem:** The `frontend/backend` structure makes assumptions that don't fit all projects:

| Project Type | Fits Current Template? | Issue |
|--------------|----------------------|-------|
| Full-stack web app | ✅ Yes | Works well |
| API-only service | ⚠️ Partial | Empty/unused frontend dir |
| CLI tool | ❌ No | No frontend/backend concept |
| Library/package | ❌ No | No runtime, just source |
| Microservices | ❌ No | Multiple backends needed |
| Mobile + API | ⚠️ Partial | "Frontend" isn't web |
| Monorepo | ❌ No | Multiple apps/services |

**Opportunity:**
- Templates that adapt to project needs
- Less confusion about what goes where
- Better guidance for different project types
- Foundation for future project variety

**Risk of Over-Engineering:**
- Too many templates = maintenance burden
- Too configurable = analysis paralysis
- Too specialized = hand-holding, not enabling

---

## 💡 Initial Thoughts

### Option A: Modular/Composable Templates

**Concept:** Base template + optional modules that can be composed

```
base-project/           # Always included
├── docs/
├── scripts/
└── .cursor/

modules/
├── api/                # Add an API service
├── web-client/         # Add a web frontend
├── cli/                # Add a CLI tool
├── mobile/             # Add mobile apps
├── infra/              # Add infrastructure code
└── worker/             # Add background workers
```

**Usage:** `./new-project.sh --modules api,cli`

**Pros:**
- Maximum flexibility
- DRY - shared base, specific modules
- User chooses what they need

**Cons:**
- Complex generator script
- More testing needed (module combinations)
- Potential for invalid combinations

---

### Option B: Specialized Templates

**Concept:** Multiple purpose-built templates

```
templates/
├── full-stack-web/     # Frontend + Backend (current)
├── api-service/        # API only (no frontend)
├── cli-tool/           # Command-line application
├── library/            # Reusable package/library
├── monorepo/           # Multiple services/apps
└── learning-project/   # Already exists (stages)
```

**Usage:** `./new-project.sh --type api-service`

**Pros:**
- Clear purpose for each template
- Easy to understand and maintain
- Tailored guidance per type

**Cons:**
- More templates to maintain
- Potential duplication across templates
- Users must choose upfront

---

### Option C: Generic + Configuration

**Concept:** Single flexible template with configuration

```
standard-project/
├── src/                # Source code (user organizes)
├── tests/
├── scripts/
├── docs/
└── project.yaml        # Configuration file
```

**project.yaml:**
```yaml
type: full-stack
components:
  - name: api
    path: src/api
  - name: web
    path: src/web
```

**Pros:**
- Single template to maintain
- User decides organization
- Highly flexible

**Cons:**
- Less opinionated (more decisions for user)
- Less guidance for beginners
- Configuration complexity

---

### Option D: Hybrid Approach

**Concept:** Keep current templates + add specialized ones as needed

```
templates/
├── standard-project/   # Current (full-stack web) - works for most
├── learning-project/   # Current (stage-based) - works for learning
├── api-service/        # NEW: API-only (no frontend)
├── cli-tool/           # NEW: Command-line tool
└── (future as needed)
```

**Pros:**
- Evolutionary approach
- Minimal disruption
- Add templates when needed

**Cons:**
- May accumulate many templates over time
- Still some duplication

---

## 🔍 Key Questions

- [ ] What project types do we actually need to support?
- [ ] How much configuration complexity is acceptable?
- [ ] What's the maintenance burden threshold (number of templates)?
- [ ] How do other template systems handle this? (cookiecutter, yeoman, create-*)
- [ ] Should templates be prescriptive or flexible?
- [ ] What's the minimum viable set of templates?
- [ ] How do we handle shared components across templates?

---

## 📊 Current Template Usage

Before deciding, we should understand how templates are actually used:

**standard-project:**
- Primary use case: Full-stack web applications
- Assumes: Single backend, single frontend
- Tech stack: Not specified (template is tech-agnostic)

**learning-project:**
- Primary use case: Learning/tutorial projects
- Assumes: Stage-based progression
- Tech stack: Not specified

**Gaps:**
- API-only services
- CLI tools
- Libraries
- Microservices

---

## 🚀 Next Steps

1. Review research topics in `research-topics.md`
2. Use `/research template-architecture --from-explore template-architecture` to conduct research
3. After research, use `/decision template-architecture --from-research` to make decisions
4. Use `/transition-plan --from-adr` to transition to feature planning

---

## 📝 Notes

**Guiding Principle:** Templates should enable, not constrain. They provide structure and guidance while allowing flexibility for project-specific needs.

**Balance to Strike:**
- **Too generic:** No guidance, user decides everything → analysis paralysis
- **Too specific:** Hand-holds every decision → doesn't scale to variety
- **Just right:** Clear structure with intentional flexibility → enables rapid start with room to grow

**Questions for User:**
- What projects do you anticipate creating in the next 6-12 months?
- Which of those would NOT fit the current standard-project template?
- What's your tolerance for maintaining multiple templates?

---

**Last Updated:** 2025-12-12

