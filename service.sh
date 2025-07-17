#!/system/bin/sh

MODDIR=${0%/*}
STATUS_FILE="$MODDIR/status"
MODULE_PROP="$MODDIR/module.prop"

# Wait for main process to complete
sleep 5

# Update module description based on status
if [ -f "$STATUS_FILE" ]; then
    STATUS=$(head -n1 "$STATUS_FILE")
    
    case $STATUS in
        "Success: "*)
            NEW_DESC="✅ Active: Hash set"
            ;;
        "Bootloader_Property_Found")
            NEW_DESC="🔵 Active: Using bootloader value"
            ;;
        "Error: "*)
            NEW_DESC="❌ Error: ${STATUS:6}"
            ;;
        *)
            NEW_DESC="🔄 Status: $STATUS"
            ;;
    esac

    # Update only description keeping other properties
    sed -i "s/^description=.*/description=Sets ro.boot.vbmeta.digest to boot partition hash. $NEW_DESC/" "$MODULE_PROP"
fi