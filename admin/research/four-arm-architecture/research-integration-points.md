# Research: Integration Points and Data Flow

**Research Topic:** Four-Arm Architecture  
**Question:** How should the four projects communicate with each other?  
**Priority:** 🔴 High  
**Status:** ✅ Complete  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31  
**Completed:** 2025-12-31

---

## 🎯 Research Question

How should the four projects communicate with each other?

**Context:** Clear integration points enable loose coupling while maintaining functionality. The architecture includes potential communication between:
- proj-cli ↔ work-prod (API calls)
- dev-toolkit → dev-infra (pulls commands)
- proj-cli → dev-infra state files
- All arms → shared configuration

---

## 🔍 Research Goals

- [x] Goal 1: Map all integration points between the four projects
- [x] Goal 2: Evaluate API vs. file-based communication patterns
- [x] Goal 3: Determine dependency relationships between projects
- [x] Goal 4: Design shared configuration format (if needed)

---

## 📚 Research Methodology

**Sources investigated:**
- [x] Review current proj-cli → work-prod API integration (`src/proj/api_client.py`)
- [x] Review dev-toolkit installation patterns (`install.sh`, `bin/dt-config`)
- [x] Review existing work-prod integration research
- [x] Review shared contracts research findings
- [x] Industry patterns analysis (CLI tools, developer ecosystems)
- [x] Case studies: Git, GitHub CLI, AWS CLI, XDG Base Directory Standard

**Sub-questions addressed:**
1. API vs. file-based communication - when to use each? ✅
2. Should proj-cli depend on dev-toolkit? ✅
3. How does dev-toolkit know about dev-infra releases? ✅
4. Should there be a shared configuration format? ✅

---

## 📊 Findings

### Finding 1: Current Integration is Well-Designed

**Description:** The existing proj-cli → work-prod integration follows best practices:

| Aspect | Implementation | Quality |
|--------|---------------|---------|
| **Protocol** | REST API over HTTP | ✅ Industry standard |
| **Contract** | OpenAPI 3.0.3 spec (691 lines) | ✅ Complete, authoritative |
| **Configuration** | XDG-compliant YAML + env vars | ✅ Best practice |
| **Error Handling** | Custom exceptions, graceful degradation | ✅ Robust |
| **Authentication** | Configurable API URL, ready for auth | ✅ Extensible |

The `api_client.py` handles all HTTP operations with proper timeout (10s), error conversion, and session management.

**Source:** `proj-cli/src/proj/api_client.py`, `proj-cli/src/proj/config.py`

**Relevance:** This integration pattern should be the model for other cross-arm communication.

---

### Finding 2: Communication Pattern Decision Matrix

**Description:** Analysis reveals when to use each communication type:

| Communication Type | Use When | Example | Four-Arm Application |
|-------------------|----------|---------|---------------------|
| **REST API** | Real-time data, CRUD operations, queries | proj-cli → work-prod | Project registry operations |
| **File-Based (Copy)** | Installation, one-time transfers | dev-toolkit → ~/.cursor/commands | Command installation |
| **File-Based (Config)** | Local settings, preferences | ~/.config/proj/config.yaml | Tool configuration |
| **Release Artifacts** | Version snapshots, immutable content | dev-infra releases | Command source for installation |
| **Environment Variables** | Overrides, CI/CD, secrets | PROJ_API_URL | Runtime configuration |

**Key Decision:** Use **API for data operations**, **files for installation/config**.

**Source:** Industry patterns analysis, existing implementation review

**Relevance:** Provides clear guidance for each integration point.

---

### Finding 3: Dependency Relationships Are Minimal and Optional

**Description:** The four projects have intentionally minimal dependencies:

```
                    dev-infra
                   (no runtime deps)
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             │             ▼
    dev-toolkit         │         (projects)
   (no runtime deps)    │
          │             │
          │             ▼
          └───────► proj-cli ◄───────┐
                        │             │
                        │ API (optional)
                        ▼             │
                    work-prod         │
                  (no external deps)──┘
```

| From | To | Dependency Type | Required? |
|------|----|-----------------|-----------|
| dev-toolkit | dev-infra | Source (release artifacts) | Optional (install-time) |
| proj-cli | work-prod | API (runtime) | Optional (API calls) |
| projects | dev-infra | Template (creation-time) | One-time |
| dev-toolkit | work-prod | None | N/A |
| proj-cli | dev-toolkit | None | N/A |
| proj-cli | dev-infra | None | N/A |

**Key Insight:** No project has hard runtime dependencies on another. All integrations are optional or one-time.

**Source:** Architecture analysis

**Relevance:** Confirms standalone usability - each project works without the others.

---

### Finding 4: XDG Base Directory Pattern Works Well

**Description:** Both dev-toolkit and proj-cli follow XDG-like patterns for configuration:

**dev-toolkit:**
```
~/.dev-toolkit/           # Config root
├── config.conf           # Global settings
└── lib/                  # Libraries (from install)
```

**proj-cli:**
```
~/.config/proj/           # XDG_CONFIG_HOME/proj
├── config.yaml           # Settings
~/.local/share/proj/      # XDG_DATA_HOME/proj
└── (data files)          # Future: local registry
```

**proj-cli implementation:**
```python
def get_xdg_config_home() -> Path:
    return Path(os.environ.get("XDG_CONFIG_HOME", Path.home() / ".config"))

def get_config_dir() -> Path:
    return get_xdg_config_home() / "proj"
```

**Source:** `proj-cli/src/proj/config.py`, `dev-toolkit/bin/dt-config`

**Relevance:** XDG pattern should be used for any new shared configuration.

---

### Finding 5: No Shared Configuration Needed

**Description:** Analysis shows each tool's config is independent and should remain so:

| Tool | Configuration Needs | Overlap |
|------|-------------------|---------|
| **dev-toolkit** | Branch names, protected branches | None |
| **proj-cli** | API URL, GitHub token, scan dirs | API URL could be shared |
| **work-prod** | Database path, server settings | None |
| **dev-infra** | N/A (templates have no runtime config) | None |

The only potential overlap (API URL) is better handled by:
1. **Default convention:** `http://localhost:5000` (already implemented)
2. **Environment variable:** `PROJ_API_URL` (already implemented)
3. **Per-tool config file** (current approach)

**Key Decision:** Each tool should maintain its own configuration. Shared config adds complexity without proportional benefit.

**Source:** Configuration analysis, complexity assessment

**Relevance:** Confirms we don't need `~/.dev-infra.yml` or similar shared config.

---

### Finding 6: dev-toolkit Release Awareness Via Git Tags

**Description:** dev-toolkit can discover dev-infra releases via Git:

**Current Pattern (dev-toolkit install.sh):**
```bash
TOOLKIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

**Proposed Command Installation Pattern (from Topic 1 research):**
```bash
# dt-cursor-install would:
1. Clone/fetch dev-infra repository
2. Read templates/standard-project/.cursor/commands/
3. Copy to ~/.cursor/commands/
4. Track version installed
```

**Version discovery options:**
1. **Git tags** - Read latest tag from dev-infra repo
2. **GitHub releases** - API call to get release info
3. **VERSION file** - Check file in dev-infra repo

Git tags are simplest and don't require network if repo is local.

**Source:** dev-toolkit install.sh analysis, industry patterns

**Relevance:** Provides mechanism for dev-toolkit to know dev-infra versions.

---

## 📊 Final Integration Point Matrix

| From | To | Type | Status | Recommendation |
|------|-----|------|--------|----------------|
| proj-cli | work-prod | REST API | ✅ Implemented | Keep as-is |
| dev-toolkit | dev-infra | Git clone/fetch | ❌ Not implemented | Add `dt-cursor-install` |
| dev-toolkit | ~/.cursor/commands/ | File copy | ❌ Not implemented | Part of `dt-cursor-install` |
| proj-cli | local state | File (JSON) | 🟡 Planned | XDG-compliant location |
| All | shared config | N/A | ❌ Not needed | Per-tool config is sufficient |

---

## 🔍 Analysis

### The Hybrid Integration Model

The Four-Arm Architecture uses a **hybrid integration model**:

1. **Data Operations** → REST API (proj-cli ↔ work-prod)
2. **Tool Installation** → File copy from repo (dev-toolkit ← dev-infra)
3. **Configuration** → Per-tool XDG-compliant files
4. **Version Coordination** → Git tags/releases (process-based)

This model achieves:
- **Loose coupling:** No runtime dependencies between tools
- **Standalone capability:** Each tool works independently
- **Optional integration:** Features degrade gracefully when other arms unavailable

### Communication Pattern Summary

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          DATA FLOW PATTERNS                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   dev-infra                                                             │
│   ├── templates/ ─────────────────────────┐                            │
│   │   └── .cursor/commands/               │ (file copy at install)     │
│   └── releases (git tags) ◄───────────────┼─────────────────┐          │
│                                           │                  │          │
│                                           ▼                  │          │
│   dev-toolkit ◄──────────────────────────────────────────────┘          │
│   ├── dt-cursor-install (reads dev-infra, writes ~/.cursor/)           │
│   └── ~/.dev-toolkit/config.conf (local config)                        │
│                                                                          │
│   proj-cli                                                              │
│   ├── ~/.config/proj/config.yaml (local config)                        │
│   └── API calls ──────────────────────────────────────────────┐        │
│                                                                │        │
│   work-prod                                                    │        │
│   ├── /api/projects (REST endpoints) ◄────────────────────────┘        │
│   └── backend/openapi.yaml (contract)                                   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Insights:**
- [x] Insight 1: API for real-time data (proj-cli ↔ work-prod), files for installation/config
- [x] Insight 2: No shared configuration needed - each tool manages its own config
- [x] Insight 3: Git tags/releases provide version awareness without runtime coupling
- [x] Insight 4: XDG Base Directory is the right pattern for tool configuration
- [x] Insight 5: All integrations are optional - supports standalone use

---

## 💡 Recommendations

- [x] **Recommendation 1:** Keep proj-cli ↔ work-prod API integration as-is (it's well-designed)
- [x] **Recommendation 2:** Implement `dt-cursor-install` to handle dev-infra → dev-toolkit → global commands flow
- [x] **Recommendation 3:** Use Git tags for version awareness (simpler than GitHub API)
- [x] **Recommendation 4:** Do NOT implement shared configuration - per-tool config is sufficient
- [x] **Recommendation 5:** All integrations MUST be optional - graceful degradation when unavailable
- [x] **Recommendation 6:** Follow XDG Base Directory pattern for any new configuration needs

---

## 📋 Requirements Discovered

### Functional Requirements

- [x] **FR-IP-1:** proj-cli MUST continue using REST API for work-prod communication
- [x] **FR-IP-2:** dev-toolkit MUST implement `dt-cursor-install` for command distribution
- [x] **FR-IP-3:** `dt-cursor-install` MUST read commands from dev-infra repository
- [x] **FR-IP-4:** `dt-cursor-install` MUST copy commands to `~/.cursor/commands/`
- [x] **FR-IP-5:** `dt-cursor-install` SHOULD track installed version for update detection

### Non-Functional Requirements

- [x] **NFR-IP-1:** All integrations MUST be optional (graceful degradation)
- [x] **NFR-IP-2:** Tools MUST work offline for core functionality
- [x] **NFR-IP-3:** Configuration MUST follow XDG Base Directory pattern
- [x] **NFR-IP-4:** No runtime dependencies between tools (install-time only)

### Constraints

- [x] **C-IP-1:** Shared configuration is NOT appropriate - adds complexity without benefit
- [x] **C-IP-2:** proj-cli and dev-toolkit MUST NOT have direct dependencies on each other

---

## 🔗 Related Research

- **[Shared Contracts](research-shared-contracts.md)** - Contract-based integration (OpenAPI standard)
- **[Command Distribution Ownership](research-command-distribution-ownership.md)** - dev-toolkit ↔ dev-infra integration
- **[Work-prod Integration Research](../work-prod-integration/README.md)** - Prior API integration research
- **[Tier 1 API Contract](../project-model-definition/research-tier-1-api-contract.md)** - proj-cli API requirements

---

## 🚀 Next Steps

1. ~~Map current integration points~~ ✅
2. ~~Research integration patterns from industry~~ ✅
3. ~~Document findings and make recommendations~~ ✅
4. **Implement** `dt-cursor-install` in dev-toolkit (ties to Topic 1)
5. **Document** integration patterns in a central location

---

**Last Updated:** 2025-12-31

