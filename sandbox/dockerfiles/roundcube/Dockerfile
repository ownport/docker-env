FROM ownport/alpine:latest

ARG BUILDER_HOST
ARG HTTP_PROXY
ARG ROUNDCUBE_VERSION

RUN wget -O - http://${BUILDER_HOST}/install/alpine/runit.sh | sh -s add
RUN wget -O - http://${BUILDER_HOST}/install/alpine/nginx.sh | \
        RUNIT_SUPPORT=yes sh -s add
RUN wget -O - http://${BUILDER_HOST}/install/alpine/php-fpm.sh | \
        RUNIT_SUPPORT=yes sh -s add
RUN wget -O - http://${BUILDER_HOST}/install/alpine/roundcube-mail.sh | \
		ROUNDCUBE_VERSION=${ROUNDCUBE_VERSION} sh -s add

CMD ["/sbin/runsvdir", "-P", "/etc/service"]
