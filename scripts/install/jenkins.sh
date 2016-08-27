#!/bin/sh
#
#	Links:
#	- jenkinsci/docker, https://github.com/jenkinsci/docker
# 	- HearstAT/docker-alpinejenkins, https://github.com/HearstAT/docker-alpinejenkins
#	

JENKINS_HOME=/data/jenkins/
JENKINS_PLUGINS=${JENKINS_PLUGINS:-}
JENKINS_UC="https://updates.jenkins-ci.org"


add() {

	[ -z ${JENKINS_VERSION} ] && {
		echo "[ERROR] Jenkins version does not specified"
		exit 1
	}

	[ ! -d ${JENKINS_HOME} ] && { mkdir -p ${JENKINS_HOME}; }

	if [ -z ${BUILDER_HOST} ];
	then
		JENKINS_URI="http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war"
		JENKINS_SHA_URI="http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war.sha1"
	else
		JENKINS_URI="http://${BUILDER_HOST}/repo/jenkins/jenkins-war-${JENKINS_VERSION}.war"
		JENKINS_SHA_URI="http://${BUILDER_HOST}/repo/jenkins/jenkins-war-${JENKINS_VERSION}.war.sha1"
	fi

	mkdir -p /opt/jenkins-${JENKINS_VERSION}/ && \
	wget ${JENKINS_URI} -O /opt/jenkins-${JENKINS_VERSION}/jenkins.war  && \
	ln -s /opt/jenkins-${JENKINS_VERSION} /opt/jenkins

	add_plugins
	make_init_script

	echo "export JENKINS_HOME=${JENKINS_HOME}" >> /etc/profile.d/jenkins.sh 
	echo "export JENKINS_UC=${JENKINS_UC}" >> /etc/profile.d/jenkins.sh 
}

remove() {

	echo '[ERROR] Not Implemented'
	exit 1
}

add_plugins() {
	
	apk add --update curl 

	for plugin in ${JENKINS_PLUGINS}; 
	do  
		echo "[INFO] Jenkins plugin installation:" ${plugin}
		curl -sSL http://updates.jenkins-ci.org/latest/${plugin}.hpi --output /opt/jenkins/plugins/${plugin}.hpi
	done

	apk del curl && rm -rf /var/lib/cache/*
}

make_init_script() {

	echo -e "#!/bin/sh\nsource /etc/profile\nexec java -jar /opt/jenkins/jenkins.war" > /opt/jenkins/run-jenkins.sh && \
	chmod +x /opt/jenkins/run-jenkins.sh
}

$@