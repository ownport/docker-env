FROM alpine:latest

ARG BUILDER_HOST
ARG HTTP_PROXY 

ARG JAVA_PACKAGE
ARG JAVA_VERSION
ARG JAVA_VERSION_BUILD

RUN wget -O - http://${BUILDER_HOST}/install/alpine/glibc.sh | sh -s add 

RUN	wget -O - http://${BUILDER_HOST}/install/java/oracle/jdk.sh | \
		JAVA_PACKAGE=${JAVA_PACKAGE} \
		JAVA_VERSION=${JAVA_VERSION} \
		JAVA_VERSION_BUILD=${JAVA_VERSION_BUILD} sh -s add

		