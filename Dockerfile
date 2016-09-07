M ubuntu:14.04

MAINTAINER wrkrcoop

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y git \
  && apt-get install -y curl \
  && apt-get install -y software-properties-common

RUN apt-get update \
  && apt-get upgrade -y \
  && add-apt-repository ppa:fkrull/deadsnakes \
  && apt-get update \
  && apt-get install -y python2.7 \
  && apt-get install -y python-dev \
  && apt-get install -y python-pip \
  && apt-get update \
  && apt-get install -y python-numpy \
  && pip install -U protobuf==3.0.0b2 \
  && pip install asciitree

RUN apt-get update \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && add-apt-repository -y ppa:webupd8team/java  \
  && apt-get update  \
  && apt-get install -y oracle-java8-installer \
  && rm -rf /var/lib/apt/lists/*  \
  && rm -rf /var/cache/oracle-jdk8-installer

RUN apt-get update \
  && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list \
  && curl https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | sudo apt-key add - \
  && apt-get update \
  && apt-get install -y bazel \
  && apt-get upgrade bazel

RUN apt-get update \
  && apt-get install -y swig

RUN apt-get update \
  && cd /opt \
  && git clone --recursive https://github.com/tensorflow/models.git \
  && cd models/syntaxnet/tensorflow \
  && ./configure


ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


