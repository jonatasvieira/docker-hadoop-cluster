FROM centos:7
MAINTAINER JONATAS VIEIRA

RUN yum update

RUN yum install java-1.8.0-openjdk-headless wget -y

COPY ../hosts /etc/hosts

RUN adduser hadoop

COPY ../ssh_keys/* /home/hadoop/.ssh/

USER hadoop

RUN cd

RUN wget http://apache.cs.utah.edu/hadoop/common/current/hadoop-3.1.2.tar.gz

RUN tar -xzf hadoop-3.1.2.tar.gz

RUN mv hadoop-3.1.2 hadoop

COPY ./profile /home/hadoop/.profile

COPY ./bashrc /home/hadoop/.bashrc

RUN sed -i 's/${JAVA_HOME}/readlink -f $(which java)/g' /home/hadoop/etc/hadoop/hadoop-env.sh



