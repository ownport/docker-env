#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	PIP_OPTS=""
	if [ ! -z ${LOCAL_REPOS_HOST} ];
	then
	    PIP_OPTS="--index-url=http://${LOCAL_REPOS_HOST}/repo/pypi/simple/ --trusted-host=${LOCAL_REPOS_HOST} "
	fi

	BUILD_PACKAGES="build-base libxslt-dev libxml2-dev libffi-dev python-dev openssl-dev"

	PIP_SCRAPY_OPTS="scrapy"
	if [ "${SCRAPY_VERSION}" == "latest" ]
	then
		PIP_SCRAPY_OPTS="${PIP_SCRAPY_OPTS}"
	else
		PIP_SCRAPY_OPTS="${PIP_SCRAPY_OPTS}==${SCRAPY_VERSION}"
	fi

	# [-] sqlitedict, avro
	apk add --update libxslt libxml2 make ${BUILD_PACKAGES} && \
	    pip install ${PIP_OPTS} ${PIP_SCRAPY_OPTS} && \
	    apk del ${BUILD_PACKAGES} && \
	    rm -rf /var/cache/apk/*
}

remove() {

	# pip uninstall scrapy sqlitedict avro && \
	pip uninstall scrapy && \
	apk del libxslt libxml2 make && \
	    rm -rf /var/cache/apk/*
}


$@
