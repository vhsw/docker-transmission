FROM debian:wheezy
MAINTAINER Tim Haak <tim@haak.co.uk>

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LIBEVENT_VERSION="2.0.22" \
    TRANSMISSION_VERSION="2.84"

COPY settings.json /var/lib/transmission-daemon/info/settings.json

RUN apt-get -q update && \
    apt-get -qy --force-yes dist-upgrade && \
    apt-get install -qy --force-yes libcurl4-openssl-dev libssl-dev pkg-config build-essential checkinstall intltool\
        wget tar ca-certificates curl unrar-free  && \
    curl -L https://github.com/downloads/libevent/libevent/libevent-${LIBEVENT_VERSION}-stable.tar.gz  -o  libevent.tar.gz && \
    tar -xvf libevent.t*gz -C /  &&\
    mv /libevent-* /libevent/ &&\
    rm  /libevent.t*gz &&\
    cd /libevent  &&\
    CFLAGS="-Os -march=native" ./configure && make  &&\
    checkinstall -y &&\
    cd /  &&\
    rm -rf /libevent  &&\

    curl -L https://transmission.cachefly.net/transmission-${TRANSMISSION_VERSION}.tar.xz -o transmission.tgz && \
    tar -xvf transmission.t*gz -C /  &&\
    mv /transmission-* /transmission/ &&\
    rm  /transmission.t*gz &&\
    cd transmission   &&\
    CFLAGS="-Os -march=native" ./configure    &&\
    make   &&\
    mkdir -p '/usr/local/share/transmission/web/images' &&\
    mkdir -p '/usr/local/share/transmission/web/style/jqueryui/images' &&\
    mkdir -p '/usr/local/share/transmission/web/style/transmission/images/buttons' &&\
    mkdir -p '/usr/local/share/transmission/web/javascript/jquery' &&\
    checkinstall -y   && \
    rm -rf /transmission && \
    apt-get purge  -qy libcurl4-openssl-dev libssl-dev pkg-config build-essential checkinstall intltool && \
    apt-get autoremove  -qy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /tmp/*

VOLUME ["/downloads", "/incomplete", "/watch", "/config"]

ADD ./settings.json /var/lib/transmission-daemon/info/settings.json

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 9091 45555

ENV USERNAME="transmission" \
    PASSWORD="password"

CMD ["/start.sh"]
