#!/usr/bin/env bash
set -e
set -o pipefail

# these functions provide a junit-lite output for simple bash tests.
#

FAILURES=""
FAILURE_COUNT=0
TEST_COUNT=0

function fail {
    echo -n "F"
    FAILURES="${FAILURES}
FAILED: $1"
    FAILURE_COUNT=$(( FAILURE_COUNT + 1 ))
    TEST_COUNT=$(( TEST_COUNT + 1 ))
}

function success {
    echo -n "."
    TEST_COUNT=$(( TEST_COUNT + 1 ))
}

# usage: test_success "message" "command" [ARGS...]
function test_success {
    message=$1
    shift
    cmd=$1
    shift
    [[ -z "$DEBUG" ]] || echo "executing success-command '$cmd $*' or message '$message'"
    if "$cmd" "$@" 1>/dev/null; then
        success
    else
        fail "$message"
    fi
}

# usage: test_fail "message" "command" [ARGS...]
function test_fail {
    message=$1
    shift
    cmd=$1
    shift
    [[ -z "$DEBUG" ]] || echo "executing fail-command '$cmd $*' or message '$message'"
    if "$cmd" "$@" 1>/dev/null; then
        fail "$message"
    else
        success
    fi
}

function assert_equals {
    if [[ "$1" == "$2" ]]; then
        fail "$3 ('$1' != '$2')"
    else
        success
    fi
}

function assert_not_equals {
    if [[ "$1" == "$2" ]]; then
        fail "$3 ('$1' == '$2')"
    else
        success
    fi
}

function report_and_exit {
    echo ""
    echo ""
    if [[ "x" == "x$FAILURES" ]]; then
        echo "$TEST_COUNT tests succeessful"
        exit 0
    fi
    echo -n "$FAILURE_COUNT / $TEST_COUNT tests failed:"
    echo "$FAILURES"
    exit 1
}
