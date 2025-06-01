#!/bin/bash

# This script listens for new windows and renames the workspace accordingly
hyprctl --batch 'subscribeevents window' | while read -r line; do
    # Get focused workspace ID
    ws_name=$(hyprctl activeworkspace -j | jq -r '.name')

    # Count number of windows in this workspace
    win_count=$(hyprctl clients -j | jq --arg ws "$ws_name" '[.[] | select(.workspace.name == $ws)] | length')

    # If it's the first window
    if [ "$win_count" -eq 1 ]; then
        # Get class or title of the focused window
        app_name=$(hyprctl activewindow -j | jq -r '.class // .title // "Unnamed"')

        # Format workspace name
        new_name="${ws_name%%:*}: $app_name"

        # Rename workspace
        hyprctl dispatch renameworkspace "$ws_name" "$new_name"
    fi
done

