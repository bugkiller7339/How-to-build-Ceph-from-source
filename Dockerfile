#ceph_srcbuild
FROM quay.io/centos/centos:stream8 as build
# This ceph docker file refer to the git repo(https://github.com/ceph/ceph-container.git),
# currently, we build the ceph docker image from centos official binary.later we may need to
# build the docker image base on source code build.

RUN     cd /etc/yum.repos.d/
RUN     sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN     sed -i 's|#baseurl=http://mirror.centos.org/.*|baseurl=https://linux-ftp.intel.com/pub/mirrors/centos/8-stream/AppStream/x86_64/os/|g' /etc/yum.repos.d/CentOS-Stream-AppStream.repo
RUN     sed -i 's|#baseurl=http://mirror.centos.org/.*|baseurl=https://linux-ftp.intel.com/pub/mirrors/centos/8-stream/BaseOS/x86_64/os/|g' /etc/yum.repos.d/CentOS-Stream-BaseOS.repo
RUN     sed -i 's|#baseurl=http://mirror.centos.org/.*|baseurl=https://linux-ftp.intel.com/pub/mirrors/centos/8-stream/extras/x86_64/os/|g' /etc/yum.repos.d/CentOS-Stream-Extras.repo
RUN     sed -i 's|#baseurl=http://mirror.centos.org/.*|baseurl=https://linux-ftp.intel.com/pub/mirrors/centos/8-stream/PowerTools/x86_64/os/|g' /etc/yum.repos.d/CentOS-Stream-PowerTools.repo

RUN     echo "sslverify=false" >> /etc/yum.conf
RUN     yum update -y &&  yum -y install git cmake gcc gcc-c++ epel-release wget udev

ARG     CEPH_VER="v16.2.7"
ARG     CEPH_REPO="https://github.com/ceph/ceph.git"

RUN     git clone -b ${CEPH_VER} ${CEPH_REPO}
RUN	cd ceph && \
        ./install-deps.sh && \
        ./do_cmake.sh -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr  && \
        cd build && \
        make -j 8  && \
        sudo make install  && \
	ceph -v


