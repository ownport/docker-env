#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

jre-8u74() {

	docker build -t 'ownport/oracle-jre:8u74' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='jre' \
		--build-arg JAVA_VERSION='8u74' \
		--build-arg JAVA_VERSION_BUILD='02' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}


server-jre-8u74() {

	docker build -t 'ownport/oracle-server-jre:8u74' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='server-jre' \
		--build-arg JAVA_VERSION='8u74' \
		--build-arg JAVA_VERSION_BUILD='02' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}


jre-8u73() {

	docker build -t 'ownport/oracle-jre:8u73' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='jre' \
		--build-arg JAVA_VERSION='8u73' \
		--build-arg JAVA_VERSION_BUILD='02' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}


server-jre-8u73() {

	docker build -t 'ownport/oracle-server-jre:8u73' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='server-jre' \
		--build-arg JAVA_VERSION='8u73' \
		--build-arg JAVA_VERSION_BUILD='02' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}


jre-8u40() {

	docker build -t 'ownport/oracle-jre:8u40' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='jre' \
		--build-arg JAVA_VERSION='8u40' \
		--build-arg JAVA_VERSION_BUILD='26' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}


server-jre-8u40() {

	docker build -t 'ownport/oracle-server-jre:8u40' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='server-jre' \
		--build-arg JAVA_VERSION='8u40' \
		--build-arg JAVA_VERSION_BUILD='26' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}



server-jre-7u76() {

	docker build -t 'ownport/oracle-server-jre:7u76' \
		--no-cache \
        $(get_default_args) \
		--build-arg JAVA_PACKAGE='server-jre' \
		--build-arg JAVA_VERSION='7u76' \
		--build-arg JAVA_VERSION_BUILD='13' \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}


$@
