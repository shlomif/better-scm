#!/bin/bash

set -e -x

a="$1"
shift
v="$1"
shift
baseurl="$1"
shift
b="$a-$v"
arc="$b.tar.xz"
build="b--$b"
(
    (
        test -f "$arc" || wget "$baseurl/$arc"
    )
    tar -xvf "$arc"
    mkdir "$build"
    cd "$build"
    cmake ../"$b"
    make
    make check
    sudo make install
) || exit -1
# Cleanup to avoid trailing space problems.
rm -f "$arc"
rm -fr "$build"
