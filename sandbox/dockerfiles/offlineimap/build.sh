#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

build() {

    _VERSION=${1:-}

    [ -z "${_VERSION}" ] && {
        echo "Please specify OfflineIMAP version. Available version: 6.7.0 (latest), 6.6.1"
        exit 1
    }

    if [ "${_VERSION}" = "latest" ]
    then
        _VERSION="6.7.0"
    fi

    docker build -t "ownport/offlineimap:${_VERSION}" \
        --no-cache \
        $(get_default_args) \
        --build-arg OFFLINEIMAP_VERSION="${_VERSION}" \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/offlineimap/
}

$@
