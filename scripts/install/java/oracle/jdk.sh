#!/bin/sh
#
#
#   Links:
#   - Smaller Java images with Alpine Linux, https://developer.atlassian.com/blog/2015/08/minimal-java-docker-containers/
#

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

    [ -z ${JAVA_PACKAGE} ] && {
        echo '[ERROR] Environment variable JAVA_PACKAGE is not defined'
        exit 1
    }

    [ -z ${JAVA_VERSION} ] && {
        echo '[ERROR] Environment variable JAVA_VERSION is not defined'
        exit 1
    }

    [ -z ${JAVA_VERSION_BUILD} ] && {
        echo '[ERROR] Environment variable JAVA_VERSION_BUILD is not defined'
        exit 1
    }

    if [ -z ${LOCAL_REPOS_HOST} ];
    then

        JDK_URL="http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz"
        apk add --update wget

        wget -c --progress=dot:mega --no-check-certificate --no-cookies \
            --header "Cookie: oraclelicense=accept-securebackup-cookie" \
            ${JDK_URL} \
            -O /tmp/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz
    else

        JDK_URL="http://${LOCAL_REPOS_HOST}/repo/oracle/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz"
        wget ${JDK_URL} -O /tmp/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz
    fi

    mkdir -p /opt && \
    tar --directory=/opt -xzf /tmp/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz && \
    ln -s `ls /opt/ | grep jdk` /opt/jdk

    rm -rf \
        /var/cache/apk/* \
        /tmp/*.tar.gz \
        /opt/jdk/*src.zip \


    if [ ! -z ${REMOVE_EXT_LIBS}];
    then

        rm -rf \
            /opt/jdk/jre/plugin \
            /opt/jdk/jre/lib/desktop \
            /opt/jdk/jre/bin/javaws \
            /opt/jdk/lib/missioncontrol \
            /opt/jdk/lib/visualvm/ \
            /opt/jdk/jre/lib/fonts/ \
            /opt/jdk/jre/lib/images/ \
            /opt/jdk/jre/lib/ext/jfxrt.jar \
            /opt/jdk/jre/lib/javaws.jar \
            /opt/jdk/jre/lib/deploy* \
            /opt/jdk/jre/lib/plugin.jar \
            /opt/jdk/lib/*javafx*.jar \
            /opt/jdk/jre/lib/jfx* \
            /opt/jdk/jre/lib/amd64/libdecora_sse.so \
            /opt/jdk/jre/lib/amd64/libprism_*.so \
            /opt/jdk/jre/lib/amd64/libfxplugins.so \
            /opt/jdk/jre/lib/amd64/libglass.so \
            /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
            /opt/jdk/jre/lib/amd64/libjavafx*.so \
            /opt/jdk/jre/lib/amd64/libjfx*.so
    fi

    JAVA_HOME=/opt/jdk
    echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/profile.d/jdk.sh
    echo "export PATH=$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/jdk.sh
    chmod +x /etc/profile.d/jdk.sh
}

remove() {

    echo "[ERROR] Not implemented"
    exit 1
}

$@
