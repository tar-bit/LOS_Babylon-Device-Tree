#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from xiaomi sm8550-common
include device/xiaomi/sm8550-common/BoardConfigCommon.mk

# Inherit the proprietary files
include vendor/xiaomi/babylon/BoardConfigVendor.mk

DEVICE_PATH := device/xiaomi/babylon

# For building with minimal manifest
#ALLOW_MISSING_DEPENDENCIES := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    recovery \
    product \
    system_ext \
    system_dlkm \
    vendor \
    odm \
    boot \
    vendor_boot \
    vendor_dlkm \
    dtbo \
    init_boot \
    system
#BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := kalama
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 440

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := video=vfb:640x400,bpp=32,memsize=3072000 disable_dma32=on swinfo.fingerprint=babylon:13/V816.0.10.0.UMVCNXM:user mtdoops.fingerprint=babylon:13/V816.0.10.0.UMVCNXM:user bootconfig
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION) --dtb $(TARGET_PREBUILT_DTB)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_RAMDISK_USE_LZ4 := true

TARGET_KERNEL_CONFIG := \
    gki_defconfig \
    vendor/kalama_GKI.config \
    vendor/babylon_GKI.config
    
TARGET_KERNEL_SOURCE := kernel/xiaomi/sm8550
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

KERNEL_LTO := none



####### Dtb/o #######
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
#BOARD_KERNEL_SEPARATED_DTBO := true
#BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
TARGET_NEEDS_DTBOIMAGE := true
BOARD_USES_QCOM_MERGE_DTBS_SCRIPT := true
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img



# Kernel (modules)
TARGET_KERNEL_EXT_MODULE_ROOT := kernel/xiaomi/sm8550-modules
TARGET_KERNEL_EXT_MODULES := \
	qcom/opensource/mmrm-driver \
	qcom/opensource/mm-drivers/hw_fence \
	qcom/opensource/mm-drivers/msm_ext_display \
	qcom/opensource/mm-drivers/sync_fence \
	qcom/opensource/audio-kernel \
	qcom/opensource/camera-kernel \
	qcom/opensource/dataipa/drivers/platform/msm \
	qcom/opensource/datarmnet/core \
	qcom/opensource/datarmnet-ext/aps \
	qcom/opensource/datarmnet-ext/offload \
	qcom/opensource/datarmnet-ext/shs \
	qcom/opensource/datarmnet-ext/perf \
	qcom/opensource/datarmnet-ext/perf_tether \
	qcom/opensource/datarmnet-ext/sch \
	qcom/opensource/datarmnet-ext/wlan \
	qcom/opensource/securemsm-kernel \
	qcom/opensource/display-drivers/msm \
	qcom/opensource/eva-kernel \
	qcom/opensource/video-driver \
	qcom/opensource/graphics-kernel \
	qcom/opensource/wlan/platform \
	qcom/opensource/wlan/qcacld-3.0/.kiwi_v2 \
	qcom/opensource/bt-kernel \
	nxp/opensource/driver
	

BOOT_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES += \
    q6_pdr_dlkm.ko \
    q6_notifier_dlkm.ko \
    snd_event_dlkm.ko \
    gpr_dlkm.ko \
    spf_core_dlkm.ko \
    adsp_loader_dlkm.ko \
    qti_battery_charger.ko
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_dlkm))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.first_stage))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD  := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := false
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := 
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    product \
    system_ext \
    system_dlkm \
    vendor \
    odm \
    vendor_dlkm \
    system
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := kalama

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2024-07-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

#ODM_MANIFEST_FILES += device/xiaomi/babylon/manifest/manifest_fuxi.xml

#prevents errors?
BOARD_VNDK_VERSION := 30
BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES=true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
