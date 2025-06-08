# ADB
PRODUCT_PROPERTY_OVERRIDES += \
  persist.service.adb.enable=1 \
  persist.service.debuggable=1 \
  persist.sys.usb.config=mtp,adb \
  persist.sys.root_access=2 \
  ro.secure=0 \
  ro.adb.secure=0 \
  ro.debuggable = 1

# AptX
PRODUCT_PROPERTY_OVERRIDES += \
    persist.bt.enableAptXHD=true \
    persist.service.btui.use_aptx=1 \
    persist.vendor.bt.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
    persist.vendor.btstack.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldacs

# BT
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bt.bdaddr_path=/system/vendor/etc/mocha_btmacaddr.txt

# DIDIM
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.didim.enable=1 \
    persist.tegra.didim.video=5 \
    persist.tegra.didim.normal=3

# DRM
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# fastbootd
PRODUCT_PROPERTY_OVERRIDES += \
    ro.fastbootd.available=true

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196610 \
    ro.sf.lcd_density=320 \
    persist.tegra.compositor=glcomposer \
    persist.tegra.nvmmlite = 1 \
    ro.input.noresample=1 \
    ro.zygote.disable_gl_preload=true \
    debug.sf.disable_hwc=1 \
    debug.sf.disable_backpressure=1 \
    debug.sf.latch_unsignaled=1

# Lineage genuine
PRODUCT_PROPERTY_OVERRIDES += \
    persist.lineage.nofool=true

# Nvmm
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.nvmmlite = 1

# OMX
PRODUCT_PROPERTY_OVERRIDES += \
    persist.media.treble_omx=false

# PBC
PRODUCT_PROPERTY_OVERRIDES += \
    pbc.enabled=0 \
    pbc.log=0 \
    pbc.board_power_threshold=20000 \
    pbc.low_polling_freq_threshold=1000 \
    pbc.rails=cpu,core,dram,gpu \
    pbc.cpu.power=/sys/bus/i2c/devices/7-0045/power1_input \
    pbc.cpu.cap=/dev/cpu_freq_max \
    pbc.cpu.cap.af=/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies \
    pbc.core.power=/sys/bus/i2c/devices/7-0043/power1_input \
    pbc.dram.power=/sys/bus/i2c/devices/7-0049/power1_input \
    pbc.gpu.power=/sys/bus/i2c/devices/7-004b/power1_input \
    pbc.gpu.cap=/dev/gpu_freq_max \
    pbc.gpu.cap.af=/sys/devices/platform/host1x/gk20a.0/devfreq/gk20a.0/available_frequencies

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    ro.radio.noril=yes
    

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
    persist.debug.wfd.enable=1 \
    wifi.interface=wlan0 \
    ap.interface=wlan0 \
    persist.tegra.nvmmlite = 1 \
    persist.wlan.ti.calibrated = 0

# Disable oem unlock
PRODUCT_PROPERTY_OVERRIDES += \
    ro.oem_unlock_supported=false

# USB
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.ffs.aio_compat=1 \
    persist.adb.nonblocking_ffs=0 \
    ro.adb.nonblocking_ffs=0 \
    ro.vendor.lineage.tegra.configfs=1 \
    persist.sys.isUsbOtgEnabled=1
