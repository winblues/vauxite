#!/bin/bash

set -ouex pipefail

systemctl --global enable skippy-xd.service
echo "KillUserProcesses=yes" >>/usr/lib/systemd/logind.conf

curl -L -o /usr/bin/xfconf-profile https://github.com/winblues/xfconf-profile/releases/latest/download/xfconf-profile-linux-amd64
chmod +x /usr/bin/xfconf-profile

curl -L -o /usr/bin/chezmoi https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-linux-amd64
chmod +x /usr/bin/chezmoi

gem install fusuma
mv /usr/local/bin/fusuma /usr/bin/fusuma
