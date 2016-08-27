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

	BUILD_PACKAGES="build-base gcc python3-dev libjpeg jpeg-dev libxml2-dev libxslt-dev "  # libzip-dev

	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	apk update

	# echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	# apk add --update libxslt libxml2 libzip ${BUILD_PACKAGES} && \
	# pip install ${PIP_OPTS} newspaper3k && \
	# apk del ${BUILD_PACKAGES} && \
	# rm -rf /var/cache/apk/*

	# apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing --allow-untrusted libzip-dev


	# BUILD_PACKAGES="  libffi-dev openssl-dev"

	# apk add --update   ${BUILD_PACKAGES} && \	
}

remove() {

	echo "Not implemented"
	exit 1
}

$@


