#!/bin/bash

case "$1" in
audio)
  xdg-terminal-exec wiremix
  ;;
bluetooth)
  xdg-terminal-exec bluetui
  ;;
network)
  xdg-terminal-exec impala
  ;;
update)
  xdg-terminal-exec sudo dnf upgrade --refresh
  ;;
*)
  echo "Usage: $0 {audio|bluetooth|network|update}"
  exit 1
  ;;
esac
