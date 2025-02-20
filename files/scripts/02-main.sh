#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

systemctl enable rpm-ostreed-automatic.timer

# skippy-xd
curl -Lo /etc/yum.repos.d/_copr_ledif-blue95.repo https://copr.fedorainfracloud.org/coprs/ledif/skippy-xd/repo/fedora-"${RELEASE}"/ledif-skippy-xd-fedora-"${RELEASE}".repo
dnf install -y skippy-xd
systemctl --global enable skippy-xd.service
echo "KillUserProcesses=yes" >>/usr/lib/systemd/logind.conf

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/ublue-os-staging-fedora-41.repo
