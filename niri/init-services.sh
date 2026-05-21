#!/bin/sh

# Configures systemd user dependencies for the Niri compositor.
# Ensures background services start automatically with Niri.
#
# Usage:    ./init-services.sh
# Requires: mako, waybar, elephant, swaybg, swayidle
#
set -euo pipefail

# Detect script directory for relative service file lookup
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Ensure niri.service exists before adding dependencies
if ! systemctl --user show niri.service --property=ExecStart >/dev/null 2>&1; then
    echo "Error: niri.service not found in user systemd." >&2
    echo "Please ensure Niri is properly installed and its systemd unit exists." >&2
    exit 1
fi

# List of services to link to niri.service
SERVICES="
    elephant.service
    mako.service
    niri-swayidle.service
    swaybg.service
    waybar.service
    walker.service
"

# Track missing services for reporting
MISSING_SERVICES=""

# Ensure all service files exist before adding dependencies
for service in $SERVICES; do
    if ! systemctl --user cat "$service" >/dev/null 2>&1; then
        echo "Warning: $service not found in user systemd." >&2
        MISSING_SERVICES="$MISSING_SERVICES $service"
        continue
    fi

    # Add as a Wants= dependency for niri.service
    systemctl --user add-wants niri.service "$service"
    echo "Linked $service to niri.service"
done

echo "-------------------------------------------------------"

if [ -n "$MISSING_SERVICES" ]; then
    echo "Configuration partially complete with warnings."
    echo "Missing services (not linked):$MISSING_SERVICES"
else
    echo "Configuration complete!"
fi

echo "Verify with: systemctl --user list-dependencies niri.service"
