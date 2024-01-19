#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2023 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#


# Version / Maintainer infos
OF_MAINTAINER := Troublescope
FOX_VARIANT := A13+
FOX_BUILD_TYPE := Stable
    
# Device info
FOX_AB_DEVICE := 1
FOX_VIRTUAL_AB_DEVICE := 1
TARGET_DEVICE_ALT := secret, maltose

OF_SCREEN_H := 2400
OF_STATUS_H := 100
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1 # left and right clock positions available
OF_USE_GREEN_LED := 0
OF_FL_PATH1 := /tmp/flashlight # See /init.recovery.mt6785.rc for more information
		

# lib Tools
FOX_USE_BASH_SHELL := 1
#FOX_USE_NANO_EDITOR := 1
#FOX_USE_TAR_BINARY := 1
#FOX_USE_SED_BINARY := 1
FOX_USE_XZ_UTILS := 1
#FOX_ASH_IS_BASH := 1
OF_ENABLE_LPTOOLS := 1

# OTA / DM-Verity / Encryption
OF_DISABLE_MIUI_OTA_BY_DEFAULT := 1
OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR := 1

# Dm-verity
OF_DONT_PATCH_ON_FRESH_INSTALLATION := 1
OF_KEEP_DM_VERITY_FORCED_ENCRYPTION := 1
OF_SKIP_FBE_DECRYPTION_SDKVERSION := 35
OF_UNBIND_SDCARD_F2FS := 1
OF_DONT_PATCH_ENCRYPTED_DEVICE := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_SKIP_MULTIUSER_FOLDERS_BACKUP := 1
OF_DEFAULT_KEYMASTER_VERSION := 4.1

# Other OrangeFox configs  
OF_ALLOW_DISABLE_NAVBAR := 0
OF_QUICK_BACKUP_LIST := /boot;/data;
FOX_BUGGED_AOSP_ARB_WORKAROUND := 1546300800
FOX_DELETE_AROMAFM := 1

# Logging
OF_LOOP_DEVICE_ERRORS_TO_LOG := 1
