#!/usr/bin/env bash

set -e
set -o pipefail

TEST_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FAIL_COUNT=0
for i in "$TEST_DIR"/test_*.sh; do
    if [[ "$i" == "$0" ]]; then
        continue
    fi
    echo "Running $i"
    "$i" || FAIL_COUNT=$(( FAIL_COUNT + 1 ))
    echo ""
done

exit $FAIL_COUNT
