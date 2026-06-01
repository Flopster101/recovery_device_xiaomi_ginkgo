#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# For building with minimal manifest
export ALLOW_MISSING_DEPENDENCIES=true

# OrangeFox
export FOX_REPLACE_TOOLBOX_GETPROP=1
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_USE_LZMA_COMPRESSION=1
export OF_FL_PATH1=/sys/class/leds/flashlight/brightness
export OF_SCREEN_H=2340
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_HIDE_NOTCH=1
export OF_CLOCK_POS=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1

# Branch/Variant
export FOX_VARIANT="A12"
export OF_USE_GREEN_LED=0

# Persistence/Settings
export FOX_SETTINGS_ROOT_DIRECTORY="/cache"
export FOX_MISCELLANEOUS_ROOT_DIRECTORY="/cache"

# Additional Fox vars
export TARGET_DEVICE_ALT="willow"
export OF_USE_NTFS_3G=1
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export FOX_DELETE_AROMAFM=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_REMOVE_AAPT=1
export LC_ALL="C"
