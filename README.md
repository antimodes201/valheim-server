# valheim-server
Dedicated docker server for Valheim

Create a containerized version of Valheim Dedicated Server https://store.steampowered.com/app/892970/Valheim/

Build by hand 
```
git clone https://github.com/antimodes201/valheim-server.git
docker build -t antimodes201/valheim-server:latest .
```
 
Docker pull
```
docker pull antimodes201/valheim-server
```
 
Docker Run with defaults change the volume options to a directory on your node and maybe use a different name then the one in the example.  
You can now also set the timezone using -e TZ "Your_TIMEZONE"
 
Timezone list can be found at: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
```
docker run -p 2456-2458:2456-2458/udp -p 2456-2458:2456-2458/tcp -v /app/docker/temp-vol:/app \
	-e INSTANCE_NAME="Server Name" \
	-e WORLD_NAME="Save_Name" \
	-e PASSWORD="changeme" \
	--name valheim antimodes201/valheim-server:latest

```
 
Additional server launch arguments can be added using the ADDITIONAL_ARGS environment settings.  There are currently no listed / known ones but has been added as documentation evolves over EA.
 
Currently exposed environmental variables and their defaul values 
- TZ America/New_York
- GAME_PORT_1 2456
- INSTANCE_NAME "Containerized Server by T3stN3t"
- WORLD_NAME "default"
- PASSWORD ""
- ADDITIONAL_ARGS ""