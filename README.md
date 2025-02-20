# vauxite &nbsp; [![bluebuild build badge](https://github.com/winblues/vauxite/actions/workflows/build.yml/badge.svg)](https://github.com/winblues/vauxite/actions/workflows/build.yml)

A modern and lightweight desktop experience Fedora Atomic Xfce. Batteries included.

![screenshot](https://blue95.neocities.org/vauxite/screenshot.png)

## From Other Atomic Desktops
If you are currently using an atomic desktop, you can rebase to the latest vauxite image.

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/winblues/vauxite:latest
  ```
- Reboot and then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/winblues/vauxite:latest
  ```
It is recommended to create a new user after rebasing.

## Shoutouts
- [BlueBuild](https://github.com/blue-build), [Universal Blue](https://github.com/ublue-os) and [Fedora](https://fedoraproject.org)
- The [Xfce](https://www.xfce.org/) team
 
