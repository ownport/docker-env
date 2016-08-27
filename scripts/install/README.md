# docker-install-scripts

The scripts repository for application installation in Dockerfile.
The execution of each script is independent and self-suficient.

## install script API

- add() - to install application(-s)
- remove() - to de-install application(-s)

The template for install script
```sh
#!/bin/sh

set -eo pipefail
[[ "$TRACE" ]] && set -x || :

add() {

	echo '[ERROR] Not Implemented'
	exit 1
}

remove() {

	echo '[ERROR] Not Implemented'
	exit 1
}

$@
```


## Local use

to be described later


## GitHub use

to be described later


## Who use it

- [ownport/docker-builder](https://github.com/ownport/docker-builder)
- [ownport/docker-sandbox-env](https://github.com/ownport/docker-sandbox-env)
- [ownport/docker-bigdata-env](https://github.com/ownport/docker-bigdata-env)


## Scripts

| Script            | Status        | Notes
| ----------------- | ------------- |----------------------
| jenkins           | in progress   |
| tini              | completed     | https://github.com/krallin/tini
