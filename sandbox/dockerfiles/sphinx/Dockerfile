FROM ownport/python:2.7

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG SPHINX_VERSION

RUN wget -O - http://${LOCAL_REPOS_HOST}/install/alpine/sphinx.sh | \
        SCRAPY_VERSION=${SPHINX_VERSION} sh -s add
