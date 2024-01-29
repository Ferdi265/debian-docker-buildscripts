#!/bin/bash -e

cd build/

# lint debs
for f in *.dsc *.changes *.deb; do
    echo ">> $f"
    lintian -I -E "$f" || true
done
