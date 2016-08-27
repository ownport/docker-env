#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

    echo "= /install/alpine/nginx.sh ============================================"
	echo "Parameters:"
	echo "RUNIT_SUPPORT=YES         to add runit support"
	echo "----------------------------------------------------------------------"

    apk add --update nginx

    if [ "${RUNIT_SUPPORT}" = "YES" ] || [ "${RUNIT_SUPPORT}" = "yes" ]
    then
        mkdir -p /etc/service/nginx/ && \
        printf "#!/bin/sh\nset -e\nexec /usr/sbin/nginx -g \"daemon off;\"" > /etc/service/nginx/run && \
        chmod +x /etc/service/nginx/run && \
        echo "[INFO] runit support was activated"
    fi

    add_config /etc/nginx/nginx.conf
}

remove() {

    echo "[WARNING] Not implemented"
}

add_config() {

cat > ${1} <<- EOF
worker_processes  1;

events { worker_connections 1024; }

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile            on;
    keepalive_timeout   65;

    server {
        listen          80;
        server_name     localhost;

        location / {
            root        html;
            index       index.html index.htm;
        }

        error_page      500 502 503 504  /50x.html;
        location = /50x.html {
            root html;
        }
    }
}
EOF

}

$@
