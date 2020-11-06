#!/bin/bash
KEY_REPEAT_RATE_HZ=50
KEY_REPEAT_DELAY_MS=250
PRIMARY_SCREEN=HDMI-0

imwheel
xrandr --output $PRIMARY_SCREEN --primary --mode 1920x1080 --rate 143.98
xinput --set-prop 9 'libinput Accel Profile Enabled' 0, 1
xset r rate $KEY_REPEAT_DELAY_MS $KEY_REPEAT_RATE_HZ
setxkbmap -layout us,gr -option grp:alt_caps_toggle

mpd
nitrogen --restore
dunst
lxsession &
clipmenud &
picom --experimental-backends &
pulseeffects --gapplication-service &
~/.config/polybar/launch.sh &
#~/.config/i3/alternating_layouts.py &
