FROM --platform=amd64 ubuntu:focal

ARG UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository universe && apt-get update
RUN apt-get install -qqy x11-apps
RUN apt-get install -qqy sudo
RUN apt-get install -qqy libtool libtool-bin autoconf flex bison build-essential cmake git
RUN apt-get install -qqy libssl-dev libcurl4-openssl-dev libgcrypt20-dev
RUN apt-get install -qqy libgtk-3-dev qt5-default qttools5-dev libqt5svg5-dev qtmultimedia5-dev
RUN apt-get install -qqy wget
RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -g sudo -u $UID $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

