#!/bin/bash

TMP=$(mktemp --suffix=.png)
scrot $TMP -o

convert $TMP -scale 10% -scale 1000% $TMP

i3lock -i $TMP
