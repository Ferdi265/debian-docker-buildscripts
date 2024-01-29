#!/bin/bash -e

cd $PACKAGE
origtargz -u
gbp buildpackage \
    --git-debian-branch=main \
    --git-ignore-new \
    --git-builder="debuild -i -I -us -uc"
