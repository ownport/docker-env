#!/bin/sh

set -e

USER=${1}
USERID=${2}
CMD=${3}

usage() {
	echo "usage: ./run-as.sh <USER> <USERID> <CMD>"
}

[ -z ${USER} ] && {
	usage
	echo "[ERROR] USER is not specified"
	exit 1
}

[ -z ${USERID} ] && {
	usage
	echo "[ERROR] USERID is not specified"
	exit 1
}

[ $# -lt 3 ] && {
	usage
	echo "[ERROR] CMD is not specified"
	exit 1
}

shift 2; CMD=$@
echo "[INFO] Prepare to run '${CMD}' from user: ${USER}/${USERID}"

adduser -D -g '' -u ${USERID} ${USER}
exec su -c "${CMD}" ${USER}
