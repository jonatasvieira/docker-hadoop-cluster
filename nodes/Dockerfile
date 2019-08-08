FROM ubuntu

MAINTAINER JONATAS VIEIRA

RUN apt-get -qq update -y

RUN apt-get -qqy install default-jre wget openssh-server openssh-client sudo

RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

RUN mkdir -p /root/.ssh/
COPY ./ssh_keys/id_rsa.pub /root/.ssh/master.pub
RUN cat /root/.ssh/master.pub >> /root/.ssh/authorized_keys
COPY ./bash_files/* /root/

RUN wget http://apache.cs.utah.edu/hadoop/common/current/hadoop-3.1.2.tar.gz

RUN tar -xzf hadoop-3.1.2.tar.gz

RUN mv hadoop-3.1.2 /opt/hadoop

COPY ./hadoop-conf-files/* /opt/hadoop/etc/hadoop/

RUN echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | tee -a /opt/hadoop/etc/hadoop/hadoop-env.sh && echo $JAVA_HOME
#Regenerate ssh keys
RUN /usr/bin/ssh-keygen -A

COPY ./docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 22
CMD ["hadoop"]






