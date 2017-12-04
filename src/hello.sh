#!/usr/bin/env bash

if [[ -z "$USER" ]]; then
    echo "USER must be set" 1>&2
    exit 1
fi
echo "Hello, $USER!"
