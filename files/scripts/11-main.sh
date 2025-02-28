#!/bin/bash

set -ouex pipefail

systemctl --global enable skippy-xd.service
echo "KillUserProcesses=yes" >>/usr/lib/systemd/logind.conf

curl -L -o /usr/bin/xfconf-profile https://github.com/winblues/xfconf-profile/releases/latest/download/xfconf-profile-linux-amd64
chmod +x /usr/bin/xfconf-profile

gem install fusuma
