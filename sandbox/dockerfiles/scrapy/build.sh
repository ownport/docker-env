#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

scrapy_latest() {

    docker build -t "ownport/scrapy:latest" \
        --no-cache \
        $(get_default_args) \
		--build-arg SCRAPY_VERSION=latest \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/scrapy
}

scrapy_1_0_6() {

    docker build -t "ownport/scrapy:1.0.6" \
        --no-cache \
        $(get_default_args) \
        --build-arg SCRAPY_VERSION=1.0.6 \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/scrapy
}



$@
