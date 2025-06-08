#
# Copyright (C) 2014 The CyanogenMod Project
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

LOCAL_PATH := device/xiaomi/mocha

# Vnedor Blob
#$(call inherit-product-if-exists, vendor/xiaomi/mocha/mocha-vendor.mk)
$(call inherit-product-if-exists, vendor/nvidia/shield/mocha.mk)

# Treble workaround
PRODUCT_PACKAGES += $(PRODUCT_PACKAGES_SHIPPING_API_LEVEL_29)

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0 \
    android.hardware.audio@2.0-impl \
    android.hardware.soundtrigger@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    audio.primary.tegra \
    libaudiohalcm \
    libaudio-resampler \
    libaudiospdif \
    libstagefrighthw \
    libtinycompress \
    tinycap_mocha \
    tinymix_mocha \
    tinyplay_mocha \
    libtinyalsa_mocha \
    tinypcminfo_mocha \
    libtinyalsa \
    xaplay
	
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio.mocha.xml:system/vendor/etc/audio.mocha.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:system/vendor/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/nvaudio_conf.xml:system/etc/nvaudio_conf.xml \
    $(LOCAL_PATH)/audio/nvaudio_fx.xml:system/etc/nvaudio_fx.xml  \
    $(LOCAL_PATH)/audio/audio_effects.xml:system/vendor/etc/audio_effects.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_engine_configuration.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_default_stream_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_engine_default_stream_volumes.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_product_strategies.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_engine_product_strategies.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_stream_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_engine_stream_volumes.xml

# Bluetooth
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    $(LOCAL_PATH)/initfiles/init.btloader.sh:system/bin/init.btloader.sh

PRODUCT_PACKAGES += \
    libbt-vendor \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/camera/nvcamera.conf:system/etc/nvcamera.conf \
    $(LOCAL_PATH)/camera/model_frontal.xml:system/vendor/etc/model_frontal.xml

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service \
    camera.device@3.2-impl \
    camera.tegra

# Comm Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.software.sip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml

# Configstore HAL
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-impl \
    android.hardware.configstore@1.1-service

# DRM HAL
#PRODUCT_PACKAGES += \
#    android.hardware.drm@1.0-impl \
#    android.hardware.drm@1.0-service 

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Filesystem management tools
PRODUCT_PACKAGES += \
    setup_fs

# FM
PRODUCT_PACKAGES += \
    android.hardware.broadcastradio@2.0-service \
    FMRadio \
    brcm-uim-sysfs \
    libfmjni \
    libfmradio.v4l2-fm

# Graphics
PRODUCT_AAPT_CONFIG += xlarge large
TARGET_SCREEN_HEIGHT := 2048
TARGET_SCREEN_WIDTH := 1536
TARGET_TEGRA_VERSION := t124
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.renderscript@1.0-impl \
    vendor.nvidia.hardware.phs@1.0-impl \
    vendor.nvidia.hardware.phs@1.0

# Shims
PRODUCT_PACKAGES += \
    libshim_atomic \
    libcamera_shim \
    libshim_camera \
    libEGL_vndk \
    libnvos_shim \
    libnvmm_shim \
    libshim_zw \
    libphs \
    libs \
    libw \

# GO
$(call inherit-product, device/xiaomi/mocha/go_mocha.mk)

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0 \
    android.hidl.manager@1.0_system

# Binder
PRODUCT_PACKAGES += \
    libhidltransport \
    libhwbinder

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-service

# Key layouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7210.kl

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Light
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.mocha

# LiveDisplay
   PRODUCT_PACKAGES += vendor.lineage.livedisplay@2.0-service-nvidia

# Media config
PRODUCT_PACKAGES += \
    android.hardware.media.omx@1.0-impl \
    android.hardware.media.omx@1.0-service

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-service-nvidia

# NVIDIA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.nvidia.blakemanager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nvidia.blakemanager.xml \
    $(LOCAL_PATH)/permissions/com.nvidia.feature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nvidia.feature.xml \
    $(LOCAL_PATH)/permissions/com.nvidia.feature.opengl4.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nvidia.feature.opengl4.xml \
    $(LOCAL_PATH)/permissions/com.nvidia.nvsi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nvidia.nvsi.xml

# Enable nvidia framework enhancements if available
-include vendor/lineage/product/nvidia.mk

#OMX(SOFTWARE)
PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.c2-poolmask=0x80000 \
    debug.stagefright.ccodec=0

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay 
            
# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.manual_postprocessing.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.manual_postprocessing.xml \
    frameworks/native/data/etc/android.hardware.camera.manual_sensor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.manual_sensor.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.location.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml\
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

PRODUCT_CHARACTERISTICS := tablet

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-service.mocha \
    vendor.lineage.power@1.0

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.tn8 \
    init.cal.rc \
    init.comms.rc \
    init.hdcp.rc \
    init.t124.rc \
    init.tegra.rc \
    init.tlk.rc \
    init.tn8.rc \
    init.tn8.usb.rc \
    init.tn8_common.rc \
    init.ussrd.rc \
    power.tn8.rc \
    power.mocha.rc \
    ueventd.tn8.rc \
    ussrd.conf \
    init.nvgpu_shims.rc \
    ussr_setup \
  
# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml

# Seccomp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/initfiles/init.renderer.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.renderer.sh

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    sensors.tegra

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/_hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/_hals.conf

# System properties
-include $(LOCAL_PATH)/system_prop.mk

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-impl \
    thermalhal.tn8.xml

# TimeKeep
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep

# Trust HAL
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

# USB HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-service.mocha

# Vendor seccomp policy files for media components:
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/seccomp/mediaextractor.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

# Wifi (All Shield devices xurrently use broadcom wifi / bluetooth modules)
    $(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)
    $(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4354/device-bcm.mk)

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service.legacy \
    hostapd \
    conn_init \
    wpa_supplicant \
    wpa_supplicant.conf
