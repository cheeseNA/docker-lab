# docker-lab

This repository contains `Dockerfile` and `deploy.sh` to
set up a container and an environment to perform machine learning experiments in.

This repository is assumed to be used in servers of AYYM lab.

## setup
Clone this repository and change currect directory.

```sh
$ git clone git@github.com:cheeseNA/docker-lab.git
$ cd docker-lab
```

Build the image.

```sh
$ docker build -t docker-lab-image .
```

Make ws folder to mount and start the container.

```sh
$ mkdir ws
$ docker run -it -v $(pwd)/ws:/root/ws --gpus all --name docker-lab docker-lab-image
```

> If you want to enable ssh-agent forwarding to the container,
> add options below.
> ```sh
> -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent
> ```
> Make sure that you are connecting a lab server with `-A` flag or `ForwardAgent yes` option in `~/.ssh/config`
> and that `ssh-agent` is running on your computer.


Then, attach shell to the container and execute the following command.

```
# bash deploy.sh
```

Refresh shell and setup is done!

```sh
$ exec $SHELL -l
```