# Shell functions for worktree management
# Add to your ~/.zshrc or ~/.bashrc:
#   source /path/to/dev-infra/scripts/shell-functions.sh
#
# Or copy the functions you want.

# wt - Quick worktree list and open
# Usage:
#   wt           - List all worktrees with indices
#   wt 1         - Open worktree at index 1
#   wt open 1    - Same as above
#   wt handoff   - Show handoff summaries
wt() {
    local script_path="${DEV_INFRA_PATH:-$HOME/Projects/dev-infra}/scripts/worktrees.sh"
    
    if [[ ! -f "$script_path" ]]; then
        echo "Error: worktrees.sh not found at $script_path"
        echo "Set DEV_INFRA_PATH or ensure dev-infra is at ~/Projects/dev-infra"
        return 1
    fi
    
    case "${1:-}" in
        "")
            "$script_path" list
            ;;
        [0-9]*)
            "$script_path" open "$1"
            ;;
        *)
            "$script_path" "$@"
            ;;
    esac
}

# cursor-wt - Open worktree by project and feature name
# Usage:
#   cursor-wt dev-infra worktree-feature-workflow
#   cursor-wt proj-cli work-prod-integration
cursor-wt() {
    local project="${1:-}"
    local feature="${2:-}"
    
    if [[ -z "$project" ]] || [[ -z "$feature" ]]; then
        echo "Usage: cursor-wt <project> <feature>"
        echo "Example: cursor-wt dev-infra worktree-feature-workflow"
        return 1
    fi
    
    # Common worktree locations to check
    local paths=(
        "$HOME/Projects/$project/.cursor/worktrees/$project/feat-$feature"
        "$HOME/Projects/$project/.cursor/worktrees/$project/$feature"
        "$HOME/.cursor/worktrees/$project/feat-$feature"
        "$HOME/.cursor/worktrees/$project/$feature"
    )
    
    for path in "${paths[@]}"; do
        if [[ -d "$path" ]]; then
            echo "Opening: $path"
            cursor "$path"
            return 0
        fi
    done
    
    echo "Worktree not found. Searched:"
    for path in "${paths[@]}"; do
        echo "  - $path"
    done
    return 1
}

# Quick aliases
alias worktrees='wt'
alias wtl='wt list'
alias wth='wt handoff'
