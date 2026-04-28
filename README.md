<p align="center">
  <img width="400" alt="vauxite" src="https://github.com/user-attachments/assets/abbbe986-7708-4d6a-836a-b837d8a2778e" />
</p>

<p align="center">
  <a href="https://github.com/winblues/vauxite/actions/workflows/build.yml">
    <img src="https://github.com/winblues/vauxite/actions/workflows/build.yml/badge.svg" alt="bluebuild build badge" />
  </a>
</p>

![screenshot](https://blue95.neocities.org/vauxite/screenshot2.png)

## Install

Download [vauxite-base-latest.iso](https://pub-969fbc86b5f24e4d81c6d022e8fd8dde.r2.dev/vauxite-base-latest.iso), flash it to a USB drive and install from there.

Once installed, you can switch to any of the other variants with:

```bash
sudo bootc switch --enforce-container-sigpolicy ghcr.io/winblues/vauxite:latest
```
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
 
