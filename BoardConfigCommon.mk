#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/amazon/mt8135-common

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7
TARGET_ARCH_VARIANT_CPU := cortex-a15

# Audio
AUDIO_MIXER_REQUIRES_MANUAL_AMP := true
TARGET_CPU_MEMCPY_OPT_DISABLE := true

# Bootloader
TARGET_HAS_LOCKED_BOOTLOADER := false

# Display
BOARD_EGL_CFG := $(COMMON_PATH)/configs/display/egl.cfg
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 1024*1024
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
USE_OPENGL_RENDERER := true

# Filesystems
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE   := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE    := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true

# Global flags
BOARD_GLOBAL_CFLAGS += -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL
BOARD_GLOBAL_CPPFLAGS += -DMTK_HARDWARE

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE ?= 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE ?= 10750528
BOARD_CACHEIMAGE_PARTITION_SIZE ?= 922746880
BOARD_SYSTEMIMAGE_PARTITION_SIZE ?= 1258291200
BOARD_USERDATAIMAGE_PARTITION_SIZE ?= 5574213120

TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_VENDOR := system/vendor

# Platform
BOARD_USES_MTK_HARDWARE := true
TARGET_BOARD_PLATFORM := mt8135
TARGET_BOARD_VENDOR := amazon

# Power
TARGET_KERNEL_HAS_TOUCH_BOOST := true

# Properties
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop

# Recovery
TARGET_RECOVERY_FSTAB ?= $(COMMON_PATH)/rootdir/etc/fstab.mt8135

# Recovery (TWRP)
ifeq ($(RECOVERY_VARIANT),twrp)
DEVICE_RESOLUTION := 800x1280
TARGET_RECOVERY_DEVICE_DIRS += $(COMMON_PATH)
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/recovery/root/etc/recovery.fstab
TW_SCREEN_BLANK_ON_BOOT := true
TW_ALWAYS_RMRF := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_EXCLUDE_SUPERSU := true
TW_EXTERNAL_STORAGE_MOUNT_POINT := "usb-otg"
TW_EXTERNAL_STORAGE_PATH := "/usb-otg"
TW_HACKED_BL_BUTTON := true
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_MAX_BRIGHTNESS := 255
TW_NO_USB_STORAGE := true
TW_THEME ?= portrait_hdpi
endif

# Wi-Fi
BOARD_CONNECTIVITY_VENDOR := MediaTek
BOARD_WLAN_DEVICE := MediaTek
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA := STA
WIFI_DRIVER_FW_PATH_AP := AP
WIFI_DRIVER_FW_PATH_P2P := P2P
WIFI_DRIVER_STATE_ON := 1
WIFI_DRIVER_STATE_OFF := 0
WPA_SUPPLICANT_VERSION := VER_0_8_X

ifeq ($(TARGET_HAS_LOCKED_BOOTLOADER),true)
# Inherit the prebuilt firmware files
include device/amazon/mt8135-firmware/BoardConfigFirmware.mk
endif

# Inherit the prebuilt kernel files
include device/amazon/mt8135-kernel/BoardConfigKernel.mk

# Inherit the proprietary files
include vendor/amazon/mt8135-common/BoardConfigVendor.mk
