FROM ubuntu:20.04

ENV STEAMPORT1  8766
ENV STEAMPORT2  8767
ENV SERVERNAME Zombies
ENV SERVERPASSWORD swar
ENV ADMINPASSWORD swadmin
ENV USER steam
ENV PLAYERPORTS 16262-16272
ENV SERVERPORT 16261
ENV STEAMCMD steamcmd

RUN useradd -m ${USER}

RUN set -x \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
            libsdl2-2.0-0:i386 \
            curl \
            lib32gcc1 \
            default-jre \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/steam/steamcmd &&\
	cd /home/steam/steamcmd &&\
	curl http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

RUN /home/steam/steamcmd/steamcmd.sh +quit
RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/pzserver +login anonymous +app_update 380870 -beta b41multiplayer +quit

USER ${USER}

EXPOSE ${STEAMPORT1}
EXPOSE ${STEAMPORT2}
EXPOSE ${SERVERPORT}/udp
EXPOSE ${PLAYERPORTS}

WORKDIR /home

COPY start.sh /home/start.sh
CMD ["bash", "start.sh"]
