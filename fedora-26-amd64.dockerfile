FROM --platform=amd64 amd64/fedora:26

ARG UID=9527
ARG USER=WFA
ARG PASSWORD="docker"
ARG DEBIAN_FRONTEND=noninteractive
ARG INTERPRETER

RUN yum update -y
RUN yum install xorg-x11-apps -y
RUN yum install gtk3-devel -y
RUN yum install wget -y
RUN yum install tar -y

RUN if [ "$INTERPRETER" = "perl5" ]; then\
	yum install p7zip p7zip-plugins -y; \
	yum install perl -y; \
	yum install make automake gcc gcc-c++ kernel-devel -y; \
	yum install cpanminus -y; \
	yum install perl-CPAN -y; \
	PERL_MM_USE_DEFAULT=1 cpan -i Net::Telnet; \
	cpanm install Net::hostent; \
	cpanm install IO::Socket --force; \
	cpanm install IO::Handle; \
	cpanm install Digest::HMAC; \
	cpanm install Digest::SHA; \
	cpanm install File::stat; \
	cpanm install Math::BigInt; \
	cpanm install Data::Dumper; \
	cpanm install Shell; \
	cpanm install arybase; \
	cpanm install Carp; \
	fi

RUN yum install sudo -y

RUN useradd -r -m -d /home/$USER -s /bin/bash -g root -u $UID $USER
RUN echo "$USER ALL=(ALL) ALL" >> /etc/sudoers

RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "root:$PASSWORD" | chpasswd
USER $USER
WORKDIR /home/$USER

