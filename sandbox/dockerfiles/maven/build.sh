#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
    echo '[ERROR] SANDBOX_ENV_PATH is not defined'
    exit 1
else
    source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

jdk7u76-mvn-3.0.5() {

    docker build -t 'ownport/maven:jdk7u76-3.0.5' \
        $(get_default_args) \
        --build-arg MAVEN_VERSION=3.0.5 \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/maven/jdk7u76.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/maven/
}

$@
