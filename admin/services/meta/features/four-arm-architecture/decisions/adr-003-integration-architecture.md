# ADR-003: Integration Architecture

**Status:** ✅ Accepted  
**Created:** 2025-12-31  
**Last Updated:** 2025-12-31

---

## Context

The Four-Arm Architecture needs clear integration points between projects. The architecture must balance:
- Standalone usability for external users
- Coordinated functionality for internal development
- Loose coupling between components

**The question:** How should the four projects communicate with each other?

**Related Research:**
- [Research: Integration Points and Data Flow](../../research/four-arm-architecture/research-integration-points.md)
- [Research Summary](../../research/four-arm-architecture/research-summary.md)

**Related Requirements:**
- FR-IP-1 through FR-IP-5 (Integration Points functional requirements)
- NFR-IP-1 through NFR-IP-4 (Integration Points non-functional requirements)
- C-IP-1, C-IP-2 (Integration Points constraints)

---

## Decision

**Use a hybrid integration model: REST API for data operations, file copy for installation, per-tool XDG-compliant configuration. No shared configuration is needed.**

### Integration Model

| Communication Type | Use Case | Example |
|-------------------|----------|---------|
| **REST API** | Real-time data, CRUD operations | proj-cli ↔ work-prod |
| **File Copy (Installation)** | One-time transfers | dev-toolkit ← dev-infra commands |
| **File Read (Config)** | Local settings | Each tool's own config file |
| **Git Tags** | Version awareness | dev-toolkit reads dev-infra releases |

### Data Flow Architecture

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

### Configuration Pattern

**Each tool maintains its own configuration:**

| Tool | Config Location | Pattern |
|------|-----------------|---------|
| **dev-toolkit** | `~/.dev-toolkit/config.conf` | Custom |
| **proj-cli** | `~/.config/proj/config.yaml` | XDG-compliant |
| **work-prod** | Environment variables, instance config | Flask standard |
| **dev-infra** | N/A (templates, no runtime) | N/A |

### Dependency Matrix

| From | To | Dependency Type | Required? |
|------|----|-----------------|-----------|
| dev-toolkit | dev-infra | Source (release artifacts) | Optional |
| proj-cli | work-prod | API (runtime) | Optional |
| projects | dev-infra | Template (creation-time) | One-time |
| dev-toolkit | work-prod | None | N/A |
| proj-cli | dev-toolkit | None | N/A |
| proj-cli | dev-infra | None | N/A |

---

## Consequences

### Positive

- **Loose coupling:** No runtime dependencies between tools
- **Standalone capability:** Each tool works independently
- **Optional integration:** Features degrade gracefully
- **Simple configuration:** Each tool manages its own config
- **Industry standard:** XDG pattern widely adopted

### Negative

- **No shared defaults:** Configuration must be set per-tool
- **Manual coordination:** Users set API URLs in each tool separately
- **No central management:** No single config file to manage all tools

---

## Alternatives Considered

### Alternative 1: Shared Configuration File

**Description:** Create `~/.dev-infra.yml` or similar shared config for all tools.

**Pros:**
- Single place to configure all tools
- Consistent settings across tools
- Easier user experience

**Cons:**
- Adds complexity without proportional benefit
- Only overlapping config is API URL
- Each tool still needs tool-specific settings
- Breaks XDG pattern

**Why not chosen:** The only potential shared setting (API URL) is better handled by:
1. Default convention (`http://localhost:5000`)
2. Environment variable (`PROJ_API_URL`)
3. Per-tool config

---

### Alternative 2: Direct Tool Dependencies

**Description:** Make proj-cli depend on dev-toolkit, or vice versa.

**Pros:**
- Could share utilities
- Tighter integration

**Cons:**
- Coupling between independent tools
- Harder standalone use
- Installation dependencies

**Why not chosen:** Tools have different purposes and should remain independent. They can both consume from other arms without depending on each other.

---

### Alternative 3: Message Queue / Event Bus

**Description:** Use message passing between tools.

**Pros:**
- Loose coupling
- Async communication

**Cons:**
- Massive overkill for CLI tools
- Requires running infrastructure
- Complex debugging

**Why not chosen:** CLI tools don't need async communication. REST API for data operations is sufficient.

---

### Alternative 4: Monorepo

**Description:** Combine all four projects into a single repository.

**Pros:**
- Easier cross-project changes
- Single versioning
- Simpler coordination

**Cons:**
- Violates standalone requirement
- Different languages (Bash, Python, Flask)
- Different release cycles

**Why not chosen:** Projects have different purposes, languages, and audiences. Monorepo would undermine standalone usability.

---

## Decision Rationale

**Key Factors:**

1. **Standalone requirement:** Each project must work for external users
2. **Existing patterns:** proj-cli → work-prod API integration is well-designed
3. **Simplicity:** Per-tool config is simpler than shared config
4. **Industry standard:** XDG pattern for configuration

**Research Support:**
- Finding 1: Current API integration is well-designed (model for others)
- Finding 3: Minimal dependencies are intentional
- Finding 4: XDG pattern works well
- Finding 5: No shared configuration needed

---

## Requirements Impact

**Requirements Addressed:**
- FR-IP-1: proj-cli REST API communication ✅
- FR-IP-2: dt-cursor-install implementation ✅
- FR-IP-3: dt-cursor-install source location ✅
- FR-IP-4: Global command destination ✅
- FR-IP-5: Version tracking ✅

**Requirements Validated:**
- NFR-IP-1: Optional integrations ✅
- NFR-IP-2: Offline core functionality ✅
- NFR-IP-3: XDG configuration pattern ✅
- NFR-IP-4: No runtime dependencies ✅

**Constraints Satisfied:**
- C-IP-1: No shared configuration ✅
- C-IP-2: No direct tool dependencies ✅

---

## Implementation Notes

### What We DON'T Need

1. ❌ Shared configuration file (`~/.dev-infra.yml`)
2. ❌ Dependencies between proj-cli and dev-toolkit
3. ❌ Message queue or event bus
4. ❌ Centralized configuration management

### What We DO Need

1. ✅ Keep proj-cli → work-prod API integration as-is
2. ✅ Implement `dt-cursor-install` for command distribution
3. ✅ Use Git tags for version awareness
4. ✅ Follow XDG pattern for new tool configuration
5. ✅ Ensure all integrations are optional

### Configuration Guidelines

When adding new configuration needs:
1. Use XDG Base Directory pattern (`~/.config/[tool]/`)
2. Support environment variable overrides
3. Document defaults clearly
4. Never require other tools' configs

---

## References

- [Research: Integration Points and Data Flow](../../research/four-arm-architecture/research-integration-points.md)
- [Requirements Document](../../research/four-arm-architecture/requirements.md)
- [proj-cli config.py](https://github.com/grimm00/proj-cli/blob/main/src/proj/config.py)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

---

**Last Updated:** 2025-12-31

