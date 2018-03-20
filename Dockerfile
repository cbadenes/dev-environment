#
# Java 1.8, Maven, Git and Docker
#
# https://github.com/jamesdbloom/docker_java8_maven
#

# pull base image.
FROM jamesdbloom/docker-java8-maven

# maintainer details
MAINTAINER Carlos Badenes-Olmedo "cbadenes@gmail.com"

# update packages and install docker
RUN  \
  apt-get update && \
  apt-get -y install apt-transport-https \
       ca-certificates \
       curl \
       gnupg2 \
       software-properties-common && \
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
  add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) \
     stable" && \
  apt-get update && \
  apt-get -y install docker-ce && \
  curl -fsSL https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose
  
# attach volumes
VOLUME /volume/git

# create working directory
WORKDIR /local/git

# run terminal
CMD ["/bin/bash"]