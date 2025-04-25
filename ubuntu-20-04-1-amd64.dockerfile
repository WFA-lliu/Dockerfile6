FROM --platform=amd64 ubuntu:focal-20200916

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
RUN cpan install File::stat
RUN cpan install Parallel::ForkManager
RUN cpan install Linux::Distribution
RUN cpan install Data::Dump
RUN cpan install List::Compare
RUN cpan install List::MoreUtils
RUN cpan install String::HexConvert
RUN cpan install Digest::SHA
RUN cpan install Digest::HMAC
RUN cpan install Math::BigFloat
RUN cpan install Math::BigInt
RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -g sudo -u $UID $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

