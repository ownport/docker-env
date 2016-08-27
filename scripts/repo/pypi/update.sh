#!/bin/bash

PYPI_MIRROR_SCRIPT=${1:-}
PYPI_PACKAGES=${2:-}
PYPI_PACKAGES_REPO=${3:-}

[ ! -f ${PYPI_MIRROR_SCRIPT} ] && {
    echo "[ERROR] The path to pypi-mirror script does not exist"
    exit 1
}

[ ! -f ${PYPI_PACKAGES} ] && {
    echo "[ERROR] The path to the list with pypi packages does not exist"
    exit 1
}

[ ! -d ${PYPI_PACKAGES_REPO} ] && {
    echo "[ERROR] The path to pypi repository does not exist"
    exit 1
}


for PYTHON_VERSION in "2.7" "3.5";
do
    echo "========================================"
    echo "| Python ${PYTHON_VERSION}"
    echo "----------------------------------------"
	docker run -ti --rm --name pypi-mirror \
	    -v ${PYPI_MIRROR_SCRIPT}:/data/pypi-mirror.py \
	    -v ${PYPI_PACKAGES}:/data/pypi-packages.json \
	    -v ${PYPI_PACKAGES_REPO}:/data/repo/ \
	    ownport/python-dev:${PYTHON_VERSION} \
	    /bin/run-as.sh pypi 1000 "/data/pypi-mirror.py -v -p /data/pypi-packages.json -d /data/repo/"

    [ "${PYTHON_VERSION}" = "3.5" ] && {
        echo "[INFO] Update get-pip.py script"
        wget -c https://bootstrap.pypa.io/get-pip.py -O ${PYPI_PACKAGES_REPO}/get-pip.py
    }
done
