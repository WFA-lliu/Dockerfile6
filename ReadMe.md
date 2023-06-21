# Dockerfile6
---


## Description:

In general, _WFA sniffer_ should be installed on individual machine; NIC, Wireshark/tshark dissector, and sniffer-agent are worked tightly on specific Linux.

NIC could be ignored for dissection-only case, then, virtual machine provides isolated environment, Wireshark/tshark and sniffer-agent could be evaluated on the environment.

Compared to virtual machine, docker container provides an environment for application-layer virtualization, such environment is more lightweight, and such environment would be suitable for Wireshark/tshark evaluation too.

This ***experimental project*** is created for _WFA sniffer_ evaluation on docker container, especially for Wireshark/tshark. A few _WFA sniffer_ packages will be installed and evaluated on corresponding Linux versions in docker containers; the docker engine is running on a virtual machine. And, Wireshark/tshark in the package shall be manipulated on docker container.

## Examples:
#### Example 1: QoS Management 2021 Update
Mentioned in GSGv10.19.0.
Assume _WFA sniffer_ package is stored in **~/Downloads** and mapped into **/wfa** in container.
###### Step 1-1: Build docker image and run docker container.
```sh
docker build -f ubuntu-20-04-amd64.dockerfile -t qm . --build-arg UID=$UID --build-arg USER=$USER --build-arg PASSWORD="demonslayer"
docker run --name qm-inst --privileged=true -v ~/Downloads:/wfa -it -e DISPLAY --net=host -v $XAUTHORITY:/root/.Xauthority qm bash
```
###### Step 1-2: Install WFA sniffer package under container.
```sh
cd /wfa
tar -xvf Wi-FiTestSuite_Sniffer-QM2021_v10.19.0.tar.gz
cd Wi-FiTestSuite_Sniffer-QM2021_v10.19.0
tar -xvf WTSSniffer.tar.gz
cd WTSSniffer
git clone https://github.com/the-tcpdump-group/libpcap.git
cd libpcap
git checkout libpcap-1.10.1
./configure --enable-remote
make
sudo make install
cd ..
export LD_LIBRARY_PATH=QM/lib
./QM/bin/wireshark
```

#### Example 2: CERTIFIED 6 (i.e. HE-R1)
Mentioned in GSGv10.20.0.
Assume _WFA sniffer_ package is stored in **~/Downloads** and mapped into **/wfa** in container.
###### Step 2-1: Build docker image and run docker container.
```sh
docker build -f ubuntu-16-04-amd64.dockerfile -t he-r1 . --build-arg UID=$UID --build-arg USER=$USER --build-arg PASSWORD="demonslayer"
docker run --name he-r1-inst --privileged=true -v ~/Downloads:/wfa -it -e DISPLAY --net=host -v $XAUTHORITY:/root/.Xauthority -v /etc/machine-id:/etc/machine-id:ro he-r1 bash
```
Extra file, i.e. **/etc/machine-id**, is needed.
###### Step 2-2: Install WFA sniffer package under container.
```sh
cd /wfa
tar -xvf Wi-FiTestSuite_Sniffer_HE-Linux_v10.20.0.tar.gz
cd Wi-FiTestSuite_Sniffer_HE-Linux_v10.20.0
su
./INSTALL
wireshark
```

#### Example 3: CERTIFIED ac (i.e. VHT-R2)
Mentioned in GSGv10.20.0.
Assume _WFA sniffer_ package is stored in **~/Downloads** and mapped into **/wfa** in container.
###### Step 3-1: Build docker image and run docker container.
```sh
docker build -f ubuntu-14-04-amd64.dockerfile -t vht-r2 . --build-arg UID=$UID --build-arg USER=$USER --build-arg PASSWORD="demonslayer"
docker run --name vht-r2-inst --privileged=true -v ~/Downloads:/wfa -it -e DISPLAY --net=host -v $XAUTHORITY:/root/.Xauthority vht-r2 bash
```
###### Step 3-2: Install WFA sniffer package under container.
```sh
cd /wfa
tar -xvf Wi-FiTestSuite_Sniffer-VHTR2-Ubuntu_v9.2.8.tar.gz
cd Wi-FiTestSuite_Sniffer-VHTR2-Ubuntu_v9.2.8
su
./INSTALL
apt-get -f install
./INSTALL
wireshark
```
Extra installation step, i.e. **apt-get -f install**, is needed.

## Conclusion:
Docker container could be used for _WFA sniffer_ evaluation (especially for Wireshark/tshark); however, extra installation steps different from the guide should be considered, sometimes.

## Reference:
[Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

[Prebuilt *Ubuntu 20.04* VMware Image](https://www.osboxes.org/ubuntu/)


