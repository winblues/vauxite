#!/bin/bash
if [[ "$(rpm -E %fedora)" -gt 41 ]]; then
  dnf5 -y copr enable ublue-os/staging
  dnf5 -y swap --repo='copr:copr.fedorainfracloud.org:ublue-os:staging' \
    rpm-ostree rpm-ostree
  dnf5 versionlock add rpm-ostree
  dnf5 -y copr disable ublue-os/staging
fi
