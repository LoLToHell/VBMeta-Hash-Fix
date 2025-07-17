#!/system/bin/sh

MODDIR=${0%/*}
STATUS_FILE="$MODDIR/status"

# Проверяем, установлено ли свойство
if [ -n "$(getprop ro.boot.vbmeta.digest)" ]; then
    exit 0
fi

# Определяем раздел boot (учитываем A/B схему)
SLOT_SUFFIX=$(getprop ro.boot.slot_suffix)
BOOT_PARTITION="/dev/block/by-name/boot$SLOT_SUFFIX"

if [ ! -e "$BOOT_PARTITION" ]; then
    # Альтернативные пути
    [ -e "/dev/block/bootdevice/by-name/boot$SLOT_SUFFIX" ] && BOOT_PARTITION="/dev/block/bootdevice/by-name/boot$SLOT_SUFFIX"
    [ -e "/dev/block/platform/*/by-name/boot$SLOT_SUFFIX" ] && BOOT_PARTITION=$(echo /dev/block/platform/*/by-name/boot$SLOT_SUFFIX)
fi

if [ ! -e "$BOOT_PARTITION" ]; then
    exit 1
fi

# Вычисляем SHA-256 хэш
BOOT_HASH=$(sha256sum "$BOOT_PARTITION" | awk '{print $1}')

# Устанавливаем свойство
resetprop ro.boot.vbmeta.digest "$BOOT_HASH"

# Initialize status
echo "Initializing..." > "$STATUS_FILE"

# Check if property already set
if [ -n "$(getprop ro.boot.vbmeta.digest)" ]; then
    echo "Bootloader_Property_Found" > "$STATUS_FILE"
    exit 0
fi

# Find boot partition
SLOT_SUFFIX=$(getprop ro.boot.slot_suffix)
BOOT_PATHS=(
    "/dev/block/by-name/boot$SLOT_SUFFIX"
    "/dev/block/bootdevice/by-name/boot$SLOT_SUFFIX"
    "/dev/block/platform/*/by-name/boot$SLOT_SUFFIX"
)

BOOT_PARTITION=""
for path in "${BOOT_PATHS[@]}"; do
    # Handle wildcards in paths
    if [ -e $path ]; then
        BOOT_PARTITION=$path
        break
    fi
done

if [ -z "$BOOT_PARTITION" ]; then
    echo "Error: Boot partition not found" > "$STATUS_FILE"
    exit 1
fi

# Calculate hash
echo "Calculating boot hash..." > "$STATUS_FILE"
BOOT_HASH=$(sha256sum "$BOOT_PARTITION" 2>/dev/null | awk '{print $1}')

if [ -z "$BOOT_HASH" ]; then
    echo "Error: Hash calculation failed" > "$STATUS_FILE"
    exit 1
fi

# Set property
resetprop ro.boot.vbmeta.digest "$BOOT_HASH"

# Final status
echo "Success: $BOOT_HASH" > "$STATUS_FILE"
exit 0