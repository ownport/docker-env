#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
    echo '[ERROR] SANDBOX_ENV_PATH is not defined'
    exit 1
else
    source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

j8u74-nexus-3.0.1-01() {

    docker build -t 'ownport/nexus:j8u74-3.0.1-01' \
        $(get_default_args) \
        --build-arg NEXUS_VERSION=3.0.1-01 \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/nexus/j8u74.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/nexus/
}

$@
