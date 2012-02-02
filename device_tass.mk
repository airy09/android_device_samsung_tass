# Copyright (C) 2010 The Android Open Source Project
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


# This file is the device-specific product definition file for
# crespo. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that crespo is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.


# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
$(call inherit-product, build/target/product/languages_full.mk)
$(call inherit-product, build/target/product/full_base.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

DEVICE_PACKAGE_OVERLAYS := device/samsung/tass/overlay

# HAL libs and other system binaries
PRODUCT_PACKAGES += \
    brcm_patchram_plus \
    copybit.tass \
    gralloc.tass \
    libOmxCore \
    make_ext4fs \
    FM \
    rzscontrol \
    SamsungServiceMode \
    bdaddr_read \
    dexpreopt \
    dump_image \
    e2fsck \
    setup_fs \
    erase_image \
    flash_image \
    screencap

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/samsung/tass/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

## Hardware properties 
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

# Board-specific init
PRODUCT_COPY_FILES += \
    device/samsung/tass/ueventd.gt-s5570.rc:root/ueventd.gt-s5570.rc \
    device/samsung/tass/prebuilt/fsr.ko:root/lib/modules/fsr.ko \
    device/samsung/tass/prebuilt/fsr_stl.ko:root/lib/modules/fsr_stl.ko \
    device/samsung/tass/prebuilt/rfs_fat.ko:root/lib/modules/rfs_fat.ko \
    device/samsung/tass/prebuilt/rfs_glue.ko:root/lib/modules/rfs_glue.ko \
    device/samsung/tass/prebuilt/sec_param.ko:root/lib/modules/sec_param.ko \
    device/samsung/tass/TASS.rle:root/TASS.rle \
    device/samsung/tass/init.gt-s5570.rc:root/init.gt-s5570.rc

## Wifi Stuff
PRODUCT_COPY_FILES += \
    device/samsung/tass/prebuilt/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/tass/prebuilt/hostapd.conf:system/etc/wifi/hostapd.conf \
    device/samsung/tass/prebuilt/get_macaddrs:system/bin/get_macaddrs \
    device/samsung/tass/prebuilt/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf 

## Media
PRODUCT_COPY_FILES += \
    device/samsung/tass/prebuilt/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    device/samsung/tass/prebuilt/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/samsung/tass/prebuilt/media_profiles.xml:system/etc/media_profiles.xml \
    device/samsung/tass/prebuilt/audio.conf:system/etc/bluetooth/audio.conf \
    device/samsung/tass/prebuilt/vold.fstab:system/etc/vold.fstab 

## keymap
PRODUCT_COPY_FILES += \
    device/samsung/tass/prebuilt/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/samsung/tass/prebuilt/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/tass/prebuilt/sec_key.kl:system/usr/keylayout/sec_key.kl \
    device/samsung/tass/prebuilt/sec_key.kcm.bin:system/usr/keychars/sec_key.kcm.bin

## application
## PRODUCT_COPY_FILES += \
##    device/samsung/tass/prebuilt/bootsound:system/bin/bootsound \
##    device/samsung/tass/prebuilt/poweron.ogg:system/media/poweron.ogg \
##    device/samsung/tass/app/TaskManager.apk:system/app/TaskManager.apk

## Tweaks
## PRODUCT_COPY_FILES += \
##     device/samsung/tass/prebuilt/30mountcache:system/etc/init.d/30mountcache \
##     device/samsung/tass/prebuilt/70zipalign:system/etc/init.d/70zipalign \
##     device/samsung/tass/prebuilt/zipalign:system/xbin/zipalign \
##     device/samsung/tass/prebuilt/sdcardtune:system/bin/sdcardtune \
##     device/samsung/tass/prebuilt/internets:system/bin/internets \
##     device/samsung/tass/prebuilt/lowmemvalue:system/bin/lowmemvalue \
##     device/samsung/tass/prebuilt/tweaksos:system/bin/tweaksos \
##     device/samsung/tass/prebuilt/97swap2sd:system/etc/init.d/97swap2sd \
##     device/samsung/tass/prebuilt/98swapmarker:system/etc/init.d/98swapmarker \
##     device/samsung/tass/prebuilt/swapper:system/bin/swapper \
##     device/samsung/tass/prebuilt/be_photo:system/etc/be_photo \
##     device/samsung/tass/prebuilt/be_movie:system/etc/be_movie \

$(call inherit-product-if-exists, vendor/samsung/tass/tass-vendor.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := tass
PRODUCT_DEVICE := tass
PRODUCT_MODEL := GT-S5570
