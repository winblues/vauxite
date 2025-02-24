#!/bin/bash

set -ouex pipefail

dnf5 install -y ublue-os-udev-rules ublue-os-update-services ublue-os-signing ublue-os-luks ublue-os-just
