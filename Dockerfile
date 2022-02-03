FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

# Set some Variables
ENV TZ "America/New_York"
ENV BRANCH "public"
ENV INSTANCE_NAME "Containerized Server by T3stN3t"
ENV GAME_PORT_1 "2456"
ENV GAME_PORT_2 "2457"
ENV GAME_PORT_3 "2458"
ENV WORLD_NAME "default"
ENV PASSWORD ""
ENV MODDED "False"
ENV ADDITIONAL_ARGS ""

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		lib32gcc1 \
		wget \
		unzip \
		tzdata \
		ca-certificates 

# add steamuser user
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /app \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /app \
		&& chown steamuser:steamuser /scripts 

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE ${GAME_PORT_1} ${GAME_PORT_2} ${GAME_PORT_3}/udp
EXPOSE ${GAME_PORT_1} ${GAME_PORT_2} ${GAME_PORT_3}/tcp

USER steamuser

# Make a volume
# contains configs and world saves
VOLUME /app

CMD ["/scripts/start.sh"]
