FROM ownport/oracle-server-jre:7u76

ARG LOCAL_REPOS_HOST
ARG HTTP_PROXY
ARG MAVEN_VERSION

RUN wget -O - http://${LOCAL_REPOS_HOST}/install/apache/maven3.sh | \
		MAVEN_VERSION=${MAVEN_VERSION} sh -s add
