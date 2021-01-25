# gochain-local

A collection of helper scripts to run gochain docker container as a local network.

## Requirements

- [Docker](https://docs.docker.com)
- `goloop/gochain` docker image
  - Please check [this article](https://gist.github.com/sink772/443b0abd0be1176b4ccb334205516450) to know how to build `goloop/gochain` docker image.

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
CONTAINER ID   IMAGE                   COMMAND                  CREATED         STATUS         PORTS                                        NAMES
48e4c66fec68   goloop/gochain:latest   "/entrypoint /bin/sh…"   9 seconds ago   Up 8 seconds   8080/tcp, 9080/tcp, 0.0.0.0:9082->9082/tcp   gochain-iconee
```

Note that log messages will be generated at `./chain/iconee.log`.

```
$ head ./chain/iconee.log
I|20210125-05:41:05.997850|b6b5|-|main|main.go:431   ____  ___   ____ _   _    _    ___ _   _
I|20210125-05:41:05.997953|b6b5|-|main|main.go:431  / ___|/ _ \ / ___| | | |  / \  |_ _| \ | |
I|20210125-05:41:05.997964|b6b5|-|main|main.go:431 | |  _| | | | |   | |_| | / _ \  | ||  \| |
I|20210125-05:41:05.997973|b6b5|-|main|main.go:431 | |_| | |_| | |___|  _  |/ ___ \ | || |\  |
I|20210125-05:41:05.997990|b6b5|-|main|main.go:431  \____|\___/ \____|_| |_/_/   \_\___|_| \_|
I|20210125-05:41:05.998006|b6b5|-|main|main.go:433 Version : v0.1.15-1039-g9f22c115
I|20210125-05:41:05.998057|b6b5|-|main|main.go:434 Build   : linux/amd64 tags()-2021-01-25-04:23:23
I|20210125-05:41:05.998094|b6b5|-|metric|metric.go:150 Initialize rootMetricCtx
T|20210125-05:41:05.998278|b6b5|-|TP|transport.go:383 registerPeerHandler &{0xc0001e6750 0xc0001e66f0 map[] {{0 0} 0 0 0 0} 0xc0001e67b0} true
T|20210125-05:41:05.998304|b6b5|-|TP|transport.go:383 registerPeerHandler &{0xc0001e66c0 :8080} true
```

### Stop the container

```
$ ./run_gochain.sh stop
>>> STOP gochain-iconee
gochain-iconee
gochain-iconee
```
