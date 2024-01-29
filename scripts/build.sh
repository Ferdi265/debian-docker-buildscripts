#!/bin/bash -e

cd $PACKAGE
gbp buildpackage --git-builder="debuild -i -I -us -uc"
