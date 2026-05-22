#!/bin/bash

# usage: notif.sh {status|toggle} [-q|--quiet]
#
# This script can serve both waybar (JSON, quiet default)
# and interactive terminal (text, --quiet to suppress text).

QUIET=${QUIET:-0}

# Detect which notification daemon is currently running
if pgrep -x "dunst" >/dev/null; then
    DAEMON="dunst"
    ICON_ON="󰂞"
    ICON_OFF="󰂛"
elif pgrep -x "mako" >/dev/null; then
    DAEMON="mako"
    ICON_ON="󰂞"
    ICON_OFF="󰂛"
else
    if [ "$QUIET" = "0" ]; then
        echo '{"text": "󰂛", "tooltip": "No notification daemon running", "class": "error"}'
    fi
    exit 1
fi

# Function to check the current status
get_status() {
    if [ "$DAEMON" = "dunst" ]; then
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo "off"
        else
            echo "on"
        fi
    elif [ "$DAEMON" = "mako" ]; then
        if makoctl mode 2>/dev/null | grep -q "dnd"; then
            echo "off"
        else
            echo "on"
        fi
    fi
}

case "$1" in
status)
    status=$(get_status)
    if [ "$QUIET" = "0" ]; then
        if [ "$status" = "off" ]; then
            echo "{\"text\": \"$ICON_OFF\", \"tooltip\": \"Notifications silenced ($DAEMON)\", \"class\": \"off\"}"
        else
            echo "{\"text\": \"$ICON_ON\", \"tooltip\": \"Notifications active ($DAEMON)\", \"class\": \"on\"}"
        fi
    fi
    ;;
toggle)
    status=$(get_status)
    if [ "$status" = "on" ]; then
        if [ "$DAEMON" = "dunst" ]; then
            dunstctl set-paused true
        else
            makoctl mode -a dnd >/dev/null 2>&1
        fi
        if [ "$QUIET" = "0" ]; then
            echo "{\"text\": \"$ICON_OFF\", \"tooltip\": \"Notifications silenced ($DAEMON)\", \"class\": \"off\"}"
        fi
    else
        if [ "$DAEMON" = "dunst" ]; then
            dunstctl set-paused false
        else
            makoctl mode -r dnd >/dev/null 2>&1
        fi
        if [ "$QUIET" = "0" ]; then
            echo "{\"text\": \"$ICON_ON\", \"tooltip\": \"Notifications active ($DAEMON)\", \"class\": \"on\"}"
        fi
    fi
    if [ "$QUIET" = "1" ]; then
        echo "Toggled notifications ($DAEMON)."
    fi
    ;;
*)
    echo "Usage: $0 {status|toggle}"
    exit 1
    ;;
esac
