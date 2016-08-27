#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

ubuntu_trusty() {
    docker build -t 'ownport/ubuntu:trusty' \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/ubuntu/ubuntu-trusty.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/ubuntu
}

ubuntu_xenial() {
    docker build -t 'ownport/ubuntu:xenial' \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/ubuntu/ubuntu-xenial.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/ubuntu
}

$@


