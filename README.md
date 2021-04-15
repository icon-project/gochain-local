# gochain-local

A collection of helper scripts to run gochain docker container as a local network.

## Requirements

- Download and install Docker
  - [Get Docker](https://docs.docker.com/get-docker/)

- `goloop/gochain-icon` docker image
  - Build
    ```
    $ git clone git@github.com:icon-project/goloop.git
    $ cd goloop
    $ make gochain-icon-image
    ```
  - Verify the generated image
    ```
    $ docker images goloop/gochain-icon
    REPOSITORY            TAG       IMAGE ID       CREATED         SIZE
    goloop/gochain-icon   latest    74676aec69ef   2 minutes ago   513MB
    ```

## Usage

You can start or stop the docker container using the following script.

```
$ ./run_gochain.sh
Usage: ./run_gochain.sh [start|stop] (docker-tag)
```

### Start the container

```
$ ./run_gochain.sh start
>>> START iconee 9082 latest
48e4c66fec68d01e767da91cbbb043c03f595b33cac69c8cdf94f39eaa03b34e

$ docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS         PORTS                                        NAMES
48e4c66fec68   goloop/gochain-icon:latest   "/entrypoint /bin/sh…"   9 seconds ago   Up 8 seconds   8080/tcp, 9080/tcp, 0.0.0.0:9082->9082/tcp   gochain-iconee
```

Note that log messages will be generated at `./chain/iconee.log`.

```
$ head ./chain/iconee.log
I|20210415-00:46:01.476846|b6b5|-|main|main.go:431   ____  ___   ____ _   _    _    ___ _   _
I|20210415-00:46:01.476932|b6b5|-|main|main.go:431  / ___|/ _ \ / ___| | | |  / \  |_ _| \ | |
I|20210415-00:46:01.476944|b6b5|-|main|main.go:431 | |  _| | | | |   | |_| | / _ \  | ||  \| |
I|20210415-00:46:01.476952|b6b5|-|main|main.go:431 | |_| | |_| | |___|  _  |/ ___ \ | || |\  |
I|20210415-00:46:01.476966|b6b5|-|main|main.go:431  \____|\___/ \____|_| |_/_/   \_\___|_| \_|
I|20210415-00:46:01.476982|b6b5|-|main|main.go:433 Version : alpha.0-22-gddf9cca2-dirty
I|20210415-00:46:01.477008|b6b5|-|main|main.go:434 Build   : linux/amd64 tags()-2021-04-15-00:44:00
I|20210415-00:46:01.477022|b6b5|-|metric|metric.go:150 Initialize rootMetricCtx
T|20210415-00:46:01.477157|b6b5|-|TP|transport.go:383 registerPeerHandler &{0xc00021a720 0xc00021a6c0 map[] {{0 0} 0 0 0 0} 0xc00021a780} true
T|20210415-00:46:01.477190|b6b5|-|TP|transport.go:383 registerPeerHandler &{0xc00021a690 :8080} true
```

### Stop the container

```
$ ./run_gochain.sh stop
>>> STOP gochain-iconee
gochain-iconee
gochain-iconee
```
