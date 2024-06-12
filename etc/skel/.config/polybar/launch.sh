#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done



# Launch bar1 and bar2
polybar -c $HOME/.config/polybar/bars/dark-config nord-top &
polybar -c $HOME/.config/polybar/bars/dark-config nord-down &
if [[ $(xrandr -q | grep 'HDMI' | grep -w 'connected' | wc -l) = 1 ]]
then
    polybar -c $HOME/.config/polybar/bars/dark-config nord-top-external &
    polybar -c $HOME/.config/polybar/bars/dark-config nord-down-external &
    polybar -c $HOME/.config/polybar/bars/dark-config nord-top-extra &
fi

echo "Bars launched..."
