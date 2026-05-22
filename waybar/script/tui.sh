#!/bin/bash

case "$1" in
audio)
  xdg-terminal-exec wiremix
  ;;
update)
  xdg-terminal-exec sudo dnf upgrade --refresh
  ;;
*)
  echo "Usage: $0 {audio|update}"
  exit 1
  ;;
esac
