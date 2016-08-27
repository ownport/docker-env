#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :


add() {

    [ -z ${BUILDER_HOST} ] && {
        apk add --update wget && \
        OFFLINEIMAP_URL="https://github.com/OfflineIMAP/offlineimap/archive/v${OFFLINEIMAP_VERSION}.tar.gz" && \
        wget -c --progress=dot:mega --no-check-certificate ${OFFLINEIMAP_URL} -O /tmp/offlineimap.tar.gz
        apk del wget
    } || {
        OFFLINEIMAP_URL="http://${BUILDER_HOST}/repo/tar.gz/offlineimap-${OFFLINEIMAP_VERSION}.tar.gz"
        wget ${OFFLINEIMAP_URL} -O /tmp/offlineimap.tar.gz
    }

    mkdir -p /data/app && \
    tar --directory=/tmp -xzf /tmp/offlineimap.tar.gz && \
    mv /tmp/offlineimap-${OFFLINEIMAP_VERSION}/* /data/app/ && \
    rm -rf \
        /tmp/* \
        /data/app/test \
        /data/app/docs \
        /data/app/*.md \
        /data/app/*.rst
}

remove() {
    exit 1
}

$@
