#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

pandoc_latest() {

    docker build -t "ownport/pandoc:latest" \
        --no-cache \
        $(get_default_args) \
		--build-arg PANDOC_VERSION=latest \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/pandoc
}


$@
