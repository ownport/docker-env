#/bin/bash
#
#   docker environment manage scripts
#

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
        $(pwd)/tmp/ \
        $(pwd)/repo/ \
        $(pwd)/install-scripts/ \
        $(pwd)/sandbox/ \
        $(pwd)/scripts/
}

dev-env-deploy() {

    [ ! -d $(pwd)/repo/ ] && { mkdir -p $(pwd)/repo/; }
    [ ! -d $(pwd)/builder/ ] && { git clone https://github.com/ownport/docker-builder.git builder; }
    [ ! -d $(pwd)/scripts/install/ ] && { git clone https://github.com/ownport/docker-install-scripts.git scripts/install; }
    [ ! -d $(pwd)/scripts/repo/ ] && { git clone https://github.com/ownport/docker-repo-scripts.git scripts/repo; }
    [ ! -d $(pwd)/sandbox/ ] && { git clone https://github.com/ownport/docker-sandbox-env.git sandbox; }
}

dev-env-update() {

    CURR_DIR=$(pwd)

    echo "[INFO] Update builder repo"
    cd ${CURR_DIR%%/}/builder && git pull origin

    echo "[INFO] Update install scripts"
    cd ${CURR_DIR%%/}/scripts/install && git pull origin

    echo "[INFO] Update docker repositories scripts"
    cd ${CURR_DIR%%/}/scripts/repo && git pull origin

    echo "[INFO] Update sandbox repo"
    cd ${CURR_DIR%%/}/sandbox && git pull origin
}





$@
