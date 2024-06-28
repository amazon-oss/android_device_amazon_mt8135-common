#!/sbin/sh

if [ -e /dev/block/platform/mtk-msdc.0/by-name/boot_x ]; then
    if grep -q "WIPE_CACHE" /dev/block/platform/mtk-msdc.0/by-name/MISC; then
        make_ext4fs /dev/block/platform/mtk-msdc.0/by-name/cache
        dd if=/dev/zero of=/dev/block/platform/mtk-msdc.0/by-name/MISC
        echo "coming from unlock, cache format successful!" > /tmp/cache.log
    elif grep -q "WIPE_DATA" /dev/block/platform/mtk-msdc.0/by-name/MISC; then
        make_ext4fs /dev/block/platform/mtk-msdc.0/by-name/userdata
        dd if=/dev/zero of=/dev/block/platform/mtk-msdc.0/by-name/MISC
        echo "coming from unlock, data format successful!" > /tmp/data.log
    fi
    /sbin/sh /sbin/fix-symlinks.sh
    /sbin/sh /sbin/fix-bootpatch.sh
fi
