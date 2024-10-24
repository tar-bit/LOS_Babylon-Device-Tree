#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, vendor/lineage/config/common_full_foldable_book_telephony.mk)

# Inherit from generic device
$(call inherit-product, device/xiaomi/babylon/device.mk)

PRODUCT_DEVICE := babylon
PRODUCT_NAME := lineage_babylon
PRODUCT_BRAND := Android
PRODUCT_MODEL := Mix Fold 3
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="missi_foldable_cn-user 14 UKQ1.230804.001 V816.0.10.0.UMVCNXM release-keys"

BUILD_FINGERPRINT := Android/missi_foldable_cn/missi:14/UKQ1.230804.001/V816.0.10.0.UMVCNXM:user/release-keys
