REPLACE="
/system/vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/APAC
"

local MBN_LIST
local MBN_FILES

MBN_LIST="/vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw"
MBN_FILES="
mcfg_sw/generic/APAC/DCM/Commercial/mcfg_sw.mbn
mcfg_sw/generic/APAC/KDDI/Commercial/mcfg_sw.mbn
mcfg_sw/generic/APAC/Rakuten/Commercial/mcfg_sw.mbn
mcfg_sw/generic/APAC/SBM/Commercial/mcfg_sw.mbn
"

local MODPATH_LIST="${MODPATH}/system${MBN_LIST}/mbn_sw.txt"
cp "${MBN_LIST}/mbn_sw.txt" "$MODPATH_LIST"

# Add each path to mcfg_sw.mbn at the end of mbn_sw.txt
#           ONLY IF the path is NOT EXIST in mbn_sw.txt
echo "" >> "$MODPATH_LIST"
local MBNFILE
for MBNFILE in $MBN_FILES; do
grep -qF "$MBNFILE" "$MODPATH_LIST" || echo "$MBNFILE" >> "$MODPATH_LIST"
done


local MODPATH_LIST_OEM="${MODPATH}/system${MBN_LIST}/oem_sw.txt"
cp "${MBN_LIST}/oem_sw.txt" "$MODPATH_LIST_OEM"

# Add each path to mcfg_sw.mbn at the end of oem_sw.txt
#           ONLY IF the path is NOT EXIST in oem_sw.txt
echo "" >> "$MODPATH_LIST_OEM"
local MBNFILE_OEM
for MBNFILE_OEM in $MBN_FILES; do
grep -qF "$MBNFILE_OEM" "$MODPATH_LIST_OEM" || echo "$MBNFILE_OEM" >> "$MODPATH_LIST_OEM"
done

rm -rf /data/vendor/modem*
rm -rf /data/vendor/radio/*

ui_print ""
ui_print "After reboot, you should be able to get VoLTE enabled"
ui_print ""