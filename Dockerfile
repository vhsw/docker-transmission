FROM ubuntu:trusty
MAINTAINER Tim Haak <tim@haak.co.uk>

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LIBEVENT_VERSION="2.0.22" \
    TRANSMISSION_VERSION="2.84"

COPY settings.json /var/lib/transmission-daemon/info/settings.json

RUN apt-get -q update && \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository -y ppa:transmissionbt/ppa && \
    apt-get -q update && \
    apt-get -qy --force-yes dist-upgrade && \
    apt-get install -qy --force-yes transmission-daemon ca-certificates wget tar curl unrar-free procps && \
    apt-get autoremove  -qy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/downloads", "/incomplete", "/watch", "/config"]

ADD ./settings.json /var/lib/transmission-daemon/info/settings.json

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 9091 45555

ENV USERNAME="transmission" \
    PASSWORD="password"

CMD ["/start.sh"]
