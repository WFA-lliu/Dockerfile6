FROM --platform=amd64 ustclug/fedora:22

ARG UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i -re 's/([a-z]{2}\.)?download.fedoraproject.org\/pub\/fedora/archives.fedoraproject.org\/pub\/archive\/fedora/g' /etc/yum.repos.d/fedora.repo
RUN sed -i -re 's/#baseurl/baseurl/g' /etc/yum.repos.d/fedora.repo

RUN sed -i -re 's/([a-z]{2}\.)?download.fedoraproject.org\/pub\/fedora/archives.fedoraproject.org\/pub\/archive\/fedora/g' /etc/yum.repos.d/fedora-updates.repo
RUN sed -i -re 's/#baseurl/baseurl/g' /etc/yum.repos.d/fedora-updates.repo

RUN yum update -y
RUN yum install xorg-x11-apps -y
RUN yum install gtk3-devel -y
RUN yum install wget -y
RUN yum install tar -y
RUN yum install sudo -y

RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -u $UID $USER
RUN echo "$USER ALL=(ALL) ALL" >> /etc/sudoers

RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

