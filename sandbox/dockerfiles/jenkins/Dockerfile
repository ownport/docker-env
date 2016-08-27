FROM ownport/alpine:latest

ARG BUILDER_HOST
ARG HTTP_PROXY

ARG JAVA_PACKAGE
ARG JAVA_VERSION
ARG JAVA_VERSION_BUILD

ARG JENKINS_VERSION
ARG JENKINS_PLUGINS

# JENKINS PLUGINS:
# credentials ssh-credentials ssh-agent ssh-slaves
# git-client git github github-api github-oauth
# ghprb scm-api postbuild-task greenballs


RUN wget -O - http://${BUILDER_HOST}/install/alpine/glibc.sh | sh -s add && \
	wget -O - http://${BUILDER_HOST}/install/java/oracle/jdk.sh | \
		JAVA_PACKAGE=${JAVA_PACKAGE} \
		JAVA_VERSION=${JAVA_VERSION} \
		JAVA_VERSION_BUILD=${JAVA_VERSION_BUILD} sh -s add && \
	wget -O - http://${BUILDER_HOST}/install/tini.sh | sh -s add && \
	wget -O - http://${BUILDER_HOST}/install/jenkins.sh | \
		JENKINS_VERSION=${JENKINS_VERSION} \
		JENKINS_PLUGINS=${JENKINS_PLUGINS} sh -s add

CMD ["tini", "--", "/opt/jenkins/run-jenkins.sh"]
