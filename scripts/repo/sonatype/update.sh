#!/bin/bash


[ -z ${SONATYPE_REPO_PATH} ] && {
    echo '[ERROR] SONATYPE_REPO_PATH environment does not specified'
    exit 1
}

SONATYPE_PACKAGES=$(dirname $0)/../etc/sonatype.packages
[ ! -f ${SONATYPE_PACKAGES} ] && {
    echo "[ERROR] sonatype.packages file does not exist in etc/ directory"
    exit 1
}

[ ! -d ${SONATYPE_REPO_PATH} ] && {
    mkdir -p ${SONATYPE_REPO_PATH}
}

for package in `cat ${SONATYPE_PACKAGES}`
do
    echo -n "[INFO] Updating package:" `basename ${package}`
    wget -q -c ${package} -O ${SONATYPE_REPO_PATH%%/}/`basename ${package}` && echo " - DONE" || echo " - FAILED"
done
