#!/bin/bash

ALPINE_PKG_MIRROR_VERSION="v0.1.0"

usage() {

    echo -e "usage: $0 <option>\n"
    echo "Available options:"
    for option in $(declare -F | cut -d " " -f 3 | sort )
    do
        echo -e "\t${option}"
    done
    echo
}

all() {

    v33_main_x86_64
    v34_main_x86_64
    v35_main_x86_64
    v34_community_x86_64
    v35_community_x86_64
    edge_testing_x86_64
    edge_community_x86_64
    extra_packages
}

precheck() {

    [ -z ${ALPINE_REPO_PATH} ] && {
        echo '[ERROR] ALPINE_REPO_PATH environment does not specified'
        exit 1
    }

    [ ! -d ${ALPINE_REPO_PATH} ] && { mkdir -p ${ALPINE_REPO_PATH}; }

    export ALPINE_HOME_DIR=$(dirname $0)

    [ ! -f "${ALPINE_HOME_DIR%%/}/mirror" ] && {
        wget -q \
            https://github.com/ownport/alpine-pkg-mirror/releases/download/${ALPINE_PKG_MIRROR_VERSION}/mirror \
            -O ${ALPINE_HOME_DIR%%/}/mirror
    }
    chmod +x ${ALPINE_HOME_DIR%%/}/mirror
}

v33_main_x86_64() {

    echo "[INFO] Update v3.3/main/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update v3.3/main/x86_64
}

v34_main_x86_64() {

    echo "[INFO] Update v3.4/main/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update v3.4/main/x86_64
}

v35_main_x86_64() {

    echo "[INFO] Update v3.5/main/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update v3.5/main/x86_64
}


v34_community_x86_64() {

    echo "[INFO] Update v3.4/community/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update v3.4/community/x86_64
}

v35_community_x86_64() {

    echo "[INFO] Update v3.5/community/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update v3.5/community/x86_64
}

edge_testing_x86_64() {

    echo "[INFO] Update edge/testing/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update edge/testing/x86_64
}

edge_community_x86_64() {

    echo "[INFO] Update edge/community/x86_64"
    precheck
    ${ALPINE_HOME_DIR%%/}/mirror \
        --config ${ALPINE_HOME_DIR%%/}/../etc/alpine-repositories.json \
        update edge/community/x86_64
}

extra_packages() {

    echo "[INFO] Update extra packages"
    precheck

    echo "[INFO] Update extra packages: glibc-2.21-r2.apk"
    wget -q -c https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk \
        --directory-prefix ${ALPINE_REPO_PATH}/alpine/apk/

    echo "[INFO] Update extra packages: glibc-2.23-r3.apk"
    wget -q -c https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk \
        --directory-prefix ${ALPINE_REPO_PATH}/alpine/apk/
}

$@
