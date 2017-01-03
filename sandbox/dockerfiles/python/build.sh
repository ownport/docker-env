#!/bin/bash

set -e

if [ -z ${SANDBOX_ENV_PATH} ];
then
    echo '[ERROR] SANDBOX_ENV_PATH is not defined'
    exit 1
else
    source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

python_2_7() {

    docker build -t "ownport/python:2.7" \
        --no-cache \
        $(get_default_args) \
        --build-arg PYTHON_VERSION="2.7" \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/python/py2-py3.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/python
}

python_dev_2_7() {

    docker build -t "ownport/python-dev:2.7" \
        --no-cache \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/python/py2-dev.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/python
}


python_3_5() {

    docker build -t "ownport/python:3.5" \
        --no-cache \
        $(get_default_args) \
        --build-arg PYTHON_VERSION="3.5" \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/python/py2-py3.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/python/
}

python_dev_3_5() {

    docker build -t "ownport/python-dev:3.5" \
        --no-cache \
        $(get_default_args) \
        --file ${SANDBOX_ENV_PATH%%/}/dockerfiles/python/py3-dev.Dockerfile \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/python/
}


rebuild() {

    echo "[INFO] Installing python 2.7"
    python_2_7
    echo "[INFO] Installing python 2.7 (dev)"
    python_dev_2_7
    echo "[INFO] Installing python 3.5"
    python_3_5
    echo "[INFO] Installing python 3.5 (dev)"
    python_dev_3_5
}

push() {

    docker push ownport/python:2.7
    docker push ownport/python:3.5
}

$@
