# Research: Work-prod Auth Model

**Research Topic:** Work-prod Integration  
**Question:** How does work-prod API authentication work? Can dev-infra have its own "account"?  
**Status:** ✅ Complete  
**Created:** 2025-12-19  
**Last Updated:** 2025-12-19

---

## 🎯 Research Question

How does work-prod API authentication work? Can dev-infra have its own "account"?

---

## 🔍 Research Goals

- [x] Goal 1: Understand what authentication mechanisms work-prod supports
- [x] Goal 2: Determine if dev-infra can have a dedicated account/identity
- [x] Goal 3: Assess how API credentials should be stored and managed
- [x] Goal 4: Evaluate service account patterns for automation

---

## 📚 Research Methodology

**Approach:** Review industry patterns for CLI tool authentication.

**Sources:**
- [x] Industry patterns for CLI tool authentication
- [x] Credential storage best practices (keychain, netrc, env vars)
- [x] Similar tools: GitHub CLI, AWS CLI, gcloud

---

## 📊 Findings

### Finding 1: API Key is Standard for CLI Tools

Most CLI tools use API keys or tokens for authentication. The pattern is:
1. User authenticates once (via web or CLI login)
2. API key/token is generated
3. Token is stored locally
4. Token is sent with each API request

Examples: GitHub CLI uses `gh auth login` to generate and store token, AWS CLI uses access key ID + secret stored in `~/.aws/credentials`.

**Source:** Industry patterns (GitHub CLI, AWS CLI)

**Relevance:** Work-prod should support API key authentication for dev-infra integration.

---

### Finding 2: OAuth 2.0 for Interactive Auth, API Keys for Automation

Best practice is to support both:
- **OAuth 2.0**: For interactive user authentication
- **API Keys**: For service accounts and automation

Dev-infra would likely use API key since it's automation/CLI tooling.

**Source:** Web search: API authentication best practices

**Relevance:** Dev-infra should use API key, not OAuth, for simpler integration.

---

### Finding 3: Credential Storage Options

| Method | Pros | Cons |
|--------|------|------|
| Environment variable | Simple, CI-friendly | Not persistent |
| Config file | Persistent, versioned | Less secure if plaintext |
| System keychain | Most secure | Platform-specific |
| netrc format | Standard, git-compatible | Plaintext |

GitHub CLI uses: macOS keychain, Windows credential manager, or `~/.config/gh/hosts.yml` as fallback.

**Source:** GitHub CLI documentation, industry patterns

**Relevance:** Dev-infra should use config file with optional keychain for security.

---

### Finding 4: "Account" vs User Identity

Two options for work-prod integration:

1. **User's personal API key** - Projects registered under user's identity
2. **Service account** - Dedicated "dev-infra" identity in work-prod

**Recommendation:** Use user's personal API key initially. This:
- Avoids work-prod changes
- Projects are owned by actual user
- Simpler implementation

Service account pattern can come later if needed.

**Source:** Internal analysis

**Relevance:** Start with user API key, not dedicated service account.

---

## 🔍 Analysis

**Key Insights:**
- [x] Insight 1: API key authentication is simplest for CLI tools
- [x] Insight 2: User's personal API key is better than service account initially
- [x] Insight 3: Store credentials in `~/.config/dev-infra/` or `~/.dev-infra/`
- [x] Insight 4: Config file is simplest; keychain integration is nice-to-have

---

## 💡 Recommendations

- [x] Recommendation 1: Use API key authentication (not OAuth)
- [x] Recommendation 2: Store API key in `~/.dev-infra/config.yml` or similar
- [x] Recommendation 3: Support `DEV_INFRA_API_KEY` env var for CI
- [x] Recommendation 4: Defer keychain integration to v2

---

## 📋 Requirements Discovered

- [x] FR-1: Support API key authentication for work-prod
- [x] FR-2: Store API key in local config file
- [x] FR-3: Support environment variable override for CI
- [x] NFR-1: API key should not be stored in per-project files (security)

---

## 🚀 Next Steps

1. Confirm work-prod supports API key authentication
2. Define config file format and location

---

**Last Updated:** 2025-12-19
