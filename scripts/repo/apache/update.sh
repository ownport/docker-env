#!/bin/bash


[ -z ${APACHE_REPO_PATH} ] && {
    echo '[ERROR] APACHE_REPO_PATH environment does not specified'
    exit 1
}

APACHE_PACKAGES=$(dirname $0)/../etc/apache.packages
[ ! -f ${APACHE_PACKAGES} ] && {
    echo "[ERROR] apache.packages file does not exist in etc/ directory"
    exit 1
}

[ ! -d ${APACHE_REPO_PATH%%/}/apache ] && {
    mkdir -p ${APACHE_REPO_PATH%%/}/apache
}
APACHE_REPO_PATH=${APACHE_REPO_PATH%%/}/apache/

for package in `cat ${APACHE_PACKAGES}`
do
    echo "[INFO] Updating package:" `basename ${package}`
    wget -q -c ${package} -O ${APACHE_REPO_PATH%%/}/`basename ${package}`
done
