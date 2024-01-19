#!/usr/bin/env bash
#
# This file is part of the OrangeFox Recovery Project
# Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
# OrangeFox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# OrangeFox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# This software is released under GPL version 3 or any later version.
# See <http://www.gnu.org/licenses/>.
#
# Please maintain this if you use this script or any part of it

# CCACHE
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_MAXSIZE="32G"
export CCACHE_DIR="/mnt/ccache"

# Warn if CCACHE_DIR is an invalid directory
if [ ! -d "${CCACHE_DIR}" ]; then
  echo "CCACHE Directory/Partition is not mounted at \"${CCACHE_DIR}\""
  echo "Please edit the CCACHE_DIR build variable or mount the directory."
fi

export LC_ALL="C"

FDEVICE="rosemary"
#set -o xtrace

fox_get_target_device() {
  local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
  if [ -n "$chkdev" ]; then
    FOX_BUILD_DEVICE="$FDEVICE"
  else
    chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
    [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
  fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
  fox_get_target_device
fi

# Dirty Fix: Only declare orangefox vars when needed
if [ -f "$(gettop)/bootable/recovery/orangefox.cpp" ]; then
  echo -e "\x1b[96m[INFO]: Setting up OrangeFox build vars for rosemary...\x1b[m"
  if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export FOX_USE_SPECIFIC_MAGISK_ZIP="$(gettop)/device/redmi/rosemary/Magisk/Magisk.zip"
    export BUNDLED_MAGISK_VER="26.4"
    export BUNDLED_MAGISK_SUM="543a96fe26c012d99baf3a3aa5a97b80508d67cc641af7c12ce9f7b226b2b889" # Sha256 sum of the prebuilt magisk
    if [ -f "${FOX_USE_SPECIFIC_MAGISK_ZIP}" -a "$(sha256sum "${FOX_USE_SPECIFIC_MAGISK_ZIP}" 2>/dev/null | awk '{print $1}')" != "${BUNDLED_MAGISK_SUM}" ]; then
      echo -e "\e[96m[INFO]: Removing invalid magisk zip\e[m"
      rm -v "${FOX_USE_SPECIFIC_MAGISK_ZIP}"
    fi

    if [ ! -f "${FOX_USE_SPECIFIC_MAGISK_ZIP}" ]; then
      # Download prebuilt magisk for OrangeFox builds
      echo -e "\e[96m[INFO]: Downloading Magisk v${BUNDLED_MAGISK_VER}\e[m"

      if [ "$(command -v "curl")" ]; then
        if [ ! -d "$(dirname "${FOX_USE_SPECIFIC_MAGISK_ZIP}")" ]; then
          mkdir -p "$(dirname "${FOX_USE_SPECIFIC_MAGISK_ZIP}")"
        fi

        # Download magisk and verify it
        curl -L --progress-bar "https://github.com/topjohnwu/Magisk/releases/download/v${BUNDLED_MAGISK_VER}/Magisk-v${BUNDLED_MAGISK_VER}.apk" -o "${FOX_USE_SPECIFIC_MAGISK_ZIP}"
        DOWNLOADED_SUM="$(sha256sum "${FOX_USE_SPECIFIC_MAGISK_ZIP}" | awk '{print $1}')"

        if [ "${DOWNLOADED_SUM}" != "${BUNDLED_MAGISK_SUM}" ]; then
          echo -e "\e[91m[ERROR]: Downloaded Magisk ZIP seems *corrupted*, removing it to protect user's safety\e[m"
          rm "${FOX_USE_SPECIFIC_MAGISK_ZIP}"
          unset "FOX_USE_SPECIFIC_MAGISK_ZIP"
        else
          echo -e "\e[96m[INFO]: Downloaded Magisk v${BUNDLED_MAGISK_VER}\e[m"
        fi
      else
        # Curl is supposed to be installed according to "Establishing a build environnement" section in AOSP docs
        # If it isn't, warn the builder about it and fallback to default Magisk ZIP
        echo -e "\e[91m[ERROR]: Curl not found!\e[m"
        unset "FOX_USE_SPECIFIC_MAGISK_ZIP"
      fi
    fi
  fi
fi
