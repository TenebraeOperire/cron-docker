FROM python:alpine
MAINTAINER TenebraeOperire

RUN apk update --no-cache && apk add --no-cache ca-certificates nano curl

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.1.0.2/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

RUN groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/false alpine && \
    usermod -G users alpine && \
    mkdir -p /config /data

COPY root/ /

VOLUME ["/config"]

ENTRYPOINT ["/init"]