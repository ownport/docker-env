#!/bin/sh
#
#   python
#
set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	PIP_OPTS=""
	if [ ! -z ${BUILDER_HOST} ];
	then
	    PIP_OPTS="--index-url=http://${BUILDER_HOST}/repo/pypi/simple/ --trusted-host=${BUILDER_HOST} "
	fi

	BUILD_PACKAGES="gcc build-base python3-dev libxml2-dev libxslt-dev"

	apk add --update libxslt libxml2 ${BUILD_PACKAGES} && \
	    pip3 install ${PIP_OPTS} requests nltk lxml && \
	    apk del ${BUILD_PACKAGES} && \
	    rm -rf /var/cache/apk/*	
}

remove() {

	pip3 uninstall requests nltk lxml && \
	apk del libxslt libxml2  && \
	rm -rf /var/cache/apk/*	
}

$@
