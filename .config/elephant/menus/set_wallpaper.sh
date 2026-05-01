#!/bin/bash

# $1 represents the file path passed from the Lua menu
WALLPAPER="$1"

# Run the wallpaper daemon in the background
awww img "$WALLPAPER" --transition-type random --transition-step 90 &

# Run the Aether theme generator
aether -g "$WALLPAPER"
