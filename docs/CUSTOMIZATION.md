# Customization Guide

**Purpose:** Comprehensive guide for customizing dev-infra templates to fit specific project needs  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This guide explains how to customize dev-infra templates for your specific project requirements. Templates are designed to be flexible starting points that can be adapted to different technologies, frameworks, and project types.

### What You'll Learn
- When to customize vs use templates as-is
- How to remove unused directories and files
- How to add project-specific directories
- How to customize CI/CD workflows
- How to adapt documentation structure
- Framework-specific customizations
- Advanced customization patterns

---

## 🤔 When to Customize

### Use Templates As-Is When:
- **Learning the patterns** - First time using templates
- **Standard projects** - Typical web apps, APIs, or tools
- **Team adoption** - Establishing consistent practices
- **Quick prototyping** - Need to start development immediately

### Customize When:
- **Specific technology stack** - Using frameworks not covered
- **Unique project requirements** - Special directory needs
- **Team preferences** - Different naming conventions
- **Integration needs** - Specific tool integrations
- **Compliance requirements** - Industry-specific needs

### Customization Levels

**Level 1: Configuration** - Update settings and preferences
**Level 2: Structure** - Modify directory structure
**Level 3: Workflow** - Change development processes
**Level 4: Framework** - Adapt for specific technologies

---

## 🗂️ Directory Structure Customization

### Removing Unused Directories

**Regular Project - Common Removals:**

**Frontend-only projects:**
```bash
# Remove backend-related directories
rm -rf backend/
rm -rf tests/integration/backend/
rm -rf tests/performance/backend/
```

**Backend-only projects:**
```bash
# Remove frontend-related directories
rm -rf frontend/
rm -rf tests/integration/frontend/
rm -rf tests/performance/frontend/
```

**CLI tools:**
```bash
# Remove web-related directories
rm -rf frontend/
rm -rf backend/
# Keep: admin/, scripts/, docs/, tests/
```

**Learning Project - Common Removals:**

**Single-topic courses:**
```bash
# Remove unused stages
rm -rf stage2-topic/
rm -rf stage3-topic/
# Rename remaining stages
mv stage1-topic/ stage1-your-topic/
```

**Reference-only projects:**
```bash
# Remove practice applications
rm -rf practice-apps/
# Keep: reference/, stage0-fundamentals/
```

### Adding Project-Specific Directories

**Regular Project Additions:**

**Mobile development:**
```bash
mkdir -p mobile/{ios,android,shared}
mkdir -p mobile/ios/Sources
mkdir -p mobile/android/app/src/main
```

**Microservices:**
```bash
mkdir -p services/{auth,user,payment,notification}
mkdir -p infrastructure/{docker,kubernetes,terraform}
mkdir -p shared/{models,utils,types}
```

**Data science:**
```bash
mkdir -p data/{raw,processed,models}
mkdir -p notebooks/
mkdir -p experiments/
mkdir -p reports/
```

**Learning Project Additions:**

**Programming courses:**
```bash
mkdir -p exercises/{beginner,intermediate,advanced}
mkdir -p solutions/
mkdir -p assessments/
```

**DevOps courses:**
```bash
mkdir -p labs/{docker,kubernetes,terraform}
mkdir -p environments/{dev,staging,prod}
mkdir -p monitoring/{logs,metrics,alerts}
```

### Updating Documentation

**After removing directories:**
1. Update main README.md
2. Remove references from admin/planning/
3. Update CI/CD workflows
4. Remove from .gitignore if needed

**After adding directories:**
1. Create README.md hubs
2. Add to main README.md
3. Update navigation links
4. Add to .gitignore if needed

---

## ⚙️ CI/CD Workflow Customization

### Technology-Specific Workflows

**Node.js Projects:**
```yaml
# .github/workflows/ci.yml
- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version: '18'
    cache: 'npm'

- name: Install dependencies
  run: npm ci

- name: Run tests
  run: npm test

- name: Build
  run: npm run build
```

**Python Projects:**
```yaml
# .github/workflows/ci.yml
- name: Setup Python
  uses: actions/setup-python@v4
  with:
    python-version: '3.11'

- name: Install dependencies
  run: pip install -r requirements.txt

- name: Run tests
  run: pytest

- name: Lint
  run: flake8 .
```

**Docker Projects:**
```yaml
# .github/workflows/ci.yml
- name: Build Docker image
  run: docker build -t ${{ github.repository }} .

- name: Run tests in container
  run: docker run --rm ${{ github.repository }} npm test

- name: Push to registry
  run: docker push ${{ github.repository }}
```

### Custom Workflow Steps

**Add security scanning:**
```yaml
- name: Security scan
  uses: securecodewarrior/github-action-add-sarif@v1
  with:
    sarif-file: security-scan-results.sarif
```

**Add performance testing:**
```yaml
- name: Performance test
  run: |
    npm run build
    npm run test:performance
```

**Add deployment:**
```yaml
- name: Deploy to staging
  if: github.ref == 'refs/heads/develop'
  run: |
    docker build -t staging .
    docker push staging
    kubectl apply -f k8s/staging/
```

---

## 📖 Documentation Structure Customization

### Hub-and-Spoke Adaptations

**Simplified Structure (Small Projects):**
```
project/
├── README.md              # Main hub
├── docs/                  # All documentation
│   ├── setup.md
│   ├── api.md
│   └── deployment.md
└── src/                   # All source code
```

**Complex Structure (Large Projects):**
```
project/
├── README.md              # Main hub
├── docs/                  # Documentation hub
│   ├── README.md          # Docs hub
│   ├── architecture/      # Architecture docs
│   ├── api/              # API documentation
│   └── deployment/       # Deployment guides
├── modules/              # Module hub
│   ├── README.md         # Module hub
│   ├── auth/            # Auth module
│   ├── user/            # User module
│   └── payment/         # Payment module
```

### Documentation Customization

**API Documentation:**
```markdown
# API Documentation

## Authentication
- [JWT Setup](auth/jwt-setup.md)
- [OAuth Integration](auth/oauth.md)

## Endpoints
- [User API](endpoints/user-api.md)
- [Payment API](endpoints/payment-api.md)
```

**Architecture Documentation:**
```markdown
# Architecture Overview

## System Design
- [High-Level Design](design/high-level.md)
- [Database Schema](design/database.md)

## Components
- [Frontend Architecture](components/frontend.md)
- [Backend Architecture](components/backend.md)
```

---

## 🛠️ Framework-Specific Customizations

### React Projects

**Frontend Structure:**
```
frontend/
├── src/
│   ├── components/        # Reusable components
│   ├── pages/            # Page components
│   ├── hooks/            # Custom hooks
│   ├── services/         # API services
│   ├── store/            # State management
│   ├── utils/            # Utility functions
│   └── types/            # TypeScript types
├── public/               # Static assets
└── tests/                # Frontend tests
```

**Package.json Scripts:**
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint src/",
    "type-check": "tsc --noEmit"
  }
}
```

### Node.js/Express Projects

**Backend Structure:**
```
backend/
├── src/
│   ├── controllers/      # Route handlers
│   ├── models/          # Data models
│   ├── services/        # Business logic
│   ├── middleware/      # Express middleware
│   ├── routes/          # Route definitions
│   ├── utils/           # Utility functions
│   └── config/          # Configuration
├── tests/               # Backend tests
└── migrations/          # Database migrations
```

**Express Setup:**
```javascript
// src/app.js
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/users', require('./routes/users'));

module.exports = app;
```

### Python/Django Projects

**Backend Structure:**
```
backend/
├── project/             # Django project
│   ├── settings/
│   ├── urls.py
│   └── wsgi.py
├── apps/                # Django apps
│   ├── auth/
│   ├── users/
│   └── payments/
├── requirements/        # Requirements files
├── tests/              # Test files
└── manage.py
```

**Django Settings:**
```python
# project/settings/base.py
import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

INSTALLED_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'apps.auth',
    'apps.users',
    'apps.payments',
]
```

---

## 🔧 Advanced Customization

### Multi-Repository Setup

**Monorepo Structure:**
```
project/
├── packages/            # Shared packages
│   ├── ui-components/
│   ├── shared-utils/
│   └── types/
├── apps/               # Applications
│   ├── web-app/
│   ├── mobile-app/
│   └── admin-panel/
├── services/           # Microservices
│   ├── auth-service/
│   ├── user-service/
│   └── payment-service/
└── infrastructure/     # Infrastructure code
    ├── docker/
    ├── kubernetes/
    └── terraform/
```

**Lerna Configuration:**
```json
{
  "version": "independent",
  "npmClient": "yarn",
  "packages": [
    "packages/*",
    "apps/*",
    "services/*"
  ]
}
```

### Multi-Environment Setup

**Environment Structure:**
```
project/
├── environments/        # Environment configs
│   ├── development/
│   ├── staging/
│   └── production/
├── config/             # Configuration files
│   ├── base.json
│   ├── dev.json
│   └── prod.json
└── scripts/            # Environment scripts
    ├── setup-dev.sh
    ├── deploy-staging.sh
    └── deploy-prod.sh
```

### Plugin Architecture

**Plugin Structure:**
```
project/
├── core/               # Core functionality
├── plugins/            # Plugin system
│   ├── auth/
│   ├── payment/
│   └── notification/
├── plugin-api/         # Plugin interface
└── examples/           # Plugin examples
```

---

## 📋 Customization Checklist

### Before Customizing

- [ ] Understand template structure
- [ ] Identify specific needs
- [ ] Plan customization approach
- [ ] Consider team preferences
- [ ] Document customization decisions

### During Customization

- [ ] Make incremental changes
- [ ] Test each change
- [ ] Update documentation
- [ ] Maintain consistency
- [ ] Follow established patterns

### After Customization

- [ ] Verify all functionality works
- [ ] Update all documentation
- [ ] Test CI/CD workflows
- [ ] Share changes with team
- [ ] Document customization rationale

---

## 🎯 Customization Examples

### Example 1: React + Node.js Full-Stack

**Customizations:**
- Keep both frontend/ and backend/
- Add shared/ directory for common types
- Customize CI/CD for both technologies
- Add Docker Compose for development

**Structure:**
```
project/
├── frontend/           # React app
├── backend/            # Node.js API
├── shared/             # Shared types/utils
├── docker-compose.yml  # Development setup
└── .github/workflows/  # CI/CD for both
```

### Example 2: Python Data Science

**Customizations:**
- Remove frontend/ and backend/
- Add data/, notebooks/, experiments/
- Customize for Jupyter and ML tools
- Add data validation workflows

**Structure:**
```
project/
├── data/               # Data files
├── notebooks/          # Jupyter notebooks
├── experiments/        # ML experiments
├── src/                # Python code
├── requirements.txt    # Dependencies
└── .github/workflows/  # Data validation CI
```

### Example 3: Learning Course

**Customizations:**
- Rename stages to match topics
- Add assessments/ directory
- Customize for specific learning path
- Add progress tracking

**Structure:**
```
course/
├── stage1-basics/      # Renamed from stage1-topic
├── stage2-intermediate/
├── stage3-advanced/
├── assessments/        # Added
├── reference/          # Quick reference
└── admin/              # Course management
```

---

## 🚨 Common Customization Mistakes

### ❌ Avoid These Mistakes

**Over-customization:**
- Don't change everything at once
- Don't remove core patterns
- Don't ignore template benefits

**Under-customization:**
- Don't leave placeholder text
- Don't ignore project-specific needs
- Don't skip documentation updates

**Inconsistent Changes:**
- Don't mix naming conventions
- Don't break hub-and-spoke pattern
- Don't ignore team standards

### ✅ Best Practices

**Incremental Changes:**
- Make small, testable changes
- Update documentation as you go
- Maintain consistency throughout

**Documentation:**
- Document all customizations
- Explain rationale for changes
- Keep documentation current

**Testing:**
- Test all customizations
- Verify CI/CD still works
- Check documentation links

---

## 📚 Related Documentation

- [Template Usage Guide](TEMPLATE-USAGE.md) - How to use templates
- [Project Types Guide](PROJECT-TYPES.md) - Regular vs Learning
- [Best Practices Guide](BEST-PRACTICES.md) - Template best practices
- [Template Files Guide](TEMPLATE-FILES.md) - Standard files reference

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Documentation Hub](README.md)
