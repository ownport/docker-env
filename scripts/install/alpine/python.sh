#!/bin/sh
#
#   python
#
set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

    PIP_OPTS=""
    if [ ! -z ${LOCAL_REPOS_HOST} ];
    then
        PIP_OPTS="--index-url=http://${LOCAL_REPOS_HOST}/repo/pypi/simple/ --trusted-host=${LOCAL_REPOS_HOST} "
    fi

    # check python version
    if [ "${PYTHON_VERSION}" == "2.7" ];
    then

        apk add --update python py-pip || apk add --update python py2-pip
        wget http://${LOCAL_REPOS_HOST}/repo/pypi/simple/pip/ && {
            pip install --upgrade ${PIP_OPTS} pip
        } || {
            pip install --upgrade pip
        }
    elif [  "${PYTHON_VERSION}" == "3.5" ];
    then

        apk add --update python3 wget && \
        wget --progress=dot:mega http://${LOCAL_REPOS_HOST}/repo/pypi/get-pip.py -P /tmp || {
            wget --progress=dot:mega --no-check-certificate https://bootstrap.pypa.io/get-pip.py -P /tmp
        }
        python3 /tmp/get-pip.py ${PIP_OPTS}
        ln -s /usr/bin/python3 /usr/bin/python
        apk del wget

    else

        echo "[ERROR] Unknown python version, ${PYTHON_VERSION}"
        exit 1
    fi

    rm -rf /var/cache/apk/* /tmp/*
}

remove() {

    # check python version
    if [ "${PYTHON_VERSION}" == "2.7" ];
    then
        apk del py-pip python

    elif [  "${PYTHON_VERSION}" == "3.5" ];
    then
        apk del python3
    fi
    echo "[WARNING] pip for python3 still exist, not installed"
}

$@
