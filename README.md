# Minecraft-Server-Everywhere 🌐
With these scripts, you can run your server on any cloud console like Google Cloud

(This requires suitable JRE to be installed on the server)
Clone this repository and change the current-working directory to this directory.
First of all, run
```bash
chmod +x server-setup.sh server-essentials.sh
```
This command will make scripts as independent executables.

After running the above commands, run these commands in order. <br>
```
./server-setup.sh
# This command asks for some required and optional details about the server and give further instructions to setup server
```
The command written below installs Playit.gg plugin to `enderman/plugins`
```
./server-essentials
```

## Now, you're almost ready to play ⛏
Run the below commmand whenever you want to run the server

```
java -jar server.jar
```
