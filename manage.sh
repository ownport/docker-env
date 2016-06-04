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

    mkdir -p \
        ${DOCKER_ENV_PATH%%/}/files/alpine/ \
        ${DOCKER_ENV_PATH%%/}/files/jenkins/ \
        ${DOCKER_ENV_PATH%%/}/files/oracle/ \
        ${DOCKER_ENV_PATH%%/}/files/pypi/ \
        ${DOCKER_ENV_PATH%%/}/files/tarballs/

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "alpine" ]
    then

        echo "[INFO] Update alpine repository"
        ALPINE_REPO_PATH=${DOCKER_ENV_PATH%%/}/files/ \
            ${DOCKER_ENV_PATH%%/}/scripts/repo/alpine/update.sh all
    fi

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "jenkins" ]
    then

        echo "[INFO] Update Jenkins repository"
        JENKINS_REPO_PATH=${DOCKER_ENV_PATH%%/}/files/jenkins/ \
            ${DOCKER_ENV_PATH%%/}/scripts/repo/jenkins/update.sh jenkins_by_list ${DOCKER_ENV_PATH%%/}/scripts/repo/jenkins/jenkins.versions
        echo "[INFO] Update Jenkins plugins"
        JENKINS_REPO_PATH=${DOCKER_ENV_PATH%%/}/files/jenkins/ \
            ${DOCKER_ENV_PATH%%/}/scripts/repo/jenkins/update.sh plugins_by_list ${DOCKER_ENV_PATH%%/}/scripts/repo/jenkins/jenkins.plugins
    fi

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "oracle-java" ]
    then

        echo "[INFO] Update Oracle Java repository"
        ORACLE_REPO_PATH=${DOCKER_ENV_PATH%%/}/files/oracle/ \
            ${DOCKER_ENV_PATH%%/}/scripts/repo/oracle/update.sh all
    fi

    if [ "${REPOSITORY}" = "all" ] || [ "${REPOSITORY}" = "pypi" ]
    then

        echo "[INFO] Update Python packages repository"
        ${DOCKER_ENV_PATH%%/}/scripts/repo/pypi/update.sh \
            ${DOCKER_ENV_PATH%%/}/scripts/pypi-mirror/pypi-mirror.py \
            ${DOCKER_ENV_PATH%%/}/etc/pypi.packages \
            ${DOCKER_ENV_PATH%%/}/files/pypi/
    fi
}

$@
