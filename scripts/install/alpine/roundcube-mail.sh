#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :


add() {

    ROUNDCUBE_TGZ="roundcubemail.tar.gz"

    apk add --update \
            sqlite \
            php-dom \
            php-xml \
            php-json \
            php-pdo \
            php-pdo_sqlite \
            php-intl \
            php-iconv \
            php-openssl \
            php-mcrypt \
            php-exif \
            php-ldap

    if [ -z ${BUILDER_HOST} ];
	then

        ROUNDCUBE_URL=`get_roundcube_url ${ROUNDCUBE_VERSION}`
		apk add --update wget
		wget -c --progress=dot:mega --no-check-certificate ${ROUNDCUBE_URL} -O /tmp/${ROUNDCUBE_TGZ}
        apk del wget

	else

		ROUNDCUBE_URL="http://${BUILDER_HOST}/repo/tar.gz/roundcubemail-${ROUNDCUBE_VERSION}.tar.gz"
        echo ${ROUNDCUBE_URL}
		wget ${ROUNDCUBE_URL} -O /tmp/${ROUNDCUBE_TGZ}
	fi

    adduser -D -g '' -u 1000 mailer

    mkdir -p /data/app /data/db /data/log /data/tmp && \
    tar --directory=/tmp -xzf /tmp/${ROUNDCUBE_TGZ} && \
    mv /tmp/roundcubemail-${ROUNDCUBE_VERSION}/* /data/app/ && \
    rm -rf /tmp/* /data/app/installer && \
    chown -R mailer:mailer /data/app /data/log /data/tmp

    add_nginx_config /etc/nginx/nginx.conf
    sed -i 's/^\(user = \).*/\1mailer/' /etc/php/php-fpm.conf
    sed -i 's/^\(group = \).*/\1mailer/' /etc/php/php-fpm.conf
}

remove() {
    echo 1
}

get_roundcube_url() {

    VERSION=${1:-}
    if [ "${VERSION}" = "1.1.5" ]
    then
        return "https://github.com/roundcube/roundcubemail/releases/download/${VERSION}/roundcubemail-${VERSION}-complete.tar.gz"
    else
        return "https://github.com/roundcube/roundcubemail/releases/download/${VERSION}/roundcubemail-${VERSION}.tar.gz"
    fi
}


add_nginx_config() {

cat > ${1} <<- EOF
user mailer;
worker_processes  1;

events { worker_connections 1024; }

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile            on;
    keepalive_timeout   65;

    server {
        listen          80;
        root            /data/app;
        index index.php;
        server_name roundcube-${ROUNDCUBE_VERSION};

        location / {
            index       index.php;
        }

        error_page      500 502 503 504  /50x.html;
        location = /50x.html {
            root html;
        }
        location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME \$document_root/\$fastcgi_script_name;
        }
    }
}
EOF

}

$@
