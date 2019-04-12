FROM alpine
LABEL maintainer="Alexey Dubrov <vhsw@ya.ru>"
LABEL org.label-schema.name="vhsw/transmission"
LABEL org.label-schema.vcs-url="https://github.com/vhsw/docker-transmission"
LABEL org.label-schema.docker.cmd="docker run \
-v ~/Downloads:/downloads \
-v ./config:/config \
-p 9091 \
-p 45555/tcp \
-p 45555/udp \
vhsw/transmission"

RUN apk --no-cache add transmission-daemon \
    && rm /etc/conf.d/transmission-daemon \
    && rm /etc/init.d/transmission-daemon \
    && mkdir /config

COPY config/settings.json /config

VOLUME ["/downloads", "/incomplete", "/watch", "/config"]
CMD ["transmission-daemon", "--foreground", "--config-dir", "/config"]
