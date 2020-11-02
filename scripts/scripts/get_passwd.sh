#!/bin/bash

passwd=$(secret-tool lookup keepass passwd)
dbpath=$(secret-tool lookup keepass dbpath)
entry=$(echo $passwd | keepassxc-cli ls ~/$dbpath Default | sed ':a;N;$!ba;s/\n/|/g' | rofi -sep "|" -dmenu -i -p 'Select' -theme custom)

echo $passwd | keepassxc-cli clip ~/$dbpath Default/$entry

notify-send "Password copied!" -t 1000
