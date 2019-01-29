FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 5901

RUN apt-get update --fix-missing && \
apt-get install -y apt-utils && \
apt-get install -y iputils-ping net-tools wget curl sudo git gnupg2 zip openjdk-8-jdk openjdk-8-jre \
tightvncserver openssh-server lxde

RUN apt-get update --fix-missing && \
apt-get install -y language-pack-ja-base language-pack-ja && \
apt-get clean

RUN locale-gen ja_JP.UTF-8

ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8

ENV GROUP developer
ENV USER devuser
ENV HOME /home/${USER}
ENV SHELL /bin/bash

RUN groupadd -g 1000 ${GROUP} && \
useradd -g ${GROUP} -G sudo -m -s ${SHELL} ${USER} && \
echo "${USER}:${USER}" | chpasswd

RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER devuser

WORKDIR ${HOME}

RUN mkdir ${HOME}/.vnc && echo "#!/bin/bash" > ~/.vnc/xstartup && \
    echo "xrdb $HOME/.Xresources" >> ~/.vnc/xstartup && \
    echo "lxsession -s LXDE &" >> ~/.vnc/xstartup && \
    chmod 755 ~/.vnc/xstartup


ENV ZAPVER 2.7.0
ENV JMETORVER 5.0

RUN wget -q https://github.com/zaproxy/zaproxy/releases/download/${ZAPVER}/ZAP_${ZAPVER}_Linux.tar.gz && \
tar zxf ZAP_${ZAPVER}_Linux.tar.gz && rm ZAP_${ZAPVER}_Linux.tar.gz

RUN wget -q http://ftp.jaist.ac.jp/pub/apache/jmeter/binaries/apache-jmeter-${JMETORVER}.tgz && \
tar zxf apache-jmeter-${JMETORVER}.tgz && rm apache-jmeter-${JMETORVER}.tgz

CMD ["sudo start"]