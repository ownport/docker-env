#!/bin/bash

ORACLE_JDK_URL="http://download.oracle.com/otn-pub/java/jdk/"
ORACLE_JDK_VERSIONS="8u74/02 8u73/02 8u66/17 8u65/17 8u60/27 8u40/26 7u76/13 7u75/13"
ORACLE_JDK_PACKAGES="jdk server-jre jre"

usage() {

    echo -e "usage: $0 <option>\n"
    echo "Available options:"
    for option in $(declare -F | cut -d " " -f 3)
    do
        echo -e "\t${option}"
    done
}

precheck() {

    [ -z ${ORACLE_REPO_PATH} ] && {
        echo "[ERROR] ORACLE_REPO_PATH system environment is not defined"
        exit 1
    }

    [ ! -d ${ORACLE_REPO_PATH} ] && { mkdir -p ${ORACLE_REPO_PATH}; } 

    export ORACLE_HOMEDIR=$(dirname $0)
}

jdk() {

    local JAVA_PACKAGE=$1
    local JAVA_VERSION=$2
    local JAVA_VERSION_BUILD=$3

    [ -z ${JAVA_PACKAGE} ] && {
        echo '[ERROR] JAVA_PACKAGE parameter is not defined'
        exit 1
    }

    [ -z ${JAVA_VERSION} ] && {
        echo '[ERROR] JAVA_VERSION parameter is not defined'
        exit 1
    }

    [ -z ${JAVA_VERSION_BUILD} ] && {
        echo '[ERROR] JAVA_VERSION_BUILD parameter is not defined'
        exit 1
    }
    
    wget -c --progress=dot:mega --no-check-certificate --no-cookies \
        ${ORACLE_JDK_URL%%/}/${JAVA_VERSION}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz \
        --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        --directory-prefix=${ORACLE_REPO_PATH}
}

all() {

    precheck
    for j_version in ${ORACLE_JDK_VERSIONS}
    do
        for j_package in ${ORACLE_JDK_PACKAGES}
        do
            jdk ${j_package} $(echo ${j_version} | tr "/" " ")
        done
    done
}



$@
