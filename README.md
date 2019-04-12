# Docker Transmission

This is the Dockerfile to set up [Transmission](https://www.transmissionbt.com/) torrent client

## Usage

[Install docker](https://docs.docker.com/install/). Then pull image:

```bash
docker pull vhsw/transmission
```

And run it:

```bash
docker run -d \
    --name transmission
    -v ~/Downloads:/downloads \
    -v ./config:/config \
    -p 9091 \
    -p 45555/tcp \
    -p 45555/udp \
    vhsw/transmission
```

## Build

Building from dockerfile:

```bash
git clone git@github.com:vhsw/docker-transmission.git
cd docker-transmission
docker build . -t transmission
```

Run the container:

```bash
docker run -d \
        --name transmission
        -v /*your_watch_dir*:/watch \
        -v /*your_final_dir:/downloads \
        -v /*your_incomplete_dir:/incomplete \
        -v /*your_config_location*:/config \
        -p 9091 \
        -p 45555/tcp \
        -p 45555/udp \
        transmission
```
