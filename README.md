# docker-env

The environment for fast developing and testing docker images. It contains:

- Installation scripts
- Script for managing local repositories
- Builder
- Dockerfiles sandbox


## Update local file repositories

To update all local repositories (full update)

```sh
$ ./manage.sh repo-update all
```

The full update contains updates for Alpine, Oracle, jenkins, Pyhton repositories

To update only specific repository you need to indicate it in the next command:
```sh
$ ./manage.sh repo-update <alpine|apache|oracle|jenkins|pypi>
```
