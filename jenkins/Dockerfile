FROM jenkins/jenkins:2.89-alpine

USER root

ARG GID=999
RUN apk --no-cache add shadow
RUN getent group $GID || groupadd -g $GID docker
RUN usermod -aG $GID jenkins

RUN curl https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar xvz -C /tmp/ && mv /tmp/docker/docker /usr/bin/docker
RUN apk --update add 'py-pip==9.0.0-r1' && pip install 'docker-compose==1.8.0'

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins
