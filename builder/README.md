# Ansible builder

Ansible build is Docker images for creating new docker images with ansible-container support


## Configuration

- /root/.ssh
- /root/.ssh/id_rsa
- /root/.ssh/id_rsa.pub
- /etc/ansible/inventory
- /etc/ansible/inventory/hosts
- /etc/ansible/inventory/docker.py
- /etc/ansible/ansible.cfg

Before you can build the Ansible container, you must export the DOCKER_HOST environment variable, since Ansible will use it to connect to the remote Docker daemon. When you use an HTTP endpoint, you need to modify `/etc/default/docker`

```
# make docker to listen on HTTP and default socket
DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"
```

Enter the command sudo service docker restart to restart the Docker daemon so that you pick up the changes to its configuration file.

### Hosts configuration file

```
# hosts
# this file is an inventory that Ansible is using to address remote servers.
Make sure to replace the information with your specific setup and variables
that you don't want to provide for every command.

[docker]
# host properties where docker daemon is running
<ip-address> ansible_ssh_user=<username>
```

### Ansible configuration file

```
# ansible.cfg

[defaults]

# use the path created from the Dockerfile
inventory = /etc/ansible/inventory

# not really secure but convenient in non-interactive environment
host_key_checking = False
# free you from typing `--private-key` parameter
priva_key_file = ~/.sh/id_rsa

# tell Ansible where are the plugins to load
callback_plugins   = /opt/ansible-plugins/callbacks
connection_plugins = /opt/ansible-plugins/connections
```

## Commands to build and validate the Ansible container

```sh
# you need DOCKER_HOST variable to point to a reachable docker daemon
# pick the method that suits your installation

# for boot2docker users
eval "$(boot2docker shellinit)"
# for docker-machine users, provisioning the running VM was named "dev"
eval "$(docker-machine env dev)"
# for users running daemon locally
export DOCKER_HOST=tcp://$(hostname -I | cut -d" " -f1):2375
# finally users relying on a remote daemon should provide the server's public ip
export DOCKER_HOST=tcp://1.2.3.4:2375

# build the container from Dockerfile
docker build -t article/ansible .

# provide server API version, as returned by `docker version | grep -i "server api"`
# it should be at least greater or equal than 1.8
export DOCKER_API_VERSION=1.19

# create and enter the workspace
docker run -it --name builder \
    # make docker client available inside
    -v /usr/bin/docker:/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    # detect local ip
    -e DOCKER_HOST=$DOCKER_HOST \
    -e DEFAULT_DOCKER_API_VERSION=DOCKER_API_VERSION \
    -v $PWD:/app -w /app \  # mount the working space
    article/ansible bash

# challenge the setup
$ container > ansible docker -m ping
192.168.0.12 | SUCCESS => {
    "invocation": {
        "module_name": "ping",
        "module_args": {}
    },
    "changed": false,
    "ping": "pong"
}
```

## Ansible test


```sh
$ ansible all -i ansible-builder, -c docker -m command -a 'uptime'
ansible-builder | SUCCESS | rc=0 >>
 06:14:37 up 2 days, 10:49,  load average: 0.40, 0.43, 0.54

```

## Links

- [Provisioning Docker containers with Ansible](https://www.ibm.com/developerworks/cloud/library/cl-provision-docker-containers-ansible/) Setting up and extending an Ansible environment with playbooks, plugins, and the Docker module


## Changes

### 201701

- PyYAML==3.11
- Jinja2==2.8
- ansible-container==0.2.0
- ansible==2.2.0.0
