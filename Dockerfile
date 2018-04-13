FROM ubuntu:trusty

RUN apt-get update \
&& apt-get install -y --force-yes \
    software-properties-common

RUN apt-add-repository \
    ppa:brightbox/ruby-ng \
&&  apt-get update

RUN apt-get upgrade -y --force-yes \
&&  apt-get install -y --force-yes \
    git \
    ruby2.4 \
    ruby2.4-dev \
    ruby-switch \
    clang-3.5 \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm3 \
    libgdbm-dev \
&&  apt-get clean

RUN ruby-switch --set ruby2.4

RUN gem install bundler -f --no-ri --no-rdoc
