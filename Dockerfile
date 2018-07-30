FROM openjdk:8u151-jdk
MAINTAINER Christian Hoffmeister <mail@choffmeister.de>

ENV SCALA_VERSION="2.12.5"
ENV SBT_VERSION="1.1.6"
ENV DOCKER_VERSION="17.12.1-ce"

WORKDIR /tmp
RUN \
  wget -q http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  echo "51b9586c645a96e7a2af8a019678dbf3cf8178f2  scala-$SCALA_VERSION.tgz" | shasum -c - && \
  tar xf scala-$SCALA_VERSION.tgz && \
  mv scala-$SCALA_VERSION /opt/scala && \
  ln -s /opt/scala/bin/fsc /usr/bin/fsc && \
  ln -s /opt/scala/bin/scala /usr/bin/scala && \
  ln -s /opt/scala/bin/scalac /usr/bin/scalac && \
  ln -s /opt/scala/bin/scaladoc /usr/bin/scaladoc && \
  ln -s /opt/scala/bin/scalap /usr/bin/scalap && \
  rm scala-$SCALA_VERSION.tgz
RUN \
  wget -q https://piccolo.link/sbt-$SBT_VERSION.tgz && \
  echo "c2b4a113057bc2c4f6224ec8b26987f64b91c1f1  sbt-$SBT_VERSION.tgz" | shasum -c - && \
  tar xf sbt-$SBT_VERSION.tgz && \
  mv sbt /opt/sbt && \
  ln -s /opt/sbt/bin/sbt /usr/bin/sbt && \
  rm sbt-$SBT_VERSION.tgz && \
  mkdir project && \
  echo "sbt.version=1.1.6" > project/build.properties && sbt sbtVersion && \
  echo "sbt.version=0.13.17" > project/build.properties && sbt sbtVersion && \
  rm -rf project
RUN \
  wget -q https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
  echo "9dd0d19312640460671352930eb44b1692441d95  docker-$DOCKER_VERSION.tgz" | shasum -c - && \
  tar xf docker-$DOCKER_VERSION.tgz && \
  mv docker /opt/docker && \
  ln -s /opt/docker/docker /usr/bin/docker && \
  rm -r docker-$DOCKER_VERSION.tgz

WORKDIR /root
