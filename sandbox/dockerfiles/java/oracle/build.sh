#!/bin/bash

if [ -z ${SANDBOX_ENV_PATH} ];
then
	echo '[ERROR] SANDBOX_ENV_PATH is not defined'
	exit 1
else
	source ${SANDBOX_ENV_PATH%%/}/lib/build-libs.sh
fi

__make_java_image() {

	IMAGE_NAME=${1:-}
	JAVA_PACKAGE=${2:-}
	JAVA_VERSION=${3:-}
	JAVA_VERSION_BUILD=${4:-}

	echo "[INFO] Creating the image ${IMAGE_NAME}"

	docker build -t ${IMAGE_NAME} \
		--no-cache \
		$(get_default_args) \
		--build-arg JAVA_PACKAGE=${JAVA_PACKAGE} \
		--build-arg JAVA_VERSION=${JAVA_VERSION} \
		--build-arg JAVA_VERSION_BUILD=${JAVA_VERSION_BUILD} \
        ${SANDBOX_ENV_PATH%%/}/dockerfiles/java/oracle
}

jre-8u74() {

	__make_java_image 'ownport/oracle-jre:8u74' 'jre' '8u74' '02'
}


server-jre-8u74() {

	__make_java_image 'ownport/oracle-server-jre:8u74' 'server-jre' '8u74' '02'
}


jre-8u73() {

	__make_java_image 'ownport/oracle-jre:8u73' 'jre' '8u73' '02'
}


server-jre-8u73() {

	__make_java_image 'ownport/oracle-server-jre:8u73' 'server-jre' '8u73' '02'
}


jre-8u40() {

	__make_java_image 'ownport/oracle-jre:8u40' 'jre' '8u40' '26'
}


server-jre-8u40() {

	__make_java_image 'ownport/oracle-server-jre:8u40' 'server-jre' '8u40' '26'
}


server-jre-7u76() {

	__make_java_image 'ownport/oracle-server-jre:7u76' 'server-jre' '7u76' '13'
}


$@
