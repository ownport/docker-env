FROM ownport/python:3.5

ARG BUILDER_HOST
ARG HTTP_PROXY

RUN wget -O - http://${BUILDER_HOST}/install/newspaper.sh | sh -s add
