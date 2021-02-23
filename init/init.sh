#!/bin/bash
#export SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
export GTK_USE_PORTAL=1

KEY_REPEAT_RATE_HZ=30
KEY_REPEAT_DELAY_MS=250
PRIMARY_SCREEN=HDMI-0

#echo "LoadTheme $SCRIPTPATH/theme.toml" > $XDG_RUNTIME_DIR/leftwm/commands.pipe

#imwheel
xrandr --output $PRIMARY_SCREEN --primary --mode 1920x1080 --rate 143.98
xinput --set-prop 9 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 9 'libinput Accel Speed' 0.3
xset r rate $KEY_REPEAT_DELAY_MS $KEY_REPEAT_RATE_HZ
setxkbmap -layout us,gr -option grp:alt_caps_toggle

picom --experimental-backends &
nitrogen --restore
~/.config/polybar/launch.sh --forest &
lxsession &
clipmenud &
mpd

#pulseeffects --gapplication-service &
#dunst
