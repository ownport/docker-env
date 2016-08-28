#!/bin/sh
#
#	Reference:
# 	- https://github.com/jeanblanchard/docker-alpine-glibc/blob/master/Dockerfile
#

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	GLIBC_APK="glibc-2.21-r2.apk"

	if [ -z ${LOCAL_REPOS_HOST} ];
	then

		GLIBC_URL="https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/${GLIBC_APK}"
		apk add --update wget
		wget -c --progress=dot:mega --no-check-certificate ${GLIBC_URL} -O /tmp/${GLIBC_APK}

	else

		GLIBC_URL="http://${LOCAL_REPOS_HOST}/repo/alpine/apk/${GLIBC_APK}"
		wget ${GLIBC_URL} -O /tmp/${GLIBC_APK}
	fi

	apk add --update libgcc && \
	apk add --allow-untrusted /tmp/${GLIBC_APK}

	[ ! -z ${LOCAL_REPOS_HOST} ] && { apk del wget; }

	ln -s /lib/libc.musl-x86_64.so.1 /usr/lib/libc.musl-x86_64.so.1 && \
	ln -s /lib/libz.so.1 /usr/lib/libz.so.1
	
	rm -rf /tmp/* /var/cache/apk/*
}

remove() {

	echo "[ERROR] Not implemented"
	exit 1
}

$@
