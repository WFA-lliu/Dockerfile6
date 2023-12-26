FROM --platform=amd64 ubuntu:jammy-20220815

ARG UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install net-tools -y
RUN apt-get install lftp -y
RUN apt-get install jq -y
RUN apt-get install git -y
RUN apt-get install make autoconf flex bison build-essential -y
RUN apt-get install libperl-dev libpcap-dev libnet-pcap-perl libnetpacket-perl -y
RUN apt-get install cpanminus -y
RUN cpanm PAR::Packer PAR::Dist Archive::Zip Shell
RUN cpan install Net::Telnet
RUN PERL_MM_USE_DEFAULT=1 cpan install NetPacket::Ethernet
RUN cpan install File::Tee
RUN cpan install Parallel::ForkManager
RUN cpan install Linux::Distribution
RUN cpan install Data::Dump
RUN cpan install List::Compare
RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -g sudo -u $UID $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

