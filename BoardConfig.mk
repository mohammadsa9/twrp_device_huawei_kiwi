#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/huawei/kiwi

# Platform
TARGET_BOARD_PLATFORM := msm8916
TARGET_BOARD_PLATFORM_GPU := qcom-adreno405

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8916
TARGET_NO_BOOTLOADER := true
TARGET_OTA_ASSERT_DEVICE := kiwi

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true

# Kernel
BOARD_KERNEL_BASE        := 0x80000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --header_version 2
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_DT_IMAGE_NAME := dt.img

# Kernel - prebuilt or build from source
BOARD_CUSTOM_BOOTIMG_MK :=  $(LOCAL_PATH)/mkbootimg.mk
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
INSTALLED_DTIMAGE_TARGET := $(LOCAL_PATH)/prebuilt/$(BOARD_DT_IMAGE_NAME)
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)
else
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/huawei/kiwi
TARGET_KERNEL_CONFIG := kiwi-64_defconfig
ifeq ($(HOST_PREBUILT_TAG),linux-x86)
BUILD_TOP := $(shell pwd)
GCC_PREBUILTS := $(BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)
KERNEL_TOOLCHAIN := $(GCC_PREBUILTS)/aarch64_aarch64-linux-android-4.9/bin
endif
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864 # /proc/partitions * 2 * BLOCK_SIZE (512) = size in bytes
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11618204672
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
RECOVERY_VARIANT := twrp
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true

# TWRP Recovery
TW_THEME := portrait_hdpi
TW_INPUT_BLACKLIST := accelerometer\\x0ahbtp_vm
TW_NO_EXFAT_FUSE := true
TW_INCLUDE_NTFS_3G := true

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file
