# GitLab Runner in docker (CentOS 7)

[![Build Status](https://travis-ci.com/pozgo/docker-gitlab-runner.svg?branch=master)](https://travis-ci.com/pozgo/docker-gitlab-runner)
[![GitHub Open Issues](https://img.shields.io/github/issues/pozgo/docker-gitlab-runner.svg)](https://github.com/pozgo/docker-gitlab-runner/issues)  
[![Stars](https://img.shields.io/github/stars/pozgo/docker-gitlab-runner.svg?style=social&label=Stars)]()
[![Fork](https://img.shields.io/github/forks/pozgo/docker-gitlab-runner.svg?style=social&label=Fork)]()  
[![](https://img.shields.io/github/release/pozgo/docker-gitlab-runner.svg)](https://github.com/pozgo/docker-gitlab-runner/releases)  
[![Docker build](http://dockeri.co/image/polinux/gitlab-runner)](https://hub.docker.com/r/polinux/gitlab-runner/)

Felling like supporting me in my projects use donate button. Thank You!  
[![](https://img.shields.io/badge/donate-PayPal-blue.svg)](https://www.paypal.me/POzgo)

[Docker Image](https://registry.hub.docker.com/u/polinux/gitlab-runner/) with GitLab Runner. It can be used as base image for more complex runners.

**More versions available through [tags](https://hub.docker.com/r/polinux/gitlab-runner/tags/)**

### Environmental Variable

|Variable|Description|
|:--|:--|
|`RUNNER_NAME`|Name that should be reported in Gitlab|
|`RUNNER_URL`|Gitlab `url`|
|`RUNNER_REGISTRATION_TOKEN`|Registration token|
|`RUNNER_EXECUTOR`|Default set to `shell`|
|`RUNNER_EXTRA_PARAMS`|Any other options available via `cli`|

### Usage

```bash
docker run \
    -d \
    --name gitlab-runner \
    -e "RUNNER_URL=http://my-gitlab.com" \
    -e "RUNNER_REGISTRATION_TOKEN=token" \
    -e "RUNNER_EXTRA_PARAMS=--tag-list=\"build, test, deploy\"" \
    polinux/gitlab-runner
```

Use `docker-compose.yml` file which contain basic setup of gitlab server with stand alone approach.

```bash
docker-compose up
```

Use automated script with `docker-compose.yml`

Start runner

```bash
./runner start
Starting Runner ...
Creating runner ... done
Runner started.
Following Log of runner...
Attaching to runner
runner    | [2018-11-22 20:50:42] Registering runner.
runner    | [2018-11-22 20:50:42] gitlab-runner register --non-interactive --name="runner" --url="https://my-gitlab.com/" --registration-token="xxxxxxxxxxxxxxxxx" --executor="shell"
runner    | Runtime platform                                    arch=amd64 os=linux pid=15 revision=cf91d5e1 version=11.4.2
runner    | Running in system-mode.
runner    |
runner    | Registering runner... succeeded                     runner=uM6p5qyF
runner    | Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
runner    | GLTOKEN: 7e02f2402198e879bcb9718ec47ce7
runner    | 2018-11-22 20:50:42,645 CRIT Supervisor running as root (no user in config file)
runner    | 2018-11-22 20:50:42,645 INFO Included extra file "/etc/supervisor.d/gitlab-runner.conf" during parsing
runner    | Unlinking stale socket /run/supervisor.sock
runner    | 2018-11-22 20:50:42,960 INFO RPC interface 'supervisor' initialized
runner    | 2018-11-22 20:50:42,960 CRIT Server 'unix_http_server' running without any HTTP authentication checking
runner    | 2018-11-22 20:50:42,961 INFO supervisord started with pid 32
runner    | 2018-11-22 20:50:43,964 INFO spawned: 'gitlab-runner' with pid 35
runner    | 2018-11-22 20:50:43,991 DEBG 'gitlab-runner' stderr output:
runner    | Runtime platform                                    arch=amd64 os=linux pid=35 revision=cf91d5e1 version=11.4.2
runner    |
runner    | 2018-11-22 20:50:43,991 DEBG 'gitlab-runner' stderr output:
runner    | Starting multi-runner from /etc/gitlab-runner/config.toml ...  builds=0
runner    | Running in system-mode.
runner    |
runner    | Configuration loaded                                builds=0
runner    |
runner    | 2018-11-22 20:50:43,992 DEBG 'gitlab-runner' stderr output:
runner    | Listen address not defined, metrics server disabled  builds=0
runner    | Listen address not defined, session server disabled  builds=0
runner    |
runner    | 2018-11-22 20:50:44,994 INFO success: gitlab-runner entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```

Unregister and remove runner

```bash
./runner delete
Unregistering runner with Token:  7e02f2402198e879bcb9718ec47ce7
Runtime platform                                    arch=amd64 os=linux pid=46 revision=cf91d5e1 version=11.4.2
Running in system-mode.

Unregistering runner from GitLab succeeded          runner=7e02f240
Updated /etc/gitlab-runner/config.toml
Runner Unregistered
Stopping Runner
Stopping runner ... done
Removing runner
Going to remove runner
Removing runner ... done
```

### Build

```bash
docker build -t polinux/gitlab-runner .
```

Docker troubleshooting
======================

Use docker command to see if all required containers are up and running:

```bash
$ docker ps
```

Check logs of gitlab server container:

```bash
$ docker logs gitlab-runner
```

Sometimes you might just want to review how things are deployed inside a running container, you can do this by executing a _bash shell_ through _docker's `exec_` command:

```bash
docker exec -ti gitlab-runner /bin/bash
```

History of an image and size of layers:

```bash
docker history --no-trunc=true polinux/gitlab-runner | tr -s ' ' | tail -n+2 | awk -F " ago " '{print $2}'
```

---

## Author
Przemyslaw Ozgo (<linux@ozgo.info>)

---

### Acknowledgements
I would like to thank [JetBrains](https://www.jetbrains.com/) for supporting me with Open Source endeavours.