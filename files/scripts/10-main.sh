#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

systemctl enable rpm-ostreed-automatic.timer

# skippy-xd
if systemctl list-unit-files skippy-xd.service; then
  systemctl --global enable skippy-xd.service
  echo "KillUserProcesses=yes" >>/usr/lib/systemd/logind.conf
fi

curl -L -o /usr/bin/xfconf-profile https://github.com/winblues/xfconf-profile/releases/latest/download/xfconf-profile-linux-amd64
chmod +x /usr/bin/xfconf-profile

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/ublue-os-staging-fedora-41.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/ledif-skippy-xd-fedora-41.repo
