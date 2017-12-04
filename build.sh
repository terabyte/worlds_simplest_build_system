#!/usr/bin/env bash

set -e
set -o pipefail
set -x

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC_DIR="$BASE_DIR/src"
TEST_DIR="$BASE_DIR/test"

OUTPUT_DIR="$BASE_DIR/build"

VERSION="0.1-$(git rev-list --count HEAD)-g$(git rev-parse --short=15 HEAD)"
if test -z "$(git ls-files --exclude-standard --others)"; then
    VERSION="${VERSION}-dirty"
fi

function clean {
    echo "Executing clean"
    rm -rf "$OUTPUT_DIR"
}

function compile {
    echo "Executing compile"
    mkdir -p "$OUTPUT_DIR"

    # bash code doesn't need to be compiled, but we pretend it does with a copy
    cp -vrp "$SRC_DIR/*" "$OUTPUT_DIR/"
}

function dotest {
    echo "Executing tests"
    (cd "$OUTPUT_DIR" && "$TEST_DIR/test.sh")
}

function release {
    echo "Building release"
    # we want globbing/word splitting here
    # shellcheck disable=SC2086
    rm -f $OUTPUT_DIR/release-*.tar.gz
    (cd "$OUTPUT_DIR" && tar -czf "release-$VERSION.tar.gz" ./*)
}

function all {
    clean
    compile
    dotest
    release
}

# main entrypoint
echo "Determined version number '$VERSION'"

if [[ $# -eq 0 ]]; then
    all
    exit $?
fi

while (( "$#" )); do
    if "$1" == "test"; then
        # test is a reserved word, so we support "dotest" or "test"
        dotest
        shift
        continue
    fi
    $1
    shift
done
