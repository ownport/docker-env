#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

    apk add --update \
        make cabal-install

}

remove() {

    echo "[ERROR] Not implemented"
    exit 1
}


$@
