#!/bin/bash

PLUGIN_URL="https://github.com/playit-cloud/playit-minecraft-plugin/releases/latest/download/playit-minecraft-plugin.jar"
PLUGIN_DIR="enderman/plugins"

# Create the plugins directory if it doesn't exist
mkdir -p "$PLUGIN_DIR"

# Download the plugin directly to the plugins directory
curl -sSL "$PLUGIN_URL" -o "$PLUGIN_DIR/playit-minecraft-plugin.jar"

echo "Playit.gg downloaded and added to the server."