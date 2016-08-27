#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	apk add --update bash && rm -rf /var/cache/apk/*
}

remove() {

	apk del bash
}

$@