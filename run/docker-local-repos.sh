#!/bin/bash
#
#   The script for managing docker local repositories container
#

usage() {

    declare -F | cut -d " " -f 3
}

get_local_repos_id() {

    docker ps -q -a -f "name=local-repos"
}

start() {

    if [ -z $(get_local_repos_id) ];
    then
        docker run -d --name 'local-repos' \
            --name local-repos \
            --hostname local-repos \
            -v $(pwd)/scripts/install/:/var/www/install:ro \
            -v $(pwd)/files/alpine/:/var/www/repo/alpine/:ro \
            -v $(pwd)/files/pypi/:/var/www/repo/pypi/:ro \
            -v $(pwd)/files/oracle/:/var/www/repo/oracle/:ro \
            -v $(pwd)/files/jenkins/:/var/www/repo/jenkins/:ro \
            -v $(pwd)/files/tarballs/:/var/www/repo/tarballs/:ro \
            -v $(pwd)/sandbox/scripts/:/var/www/scripts/alpine/:ro \
            ownport/docker-local-repos:latest && \
        echo '[INFO] docker-local-repos container was started';
    else
        echo '[ERROR] docker-local-repos is active already,' $(get_local_repos_id);
    fi
}

stop() {

    if [ -z $(get_local_repos_id) ];
    then
        echo "[ERROR] local-repos is not started";
    else
        docker stop $(get_local_repos_id) && \
        echo '[INFO] local-repos was stopped'
    fi
}

restart() {

    stop && remove && start
}

remove() {

    docker rm $(get_local_repos_id)
}

$@
