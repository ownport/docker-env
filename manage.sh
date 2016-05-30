#/bin/bash
#
#   docker environment manage scripts
#

source VERSIONS

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
        $(pwd)/install-scripts/ \
        $(pwd)/sandbox/ \
        $(pwd)/scripts/ 
}


env-deploy() {

    if [ -d $(pwd)/tmp/ ]
    then
        rm -rf $(pwd)/tmp/*
        mkdir -p $(pwd)/tmp/
    fi

    if [ -z ${DOCKER_BUILDER_VERSION} ]
    then
        echo "[ERROR] Docker builder version is not specified in VERSIONS file"
        exit 1
    else
        echo "[INFO] Installation docker-builder:${DOCKER_BUILDER_VERSION}"
        docker pull ownport/docker-builder:${DOCKER_BUILDER_VERSION} && \
        echo "[INFO] Installation docker-builder:${DOCKER_BUILDER_VERSION} was completed"
    fi

    if [ -z ${INSTALL_SCRIPTS_VERSION} ]
    then
        echo "[ERROR] Install scripts version is not specified in VERSIONS file"
        exit 1
    else
        if [ "${INSTALL_SCRIPTS_VERSION}" = "master" ]
        then
            INSTALL_SCRIPTS_FILENAME="${INSTALL_SCRIPTS_VERSION}.tar.gz"
        else
            INSTALL_SCRIPTS_FILENAME="v${INSTALL_SCRIPTS_VERSION}.tar.gz"
        fi
        wget -c "https://github.com/ownport/docker-install-scripts/archive/${INSTALL_SCRIPTS_FILENAME}" -P $(pwd)/tmp/ && \
            tar xzf $(pwd)/tmp/${INSTALL_SCRIPTS_FILENAME} -C $(pwd)/tmp/ && \
            rm -rf $(pwd)/install-scripts/ && \
            mv $(pwd)/tmp/docker-install-scripts-${INSTALL_SCRIPTS_VERSION} $(pwd)/install-scripts/ && \
            rm $(pwd)/tmp/${INSTALL_SCRIPTS_FILENAME}
    fi


    if [ -z ${SANDBOX_VERSION} ]
    then
        echo "[ERROR] Sandbox version is not specified in VERSIONS file"
        exit 1
    else
        if [ "${SANDBOX_VERSION}" = "master" ]
        then
            SANDBOX_FILENAME="${SANDBOX_VERSION}.tar.gz"
        else
            SANDBOX_FILENAME="v${SANDBOX_VERSION}.tar.gz"
        fi
        wget -c "https://github.com/ownport/docker-sandbox-env/archive/${SANDBOX_FILENAME}" -P $(pwd)/tmp/ && \
            tar xzf $(pwd)/tmp/${SANDBOX_FILENAME} -C $(pwd)/tmp/ && \
            rm -rf $(pwd)/sandbox/ && \
            mv $(pwd)/tmp/docker-sandbox-env-${SANDBOX_VERSION} $(pwd)/sandbox/ && \
            rm $(pwd)/tmp/${SANDBOX_FILENAME}
    fi

}

dev-env-deploy() {

    git clone https://github.com/ownport/docker-builder.git builder
    git clone https://github.com/ownport/docker-install-scripts.git scripts/install
    git clone https://github.com/ownport/docker-repo-scripts.git scripts/repo
    git clone https://github.com/ownport/docker-sandbox-env.git sandbox
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
