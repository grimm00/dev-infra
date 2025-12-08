#!/usr/bin/env bats

# Template Validation Test Suite
# Main test suite file that includes all test category files

load '../helpers/helpers.bash'

# Load test category files
load 'file-presence'
load 'link-validation'
load 'structure-validation'
load 'generation-success'

# Test suite setup and teardown are handled by individual test files
# This main file serves as the entry point for running all template validation tests

