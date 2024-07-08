FROM --platform=amd64 ubuntu:xenial-20170915

ARG UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -qqy x11-apps
RUN apt-get install -qqy sudo
RUN apt-get install git pkg-config cmake make autoconf flex bison build-essential -y
RUN apt-get install libglib2.0-dev libxml2-dev liblz4-dev libkrb5-dev libnghttp2-dev liblua5.2-dev libgcrypt20-dev libc-ares-dev -y
RUN apt-get install libgtk-3-dev qt5-default qttools5-dev qttools5-dev-tools libqt5svg5-dev qtmultimedia5-dev -y

RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -g sudo -u $UID $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

