#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt8135 \
    init.connectivity.rc \
    init.mt8135.rc \
    init.mt8135.usb.rc \
    init.sensors.rc \
    ueventd.mt8135.rc

ifeq ($(TARGET_HAS_LOCKED_BOOTLOADER),true)
$(warning Will use prebuilt boot image since TARGET_HAS_LOCKED_BOOTLOADER is set to true)
PRODUCT_PACKAGES += \
    2ndinit
endif

ifneq ($(filter eng userdebug,$(TARGET_BUILD_VARIANT)),)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    ro.secure=0
endif

# Call dalvik heap config
$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

# Call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

# Inherit the proprietary files
$(call inherit-product, vendor/amazon/mt8135-common/mt8135-common-vendor.mk)

# Inherit the prebuilt kernel files
$(call inherit-product-if-exists, device/amazon/mt8135-kernel/kernel.mk)
