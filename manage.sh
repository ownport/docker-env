#/bin/bash
#
#   docker environment manage scripts
#

DOCKER_ENV_PATH=$(dirname $(readlink -f $0))

source ${DOCKER_ENV_PATH%%/}/SETTINGS

usage() {

    echo "usage: ./manage.sh <command> <args>"

    echo -e "\nAvailable commands:"
    for cmd in $(declare -F | cut -d " " -f 3)
    do
        echo " ${cmd}"
    done
    echo
}

clean() {

    rm -rf \
        ${DOCKER_ENV_PATH%%/}/tmp/ \
        ${DOCKER_ENV_PATH%%/}/files/ \
        ${DOCKER_ENV_PATH%%/}/repo/ \
        ${DOCKER_ENV_PATH%%/}/sandbox/ \
        ${DOCKER_ENV_PATH%%/}/scripts/
}

dev-env-new() {

    [ ! -d $(pwd)/files/ ] && { mkdir -p $(pwd)/files/; }

    git submodule init && git submodule update
}

dev-env-update() {

    echo "[INFO] Update local repos"
    cd ${DOCKER_ENV_PATH%%/}/repo && git pull origin master

    echo "[INFO] Update install scripts"
    cd ${DOCKER_ENV_PATH%%/}/scripts/install && git pull origin master

    echo "[INFO] Update docker repositories scripts"
    cd ${DOCKER_ENV_PATH%%/}/scripts/repo && git pull origin master

    echo "[INFO] Update sandbox repo"
    cd ${DOCKER_ENV_PATH%%/}/sandbox && git pull origin master
}

repo-update() {

    local REPOSITORY=${1:-}

    mkdir -p \
        ${DOCKER_ENV_PATH%%/}/files/alpine/ \
        ${DOCKER_ENV_PATH%%/}/files/jenkins/ \
        ${DOCKER_ENV_PATH%%/}/files/oracle/ \
        ${DOCKER_ENV_PATH%%/}/files/pypi/ \
        ${DOCKER_ENV_PATH%%/}/files/tarballs/

    echo "[INFO] Update alpine repository"
    ALPINE_REPO_PATH=${DOCKER_ENV_PATH%%/}/files/ \
        ${DOCKER_ENV_PATH}/scripts/repo/alpine/update.sh all
}

$@
