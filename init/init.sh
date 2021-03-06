#!/bin/bash
# export GTK_USE_PORTAL=1

KEY_REPEAT_RATE_HZ=30
KEY_REPEAT_DELAY_MS=250
PRIMARY_SCREEN=HDMI-0

# xrandr --output DVI-D-0 --auto --left-of HDMI-0
xrandr --output $PRIMARY_SCREEN --primary --mode 1920x1080 --rate 143.98
xinput --set-prop 9 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 9 'libinput Accel Speed' 0.3
xset r rate $KEY_REPEAT_DELAY_MS $KEY_REPEAT_RATE_HZ
setxkbmap -layout us,gr -option grp:alt_caps_toggle

sh ~/.config/plasma-workspace/env/paths.sh &
sh ~/.config/polybar/launch.sh &
picom --experimental-backends &
nitrogen --restore &
lxsession &
dunst &
