# Inherit device configuration for mocha.
$(call inherit-product, device/xiaomi/mocha/full_mocha.mk)

# Inherit some common lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

# Product Information
PRODUCT_NAME := lineage_mocha
PRODUCT_DEVICE := mocha
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi
BOARD_VENDOR := Xiaomi

# GMS Client ID
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
