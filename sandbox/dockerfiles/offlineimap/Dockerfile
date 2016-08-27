FROM ownport/python:2.7

ARG BUILDER_HOST
ARG HTTP_PROXY
ARG OFFLINEIMAP_VERSION

RUN wget -O - http://${BUILDER_HOST}/install/alpine/offlineimap.sh | \
    OFFLINEIMAP_VERSION="${OFFLINEIMAP_VERSION}" sh -s add
