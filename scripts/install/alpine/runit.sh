#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	apk add --update runit && \
	rm -rf /var/cache/apk/*
}

remove() {

	apk del runit && \
	rm -rf /var/cache/apk/* 		
}

$@

