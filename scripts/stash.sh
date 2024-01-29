#!/bin/bash

ERROR=0
if [[ $# -ne 1 ]]; then
    echo "error: missing build stash name" >&2
    ERROR=1
else
    NAME="build-$1"
fi

if [[ -d "$NAME" ]]; then
    echo "error: build stash '$NAME' already exists" >&2
    ERROR=1
fi

if [[ $ERROR -eq 1 ]]; then
    echo "usage: stash.sh NAME" >&2
    exit 1
fi

mkdir "$NAME"
shopt -s nullglob
mv *.build *.buildinfo *.changes *.deb *.dsc *.debian.tar.xz *.orig.tar.gz{,.asc,.sig} "$NAME"
