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
if [ ${BRANCH} == "public" ]
then
	/app/steamcmd/steamcmd.sh +force_install_dir /app +login anonymous +app_update 896660 +quit
else
	/app/steamcmd/steamcmd.sh +force_install_dir /app +login anonymous +app_update 896660 -beta ${BRANCH} +quit
fi

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
export SteamAppId=892970

x=`echo "${MODDED}"|tr '[:upper:]' '[:lower:]'`
if [ ${x} == "true" ]
then
	echo "LOADING MODDED SERVER PATH!"
	export DOORSTOP_ENABLE=TRUE
	export DOORSTOP_INVOKE_DLL_PATH=./BepInEx/core/BepInEx.Preloader.dll
	export DOORSTOP_CORLIB_OVERRIDE_PATH=./unstripped_corlib

	export LD_LIBRARY_PATH="./doorstop_libs:$LD_LIBRARY_PATH"
	export LD_PRELOAD="libdoorstop_x64.so:$LD_PRELOAD"
	export LD_LIBRARY_PATH="./linux64:$LD_LIBRARY_PATH"

	if [ -z "${PASSWORD}" ]
	then
		echo "Password Not Set"
		./valheim_server.x86_64 -name "${INSTANCE_NAME}" -port ${GAME_PORT_1} -world "${WORLD_NAME}" -public 1 ${ADDITIONAL_ARGS}
	else
		echo "Password Set"
		./valheim_server.x86_64 -name "${INSTANCE_NAME}" -port ${GAME_PORT_1} -world "${WORLD_NAME}" -password "${PASSWORD}" -public 1 ${ADDITIONAL_ARGS}
	fi	
else
	echo "Vanilla Server"
	export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
	if [ -z "${PASSWORD}" ]
	then
		echo "Password Not Set"
		./valheim_server.x86_64 -name "${INSTANCE_NAME}" -port ${GAME_PORT_1} -world "${WORLD_NAME}" -public 1 ${ADDITIONAL_ARGS}
	else
		echo "Password Set"
		./valheim_server.x86_64 -name "${INSTANCE_NAME}" -port ${GAME_PORT_1} -world "${WORLD_NAME}" -password "${PASSWORD}" -public 1 ${ADDITIONAL_ARGS}
	fi
fi	
