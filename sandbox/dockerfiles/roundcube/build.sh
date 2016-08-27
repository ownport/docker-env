#!/bin/bash
#
#   webmail roundcube
#

if [ -z ${SANDBOX_ENV_PATH} ];
then
    echo '[ERROR] SANDBOX_ENV_PATH is not defined'
    exit 1
else
    source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

roundcube_1_0_9() {

    docker build -t "ownport/roundcube:1.0.9" \
        --no-cache \
        $(get_default_args) \
        --build-arg ROUNDCUBE_VERSION="1.0.9" \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/roundcube
}

roundcube_1_1_5() {

    docker build -t "ownport/roundcube:1.1.5" \
        --no-cache \
        $(get_default_args) \
        --build-arg ROUNDCUBE_VERSION="1.1.5" \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/roundcube
}

$@
