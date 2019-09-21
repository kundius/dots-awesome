#!/bin/bash

ICON_PATH=~/.config/awesome/icons/redshift.png

case $1 in
    period-changed)
        if [[ "$3" != "none" ]]; then
            exec notify-send --urgency low -i $ICON_PATH "Redshift" "Period changed to $3."
        fi
esac
