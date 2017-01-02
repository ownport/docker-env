#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

ansible_latest() {

    docker build -t "ownport/ansible:latest" \
        --no-cache \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/ansible/ansible.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/ansible
}

ansible_container_latest() {

    docker build -t "ownport/ansible-container:latest" \
        --no-cache \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/ansible/ansible-container.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/ansible
}

$@
