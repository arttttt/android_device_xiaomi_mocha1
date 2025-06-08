#
# Copyright (C) 2017 The Android Open Source Project
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

# Sets Android Go default values for properties specific for mocha

# Low RAM configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.low_ram=true \
    persist.traced.enable=1

# LMK settings (less aggressive for 2GB RAM)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lmk.critical_upgrade=true \
    ro.lmk.upgrade_pressure=50 \
    ro.lmk.downgrade_pressure=70 \
    ro.lmk.medium=800 \
    ro.lmk.kill_heaviest_task=false \
    ro.statsd.enable=true

# Heap sizes (adjusted for 2GB RAM)
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=384m \
    dalvik.vm.madvise-random=true

# Compiler and optimization settings
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.shared=quicken \
    pm.dexopt.downgrade_after_inactive_days=10

# Boot image profile
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt

# Network stack
PRODUCT_PACKAGES += InProcessNetworkStack

# Minimize debug info
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# madvise random in ART to reduce page cache thrashing.
PRODUCT_PROPERTY_OVERRIDES += \
     dalvik.vm.madvise-random=true