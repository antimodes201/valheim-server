#!/bin/bash
# Start script for Valheim Dedicated Server Docker Image

# Move steamcmd install to startup
if [ ! -f /app/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /app/steamcmd/
	cd /app/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi

# Update game
/app/steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 896660 +quit

# Move save directory
mkdir -p /home/steamuser/.config/unity3d

if [ ! -d /app/saves ]
then
	mkdir /app/saves
fi
ln -s /app/saves /home/steamuser/.config/unity3d/IronGate

# Launch Game
timeStamp=`date +%m%d%Y_%H%M`
cd /app/
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

if [ -z "${PASSWORD}" ]
then
	echo "Password Not Set"
	./valheim_server.x86_64 -name "${INSTANCE_NAME}" -port ${GAME_PORT_1} -world "${WORLD_NAME}" -public 1 ${ADDITIONAL_ARGS}
else
	echo "Password Set"
	./valheim_server.x86_64 -name "${INSTANCE_NAME}" -port ${GAME_PORT_1} -world "${WORLD_NAME}" -password "${PASSWORD}" -public 1 ${ADDITIONAL_ARGS}
fi
