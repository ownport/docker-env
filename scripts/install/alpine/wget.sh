#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :


add() {

	apk add --update wget && \
	rm -rf /var/cache/apk/* 
}


remove() {

	apk add --update wget && \
	apk del wget && \
	rm -rf /var/cache/apk/*
}

$@
