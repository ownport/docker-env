#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

jenkins_1_653() {

    docker build -t "ownport/jenkins:1.653" \
        --no-cache \
        $(get_default_args) \
        --build-arg JAVA_PACKAGE="server-jre" \
		--build-arg JAVA_VERSION='8u74' \
		--build-arg JAVA_VERSION_BUILD='02' \
        --build-arg JENKINS_VERSION="1.653" \
        --build-arg JENKINS_PLUGINS="" \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/jenkins/
}

jenkins_1_654() {

    docker build -t "ownport/jenkins:1.654" \
        --no-cache \
        $(get_default_args) \
        --build-arg JAVA_PACKAGE="server-jre" \
        --build-arg JAVA_VERSION='8u74' \
        --build-arg JAVA_VERSION_BUILD='02' \
        --build-arg JENKINS_VERSION="1.654" \
        --build-arg JENKINS_PLUGINS="" \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/jenkins/
}

$@