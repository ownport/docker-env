#!/bin/sh

add() {

	echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
	apk add --update tini && \
	rm -rf /var/cache/apk/*
}

remove() {

	echo '[ERROR] Not Implemented'
	exit 1
}

$@