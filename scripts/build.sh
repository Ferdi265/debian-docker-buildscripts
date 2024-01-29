#!/bin/bash -e

# enter package folder
cd $PACKAGE

# ensure package is a git repo
[[ "$PWD" == "$(git rev-parse --show-toplevel 2>/dev/null)" ]]

# download and/or unpack source tarball
origtargz -u

# build
gbp buildpackage \
    --git-debian-branch=main \
    --git-ignore-new \
    --git-builder="debuild -i -I -us -uc"
