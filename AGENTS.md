# AGENTS.md

## What this repo is

A **BlueBuild** project that produces signed OCI container images for a Fedora Atomic Xfce desktop (`ghcr.io/winblues/vauxite`). There is no application code — the "source" is YAML recipe files, build-time shell scripts, and a filesystem overlay. End users install/update via `bootc` or `rpm-ostree rebase`.

## Developer commands (via `just`)

```bash
just build                  # build vauxite image locally (default)
just build vauxite-minimal  # build a specific recipe variant
just build vauxite-base
just test-local             # build + rebase the running system to the local image
just generate-iso           # ISO from the published remote image
just generate-local-iso     # ISO from a locally-built vauxite-base image
```

All local builds pass `--tempdir /var/tmp` to `bluebuild`. This is intentional — `/tmp` on many systems is a size-limited tmpfs; OCI image builds need substantial scratch space. Do not change this.

There are no lint, test, typecheck, or format commands.

## Recipe variants

| Recipe | Purpose |
|---|---|
| `recipes/vauxite.yml` | Full image (dev tools, QEMU/libvirt, tailscale, etc.) |
| `recipes/vauxite-minimal.yml` | Minimal image (base + Xfce, less bloat) |
| `recipes/vauxite-base.yml` | Bare Fedora Xfce Atomic, used as ISO installer base only |
| `recipes/vauxite-next.yml` | Rawhide variant — **not built in CI** (workflow is `.disabled`) |

## Key directories

- `recipes/` — one YAML file per image variant; the main entry point
- `files/system/` — filesystem overlay copied to `/` inside the image at build time
- `files/scripts/` — build-time shell scripts run inside the container during image build
- `files/installers/` — overlay used only in `vauxite-base` for the ISO installer
- `modules/` — custom BlueBuild modules (currently empty; only `.gitkeep`)
- `packages/skippy-xd/` — RPM spec for skippy-xd, built separately in COPR `ledif/skippy-xd`

## Non-obvious build quirks

- **Repo files are shipped enabled, then disabled**: `.repo` files under `files/system/etc/yum.repos.d/` have `enabled=1` so `dnf5` can pull packages during build. `files/scripts/10-core.sh` flips them to `enabled=0` before the image is finalized. Do not remove that step.

- **`chezmoi` and `xfconf-profile` binaries are curl-downloaded** at build time in `11-main.sh` from GitHub `latest` releases — no pinned version. Builds can be non-reproducible if upstream changes.

- **`fusuma` is installed as a Ruby gem** (`gem install fusuma`) and symlinked to `/usr/bin/fusuma`. This is unconventional for an OS image but intentional.

- **Terra repo is transient**: added in `11-main.sh` to install `flatpost` and nerd fonts, then immediately disabled with `dnf5 config-manager setopt "terra*".enabled=false`.

- **`vauxite-next.yml`** uses `image-version: rawhide` and its CI workflow is `.disabled` — it exists for local experimentation but is not maintained in CI.

- **Duplicate package entries in `vauxite.yml`**: several RPMs (`podman-compose`, `podman-machine`, `qemu*`, `strace`) appear twice in the `rpm-ostree` install list. This is a known copy-paste artifact; it does not cause failures.

## CI

- `build.yml`: builds all three active variants in a matrix on push to `main`, PRs, daily schedule (06:00 UTC), and manual dispatch. Uses `blue-build/github-action@v1.11`. Images are signed with cosign (`SIGNING_SECRET`).
- `build-iso.yml`: builds ISOs weekly (Monday 10:00 UTC) and uploads to Cloudflare R2 (`R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_ENDPOINT`). Upload only runs on `main`.

## Image signing

`cosign.pub` is committed to the repo for verifying published images. The private key is gitignored and stored as the `SIGNING_SECRET` Actions secret. Never commit `cosign.key`.
