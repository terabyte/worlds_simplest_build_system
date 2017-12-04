#!/usr/bin/env bash

set -e
set -o pipefail

TEST_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SCRIPT_UNDER_TEST="hello.sh"

# shellcheck disable=SC1090
source "$TEST_DIR/bunit.sh"

export USER="__SOME_TEST_USER__"

test_success "Correctly outputs the user" "$SCRIPT_UNDER_TEST | grep -q $USER"
test_success "Correctly contains the string 'Hello'" "$SCRIPT_UNDER_TEST | grep -q Hello"

