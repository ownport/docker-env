
DOCKER_HOST ?= tcp://$(shell hostname -I | cut -d" " -f1):2375
DOCKER_API_VERSION ?= $(shell docker version --format "{{ .Server.APIVersion }}")

build-ansible-builder-py27:
	docker build -t "ownport/ansible-builder:py27" \
		--file $(shell pwd)/ansible-builder.Dockerfile \
		.

run-ansible-builder-py27:
	docker run -ti --rm --name ansible-builder \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(shell pwd)/inventory:/etc/ansible/inventory \
		-v $(shell pwd)/test:/etc/ansible/test \
		ownport/ansible-builder:py27 \
		/bin/sh
		# -v /usr/bin/docker:/usr/bin/docker \
		# -e DOCKER_HOST=$(DOCKER_HOST) \
		# -e DOCKER_API_VERSION=$(DOCKER_API_VERSION) \
