#!/bin/bash

if [ -f "/tmp/game_scripts" ]; then
    rm "/tmp/game_scripts"
    notify-send -t 3000 "Game Disabled"
    riverctl unmap normal Shift D
    riverctl unmap normal Shift W
else
    touch "/tmp/game_scripts"
    notify-send -t 3000 "Game Enabled"
    riverctl map normal Shift D spawn '~/s-d.sh'
    riverctl map normal Shift W spawn '~/s-w.sh'
fi
