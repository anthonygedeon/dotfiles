#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=$HOME/.config/polybar/config.ini --reload mybar &
  done
else
  polybar --config=$HOME/.config/polybar/config.ini --reload mybar &
fi

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
/usr/bin/polybar --config=$HOME/.config/polybar/config.ini mybar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
