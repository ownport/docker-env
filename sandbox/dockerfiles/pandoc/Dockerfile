FROM ownport/alpine:latest

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG PANDOC_VERSION

RUN wget -O - http://${LOCAL_REPOS_HOST}/install/alpine/pandoc.sh | \
        PANDOC_VERSION=${PANDOC_VERSION} sh -s add
