FROM ownport/python:2.7

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY


RUN apk add --update build-base python-dev libffi-dev openssl-dev && \
    pip install --upgrade pip && \
    pip install ansible-container && \
    apk del build-base python-dev libffi-dev openssl-dev
    
