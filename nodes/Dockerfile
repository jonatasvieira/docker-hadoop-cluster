FROM centos:7
MAINTAINER JONATAS VIEIRA

RUN yum update

RUN yum install java-1.8.0-openjdk-headless wget -y

COPY ../hosts /etc/hosts

RUN adduser hadoop

COPY ../ssh_keys/id_rsa.pub /home/hadoop/.ssh/master.pub

RUN cat /home/hadoop/.ssh/master.pub >> ~/.ssh/authorized_keys


