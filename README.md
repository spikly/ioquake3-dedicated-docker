# ioquake3-dedicated-docker
A docker container for running ioquake3 dedicated servers built on Alpine Linux.

## How to use

You will need to own a copy of Quake III Arena as the game files (specifically pak0.pk3) are needed to run this image.

### Download the latest image:

```
docker pull spikly/q3syn:latest
```

### Configure your server using server.cfg

Create a plain text file named server.cfg and add the configuration options to set the score limit, game type, number of bots and map rotation. A simple confiuration for a Free For All server is below.

```
seta sv_hostname "YOUR_SERVER_NAME" // The name of your server as you want it to appear in the server browser list
seta sv_maxclients 12 // The max number of players
seta sv_pure 1 // Enable pure server (recommended unless playing certain mods)

// Password
seta g_needpass 1 // Enable/disable a password that players must enter in order to join the server
seta g_password "YOUR_PASSWORD"

seta timelimit 15 // Game time limit in minutes
seta fraglimit 25 // Frag score limit

seta g_gametype 0 // Set the game type (0: FFA, 1: Tourney, 2: FFA, 3: TD, 4: CTF)
seta g_friendlyFire 0 // Enable/disable friendly fire
seta g_teamAutoJoin 0 // Enable/disable auto team join for team games
seta g_teamForceBalance 1 // Enable auto team balancing
seta g_inactivity 300 // Kick player after period of inactivity in seconds (e.g. 300 = 5 minutes)
seta g_doWarmup 1 // Enable/disable warmup
seta g_warmup 15 // Warmup duration in seconds

// Map cycle
set map1 "map Q3DM1; set nextmap vstr map2"
set map2 "map Q3DM2; set nextmap vstr map3"
set map3 "map Q3TOURNEY1; set nextmap vstr map4"
set map4 "map Q3DM4; set nextmap vstr map5"
set map5 "map Q3DM5; set nextmap vstr map6"
set map6 "map Q3DM6; set nextmap vstr map7"
set map7 "map Q3TOURNEY2; set nextmap vstr map1"
vstr map1

// Bots
seta bot_enable 1 // Enable/disable bots
seta bot_nochat 1 // Enable/disable bot chatting
seta g_spskill 2 // Set the bot skill level
seta bot_minplayers 8 // Set minimum number of players on the server, if there are less than that bots will fill in the empty player slots
```

You can find more detailed server configuration instructions here: https://www.quake3world.com/q3guide/servers.html

### Run the image:

```
docker run -p 27960:27960/udp -d -v /path/to/your/pak0.pk3:/data/pak0.pk3 -v /path/to/your/server.cfg:/data/server.cfg spikly/q3syn:latest
```

You can easily run multiple servers by changing the port number you map to the container. For example after running the command above you could then run:

```
docker run -p 27961:27960/udp -d -v /path/to/your/pak0.pk3:/data/pak0.pk3 -v /path/to/another/server.cfg:/data/server.cfg spikly/q3syn:latest
```

which would start another server using a different config accessible through port **27961**.

### Join your server

Open the Quake 3 console and type:

```
\connect YOUR_SERVER_OR_IP
```

Or if running a server on something other than port 27960:

```
\connect YOUR_SERVER_OR_IP:PORT_NUMBER
```
