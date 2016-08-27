FROM ubuntu:trusty

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    wget -O - http://${LOCAL_REPOS_HOST}/scripts/alpine/run-as.sh > /bin/run-as.sh && \
	chmod +x /bin/run-as.sh
	
