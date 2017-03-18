#!/bin/sh

BUILD_DEPS='build-base python-dev libffi-dev openssl-dev'

# ansible and deps installation
install() {

    install_dev_deps
    install_docker
    install_python_deps
    clean

    echo '[INFO] Creating directory for Ansible roles: /etc/ansible/roles/' && \
    mkdir -p /etc/ansible/roles
}

install_dev_deps() {

    echo '[INFO] Install dev dependencies'
    apk add --update --no-cache ${BUILD_DEPS}
}

install_docker() {

    echo '[INFO] Install docker'
    apk add --update --no-cache docker
    apk del -f git
}

install_python_deps() {

    echo '[INFO] Install python dependencies'
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt
}

clean() {

    echo '[INFO] Cleaning'
    apk del ${BUILD_DEPS}
    rm -rf /tmp/* /var/cache/apk/* /root/.cache
    find /usr/lib/python2.7/ -name *.py[co] -exec rm {} \;
}


$@
