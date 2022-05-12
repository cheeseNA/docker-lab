# specify the Parent Image from which you are building
FROM nvidia/cuda:11.0-devel-ubuntu20.04

LABEL maintainer="cheeseNA"

# set as noninteractive
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.cargo/bin:$PATH"
ENV SHELL="/usr/bin/zsh"
ENV LC_CTYPE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# install Python3
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key A4B469963BF863CC
RUN apt-get update && apt-get install -y python3.9

# install other packages
ENV PATH="/root/.cargo/bin:$PATH"
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && cargo install exa git-delta
RUN apt-get install -y tree bat jq fasd zsh ffmpeg tldr tmux wget neovim
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

# locale settings
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8

# copy files to the container (COPY <src> <dest>)
COPY ./deploy.sh /root/deploy.sh

# set the working directory
WORKDIR /root

CMD ["zsh"]
