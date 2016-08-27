FROM ownport/alpine:latest

ARG BUILDER_HOST
ARG HTTP_PROXY

RUN wget -O - http://${BUILDER_HOST}/install/alpine/git.sh | sh -s add

