#!/bin/bash

CONTAINER_NAME=local-repos

usage() {

	echo -e "Available commands:\n"
	for cmd in $(declare -F | cut -d " " -f 3 | \
		grep -v get_local_repos_host | \
		grep -v get_default_args | \
		grep -v get_http_proxy | \
		grep -v "^__" | sort );
	do
		echo -e "\t${cmd}"
	done
	echo

}

get_local_repos_host() {

	docker inspect -f "{{ json .NetworkSettings.Networks.bridge.IPAddress }}" ${CONTAINER_NAME} | sed "s/\"//g"
}

get_http_proxy() {

	echo "http://$(get_local_repos_host):8118"
}

get_default_args() {

	_LOCAL_REPOS_HOST=$(get_local_repos_host)
	if [ ! -z "${_LOCAL_REPOS_HOST}" ];
	then
		echo -n \
			"--build-arg LOCAL_REPOS_HOST=${_LOCAL_REPOS_HOST}" \
			"--build-arg HTTP_PROXY=http://${_LOCAL_REPOS_HOST}:8118" \
			" "
	fi
}
