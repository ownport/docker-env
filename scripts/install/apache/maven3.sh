#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

[ -z ${MAVEN_VERSION} ] && {
    echo '[ERROR] Environment variable MAVEN_VERSION is not defined'
    exit 1
}

if [ -z ${LOCAL_REPOS_HOST} ];
then
    MAVEN_URL="http://www-eu.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
else
    MAVEN_URL="http://${LOCAL_REPOS_HOST}/repo/apache/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
fi

mkdir -p /opt && \
wget ${MAVEN_URL} -O /tmp/maven.tar.gz && \
tar --directory=/opt -xzf /tmp/maven.tar.gz && \
rm  -f /tmp/*.tar.gz

echo "export PATH=/opt/apache-maven-${MAVEN_VERSION}/bin:\$PATH" >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
