FROM alpine:3.3

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY

RUN echo "hosts: files dns" >> /etc/nsswitch.conf && \
	wget -O - http://${LOCAL_REPOS_HOST}/scripts/alpine/run-as.sh > /bin/run-as.sh && \
	chmod +x /bin/run-as.sh
