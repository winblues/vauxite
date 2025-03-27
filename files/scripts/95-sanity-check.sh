#!/bin/bash

set -euo pipefail

packages=("xfce4-pulseaudio-plugin" "pipewire")

missing=()
for pkg in "${packages[@]}"; do
  if ! rpm -q --quiet "$pkg"; then
    missing+=("$pkg")
  fi
done

if ((${#missing[@]} > 0)); then
  echo "The following packages are missing: ${missing[*]}"
  exit 1
fi
