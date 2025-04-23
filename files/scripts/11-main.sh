#!/bin/bash

set -ouex pipefail

# TODO: use systemd-tmpfiles for this
echo "KillUserProcesses=yes" >>/usr/lib/systemd/logind.conf

curl -L -o /usr/bin/xfconf-profile https://github.com/winblues/xfconf-profile/releases/latest/download/xfconf-profile-linux-amd64
chmod +x /usr/bin/xfconf-profile

curl -L -o /usr/bin/chezmoi https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-linux-amd64
chmod +x /usr/bin/chezmoi

gem install fusuma --no-document --install-dir /usr/lib/ruby/gems/fusuma
ln -s /usr/lib/ruby/gems/fusuma/bin/fusuma /usr/bin/fusuma

dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release{,-extras}
dnf5 -y install flatpost
dnf5 -y config-manager setopt "terra*".enabled=false

systemctl preset-all
systemctl --global preset-all
