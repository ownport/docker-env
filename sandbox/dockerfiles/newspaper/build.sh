#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

newspaper_latest() {

    docker build -t "ownport/newspaper:latest" \
        --no-cache \
        $(get_default_args) \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/newspaper
}

$@

