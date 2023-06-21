FROM --platform=amd64 ubuntu:trusty

ARG UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -qqy x11-apps

RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -g sudo -u $UID $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

