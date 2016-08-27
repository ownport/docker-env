FROM ownport/python:3.5

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG PYTHON_VERSION

RUN apk add --update build-base
