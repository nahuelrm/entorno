#! /usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done


# First Monitor

polybar primary-bar -c ~/.config/polybar/config.ini &
polybar primary-widgets -c ~/.config/polybar/config.ini &

# Second Monitor

polybar secondary-bar -c ~/.config/polybar/config.ini &
polybar secondary-widgets -c ~/.config/polybar/config.ini &
