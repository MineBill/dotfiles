#!/bin/bash
INSTALL_LOCATION="~/.local/share/fonts/"

if [[ $# -ge 2 ]]; then
    if [[ -d "$2" ]]; then
        INSTALL_LOCATION=$2
    else
        echo "$2 is not a valid location"
        echo "Exiting.."
        exit -1
    fi
else
    if [[ ! -d "$INSTALL_LOCATION" ]]; then
        echo "$INSTALL_LOCATION does not exist"
        echo "Should i create it(Y/n)?"
        read $ans
        and=${ans:-y}
        case $ans in
            y)
                mkdir -p $INSTALL_LOCATION
                ;;
            *)
                echo "Exiting.."
                exit 0
                ;;
        esac
    fi
fi

if [[ ! -f "$1" ]]; then
    echo "$1 does not exist."
    echo "Exiting"
    exit -1
fi

ft=$(echo $1 | grep '\..*' -o)

case $ft in 
    .zip)
        echo "Installing zip file to " "\"$INSTALL_LOCATION\""
        unzip $1 -d $INSTALL_LOCATION 1>/dev/null
        ;;
    .tar.gz)
        echo "Installing zip file to " "\"$INSTALL_LOCATION\""
        tar -xvzf $1 -C $INSTALL_LOCATION 1>/dev/null
        ;;
    *)
        echo "Filetype is not supported"
        ;;
esac
