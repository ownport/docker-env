FROM ownport/alpine:latest

ARG BUILDER_HOST
ARG HTTP_PROXY 

ARG JAVA_VERSION
ARG JAVA_PACKAGE

RUN wget -O - http://${BUILDER_HOST}/install/alpine/openjdk.sh | \
		JAVA_VERSION=${JAVA_VERSION} JAVA_PACKAGE=${JAVA_PACKAGE} sh -s add

