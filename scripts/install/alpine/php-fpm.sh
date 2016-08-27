#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

    echo "= /install/alpine/php-fpm.sh ============================================"
	echo "Parameters:"
	echo "RUNIT_SUPPORT=YES         to add runit support"
	echo "----------------------------------------------------------------------"

    apk add --update php-fpm

    if [ "${RUNIT_SUPPORT}" = "YES" ] || [ "${RUNIT_SUPPORT}" = "yes" ]
    then
        mkdir -p /etc/service/php-fpm/ && \
        printf "#!/bin/sh\nset -e\nexec /usr/bin/php-fpm --nodaemonize" > /etc/service/php-fpm/run && \
        chmod +x /etc/service/php-fpm/run && \
        echo "[INFO] runit support was activated"
    fi
}

remove() {

    echo "[WARNING] Not implemented"
}

$@
