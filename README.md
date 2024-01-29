# Debian Docker Buildscripts

This repo contains some of the scripts I use to maintain Debian packages from a
non-Debian system via Docker.

## Usage

1. clone this repo
2. clone another Debian package inside this repo
  - for example: `git clone https://github.com/Ferdi265/wl-mirror-debian wl-mirror`
3. run `./scripts/docker.sh --package PACKAGE`
  - for example `./scripts/docker.sh --package wl-mirror`

## Target Package structure

These scripts are intended for Debian packages with a bare `debian/` folder
that a `.orig.tar.gz` source tarball can be extracted over.

The invocation of `git-buildpackage` also assumes the main branch is named
`main` instead of `master`.
