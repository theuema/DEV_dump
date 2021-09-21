# Docker

0.  [Commands](#0-Commands)
1.  [Dockerfile](#1-Dockerfile)
2.  [Rocker](#2-Rocker)
3.  [Removing Docker Containers](#3-Removing-Docker-Containers%22).

- *Info: Installation instructions can be found in* `DEV_notes/_install_docker_pyTorch_w_nVidia-docker.md` 

* * *
## 0 Commands
 *** 
 
*Get a [list of all containers](https://linuxize.com/post/how-to-list-docker-containers/):* `docker container ls` command with the `-a` option.

*Command to build a Docker image from a Dockerfile:*
`docker build`
 
```
# define a tag with -t, which is basically the name of the image
# the dot `.` is to specify the directory where `docker build` looks for the Dockerfile
> docker build -t TAG .
```
 
 
***
## 1 Dockerfile
***
- **Info:** [A Beginner’s guide to Dockerfile with a sample project](https://medium.com/bb-tutorials-and-thoughts/docker-a-beginners-guide-to-dockerfile-with-a-sample-project-6c1ac1f17490)

```
# Starting point always is the `FROM` keyword, this is mostly an image pulled from public registries such as docker hub. One can also start from scratch with: `FROM scratch`
> FROM debian:stretch

# LABEL is used to add some metadata to the image. 
> LABEL "about"="This file is just an example"

> ENV LC_ALL en_US.UTF-8
> ENV LANG en_US.UTF-8

# RUN executes the instructions in a new layer on top of the existing image and commit those layers and the resulted layer will be used for the next instructions in the Dockerfile. 

> RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gconf2 \
    gconf-service \
    gvfs-bin \
    hunspell-en-us \
    libasound2 \
    libgtk2.0-0 \
    libnotify4 \
    libnss3 \
    libxss1 \
    libxtst6 \
    locales \
    python \
    xdg-utils \
        libgnome-keyring0 \
        gir1.2-gnomekeyring-1.0 \
        libappindicator1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

> RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

# ADD is used to add files or directories and remote files from URL from source host filesystem to a destination in the container file system. 
> ADD ./slack-desktop-2.1.0-amd64.deb ./
> RUN dpkg -i slack-desktop-2.1.0-amd64.deb

# ENTRYPOINT is used as an executable for the container. Let’s look at the below example. We are using ENTRYPOINT for executable command and also could use CMD command to pass some default commands to the executable.
# > CMD [some arguments for executable like "-v"]
> ENTRYPOINT ["slack"]
```

***
## 2 Rocker
*** 
- **Info:** [ROS Tutorial](https://wiki.ros.org/docker/Tutorials/GUI) on Using GUI's with Docker
- Rocker [Github Repository](https://github.com/osrf/rocker)

Is a tool which will help you run docker containers with hardware acceleration. If you have an nvidia driver and need graphics acceleration you can run it with --x11 as an option to enable the X server in the container. It can also pass through your user using --user and mount your home directory using --home. And it can also pass through PulseAudio with --pulse. 

*** 
## 3 Removing Docker Containers
* * *

Docker containers are not automatically removed when you stop them unless you start the container using the `--rm` flag.

### Removing one or more containers

To remove one or more Docker containers, use the `docker container rm` command, followed by the IDs of the containers you want to remove.