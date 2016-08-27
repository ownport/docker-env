FROM ownport/python:2.7

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG SCRAPY_VERSION

RUN wget -O - http://${LOCAL_REPOS_HOST}/install/alpine/scrapy.sh | \
        SCRAPY_VERSION=${SCRAPY_VERSION} sh -s add
