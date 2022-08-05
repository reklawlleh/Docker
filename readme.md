# **Docker tModLoader 1.4 Remote Server container**

## Requirements:
### Server-Side:
- Remote Server (probably works locally too, if Docker is installed)
- docker
- docker-compose (preferable)

## Setup Guide:
###  **Preparation before downloading the repository!**

#### **Mod folder**
If you want to play with mods on the Server, you have to download the Mods first on your side in-game with tModLoader or from the Steam Workshop **AND ENABLE THEM IN-GAME (for the enable.json file)**

- On Windows the mods are located at `C:\Program Files (x86)\Steam\steamapps\workshop\content\1281930`

1. Create a new folder called `mods`
2. Got to `C:\Program Files (x86)\Steam\steamapps\workshop\content\1281930`
3. Copy all the folders inside the `1281930` folder and paste them into the `mods` folder
4. Get the `enable.json` at `C:\Users\USERNAME\Documents\MyGames\Terraria\tModLoader\Mods`
5. Copy and paste the .json file also into the `mods` folder

#### **World files**
If you already have a world and want to use it read the steps below, if not skip this.

- On Windows, Terraria Worlds are saved under `C:\Users\USERNAME\Documents\My Games\Terraria\Worlds` and tModLoader Worlds at `C:\Users\USERNAME\Documents\My Games\Terraria\tModLoader\Worlds`

1. Create a new folder called `worlds` 
2. Got to `C:\Users\USERNAME\Documents\My Games\Terraria\Worlds` or `C:\Users\USERNAME\Documents\My Games\Terraria\tModLoader\Worlds`
3. Copy your world files with the file extension `.twld` and `.wld` and paste them into the `worlds` folder 


(Example: `testWorld.twld`)

### **Server setup**
1. Create a new folder anywhere on your Server for example `/home/YOUR_USERNAME/tmodserver` on Linux
2. Download or copy the repository into the folder with git, wget, curl or WinSCP.
3. Transfer if necessary your `mods` and `worlds` folders from your Host System into the `tmodserver` folder on your server with WinSCP or with the scp command.
4. **Configure serverconfig.txt** 

      The `start-tModLoaderServer.sh` Shell script from tModLoader will automatically read the content of the `serverconfig.txt` file. You need to modify the content inside the config file.

      You can read all the config options on the wiki
      https://terraria.fandom.com/wiki/Server#Server_config_file

      ### **Here you have two options**
      #### **Use your existing world**

      4.1. Open the `serverconfig.txt`

      4.2. Go to the variable `world` and write the name of your existing world inside the path and put the file extension `.wdl` at the end. So that every time the Container starts it will launch automatically this world

      Example:
      ````
      world=/root/.local/share/Terraria/tModLoader/Worlds/YOUR_WORLD_NAME.wdl <- Changed it
      ````
      4.3. Change the other variables above to your liking

      4.4. Save it
      #### **Creating new world**
      4.1. Open the `serverconfig.txt`

      4.2. Go to the variable `worldname` and change the world name to your liking

      4.3. Do this for the other values below

      4.4. Go to the variable `world` and write the name of your new world inside the path and put the file extension `.wdl` at the end. So every time the Container starts it will launch automatically this world

      Example:
      ````
      world=/root/.local/share/Terraria/tModLoader/Worlds/YOUR_WORLD_NAME.wdl <- Changed it
      ````
      4.5. Change the other variables above if necessary 

      4.6. Save it

5. After that make sure you're in the folder with the docker-compose file and run `docker compose build` and `docker compose up -d `
6. The Docker should load/create the world automatically and start the server


### **Note**
- You can open the server console in the container by entering `docker exec -it tmodloader tmux a -t modserver` (you can detach from the console by pressing ctrl + b release the keys and press only d)
- You can bash into the docker container by `docker exec -it tmodloader bash`
- You can change the `serverconfig.txt` anytime, but make sure you build the image again with `docker compose build`
- If you need to disable some mods, open the `enable.json` on your remote server and delete the name of the mod. After that just run `docker compose build` and the server will ignore the mod.

## Issues / Nice to know
- For some reason starting the `start-tModLoaderServer.sh` manually inside the container or as an ENTYPOINT in the Dockerfile throws `./start-tModLoaderServer.sh: 5: ./start-tModLoaderServer.sh: [[: not found`
(i dont know why)
- You need to use the `stdin_open: true tty: true` commands inside docker-compose. If not the container will crash immediately after finishing the server setup with `System.NullReferenceException: Object reference not set to an instance of an object. Terraria.Main.ExecuteCommand(String text, CommandCaller commandCaller) tModLoader\Terraria\Main.cs:line 4661`
- You don't need to install Terraria to run a 1.4 tModServers
- You need `mono-complete` installed on the Linux image to run tModLoader