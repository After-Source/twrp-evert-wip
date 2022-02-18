#
# Copyright 2012 The Android Open Source Project
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
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/pb/config/common.mk)

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_product=true \
    POSTINSTALL_PATH_product=bin/check_dynamic_partitions \
    FILESYSTEM_TYPE_product=ext4 \
    POSTINSTALL_OPTIONAL_product=false

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_engine_sideload \
    update_verifier

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl.sdm660 \
    android.hardware.boot@1.0-impl.recovery \
     bootctrl.sdm660.recovery

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd



# Enable retrofit dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    check_dynamic_partitions

# FBE crypto volume modes
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.volume.contents_mode=ice

# Properties for decryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=sdm660 \
    ro.hardware.gatekeeper=sdm660 \
    ro.hardware.bootctrl=sdm660 \
    ro.build.system_root_image=true

# Time Zone data for recovery
PRODUCT_COPY_FILES += \
    system/timezone/output_data/iana/tzdata:recovery/root/system_root/usr/share/zoneinfo/tzdata

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := evert
PRODUCT_NAME := omni_evert
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto G6 Plus
PRODUCT_MANUFACTURER := Motorola
