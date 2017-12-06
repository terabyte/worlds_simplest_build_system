# World's Simplest Build System

This is the world's simplest proof-of-concept build system.  Everything (buildsystem and the thing it builds) is implemented in bash.  Besides `bash`, there are no external dependencies.

# Usage

    # produce artifacts
    ./build.sh

    # invoke "application"
    ./build/hello.sh

# What is this?

This is a very simple example build system designed explicitly to produce the following outcomes:

* No external dependencies (sorta - see below)
* deterministic output based only upon the input - the working tree
* deterministic tests

# External Dependencies

I say there are no external dependencies, but that is a half-lie.  Several assumptions are made which are ok only because they are almost always true.  This proof of concept depends upon the following being on your path:

1. A sane version of bash
2. A sane version of env
3. A sane version of cp
4. A sane version of GNU tar
5. A sane version of git - almost any version will do

This is fewer external dependencies than most builds.

