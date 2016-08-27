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
