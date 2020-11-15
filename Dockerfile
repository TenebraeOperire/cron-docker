FROM python:slim-buster
MAINTAINER TenebraeOperire

RUN apt-get update

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.1.0.2/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

RUN groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/false debian && \
    usermod -G users debian && \
    mkdir -p /config /data

COPY root/ /

VOLUME ["/config"]

ENTRYPOINT ["/init"]