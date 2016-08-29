FROM ownport/oracle-server-jre:8u74

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG NEXUS_VERSION

RUN wget -O - http://${LOCAL_REPOS_HOST}/install/nexus3.sh | \
		MAVEN_VERSION=${NEXUS_VERSION} sh -s add
