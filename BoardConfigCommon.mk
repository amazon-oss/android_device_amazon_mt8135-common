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

# Bootloader
TARGET_HAS_LOCKED_BOOTLOADER := false

# Filesystems
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE   := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE    := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true

# Global flags
COMMON_GLOBAL_CFLAGS += -DAMAZON_LOG -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL
TARGET_GLOBAL_CPPFLAGS += -DMTK_HARDWARE

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

ifeq ($(TARGET_HAS_LOCKED_BOOTLOADER),true)
# Inherit the prebuilt firmware files
include device/amazon/mt8135-firmware/BoardConfigFirmware.mk
endif

# Inherit the prebuilt kernel files
include device/amazon/mt8135-kernel/BoardConfigKernel.mk

# Inherit the proprietary files
include vendor/amazon/mt8135-common/BoardConfigVendor.mk
