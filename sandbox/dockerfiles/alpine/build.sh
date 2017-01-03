#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

alpine_latest() {
    docker build -t 'ownport/alpine:latest' \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine/alpine-latest.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine
}

alpine_3_5() {
	docker build -t 'ownport/alpine:3.5' \
	$(get_default_args) \
	--file ${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine/alpine-3.5.Dockerfile \
	${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine
}


alpine_3_4() {
    docker build -t 'ownport/alpine:3.4' \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine/alpine-3.4.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine
}

alpine_3_3() {
	docker build -t 'ownport/alpine:3.3' \
	$(get_default_args) \
	--file ${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine/alpine-3.3.Dockerfile \
	${SANDBOX_ENV_PATH%%/}/dockerfiles/alpine
}

$@
