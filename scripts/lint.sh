#!/bin/bash -e

if [[ "$#" -eq 1 ]]; then
    cd "$1"
elif [[ "$#" -ne 0 ]]; then
    echo "error: usage: ./scripts/lint.sh [dir]" >&2
    exit 1
fi

# lint debs
shopt -s nullglob
for f in *.dsc *.changes *.deb; do
    echo ">> $f"
    lintian -I -E "$f" || true
done
