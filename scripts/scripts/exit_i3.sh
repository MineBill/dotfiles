#!/bin/sh
action=$(kdialog --menu "Select action" shutdown "Shutdown" restart "Restart" logout "Logout" lock "Lock")

if [[ $? == 0 ]]; then
    case $action in
        logout)
            i3-msg exit
            ;;
        shutdown)
            shutdown now
            ;;
        restart)
            shutdown -r now
            ;;
        lock)
            notify-send "Not implemented" "Locking is not currently implemented" -t 1500
            ;;
    esac
fi
