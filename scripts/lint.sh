#!/bin/bash -e

# lint debs
shopt -s nullglob
for f in *.dsc *.changes *.deb; do
    echo ">> $f"
    lintian -I -E "$f" || true
done
