# python

## Update ge-pip.py script

```sh
$ cd sandbox-env
$ ./scripts/repo/update-pip.sh 
--2016-03-12 23:27:28--  https://bootstrap.pypa.io/get-pip.py
Resolving bootstrap.pypa.io (bootstrap.pypa.io)... 23.235.43.175
Connecting to bootstrap.pypa.io (bootstrap.pypa.io)|23.235.43.175|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1522812 (1.5M) [text/x-python]
Saving to: ‘/media/docker-env/sandbox-env/repo/pypi/get-pip.py’

100%[======================================================================>] 1,522,812   1.03MB/s   in 1.4s   

2016-03-12 23:27:30 (1.03 MB/s) - ‘/media/docker-env/sandbox-env/repo/pypi/get-pip.py’ saved [1522812/1522812]
```

## Update PyPI packages

```sh
$ cd sandbox-box
$ ./run/pypi-mirror.sh 
[INFO] Prepare to run '/data/update-pypi-repo.sh' from user: pypi/1000
Collecting pip
  File was already downloaded /data/repo/packages/pip-8.1.0-py2.py3-none-any.whl
....
Collecting wheel
  File was already downloaded /data/repo/packages/wheel-0.29.0-py2.py3-none-any.whl
Successfully downloaded wheel
```

## Create docker image for python 2.7

```sh
$ ./build/python.sh python_2_7
```

## Create docker image for python 3.5

```sh
$ ./build/python.sh python_3_5
```

