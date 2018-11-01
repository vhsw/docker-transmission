# Docker Transmission

This is a Dockerfile to set up Transmission - (https://www.transmissionbt.com/)

Build from docker file:

```
git clone git@github.com:vhsw/docker-transmission.git
cd docker-transmission
docker build -t transmission .
```
Run docker container:
```
docker run -d --name transmission
              -v /*your_watch_dir*:/watch \
              -v /*your_final_dir:/downloads \
              -v /*your_incomplete_dir:/incomplete \
              -v /*your_config_location*:/config \
              -p your_external_port:45555 \
              -p web_interface_port:9091 \
              -e "USERNAME=username" \
              -e "PASSWORD=password"
              transmission:latest
```
