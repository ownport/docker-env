FROM ownport/python:3.5

ARG BUILDER_HOST
ARG HTTP_PROXY

RUN wget -O - http://${BUILDER_HOST}/install/text-processing.sh | sh -s add

