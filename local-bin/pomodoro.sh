#!/bin/bash
# This grabs the current status from the app
STATUS=$(gnome-pomodoro --status)

if [[ "$STATUS" == *"Paused"* ]]; then
    ICON="⏸"
else
    ICON=""
fi

# Clean up the text to just show time
TIME=$(echo "$STATUS" | grep -oP '\d+:\d+')

# Output JSON for Waybar
echo "{\"text\": \"$ICON $TIME\", \"tooltip\": \"$STATUS\", \"class\": \"$STATUS\"}"
