#!/bin/bash

if [ -f "/tmp/toggle-gamemode" ]; then
    rm "/tmp/toggle-gamemode"
    notify-send -t 3000 "Gamemode Disabled"
    riverctl unmap normal Shift D
    riverctl unmap normal Shift W
else
    touch "/tmp/toggle-gamemode"
    notify-send -t 3000 "Gamemode Enabled"
    riverctl map normal Shift D spawn '~/s-d.sh'
    riverctl map normal Shift W spawn '~/s-w.sh'
fi
