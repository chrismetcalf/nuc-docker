FROM ubuntu:latest

ENV NUC_VERSION 2.1.9-1

# Update system
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y wget make gcc patchutils

# Download and install NUC
COPY Makefile.patch /usr/local/src/Makefile.patch
RUN cd /usr/local/src \
  && wget -O nuc.tar.gz https://www.no-ip.com/client/linux/noip-duc-linux.tar.gz \
  && tar -zxvf nuc.tar.gz \
  && cd noip-* \
  && cat ../Makefile.patch | patch -p0 \
  && make \
  && make install

ENTRYPOINT ["/usr/local/bin/noip2"]
