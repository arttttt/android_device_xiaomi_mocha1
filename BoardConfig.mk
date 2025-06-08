#
# Copyright (C) 2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Path
LOCAL_PATH := device/xiaomi/mocha

# Audio
USE_XML_AUDIO_POLICY_CONF := 1
USE_CUSTOM_AUDIO_POLICY  := 1
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINYHAL_AUDIO := true

# Architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a15

TARGET_NOT_USE_GZIP_RECOVERY_RAMDISK := true

# Binder API
TARGET_USES_64_BIT_BINDER := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BCM_BLUETOOTH_MANTA_BUG := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

# Board
TARGET_BOARD_PLATFORM := tegra
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Boot animation
TARGET_SCREEN_HEIGHT := 2048
TARGET_SCREEN_WIDTH := 1536
TARGET_BOOTANIMATION_HALF_RES := true

# Camera
#TARGET_HAS_LEGACY_CAMERA_HAL1 := true
#TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true

# ELF
BUILD_BROKEN_PREBUILT_ELF_FILES := true
LOCAL_CHECK_ELF_FILES := false

# FM
BOARD_HAVE_BCM_FM := false

# FS
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_EXFAT_DRIVER := sdfat
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

# Display
TARGET_SCREEN_DENSITY := 320

# Graphics
USE_OPENGL_RENDERER := true
BOARD_DISABLE_TRIPLE_BUFFERED_DISPLAY_SURFACES := true
#VSYNC_EVENT_PHASE_OFFSET_NS := 1000000
#SF_VSYNC_EVENT_PHASE_OFFSET_NS := 1000000
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# HIDL Manifest
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/manifest.xml
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# Include
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Kernel
BOARD_KERNEL_CMDLINE := vpr_resize androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x10000000
BOARD_RAMDISK_OFFSET := 0x02000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
TARGET_KERNEL_SOURCE := kernel/xiaomi/mocha-24.1
TARGET_KERNEL_CONFIG := tegra12_android_defconfig
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk
#BOARD_SYSTEMIMAGE_PARTITION_SIZE := 671088640 # 640 Mb stock partition table
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3001024512 # 2.8 Gb
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11196694528
BOARD_CACHEIMAGE_PARTITION_SIZE := 387973120
BOARD_BOOTIMAGE_PARTITION_SIZE := 20971520
BOARD_PERSISTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 20971520
BOARD_FLASH_BLOCK_SIZE := 131072

# LINEAGEHW
JAVA_SOURCE_OVERLAYS := org.lineageos.hardware|$(LOCAL_PATH)/lineagehw|**/*.java

# Malloc
MALLOC_SVELTE := true

# Offmode Charging
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH := "/sys/class/backlight/lcd-backlight/brightness"
RED_LED_PATH := "/sys/class/leds/red/brightness"
GREEN_LED_PATH := "/sys/class/leds/green/brightness"
BLUE_LED_PATH := "/sys/class/leds/blue/brightness"

# Per-application sizes for shader cache
MAX_EGL_CACHE_SIZE := 4194304
MAX_EGL_CACHE_ENTRY_SIZE := 262144

# PowerHAL
TARGET_POWERHAL_VARIANT := tegra

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += device/xiaomi/mocha
TARGET_RECOVERY_FSTAB := device/xiaomi/mocha/initfiles/fstab.tn8
BOARD_NO_SECURE_DISCARD := true

# RenderScript
OVERRIDE_RS_DRIVER := libnvRSDriver.so
BOARD_OVERRIDE_RS_CPU_VARIANT_32 := cortex-a15

# SELinux
SELINUX_IGNORE_NEVERALLOWS := true
BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/sepolicy/mocha \
                       $(LOCAL_PATH)/sepolicy/lineage-common \
                       $(LOCAL_PATH)/sepolicy/common
# Camera shims
TARGET_LD_SHIM_LIBS += /system/vendor/lib/hw/camera.tegra.so|/system/vendor/lib/libcamera_shim.so

# nvgpu shims
TARGET_LD_SHIM_LIBS += \
  /system/vendor/lib/libglcore.so|/system/lib/libutilscallstack.so \
  /system/vendor/lib/egl/libEGL_tegra.so|/system/vendor/lib/libw.so \
  /system/vendor/lib/egl/libEGL_tegra.so|/system/vendor/lib/libnvos_shim.so

# liblog shims
TARGET_LD_SHIM_LIBS += \
  /system/vendor/lib/libnvcamlog.so|/system/lib/liblog.so \
  /system/vendor/lib/libnvmm_camera_v3.so|/system/lib/liblog.so \
  /system/vendor/lib/libnvcamerahdr_v3.so|/system/lib/liblog.so \
  /system/vendor/lib/hw/camera.tegra.so|/system/lib/liblog.so \
  /system/vendor/lib/egl/libEGL_tegra.so|/system/lib/liblog.so \
  /system/vendor/lib/libglcore.so|/system/lib/liblog.so \
  /system/vendor/lib/libnvgr.so|/system/lib/liblog.so \
  /system/vendor/lib/libnvmm_utils.so|/system/lib/liblog.so \
  /system/vendor/lib/libnvomxadaptor.so|/system/lib/liblog.so \
  /system/vendor/lib/libnvomx.so|/system/lib/liblog.so \
  /system/vendor/lib/libmplmpu.so|/system/lib/liblog.so

# Nvmm shims
TARGET_LD_SHIM_LIBS += \
  /system/vendor/lib/libnvomxadaptor.so|/system/lib/libmedia_omx.so \
  /system/vendor/lib/libnvomxadaptor.so|/system/vendor/lib/libnvmm_shim.so \
  /system/vendor/lib/libnvmlite_video.so|/system/vendor/lib/libnvos_shim.so

#TARGET_LD_SHIM_LIBS += \
#    /system/vendor/lib/libnvgr.so|libshim_atomic.so \
#    /system/vendor/lib/libnvcap_video.so|libshim_camera.so \
#    /system/vendor/lib/hw/hwcomposer.tegra.so|libshim_camera.so \

# ThermalHAL
TARGET_THERMALHAL_VARIANT := tegra

# WEBGL in WebKit
ENABLE_WEBGL := true

# Use unified vendor
TARGET_TEGRA_VARIANT := shield

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
#WIFI_DRIVER_MODULE_ARG           := "iface_name=wlan0"
#WIFI_DRIVER_MODULE_NAME          := "bcmdhd"

# workaround for devices that uses old GPU blobs
#BOARD_EGL_WORKAROUND_BUG_10194508 := true
                       
# Zygote whitelist extra paths
ZYGOTE_WHITELIST_PATH_EXTRA := \"/dev/nvhost-ctrl\",\"/dev/nvmap\",

# Security patch level
VENDOR_SECURITY_PATCH := 2022-04-05    