# Tier 1: Core Registry - Field Definitions

**Purpose:** Detailed field definitions for Tier 1 MVP  
**Status:** ✅ Ready (audit confirms 7 fields ready)  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-22

---

## 🎯 Tier 1 Scope

**Goal:** Minimum viable fields for proj-cli and work-prod registry to work together.

**Timeline:** Immediate (fields already exist in work-prod)

**Use Cases:**

- `proj create "My Project"` - Create project record
- `proj list` - List all projects
- `proj get <id>` - Get project details
- `proj inv export api` - Push inventory to registry

---

## 📊 Audit Results

**Source:** `work-prod/backend/app/models/project.py`

All 7 Tier 1 fields are **already implemented and ready**:

| Field         | Status   | Changes Needed |
| ------------- | -------- | -------------- |
| `id`          | ✅ Ready | None           |
| `name`        | ✅ Ready | None           |
| `path`        | ✅ Ready | None           |
| `description` | ✅ Ready | None           |
| `remote_url`  | ✅ Ready | None           |
| `created_at`  | ✅ Ready | None           |
| `updated_at`  | ✅ Ready | None           |

**Conclusion:** No schema changes needed for Tier 1. proj-cli can use work-prod API immediately.

---

## 📋 Field Definitions

### `id`

**Type:** Integer (auto-increment)  
**Required:** Yes (generated)  
**Source:** Database

**Description:**  
Unique identifier for the project. Auto-generated on creation.

**API Behavior:**

- Create: Not provided (auto-generated)
- Read: Always returned
- Update: Cannot modify

**Example:** `42`

---

### `name`

**Type:** String (max 200 characters)  
**Required:** Yes  
**Source:** User input

**Description:**  
Display name for the project. Should be human-readable.

**Validation:**

- Required (cannot be null or empty)
- Max 200 characters
- Indexed for search

**API Behavior:**

- Create: Required
- Read: Always returned
- Update: Can modify

**Examples:**

- `"work-prod"`
- `"Python ML Tutorial"`
- `"React Portfolio Site"`

---

### `path`

**Type:** String (max 500 characters)  
**Required:** No  
**Source:** User input or inventory scan

**Description:**  
Local filesystem path to the project directory. Optional - not all projects have a local clone.

**Validation:**

- Optional (can be null)
- Max 500 characters
- Unique constraint (no two projects can have same path)

**API Behavior:**

- Create: Optional
- Read: Always returned (may be null)
- Update: Can modify

**Examples:**

- `"/Users/cdwilson/Projects/work-prod"`
- `"~/Projects/dev-infra"`
- `null` (for remote-only projects)

**Notes:**

- Used by `proj inv scan local` to detect projects
- Used to link local projects to registry records

---

### `description`

**Type:** Text (unlimited)  
**Required:** No  
**Source:** User input or GitHub API

**Description:**  
Optional description of the project. Can be synced from GitHub repository description.

**Validation:**

- Optional (can be null or empty)
- No length limit

**API Behavior:**

- Create: Optional
- Read: Always returned (may be null)
- Update: Can modify

**Examples:**

- `"Work productivity and engagement management system"`
- `"Learning Python machine learning with scikit-learn"`
- `null`

---

### `remote_url`

**Type:** String (max 500 characters)  
**Required:** No  
**Source:** User input or git remote

**Description:**  
URL of the remote repository (GitHub, GitLab, etc.). Used for:

- Deduplication (same remote = same project)
- GitHub API sync
- Opening in browser

**Validation:**

- Optional (can be null)
- Max 500 characters
- Should be a valid URL (starts with http/https)

**API Behavior:**

- Create: Optional
- Read: Always returned (may be null)
- Update: Can modify

**Examples:**

- `"https://github.com/grimm00/work-prod"`
- `"https://github.com/grimm00/dev-infra"`
- `null` (for local-only projects)

**Notes:**

- Used by `proj inv scan github` to discover projects
- Used as deduplication key in `proj inv export api`

---

### `created_at`

**Type:** DateTime  
**Required:** Yes (auto-populated)  
**Source:** Database

**Description:**  
Timestamp when the project record was created in the registry.

**Validation:**

- Required (auto-populated on insert)
- Cannot be modified after creation

**API Behavior:**

- Create: Not provided (auto-generated)
- Read: Always returned (ISO 8601 format)
- Update: Cannot modify

**Example:** `"2025-12-22T14:30:00Z"`

---

### `updated_at`

**Type:** DateTime  
**Required:** Yes (auto-populated)  
**Source:** Database

**Description:**  
Timestamp when the project record was last modified.

**Validation:**

- Required (auto-populated on insert and update)
- Auto-updated on any modification

**API Behavior:**

- Create: Not provided (auto-generated)
- Read: Always returned (ISO 8601 format)
- Update: Auto-updated (cannot manually set)

**Example:** `"2025-12-22T15:45:00Z"`

---

## 📡 API Contract (Tier 1)

### Create Project

**Endpoint:** `POST /api/projects`

**Request Body:**

```json
{
  "name": "My Project",
  "path": "/Users/me/Projects/my-project",
  "description": "A cool project",
  "remote_url": "https://github.com/me/my-project"
}
```

**Required Fields:** `name`  
**Optional Fields:** `path`, `description`, `remote_url`

**Response (201 Created):**

```json
{
  "id": 42,
  "name": "My Project",
  "path": "/Users/me/Projects/my-project",
  "description": "A cool project",
  "remote_url": "https://github.com/me/my-project",
  "created_at": "2025-12-22T14:30:00Z",
  "updated_at": "2025-12-22T14:30:00Z"
}
```

---

### List Projects

**Endpoint:** `GET /api/projects`

**Response (200 OK):**

```json
[
  {
    "id": 1,
    "name": "work-prod",
    "path": "/Users/cdwilson/Projects/work-prod",
    "description": "Work productivity system",
    "remote_url": "https://github.com/grimm00/work-prod",
    "created_at": "2025-12-01T10:00:00Z",
    "updated_at": "2025-12-22T14:30:00Z"
  },
  {
    "id": 2,
    "name": "dev-infra",
    "path": "/Users/cdwilson/Projects/dev-infra",
    "description": "Development infrastructure templates",
    "remote_url": "https://github.com/grimm00/dev-infra",
    "created_at": "2025-12-01T10:00:00Z",
    "updated_at": "2025-12-22T14:30:00Z"
  }
]
```

---

### Get Project

**Endpoint:** `GET /api/projects/:id`

**Response (200 OK):**

```json
{
  "id": 42,
  "name": "My Project",
  "path": "/Users/me/Projects/my-project",
  "description": "A cool project",
  "remote_url": "https://github.com/me/my-project",
  "created_at": "2025-12-22T14:30:00Z",
  "updated_at": "2025-12-22T14:30:00Z"
}
```

**Response (404 Not Found):**

```json
{
  "error": "Project not found"
}
```

---

## ✅ Tier 1 Checklist

**work-prod (Server):**

- [x] `id` field exists
- [x] `name` field exists (required)
- [x] `path` field exists (optional)
- [x] `description` field exists (optional)
- [x] `remote_url` field exists (optional)
- [x] `created_at` field exists (auto)
- [x] `updated_at` field exists (auto)
- [x] API endpoints exist (`POST`, `GET /`, `GET /:id`)

**proj-cli (Client):**

- [ ] `proj create` uses Tier 1 fields
- [ ] `proj list` displays Tier 1 fields
- [ ] `proj get` displays Tier 1 fields
- [ ] `proj inv export api` sends Tier 1 fields

---

## 🚀 Next Steps

1. **Confirm:** Verify work-prod API returns all Tier 1 fields
2. **Test:** Test proj-cli commands against work-prod API
3. **Document:** Update proj-cli documentation with Tier 1 fields
4. **Plan Tier 2:** Begin classification and organization decisions

---

**Last Updated:** 2025-12-22
