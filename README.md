# Fedora Sway Spin

Sway desktop environment build from Fedora Sway spin.

## tools used

- Nautilus for file explorer
- wiremix for audio
- xdg-terminal-exec
- iwd for networking
- bluetui for bluetooth

## Package removed

- Thunar

## Network

```
sudo systemctl disable --now NetworkManager wpa_supplicant
sudo systemctl enable --now iwd
```

edit `/etc/iwd/main.conf`

```
[General]
EnableNetworkConfiguration=true
```
