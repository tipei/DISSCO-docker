FROM ubuntu:16.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV DISPLAY=$DISPLAY
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    echo 'tzdata tzdata/Areas select Europe' | debconf-set-selections && \
    echo 'tzdata tzdata/Zones/Europe select London' | debconf-set-selections && \
    echo 'keyboard-configuration keyboard-configuration/layout select "English (US)"' | debconf-set-selections && \
    echo 'keyboard-configuration keyboard-configuration/layoutcode select us' | debconf-set-selections && \
    echo 'keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC' | debconf-set-selections && \
    echo 'keyboard-configuration keyboard-configuration/variant select ' | debconf-set-selections && \
    apt-get install -y \
        cowsay \
        g++ \
        gdb \
        git \
        premake4 \
        libmuparser-dev \
        libmuparser2v5 \
        libxerces-c-dev \
        libsndfile1-dev \
        libsndfile1 \
        lilypond \
        libgtkmm-2.4-1v5 \
        libgtkmm-2.4-dev \
        libgtk2.0-dev \
        make \
        gnome-terminal \
        xterm \
        x11-apps \
        dbus-x11 \
        gnome-session \
        gnome-shell \
        gnome-tweak-tool \
        ubuntu-gnome-desktop \
        vim \
        locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && update-locale

RUN service dbus start

COPY DISSCO-2.1.0/ /root/DISSCO-2.1.0/

WORKDIR /root/DISSCO-2.1.0/

ENTRYPOINT ["/bin/bash", "-c", "service dbus start && while :; do sleep 2073600; done"]
