#!/bin/bash

SCREENSHOTS_DIR=~/shots
ICON_PATH=~/.config/awesome/icons/screenshot.png
TIMESTAMP="$(date +%Y.%m.%d-%H.%M.%S)"
FILENAME=$SCREENSHOTS_DIR/$TIMESTAMP.screenshot.png

# Make screenshots directory if it does not exists
if [ ! -d "$SCREENSHOTS_DIR" ]; then
    mkdir $SCREENSHOTS_DIR
fi

if [[ "$1" = "-s" ]]; then
    # Area/window selection
    notify-send "Select area to capture." --urgency low -i $ICON_PATH -t 1500
    scrot -s $FILENAME -q 95
    if [[ "$?" = "0" ]]; then
        notify-send "Screenshot taken." --urgency low -i $ICON_PATH
    fi
else
    # Fullscreen shot
    scrot $FILENAME -q 95
    notify-send "Screenshot taken." --urgency low -i $ICON_PATH
fi
