#!/bin/bash

set -ouex pipefail

systemctl enable rpm-ostreed-automatic.timer

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/ublue-os-staging-fedora-41.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/ledif-skippy-xd-fedora-41.repo
