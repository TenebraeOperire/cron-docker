FROM python:alpine
MAINTAINER TenebraeOperire

RUN apk update --no-cache && apk add --no-cache ca-certificates nano curl

RUN apk add --no-cache --virtual=build-dependencies wget  && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community shadow && \
    curl -o /tmp/s6-overlay.tar.gz -L \
    "https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz" && \
    tar xfz /tmp/s6-overlay.tar.gz -C / && \
    apk del --purge build-dependencies && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

RUN groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/false alpine && \
    usermod -G users alpine && \
    mkdir -p /config /data

COPY root/ /

VOLUME ["/config"]

ENTRYPOINT ["/init"]