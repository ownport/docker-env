FROM ownport/alpine:latest

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG PYTHON_VERSION

RUN wget -O - http://${LOCAL_REPOS_HOST}/install/alpine/python.sh | \
		PYTHON_VERSION=${PYTHON_VERSION} sh -s add
