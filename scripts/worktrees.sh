#!/usr/bin/env bash
#
# worktrees.sh - List and open git worktrees
#
# Usage:
#   ./scripts/worktrees.sh           # List all worktrees with cursor commands
#   ./scripts/worktrees.sh open N    # Open worktree N in cursor
#   ./scripts/worktrees.sh handoff   # Show handoff files for all worktrees
#

set -uo pipefail

# Colors
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

list_worktrees() {
    echo -e "${BOLD}📂 Active Worktrees${NC}"
    echo ""
    
    local i=0
    while IFS= read -r line; do
        local path=$(echo "$line" | awk '{print $1}')
        local branch=$(echo "$line" | sed 's/.*\[\(.*\)\].*/\1/')
        local name=$(basename "$path")
        
        echo -e "${BOLD}[$i]${NC} ${GREEN}$branch${NC}"
        echo -e "    Path: ${BLUE}$path${NC}"
        echo -e "    Open: ${YELLOW}cursor $path${NC}"
        
        # Check for handoff file
        if [[ -f "$path/tmp/handoff.md" ]]; then
            echo -e "    Handoff: ✅ $path/tmp/handoff.md"
        fi
        echo ""
        
        i=$((i + 1))
    done < <(git worktree list)
}

open_worktree() {
    local index=$1
    local i=0
    
    while IFS= read -r line; do
        if [[ $i -eq $index ]]; then
            local path=$(echo "$line" | awk '{print $1}')
            echo -e "${GREEN}Opening: $path${NC}"
            cursor "$path"
            return 0
        fi
        i=$((i + 1))
    done < <(git worktree list)
    
    echo "Error: Worktree index $index not found"
    return 1
}

show_handoffs() {
    echo -e "${BOLD}📋 Worktree Handoffs${NC}"
    echo ""
    
    while IFS= read -r line; do
        local path=$(echo "$line" | awk '{print $1}')
        local branch=$(echo "$line" | sed 's/.*\[\(.*\)\].*/\1/')
        
        if [[ -f "$path/tmp/handoff.md" ]]; then
            echo -e "${BOLD}$branch${NC}"
            echo -e "---"
            # Show first 20 lines of handoff
            head -20 "$path/tmp/handoff.md"
            echo -e "..."
            echo ""
        fi
    done < <(git worktree list)
}

# Main
case "${1:-list}" in
    list)
        list_worktrees
        ;;
    open)
        if [[ -z "${2:-}" ]]; then
            echo "Usage: $0 open <index>"
            exit 1
        fi
        open_worktree "$2"
        ;;
    handoff|handoffs)
        show_handoffs
        ;;
    *)
        echo "Usage: $0 [list|open N|handoff]"
        exit 1
        ;;
esac
