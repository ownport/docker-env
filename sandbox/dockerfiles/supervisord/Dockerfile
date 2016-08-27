FROM ownport/alpine:latest

ARG BUILDER_HOST
ARG HTTP_PROXY

RUN wget -O - http://${BUILDER_HOST}/install/alpine/supervisord.sh | sh -s add

CMD ["/usr/bin/supervisord","-n"]
