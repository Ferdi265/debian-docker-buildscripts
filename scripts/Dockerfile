ARG BASE=debian:unstable
FROM $BASE

# install debian build scripts
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential wget devscripts equivs lintian git-buildpackage \
    && rm -rf /var/lib/apt/lists/*

# install build dependencies
ARG PACKAGE
ADD $PACKAGE /tmp/package-build-deps
RUN apt-get update \
    && cd /tmp/package-build-deps \
    && DEBIAN_FRONTEND=noninteractive mk-build-deps -i -t "apt-get -y --no-install-recommends" \
    && rm -rf /tmp/package-build-deps \
    && rm -rf /var/lib/apt/lists/*

# set up user account
RUN passwd -d root \
    && groupadd -g 1000 user \
    && useradd -u 1000 -g 1000 -s /bin/bash -d /tmp/ user
USER user

# set up mounted source volume
VOLUME /src
WORKDIR /src
ENV PACKAGE=$PACKAGE

# build debian package
CMD scripts/build.sh
