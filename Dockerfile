FROM alpine:latest
LABEL maintainer="Alexey Dubrov <vhsw@ya.ru>" \
      cloned_from="timhaak/docker-transmission"

# because transmissions asks for this
# currently not supported by kernel
# RUN echo "net.core.rmem_max = 4194304" >> /etc/sysctl.conf 
# RUN echo "net.core.wmem_max = 1048576" >> /etc/sysctl.conf 
# RUN sysctl -p

RUN apk --no-cache add transmission-daemon 
RUN rm /etc/conf.d/transmission-daemon
COPY settings.json /var/transmission/config/settings.json
RUN mkdir /config

VOLUME ["/downloads", "/incomplete", "/watch", "/config"]

COPY start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 9091 45555 45555/udp

ENV USERNAME="transmission" \
    PASSWORD="password"

CMD ["/start.sh"]
