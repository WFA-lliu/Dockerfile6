FROM --platform=amd64 ubuntu:noble-20250415.1

ARG _UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive
ENV PASSWORD=$PASSWORD

RUN apt-get update
RUN apt-get install -qqy x11-apps
RUN apt-get install -qqy sudo
#RUN apt-get install -qqy libtool libtool-bin autoconf flex bison build-essential cmake git
#RUN apt-get install -qqy libssl-dev libcurl4-openssl-dev libgcrypt20-dev
#RUN apt-get install -qqy libgtk-3-dev qttools5-dev libqt5svg5-dev qtmultimedia5-dev
RUN apt-get install -qqy tzdata
RUN apt-get install -qqy ssh
RUN sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
#RUN systemctl enable ssh
RUN apt-get install -qqy wget
RUN apt-get install -qqy python3 python3-pip
RUN pip3 install pycryptodome --break-system-packages
RUN pip3 install python-gnupg --break-system-packages
RUN pip3 install texttable --break-system-packages
RUN pip3 install pyftpdlib --break-system-packages
RUN pip3 install ptftpd --break-system-packages
RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -g sudo -u $_UID $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER
#CMD [ "/bin/sh", "-c", "echo $PASSWORD | sudo -S service ssh restart && bash" ]
ENTRYPOINT echo "$PASSWORD" | sudo -S service ssh restart && bash

