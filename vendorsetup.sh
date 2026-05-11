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

_ginkgo_apply_recovery_patches() {
    local device_tree
    local recovery_tree
    local patch
    local subject

    device_tree="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    recovery_tree="$(cd "${device_tree}/../../.." && pwd)/bootable/recovery"

    if [ ! -d "${recovery_tree}/.git" ]; then
        echo "Skipping recovery patches: ${recovery_tree} is not a git repository"
        return 0
    fi

    for patch in "${device_tree}"/patches/*.patch; do
        [ -e "${patch}" ] || continue

        subject="$(sed -n 's/^Subject: \[PATCH[^]]*\] //p; s/^Subject: //p' "${patch}" | head -n 1)"
        if [ -n "${subject}" ] && git -C "${recovery_tree}" log --format=%s | grep -Fxq "${subject}"; then
            echo "Recovery patch already applied: $(basename "${patch}")"
            continue
        fi

        if git -C "${recovery_tree}" apply --reverse --check "${patch}" >/dev/null 2>&1; then
            echo "Recovery patch already applied: $(basename "${patch}")"
            continue
        fi

        echo "Applying recovery patch: $(basename "${patch}")"
        if ! git -C "${recovery_tree}" am --3way "${patch}"; then
            git -C "${recovery_tree}" am --abort >/dev/null 2>&1
            echo "Failed to apply recovery patch: $(basename "${patch}")"
            return 1
        fi
    done
}

_ginkgo_apply_recovery_patches
unset -f _ginkgo_apply_recovery_patches
