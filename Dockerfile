FROM ubuntu:20.04

RUN apt-get update && apt-get install -y ca-certificates nano curl wget python3 python3-pip

RUN wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb

RUN apt-get update && apt-get install -y apt-transport-https && \
    apt-get update && apt-get install -y dotnet-runtime-5.0

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

RUN groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/false ubuntu && \
    usermod -G users ubuntu && \
    mkdir -p /config /data

COPY root/ /

VOLUME ["/config"]

ENTRYPOINT ["/init"]