# ----------------------------------------------------------------------
# Docker aliases
#

d-help() { declare -F | grep d- | cut -d " " -f 3; }

# remove exited containers
d-rm-ec() {
    EXITED_CONTAINERS=$(docker ps -a | grep Exited | cut -d " " -f 1;);
    if [ -z $EXITED_CONTAINERS ];
    then
        echo "No exited containers";
    else
        docker rm $EXITED_CONTAINERS;
    fi
}

# remove none images
d-rm-ni() {
    NONE_IMAGES=$(docker images | grep "^<none>" | awk '{print $3}' )
    if [ -z $NONE_IMAGES ];
    then
        echo "No none images";
    else
        docker rmi $NONE_IMAGES;
    fi
}

# remove exited containers and none images
d-rm-ci() { d-rm-ec && d-rm-ni; }

# remove images
d-rm-i() { docker rmi $@; }

# get container's IP address
d-ip() { docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1; }

# get docker images
d-im() { docker images; }

d-im-s() { docker images | grep -v REPOSITORY | awk -F " " '{print $1":"$2}' | sort;}

# get all container processes
d-ps-a() { docker ps -a; }

# run interactive container
d-run-i() { docker run -ti --rm $@; }

# execute interactive container
d-ex-i() { docker exec -ti $@; }
