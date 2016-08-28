#!/bin/bash
#
#	Update repo script
#

REPO_SCRIPTS_PATH=$(dirname $(readlink -f $0))
AVAILABLE_REPOSITORY_NAMES="alpine oracle jenkins pypi"

usage() {

    echo -e "usage: update.sh <action> | <repo-name>\n"
    echo "Available actions:"
    echo " - usage"
    echo " - all"
    echo
    echo "Available repository names:"
    echo " - alpine"
    echo " - apache"
    echo " - oracle"
    echo " - jenkins"
    echo " - pypi"
    echo
}

precheck() {

    ACTION=${1:-}
    REPOS_PATH=${2:-}

    if [ -z "${ACTION}" ] || [ "${ACTION}" = "usage" ]
    then
        usage; exit 0
    elif [ "${ACTION}" = "all" ]
    then
        all; exit 0
    elif [[ ! ${AVAILABLE_REPOSITORY_NAMES} =~ (^|[[:space:]])"${ACTION}"($|[[:space:]]) ]]
    then
        echo "[ERROR] Unknown repository name or action: ${ACTION}"
        exit 1
    fi

    if [ -z ${REPOS_PATH} ] && [ ! -d ${REPOS_PATH} ]
    then
        echo "[ERROR] Repository path is not specified or does not exist"
        exit 1
    fi

    for repo in ${AVAILABLE_REPOSITORY_NAMES}
    do
        if [ ! -d ${REPOS_PATH%%/}/${repo} ]
        then
            echo "[WARNING] The repository path does not exist," ${REPOS_PATH%%/}/${repo}
            mkdir -p ${REPOS_PATH%%/}/${repo}
            echo "[INFO] The repository path was created," ${REPOS_PATH%%/}/${repo}
        fi
    done
}

alpine() {

    precheck alpine $@
    echo "[INFO] Update Alpine repository"
	ALPINE_REPO_PATH=${REPOS_PATH} ${REPO_SCRIPTS_PATH%%/}/alpine/update.sh all
}

apache() {

    precheck apache $@
    echo "[INFO] Update Apache repository"
	APACHE_REPO_PATH=${REPOS_PATH} ${REPO_SCRIPTS_PATH%%/}/apache/update.sh all
}

jenkins() {

    precheck jenkins $@
    echo "[INFO] Update Jenkins repository"
    JENKINS_REPO_PATH=${REPOS_PATH%%/}/jenkins/ \
        ${REPO_SCRIPTS_PATH%%/}/jenkins/update.sh jenkins_by_list ${REPO_SCRIPTS_PATH%%/}/etc/jenkins.versions
    echo "[INFO] Update Jenkins plugins"
    JENKINS_REPO_PATH=${REPOS_PATH%%/}/jenkins/ \
        ${REPO_SCRIPTS_PATH%%/}/jenkins/update.sh plugins_by_list ${REPO_SCRIPTS_PATH%%/}/etc/jenkins.plugins

}

oracle() {

    precheck oracle $@
    echo "[INFO] Update Oracle Java repository"
    ORACLE_REPO_PATH=${REPOS_PATH%%/}/oracle/ \
        ${REPO_SCRIPTS_PATH%%/}/oracle/update.sh all
}

pypi() {

    precheck pypi $@
    echo "[INFO] Update Python packages repository"
    ${REPO_SCRIPTS_PATH%%/}/pypi/update.sh \
        ${REPO_SCRIPTS_PATH%%/}/pypi/pypi-mirror.py \
        ${REPO_SCRIPTS_PATH%%/}/etc/pypi-packages.json \
        ${REPOS_PATH%%/}/pypi/
}

all() {

    precheck all $@
    alpine $@
    apache $@
    jenkins $@
    oracle $@
    pypi $@
}

$@
