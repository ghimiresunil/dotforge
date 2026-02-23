#!/bin/bash

# Get mute status of default mic source (yes or no)
mute_status=$(pactl get-source-mute @DEFAULT_SOURCE@)

if [[ "$mute_status" == "Mute: yes" ]]; then
    echo "🎤 ❌"  # Mic muted
else
    echo "🎤 ✅"  # Mic unmuted
fi
