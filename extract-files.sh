#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi


function blob_fixup() {
    case "${1}" in
        bin/6620_launcher)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        bin/kisd)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        bin/nvram_agent_binder)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        bin/wlan_loader)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        bin/wmt_loader)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/amzn_dha.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/audio.primary.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/camera.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/hwcomposer.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/keystore.amzn.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/keystore.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/sensors.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/hw/thermal.mt8135.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libMtkOmxAIVPlayer.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            patchelf --add-needed "libstagefright_shim.so" "${2}"
            ;;
        lib/libMtkOmxCore.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libMtkOmxMp3Dec.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libMtkOmxVdec.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            patchelf --add-needed "libui_shim.so" "${2}"
            ;;
        lib/libMtkOmxVenc.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            patchelf --add-needed "libui_shim.so" "${2}"
            sed -i 's|_ZN7android19GraphicBufferMapper4lockEPK13native_handleiRKNS_4RectEPPv|_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv|g' "${2}"
            ;;
        lib/lib_uree_mtk_modular_drm.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/lib_uree_mtk_video_secure_al.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libaudio_customization.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libaudiocompensationfilter.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libaudiocustparam.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbluetooth_hw_test.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbluetooth_mtk.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbluetooth_mtk_pure.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbluetooth_relayer.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbluetoothem_mtk.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbt-vendor.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libbwc.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.camadapter.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.campipe.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.camshot.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.client.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            patchelf --add-needed "libui_shim.so" "${2}"
            sed -i 's|_ZN7android19GraphicBufferMapper4lockEPK13native_handleiRKNS_4RectEPPv|_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv|g' "${2}"
            ;;
        lib/libcam.device1.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.exif.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.paramsmgr.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam.utils.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam_mmp.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam_platform.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcam_utils.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcamalgo.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcamdrv.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcameraanalyzer.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libcameracustom.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libdrmplayreadydecryptor.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libfeatureio.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libgralloc_extra.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libimageio.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libinvensense_hal.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libion_mtk.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libm4u.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libmatv_cust.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libnvram_daemon_callback.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libplayready.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libsmartvolume.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libthermalservice.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libtz_uree.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        lib/libvcodecdrv.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/drm/libdrmwvmplugin.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/libamazonlog.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/liboemcrypto.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/libsrv_um.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/libwvm.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            patchelf --add-needed "libstagefright_shim.so" "${2}"
            ;;
        vendor/lib/libWVStreamControlAPI_L1.so)
            patchelf --add-needed "libstlport_shim.so" "${2}"
            ;;
        vendor/lib/mediadrm/libplayreadydrmplugin.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/mediadrm/libwvdrmengine.so)
            patchelf --add-needed "libamazonlog.so" "${2}"
            ;;
    esac
}

if [ -z "${ONLY_TARGET}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR_COMMON:-$VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -s "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../../${VENDOR}/${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"
