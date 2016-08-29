#!/bin/sh
#
#	Reference:
# 	- https://github.com/jeanblanchard/docker-alpine-glibc/blob/master/Dockerfile
#
#	https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.21-r2/glibc-2.21-r2.apk
#	https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk


set -eo pipefail
[[ "$TRACE" ]] && set -x || :

[ -z "${GLIBC_VERSION}" ] && {
	echo "[ERROR] GLIBC_VERSION is not defined"
	exit 1
}

add() {

	if [ -z ${LOCAL_REPOS_HOST} ];
	then

		GLIBC_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk"
		apk add --update wget
		wget -c --progress=dot:mega --no-check-certificate ${GLIBC_URL} -O /tmp/${GLIBC_APK}
		apk del wget

	else

		GLIBC_URL="http://${LOCAL_REPOS_HOST}/repo/alpine/apk/glibc-${GLIBC_VERSION}.apk"
		wget ${GLIBC_URL} -O /tmp/glibc-${GLIBC_APK}.apk
	fi

	apk add --update libgcc && \
	apk add --allow-untrusted /tmp/glibc-${GLIBC_APK}.apk

	ln -s /lib/libc.musl-x86_64.so.1 /usr/lib/libc.musl-x86_64.so.1 && \
	ln -s /lib/libz.so.1 /usr/lib/libz.so.1

	rm -rf /tmp/* /var/cache/apk/*
}

remove() {

	echo "[ERROR] Not implemented"
	exit 1
}

$@
