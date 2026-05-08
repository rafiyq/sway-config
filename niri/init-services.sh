#!/bin/sh

# Configures systemd user dependencies for the Niri compositor.
# Ensures background services start automatically with Niri.
#
# Requires:     mako, waybar, elephant, swaybg, swayidle
# Recommends:   walker

# List of services to link to niri.service
SERVICES="
    mako.service
    waybar.service
    elephant.service
    swaybg.service
    niri-swayidle.service
"

# Loop through the list and add each as a 'wants' dependency
for service in $SERVICES; do
    systemctl --user add-wants niri.service "$service"
done

echo "-------------------------------------------------------"
echo "Configuration complete!"
echo "Verify with: systemctl --user list-dependencies niri.service"
