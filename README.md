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

You can start or stop the docker container using the following script. You can also use [docker compose](#using-docker-compose) to start or stop the container.

```
$ ./run_gochain.sh
Usage: ./run_gochain.sh [start|stop|pause|unpause|ps]
```

### Start the container

```
$ ./run_gochain.sh start
>>> START with compose-single.yml
Creating network "gochain-local_default" with the default driver
Creating gochain-iconee ... done

$ ./run_gochain.sh ps
     Name                   Command               State                              Ports
----------------------------------------------------------------------------------------------------------------------
gochain-iconee   /entrypoint /bin/sh -c /go ...   Up      8080/tcp, 9080/tcp, 0.0.0.0:9082->9082/tcp,:::9082->9082/tcp
```

Note that log messages will be generated at `./chain/iconee.log`.

```
$ head ./chain/iconee.log
I|20211008-03:27:35.242715|b6b5|-|main|main.go:433   ____  ___   ____ _   _    _    ___ _   _
I|20211008-03:27:35.243626|b6b5|-|main|main.go:433  / ___|/ _ \ / ___| | | |  / \  |_ _| \ | |
I|20211008-03:27:35.243644|b6b5|-|main|main.go:433 | |  _| | | | |   | |_| | / _ \  | ||  \| |
I|20211008-03:27:35.243659|b6b5|-|main|main.go:433 | |_| | |_| | |___|  _  |/ ___ \ | || |\  |
I|20211008-03:27:35.243678|b6b5|-|main|main.go:433  \____|\___/ \____|_| |_/_/   \_\___|_| \_|
I|20211008-03:27:35.243693|b6b5|-|main|main.go:435 Version : v1.0.0
I|20211008-03:27:35.243713|b6b5|-|main|main.go:436 Build   : linux/amd64 tags(rocksdb)-2021-10-05-08:13:18
I|20211008-03:27:35.243732|b6b5|-|metric|metric.go:150 Initialize rootMetricCtx
T|20211008-03:27:35.244757|b6b5|-|TP|transport.go:383 registerPeerHandler &{0xc0001ca540 0xc0001ca4e0 map[] {{0 0} 0 0 0 0} 0xc0001ca5a0} true
T|20211008-03:27:35.244925|b6b5|-|TP|transport.go:383 registerPeerHandler &{0xc0001ca4b0 :8080} true
```

### Stop the container

```
$ ./run_gochain.sh stop
>>> STOP with compose-single.yml
Stopping gochain-iconee ... done
Removing gochain-iconee ... done
Removing network gochain-local_default
```

### Pause the container
```
$ ./run_gochain.sh pause
```

### Unpause the container
```
$ ./run_gochain.sh unpause
```

## Using Docker-Compose

There are two docker Compose files as the following.
  - `compose-single.yml`: run a single gochain node as the previous script example
  - `compose-multi.yml`: run multiple (four) gochain nodes which validate the same blocks

### Create and Start the container

#### For a single gochain node:
```
$ docker-compose -f compose-single.yml up -d
Creating network "gochain-local_default" with the default driver
Creating gochain-iconee ... done

$ docker-compose -f compose-single.yml ps
     Name                   Command               State                              Ports
----------------------------------------------------------------------------------------------------------------------
gochain-iconee   /entrypoint /bin/sh -c /go ...   Up      8080/tcp, 9080/tcp, 0.0.0.0:9082->9082/tcp,:::9082->9082/tcp
```

#### For multiple gochain nodes:
```
$ docker-compose -f compose-multi.yml up -d
Creating network "gochain-local_default" with the default driver
Creating gochain-local_node3_1 ... done
Creating gochain-local_node0_1 ... done
Creating gochain-local_node1_1 ... done
Creating gochain-local_node2_1 ... done

$ docker-compose -f compose-multi.yml ps
        Name                       Command               State                         Ports
-------------------------------------------------------------------------------------------------------------------
gochain-local_node0_1   /entrypoint /bin/sh -c /go ...   Up      8080/tcp, 0.0.0.0:9080->9080/tcp,:::9080->9080/tcp
gochain-local_node1_1   /entrypoint /bin/sh -c /go ...   Up      8080/tcp, 0.0.0.0:9081->9080/tcp,:::9081->9080/tcp
gochain-local_node2_1   /entrypoint /bin/sh -c /go ...   Up      8080/tcp, 0.0.0.0:9082->9080/tcp,:::9082->9080/tcp
gochain-local_node3_1   /entrypoint /bin/sh -c /go ...   Up      8080/tcp, 0.0.0.0:9083->9080/tcp,:::9083->9080/tcp
```

### Stop and remove the container

```
$ docker-compose -f compose-single.yml down
```

or
```
$ docker-compose -f compose-multi.yml down
```

## Persistence of Data
If you want to persist your data across docker restarts, set `GOCHAIN_CLEAN_DATA` in `./data/single/iconee.env` to `false`.
In case of the multiple nodes, modify `./data/multi/common.env` instead.
