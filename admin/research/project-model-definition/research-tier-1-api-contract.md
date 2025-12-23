# Research: Tier 1 API Contract

**Research Topic:** Project Model Definition  
**Question:** What exact API contract does proj-cli need from work-prod for Tier 1?  
**Status:** ✅ Complete  
**Priority:** 🔴 High (Tier 1)  
**Created:** 2025-12-22  
**Last Updated:** 2025-12-23  
**Completed:** 2025-12-23

---

## 🎯 Research Question

What exact API contract does proj-cli need from work-prod for Tier 1?

This research will define the minimum viable API contract that allows proj-cli to:
- Create project records
- List and retrieve projects
- Update project information
- Push inventory data to the registry

---

## 🔍 Research Goals

- [x] Goal 1: Document existing work-prod API endpoints
- [x] Goal 2: Identify required vs optional fields for each operation
- [x] Goal 3: Define error response format
- [x] Goal 4: Create API contract document for proj-cli

---

## 📚 Research Methodology

**Approach:** Audit existing work-prod API implementation and document contract.

**Sources:**
- [x] work-prod OpenAPI specification (`backend/openapi.yaml`) - 691 lines
- [x] work-prod API routes (`backend/app/api/projects.py`)
- [x] work-prod project model (`backend/app/models/project.py`) - 66 lines
- [x] proj-cli API client (`src/proj/api_client.py`) - 253 lines

---

## 📊 Findings

### Finding 1: Comprehensive OpenAPI 3.0.3 Specification Exists

work-prod already has a complete OpenAPI specification documenting all endpoints.

**Source:** `work-prod/backend/openapi.yaml`

**Key Endpoints:**
| Endpoint | Method | Operation | Status |
|----------|--------|-----------|--------|
| `/api/projects` | GET | List/search projects | ✅ Ready |
| `/api/projects` | POST | Create project | ✅ Ready |
| `/api/projects/{id}` | GET | Get single project | ✅ Ready |
| `/api/projects/{id}` | PATCH | Update project | ✅ Ready |
| `/api/projects/{id}` | DELETE | Delete project | ✅ Ready |
| `/api/projects/{id}/archive` | PUT | Archive project | ✅ Ready |
| `/api/projects/import` | POST | Bulk import | ✅ Ready |
| `/api/health` | GET | Health check | ✅ Ready |

**Relevance:** proj-cli has all endpoints it needs for Tier 1 operations.

---

### Finding 2: Project Model Has 10 Fields (7 Tier 1 Ready)

The work-prod Project model has these fields:

**Tier 1 Fields (Ready to use):**
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | Integer | Auto | Primary key (read-only) |
| `name` | String(200) | Yes | Only required field for create |
| `path` | String(500) | No | Local filesystem path (unique) |
| `description` | Text | No | Project description |
| `remote_url` | String(500) | No | GitHub/remote URL |
| `created_at` | DateTime | Auto | Auto-set on create |
| `updated_at` | DateTime | Auto | Auto-set on update |

**Tier 2 Fields (Need alignment research):**
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `status` | Enum | Yes (default: active) | `active`, `paused`, `completed`, `cancelled` |
| `organization` | String(100) | No | String field, not FK |
| `classification` | Enum | No | `primary`, `secondary`, `archive`, `maintenance` |

**Source:** `work-prod/backend/app/models/project.py`

**Relevance:** Tier 1 fields are immediately usable. Classification/organization need Tier 2 research to align with taxonomy.

---

### Finding 3: proj-cli API Client Already Implements Full Contract

The proj-cli API client (`api_client.py`) already implements all necessary methods:

```python
class APIClient:
    def list_projects(self, status, organization, classification, search) -> List[Dict]
    def get_project(self, project_id: int) -> Dict
    def create_project(self, data: Dict) -> Dict
    def update_project(self, project_id: int, data: Dict) -> Dict
    def delete_project(self, project_id: int) -> None
    def search_projects(self, query: str) -> List[Dict]
    def import_projects(self, projects: List[Dict]) -> Dict
    def archive_project(self, project_id: int) -> Dict
```

**Source:** `proj-cli/src/proj/api_client.py`

**Relevance:** No new API client work needed - the contract is already implemented.

---

### Finding 4: Error Response Format is Standardized

work-prod uses a consistent error response format:

```json
{
    "error": "Human-readable error message"
}
```

**HTTP Status Codes:**
| Code | Meaning | When Used |
|------|---------|-----------|
| 200 | Success | GET, PATCH, PUT success |
| 201 | Created | POST success |
| 204 | No Content | DELETE success |
| 400 | Bad Request | Validation errors, missing fields |
| 404 | Not Found | Project doesn't exist |
| 409 | Conflict | Duplicate path, integrity error |
| 500 | Server Error | Database or internal errors |

**Source:** `work-prod/backend/openapi.yaml` - Error component schema

**Relevance:** proj-cli error handler already handles these via `APIError`, `BackendConnectionError`, `TimeoutError`.

---

### Finding 5: Bulk Import API Handles Inventory Push

The `/api/projects/import` endpoint supports proj-cli's inventory export needs:

**Request:**
```json
{
    "projects": [
        {"name": "Project 1", "remote_url": "https://github.com/...", ...},
        {"name": "Project 2", ...}
    ]
}
```

**Response:**
```json
{
    "imported": 2,
    "skipped": 0,
    "errors": []
}
```

**Deduplication:** Projects are skipped if `remote_url` already exists in database.

**Source:** `work-prod/backend/openapi.yaml` - `/projects/import` endpoint

**Relevance:** This directly supports `proj inv export api` functionality.

---

### Finding 6: Query Parameters Support Filtering

The GET `/api/projects` endpoint supports these query parameters:

| Parameter | Type | Description |
|-----------|------|-------------|
| `status` | Enum | Filter by status |
| `organization` | String | Filter by organization |
| `classification` | Enum | Filter by classification |
| `search` | String | Case-insensitive name/description search |

**Source:** `work-prod/backend/openapi.yaml`

**Relevance:** proj-cli `list_projects()` already supports all these filters.

---

## 🔍 Analysis

The Tier 1 API contract is **fully implemented and operational**. Both work-prod and proj-cli are ready for integration.

**Key Insights:**
- [x] Insight 1: **API is complete** - All CRUD operations plus import/archive are implemented
- [x] Insight 2: **Client is complete** - proj-cli API client matches work-prod exactly
- [x] Insight 3: **Contract is documented** - OpenAPI spec provides authoritative reference
- [x] Insight 4: **Error handling is consistent** - Standardized error format with proper HTTP codes
- [x] Insight 5: **Tier 1 can proceed immediately** - No blockers for basic proj-cli integration

**Gap Analysis:**

| Capability | work-prod | proj-cli | Gap |
|------------|-----------|----------|-----|
| Create project | ✅ | ✅ | None |
| List projects | ✅ | ✅ | None |
| Get project | ✅ | ✅ | None |
| Update project | ✅ | ✅ | None |
| Delete project | ✅ | ✅ | None |
| Archive project | ✅ | ✅ | None |
| Bulk import | ✅ | ✅ | None |
| Search | ✅ | ✅ | None |
| Filter by status | ✅ | ✅ | None |

---

## 💡 Recommendations

- [x] Recommendation 1: **Proceed with Tier 1 integration** - No API changes needed
- [x] Recommendation 2: **Use OpenAPI spec as contract reference** - It's authoritative and complete
- [x] Recommendation 3: **Defer classification/status alignment to Tier 2** - Current values work for MVP
- [x] Recommendation 4: **Consider API versioning** - For future breaking changes (e.g., classification enum change)

---

## 📋 Requirements Discovered

- [x] **REQ-1:** proj-cli must send `name` field on project create (only required field)
- [x] **REQ-2:** proj-cli must handle all HTTP status codes (200, 201, 204, 400, 404, 409, 500)
- [x] **REQ-3:** proj-cli `import_projects` must use `remote_url` for deduplication awareness
- [x] **REQ-4:** proj-cli must support config for API URL (`api_url` in config)
- [x] **REQ-5:** work-prod OpenAPI spec must be updated when API changes (single source of truth)

---

## 📋 API Contract Summary

### Tier 1 Contract for proj-cli

**Base URL:** `http://localhost:5000/api` (configurable via `PROJ_API_URL`)

**Create Project:**
```
POST /projects
Content-Type: application/json

{
    "name": "Project Name",        // REQUIRED
    "path": "/path/to/project",    // optional
    "description": "Description",  // optional
    "remote_url": "https://..."    // optional
}

Response: 201 Created + Project JSON
```

**List Projects:**
```
GET /projects
GET /projects?search=query
GET /projects?status=active
GET /projects?organization=work

Response: 200 OK + Array of Project JSON
```

**Get Project:**
```
GET /projects/{id}

Response: 200 OK + Project JSON
Response: 404 Not Found + {"error": "Project not found"}
```

**Update Project:**
```
PATCH /projects/{id}
Content-Type: application/json

{
    "name": "New Name",     // optional
    "status": "completed"   // optional
}

Response: 200 OK + Updated Project JSON
```

**Delete Project:**
```
DELETE /projects/{id}

Response: 204 No Content
Response: 404 Not Found
```

**Import Projects (Inventory):**
```
POST /projects/import
Content-Type: application/json

{
    "projects": [
        {"name": "...", "remote_url": "..."},
        ...
    ]
}

Response: 201 Created + {"imported": N, "skipped": N, "errors": [...]}
```

---

## 🚀 Next Steps

1. ✅ Research complete - no API changes needed for Tier 1
2. ➡️ Proceed with Classification Enum research (Topic 2) for Tier 2 alignment
3. ➡️ Use `/decision project-model-definition --from-research` after all research complete

---

**Last Updated:** 2025-12-23
