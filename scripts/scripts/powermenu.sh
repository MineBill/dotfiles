#!/bin/bash


selection=$(echo "Logout|Lock|Sleep|Restart|Shutdown" | rofi -sep "|" -dmenu -i -p 'Select')

case $selection in
    Logout)
        wm=$(wmctrl -m | head -1 | awk '{print $2}')
        case wm in
            xmonad)
                xmonadctl 39
                ;;
            i3)
                i3-msg exit
                ;;
            *)
                ;;
        esac
        ;;
    Lock)
        ~/scripts/lock.sh
        ;;
    Sleep)
        s2ram --force
        ;;
    Restart)
        shutdown -r now
        ;;
    Shutdown)
        shutdown now
        ;;
    *)
        notify-send "Invalid action '$selection'"
        ;;
esac
