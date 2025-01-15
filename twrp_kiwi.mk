#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from kiwi device.
$(call inherit-product, device/huawei/kiwi/device.mk)

PRODUCT_BRAND := HONOR
PRODUCT_DEVICE := kiwi
PRODUCT_MANUFACTURER := HUAWEI
PRODUCT_MODEL := KIW-L24
PRODUCT_NAME := twrp_kiwi
