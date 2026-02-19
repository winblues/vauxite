#!/bin/bash
set -ouex pipefail

# Clean /tmp
find /tmp -mindepth 1 -maxdepth 1 -delete 2>/dev/null || true

# Clean /var/tmp
find /var/tmp -mindepth 1 -maxdepth 1 -depth -delete 2>/dev/null || true

# Clean DNF caches using find instead of rm
find /var/cache/dnf/ -mindepth 1 -delete 2>/dev/null || true
find /var/cache/dnf5/ -mindepth 1 -delete 2>/dev/null || true
find /var/lib/dnf/ -mindepth 1 -delete 2>/dev/null || true
find /run/ -mindepth 1 -delete 2>/dev/null || true

# Clean up Ruby gem cache
find /root/.gem -delete 2>/dev/null || true
find /tmp/ -name "gem*" -delete 2>/dev/null || true

# Clean up stray files for Anaconda installer
find / -maxdepth 1 -name "nvim.root" -delete 2>/dev/null || true
find / -maxdepth 1 -name "dnf" -delete 2>/dev/null || true
find / -maxdepth 1 -name "selinux-policy" -delete 2>/dev/null || true

# Clean up hidden files in current directory (or root if that's where script runs)
find . -maxdepth 1 \( -name ".wget-hsts*" -o -name ".wget-hpkp*" -o -name ".wh.*" -o -name ".*_lck_*" \) -delete 2>/dev/null || true

echo "cleanup done"
