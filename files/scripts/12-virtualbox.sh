#!/usr/bin/env bash

set -ouex pipefail


# get current Fedora version
RELEASE="$(rpm -E %fedora)"

# search installed rpm packages for kernel to get version; `uname -r` does not work in a container environment
KERNEL_VER="$(rpm -qa | grep -E 'kernel-[0-9].*?[.\\-]ba' | cut -d'-' -f2,3)"
# install dkms
dnf install -y dkms
# get latest version number of VirtualBox
VIRTUALBOX_VER="$(curl -L https://download.virtualbox.org/virtualbox/LATEST.TXT)"
# URL to list of VirtualBox packages for latest version
VIRTUALBOX_VER_URL="https://download.virtualbox.org/virtualbox/$VIRTUALBOX_VER/"
# get all available VirtualBox Fedora rpm packages, sorted descending, and loop through them
VIRTUALBOX_RPMS="$(curl -L "$VIRTUALBOX_VER_URL" | grep -E -o 'VirtualBox.+?fedora[0-9]+?-.+?\.x86_64\.rpm' | sed -E -e 's/">.*//' | sort -Vr)"
for _VIRTUALBOX_RPM in $VIRTUALBOX_RPMS; do
  # extract the Fedora version from the file name
  FEDORA_VERSION="$(echo $_VIRTUALBOX_RPM | grep -E -o 'fedora[0-9]+' | grep -E -o '[0-9]+')"
  # if <= $RELEASE, break
  if [[ "$FEDORA_VERSION" -le "$RELEASE" ]]; then
    VIRTUALBOX_RPM="$_VIRTUALBOX_RPM"
    break
  fi
done
# URL to VirtualBox rpm
VIRTUALBOX_RPM_URL="$VIRTUALBOX_VER_URL$VIRTUALBOX_RPM"
echo "Using '$VIRTUALBOX_RPM_URL' for Fedora $RELEASE"
# download VirtualBox rpm
curl -L -o "/tmp/$VIRTUALBOX_RPM" "https://download.virtualbox.org/virtualbox/$VIRTUALBOX_VER/$VIRTUALBOX_RPM"
# install VirtualBox
dnf install -y "/tmp/$VIRTUALBOX_RPM"
# Insert hardcoded kernel version in VirtualBox scripts where necessary to get
# kernel modules to build. Without doing this, VirtualBox attempts to build the
# kernel modules for the kernel the GitHub runner host is running on.
# There may be a better way to do this, but since this is an atomic system
# anyway and these scripts don't persist across updates, it should not be an
# issue unless the kernel is changed downstream from here.
vbox_hardcode_kv () {
  local TARGET_FILE="$1"
  # sed expression to replace "uname -r" with "echo '[kernel version]'"
  local EXPR_UNAME_R="s/uname -r/echo '$KERNEL_VER'/g"
  # sed expression to replace "depmod -a" with "depmod -v '[kernel version]' -a"
  local EXPR_DEPMOD_A="s/depmod -a/depmod -v '$KERNEL_VER' -a/g"
  sed -i -e "$EXPR_UNAME_R" -e "$EXPR_DEPMOD_A" "$TARGET_FILE"
}
vbox_hardcode_kv /usr/lib/virtualbox/vboxdrv.sh
vbox_hardcode_kv /usr/lib/virtualbox/check_module_dependencies.sh
# run vboxconfig with KERN_VER set to build kernel modules
KERN_VER="$KERNEL_VER" /sbin/vboxconfig
# cat vbox log if it exists
if [[ -e /var/log/vbox-setup.log ]]; then
  cat /var/log/vbox-setup.log
fi
# extension pack file name
EXTPACK_NAME="Oracle_VirtualBox_Extension_Pack-$VIRTUALBOX_VER.vbox-extpack"
# sha256 sums URL
SUMS_URL="${VIRTUALBOX_VER_URL}SHA256SUMS"
# sha256 for extpack file
HASH="$(curl -L $SUMS_URL | grep $EXTPACK_NAME | cut -d' ' -f1)"
# extension pack URL
EXTPACK_URL="${VIRTUALBOX_VER_URL}${EXTPACK_NAME}"
# download and install extension pack
EXTPACK_PATH="/tmp/extpack.vbox-extpack"
curl -L -o $EXTPACK_PATH "$EXTPACK_URL"
/usr/lib/virtualbox/VBoxExtPackHelperApp install \
  --base-dir /usr/lib/virtualbox/ExtensionPacks \
  --cert-dir /usr/share/virtualbox/ExtPackCertificates \
  --name "Oracle VirtualBox Extension Pack" \
  --tarball $EXTPACK_PATH \
  --sha-256 $HASH

mkdir -p /usr/lib/modules-load.d
cat > /usr/lib/modules-load.d/bazzite-virtualbox.conf << EOF
# load virtualbox kernel drivers
vboxdrv
vboxnetflt
vboxnetflt
EOF
