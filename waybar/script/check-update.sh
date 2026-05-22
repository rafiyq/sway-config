#!/bin/bash

# check-update.sh - Check for available system updates
# Returns JSON for waybar consumption

# Try dnf5 first, fall back to dnf
CHECK_CMD="dnf check-update -q"
if command -v dnf5 >/dev/null 2>&1; then
    CHECK_CMD="dnf5 check-update -q"
fi

# Run check quietly
$CHECK_CMD &>/dev/null
STATUS=$?

if [ $STATUS -eq 100 ]; then
    # Updates are available
    echo '{"text": "", "tooltip": "Updates are available! Click to update.", "class": "warning"}'
    exit 0
elif [ $STATUS -eq 0 ]; then
    # System is up to date
    echo '{"text": "", "tooltip": "System is up to date", "class": "good"}'
    exit 0
else
    # Error occurred
    echo '{"text": "󰇚", "tooltip": "Update check failed", "class": "critical"}'
    exit 0
fi
