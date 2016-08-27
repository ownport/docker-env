#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	PIP_OPTS=""
	if [ ! -z ${LOCAL_REPOS_HOST} ];
	then
	    PIP_OPTS="--index-url=http://${LOCAL_REPOS_HOST}/repo/pypi/simple/ --trusted-host=${LOCAL_REPOS_HOST} "
	fi

	pip install Sphinx

}

remove() {

    echo "[ERROR] Not implemented"
    exit 1
}


$@
