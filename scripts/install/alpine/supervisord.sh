#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {
	
	apk add --update supervisor && rm -rf /var/cache/apk/* 
}

remove() {


	apk del supervisor && rm -rf /var/cache/apk/* 
}

$@

