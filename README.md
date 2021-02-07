# eco-server
Dedicated docker server for Eco

Create a containerized version of Eco Dedicated Server https://store.steampowered.com/app/382310/Eco/

Build by hand 
```
git clone https://github.com/antimodes201/eco-server.git
docker build -t antimodes201/eco-server:latest .
```
 
Docker pull
```
docker pull antimodes201/eco-server
```
 
Docker Run with defaults change the volume options to a directory on your node and maybe use a different name then the one in the example.  
You can now also set the timezone using -e TZ "Your_TIMEZONE"
 
Timezone list can be found at: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
```
docker run -it -p 3000-3001:3000-3001/udp -p 3000-3001:3000-3001/tcp -v /app/docker/eco:/eco
	--name eco antimodes201/eco-server:latest
```
Currently exposed environmental variables and their defaul values 
- TZ America/New_York
- GAME_PORT 3000 
- WEB_PORT 3001

