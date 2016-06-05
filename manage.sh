#/bin/bash
#
#   docker environment manage scripts
#

DOCKER_ENV_PATH=$(dirname $(readlink -f $0))

source ${DOCKER_ENV_PATH%%/}/etc/settings

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

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "alpine" ]
    then
        ${DOCKER_ENV_PATH%%/}/scripts/repo/update.sh alpine ${DOCKER_ENV_PATH%%/}/files/
    fi

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "jenkins" ]
    then
        ${DOCKER_ENV_PATH%%/}/scripts/repo/update.sh jenkins ${DOCKER_ENV_PATH%%/}/files/
    fi

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "oracle-java" ]
    then
        ${DOCKER_ENV_PATH%%/}/scripts/repo/update.sh oracle ${DOCKER_ENV_PATH%%/}/files/
    fi

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "pypi" ]
    then
        ${DOCKER_ENV_PATH%%/}/scripts/repo/update.sh pypi ${DOCKER_ENV_PATH%%/}/files/
    fi
}

$@
