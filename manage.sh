#/bin/bash
#
#   docker environment manage scripts
#

DOCKER_ENV_PATH=$(pwd)

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

    CURR_DIR=$(pwd)

    echo "[INFO] Update local repos"
    cd ${CURR_DIR%%/}/repo && git pull origin master

    echo "[INFO] Update install scripts"
    cd ${CURR_DIR%%/}/scripts/install && git pull origin master

    echo "[INFO] Update docker repositories scripts"
    cd ${CURR_DIR%%/}/scripts/repo && git pull origin master

    echo "[INFO] Update sandbox repo"
    cd ${CURR_DIR%%/}/sandbox && git pull origin master
}


$@
