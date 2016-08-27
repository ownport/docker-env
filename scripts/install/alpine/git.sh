#!/bin/sh
#
#   python
#
set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	apk add --update git && \
	rm -rf /var/cache/apk/* /tmp/*
}

remove() {
	
	apk del git && \
	rm -rf /var/cache/apk/*
}

$@
