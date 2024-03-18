#!/bin/bash

# Function to configure server properties
configure_properties() {
    echo "max-players=$MAX_PLAYERS" >> server.properties
    echo "motd=$MOTD" >> server.properties
    echo "hardcore=$HARDCORE" >> server.properties
    echo "difficulty=$DIFFICULTY" >> server.properties
    echo "view-distance=$VIEW_DISTANCE" >> server.properties
    echo "level-seed=$LEVEL_SEED" >> server.properties
}

# Check if offline mode is enabled
offline_mode() {
    if [[ "$1" == "true" ]]; then
        echo "online-mode=false" >> server.properties
    else
        echo "online-mode=true" >> server.properties
    fi
}

# User Inputs
read -p "Enter Minecraft Version: " MINECRAFT_VERSION
read -p "Enter max players (Optional): " MAX_PLAYERS
read -p "Enter MOTD (Optional): " MOTD
read -p "Enter hardcore mode (true/false, Optional): " HARDCORE
read -p "Enter difficulty (Optional): " DIFFICULTY
read -p "Enter view distance (Optional): " VIEW_DISTANCE
read -p "Enter level seed (Optional): " LEVEL_SEED
read -p "Enable offline mode? (true/false, Optional): " OFFLINE_MODE

# Set default values if not provided
MAX_PLAYERS=${MAX_PLAYERS:-20}
MOTD=${MOTD:-"Welcome to Enderman's server."}
HARDCORE=${HARDCORE:-false}
DIFFICULTY=${DIFFICULTY:-normal}
VIEW_DISTANCE=${VIEW_DISTANCE:-10}
LEVEL_SEED=${LEVEL_SEED:-}
OFFLINE_MODE=${OFFLINE_MODE:-false}

# Constants
PROJECT="paper"
SERVER_DIR="enderman"
SERVER_JAR="server.jar"

# Fetch the latest version and build information from PaperMC API
LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/${PROJECT} | \
    jq -r '.versions[-1]')
LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

# Construct URL for downloading PaperMC server JAR
JAR_NAME=${PROJECT}-${LATEST_VERSION}-${LATEST_BUILD}.jar
PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${LATEST_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"

# Create server directory if it doesn't exist
mkdir -p "$SERVER_DIR"
cd "$SERVER_DIR" || exit

# Copy server-icon.png to server directory
cp /path/to/server-icon.png "$SERVER_DIR"

# Download the latest PaperMC version
curl -o "$SERVER_JAR" "$PAPERMC_URL"
echo "Downloads completed"

# Configure server properties
configure_properties

# Accept Minecraft EULA
echo "eula=true" > eula.txt

# Configure offline mode if specified
offline_mode "$OFFLINE_MODE"

echo  "PLEASE READ THE INSTRUCTIONS
First, run the command 
\"java -jar server.jar\" 
and wait for the \"Done\" message before closing the server. 
Then, install essential plugins by running 
\"cd .. ; ./server-essentials.sh\" 
(Goes parent directory and runs source server-essentials.sh)
and following the on-screen instructions. 

If you don't have a Playit account, create one by clicking on the provided links. Finally, remember to run 
\"java -jar server.jar\" 
to start your server, ensuring that you are in the 'enderman' directory."