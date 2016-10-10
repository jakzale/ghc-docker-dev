FROM pritunl/archlinux:latest
MAINTAINER Jakub Zalewski

RUN yes | pacman -S \
      ghc           \
      gcc           \
      make          \
      happy         \
      alex          \
      autoconf      \
      automake      \
      python        \
      python-sphinx \
      libedit       \
      git           \
      neovim        \
      php

RUN mkdir /php && cd /php \
  && git clone https://github.com/phacility/libphutil.git \
  && git clone https://github.com/phacility/arcanist.git

RUN useradd -m -d /home/ghc -s /bin/bash ghc
RUN echo "ghc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ENV HOME /home/ghc
WORKDIR /home/ghc
USER ghc

ENV EDITOR nvim
ENV PATH /php/arcanist/bin:$PATH 
CMD /bin/bash
