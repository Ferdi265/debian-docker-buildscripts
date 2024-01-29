ARG BASE=debian:unstable
ARG PACKAGE
FROM $BASE

# install debian build scripts
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential wget devscripts lintian git-buildpackage \
    && rm -rf /var/lib/apt/lists/*

# install build dependencies
ADD $PACKAGE /tmp/package-build-deps
RUN cd /tmp/package-build-deps \
    && mk-build-deps -i \
    && rm -rf /tmp/package-build-deps

# set up user account
RUN passwd -d root \
    && groupadd -g 1000 user \
    && useradd -u 1000 -g 1000 -s /bin/bash -d /tmp/ user
USER user

# set up mounted source volume
VOLUME /src
WORKDIR /src/$PACKAGE

# build debian package
CMD gpb buildpackage
