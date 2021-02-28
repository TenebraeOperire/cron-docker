FROM python:slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y cron ca-certificates nano curl

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && \
    /tmp/s6-overlay-amd64-installer / && \
    rm /tmp/s6-overlay-amd64-installer

RUN mkdir -p /config /data

COPY root/ /

VOLUME ["/config"]

ENTRYPOINT ["/init"]