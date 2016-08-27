#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
    echo '[ERROR] SANDBOX_ENV_PATH is not defined'
    exit 1
else
    source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

openjdk8_jdk_latest() {

    docker build -t 'ownport/openjdk8-jdk:latest' \
        $(get_default_args) \
        --build-arg JAVA_VERSION=8 \
        --build-arg JAVA_PACKAGE=jdk \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/openjdk/
}

openjdk8_jre_latest() {

    docker build -t 'ownport/openjdk8-jre:latest' \
    	--no-cache \
        $(get_default_args) \
        --build-arg JAVA_VERSION=8 \
        --build-arg JAVA_PACKAGE=jre \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/openjdk/
}

openjdk7_jdk_latest() {

    docker build -t 'ownport/openjdk7-jdk:latest' \
        $(get_default_args) \
        --build-arg JAVA_VERSION=7 \
        --build-arg JAVA_PACKAGE=jdk \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/openjdk/
}

openjdk7_jre_latest() {

    docker build -t 'ownport/openjdk7-jre:latest' \
        $(get_default_args) \
        --build-arg JAVA_VERSION=7 \
        --build-arg JAVA_PACKAGE=jre \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/openjdk/
}

$@

