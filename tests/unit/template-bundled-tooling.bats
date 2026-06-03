#!/usr/bin/env bats

# BATS tests: templates must not bundle skills, commands, or agents (ADR-001).

load '../helpers/helpers.bash'

setup() {
    setup_test_env
}

teardown() {
    cleanup_test_env
}

@test "templates: standard-project has no .claude/skills directory" {
    [ ! -d "$PROJECT_ROOT/templates/standard-project/.claude/skills" ]
}

@test "templates: standard-project has no .cursor/commands directory" {
    [ ! -d "$PROJECT_ROOT/templates/standard-project/.cursor/commands" ]
}

@test "templates: learning-project has no .cursor/commands directory" {
    [ ! -d "$PROJECT_ROOT/templates/learning-project/.cursor/commands" ]
}

@test "templates: no agent definition files under templates" {
    run find "$PROJECT_ROOT/templates" -name '*.agent.md' -o -path '*/.agents/*'
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
