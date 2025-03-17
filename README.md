# vauxite &nbsp; [![bluebuild build badge](https://github.com/winblues/vauxite/actions/workflows/build.yml/badge.svg)](https://github.com/winblues/vauxite/actions/workflows/build.yml)

A modern and lightweight desktop experience based on Fedora Xfce Atomic. Batteries included.

![screenshot](https://blue95.neocities.org/vauxite/screenshot2.png)


## Install

Downloaded [vauxite-base-latest.iso](https://pub-969fbc86b5f24e4d81c6d022e8fd8dde.r2.dev/vauxite-base-latest.iso), flash it to a USB drive and install from there.

Once installed, you can switch to any of the winblues variants either by using the installers present on the desktop, or by manually running `/usr/lib/winblues-rebase`.
### Image Descriptions
| Image | Description |
| ---------- | ----------- |
|`vauxite`| Atomic Xfce with all the bells and whistles. Similar to `bluefin-dx` and `aurora-dx`, the developer experience Universal Blue images |
| `vauxite-minimal` | For those who want the core Universal Blue features (drivers, codecs and automatic updates) but are concerned with "bloat" |
| `vauxite-base` | Upstream Fedora Atomic Xfce, mainly used for creating ISOs |



### From Other Atomic Desktops
If you are currently using a Fedora atomic desktop, you can simply rebase to any of the vauxite images using `rpm-ostree rebase`. For example:

  ```bash
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/winblues/vauxite:latest
  ```

## Shoutouts
- [BlueBuild](https://github.com/blue-build), [Universal Blue](https://github.com/ublue-os) and [Fedora](https://fedoraproject.org)
- The [Xfce](https://www.xfce.org/) team
 
