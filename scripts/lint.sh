#!/bin/bash -e

# lint debs
for f in *.dsc *.changes *.deb; do
    echo ">> $f"
    lintian -I -E "$f" || true
done
