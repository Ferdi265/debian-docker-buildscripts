#!/bin/bash -e

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BUILD_DIR="$(dirname "$SCRIPT_DIR")"

ARGV=( "$@" )
shift-argv() {
    ARGV=( "${ARGV[@]:1:${#ARGV[@]}}" )
}

ERROR=0
declare -A OPTIONS
parse-opt() {
    if [[ -n ${OPTIONS[$OPT]} ]]; then
        ERROR=1
        echo "error: duplicate option '$OPT'" >&2
        return 1
    else
        OPTIONS[$OPT]=1
        return 0
    fi
}

parse-arg() {
    if [[ ${#ARGV[@]} -lt 1 || "${ARGV[0]:0:1}" == "-" ]]; then
        ERROR=1
        echo "error: option '$OPT' requires an argument" >&2
        return 1
    else
        ARG="${ARGV[0]}"
        shift-argv
        return 0
    fi
}

BUILD_ARGS=()
while [[ ${#ARGV[@]} -ge 1 && "${ARGV[0]:0:1}" == "-" ]]; do
    OPT="${ARGV[0]}"
    shift-argv

    case "$OPT" in
        --base) parse-opt && parse-arg && BUILD_ARGS+=("--build-arg" "BASE=$ARG");;
        --package) parse-opt && parse-arg &&  BUILD_ARGS+=("--build-arg" "PACKAGE=$ARG") && PACKAGE=$ARG;;
        --) break;;
        *) echo "error: invalid option '$OPT'" >&2; ERROR=1;;
    esac
done

if [[ -z "${OPTIONS[--package]}" ]]; then
    echo "error: missing option '--package'" >&2
    ERROR=1
fi

if [[ "$ERROR" -eq 1 ]]; then
    echo "usage: docker.sh --package PACKAGE [--base IMAGE] [cmd]" >&2
    exit 1
fi

# build and run container
cd "$BUILD_DIR"
sudo docker build "${BUILD_ARGS[@]}" -t debuild-$PACKAGE -f "$SCRIPT_DIR/Dockerfile" .
sudo docker run --rm -it -v "$PWD:/src" --env-file=.env debuild-$PACKAGE "${ARGV[@]}"
