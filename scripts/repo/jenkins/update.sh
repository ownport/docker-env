#!/bin/bash

JENKINS_URL="http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/"

usage() {

    echo -e "usage: $0 <option>\n"
    echo "Available options:"
    for option in $(declare -F | cut -d " " -f 3)
    do
        echo -e "\t${option}"
    done
}


precheck() {

    [ -z ${JENKINS_REPO_PATH} ] && {
        echo "[ERROR] JENKINS_REPO_PATH system environment is not defined"
        exit 1
    }

    [ ! -d ${JENKINS_REPO_PATH} ] && { mkdir -p ${JENKINS_REPO_PATH}; }
}

jenkins() {

    local JENKINS_VERSION=${1:-}

    [ -z ${JENKINS_VERSION} ] && {
        echo "[ERROR] JENKINS_VERSION variable is not defined"
        exit 1
    }

    precheck
    wget -c --progress=dot:mega \
        ${JENKINS_URL%%/}/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war \
        --directory-prefix=${JENKINS_REPO_PATH} && \
    wget -c --progress=dot:mega \
        ${JENKINS_URL%%/}/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war.sha1 \
        --directory-prefix=${JENKINS_REPO_PATH}
}


jenkins_by_list() {

    local _JENKINS_VERSIONS=${1:-}
    [ -z ${_JENKINS_VERSIONS} ] && {
        echo -e "[ERROR] The file with Jenkins versions is not specified\n"
        echo "usage: update.sh jenkins_by_list <file-with-versions>"
        exit 1
    }

    [ ! -f ${_JENKINS_VERSIONS} ] && {
        echo -e "[ERROR] The file with Jenkins versions is not exist," ${_JENKINS_VERSIONS}
        exit 1
    }

    precheck
    for version in $(cat ${_JENKINS_VERSIONS})
    do
        jenkins ${version}
    done
}


all_plugins() {

    precheck
    wget -c -r -np -nH -l1 http://updates.jenkins-ci.org/latest/ \
        --directory-prefix ${JENKINS_REPO_PATH%%/}/plugins/ \
        -A "*.hpi"
}


plugins_by_list() {

    local _JENKINS_PLUGINS=${1}
    [ -z ${_JENKINS_PLUGINS} ] && {
        echo -e "[ERROR] The file with Jenkins plugins is not specified\n"
        echo "usage: update.sh plugins_by_list <file-with-plugin-names>"
        exit 1
    }

    [ ! -f ${_JENKINS_PLUGINS} ] && {
        echo -e "[ERROR] The file with Jenkins plugins is not exist," ${_JENKINS_PLUGINS}
        exit 1
    }

    precheck
    for plugin in $(cat ${_JENKINS_PLUGINS})
    do
        wget -c -r -np -nH -l1 http://updates.jenkins-ci.org/latest/ \
            --directory-prefix ${JENKINS_REPO_PATH%%/}/plugins/ \
            -A "${plugin}*.hpi"
    done

}

$@
