FROM --platform=i386 i686/ubuntu:14.04

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

#libpam-systemd should be fixed manually; corresponding information could be found as following
#https://askubuntu.com/questions/534810/error-with-libpam-systemdamd64
#apt-get install libpam-systemd
#sed -i -e 's/invoke-rc.d/#invoke-rc.d/' "/var/lib/dpkg/info/libpam-systemd:i386.prerm"
#sed -i -e 's/invoke-rc.d/#invoke-rc.d/' "/var/lib/dpkg/info/libpam-systemd:i386.postinst"
#apt-get update
#apt-get install libpam-systemd -f

