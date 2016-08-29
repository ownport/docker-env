#!/bin/sh
#

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

[ -z ${NEXUS_VERSION} ] && {
    echo '[ERROR] Environment variable NEXUS_VERSION is not defined'
    exit 1
}

if [ -z ${LOCAL_REPOS_HOST} ];
then
    NEXUS_URL="https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz"
else
    NEXUS_URL="http://${LOCAL_REPOS_HOST}/repo/sonatype/nexus-${NEXUS_VERSION}-unix.tar.gz"
fi

echo "[INFO] Nexus URL: ${NEXUS_URL}"
wget ${NEXUS_URL} -O /tmp/nexus.tar.gz

mkdir -p /opt && \
tar --directory=/opt -xzf /tmp/nexus.tar.gz && \
ln -s /opt/nexus-${NEXUS_VERSION}/ /opt/nexus

rm -rf \
    /var/cache/apk/* \
    /tmp/*.tar.gz

echo "export PATH=/opt/nexus/bin:\$PATH" >> /etc/profile.d/nexus.sh
chmod +x /etc/profile.d/nexus.sh
