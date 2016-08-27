#!/bin/sh
#
#   OpenJDK [JDK or JRE]
#

set -eo pipefail
[[ "$TRACE" ]] && set -x || :


add() {

    echo "= /install/alpine/openjdk.sh ============================================"
    echo "Parameters:"
    echo "JAVA_PACKAGE=[jdk|jre]"
    echo "JAVA_VERSION=[7|8]"
    echo "-------------------------------------------------------------------------"

    [ -z ${JAVA_PACKAGE} ] && {
        echo '[ERROR] Environment variable JAVA_PACKAGE does not defined'
        exit 1
    }

    [ -z ${JAVA_VERSION} ] && {
        echo '[ERROR] Environment variable JAVA_VERSION does not defined'
        exit 1
    }

    if [ "${JAVA_PACKAGE}" == "jdk" ];
    then
        apk add --update openjdk${JAVA_VERSION}
    elif [ "${JAVA_PACKAGE}" == "jre" ]; 
    then
        apk add --update openjdk${JAVA_VERSION}-jre
    fi

    rm -rf /var/cache/apk/* /tmp/*

}

remove() {

    echo "[ERROR] Not implemented"
    exit 1
}

$@

