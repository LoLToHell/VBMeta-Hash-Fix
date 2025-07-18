# VBMeta-Hash-Fix

A Magisk/KernelSU/Apatch module to fix VBMeta detections on Android

![License](https://img.shields.io/github/license/LoLToHell/VBMeta-Hash-Fix)
![Release date](https://img.shields.io/github/release-date/LoLToHell/VBMeta-Hash-Fix)
![Downloads](https://img.shields.io/github/downloads/LoLToHell/VBMeta-Hash-Fix/Total)

## Tested 

Android 15, LineageOS 22.1, 6.1.57 Kernel with KernelSU Next (Magic_Mount) via susfs, Poco F6 (Peridot)

## Description

Simple script to set valid Boot Hash for `ro.boot.vbmeta.digest` and pass certification 

## Features 

Automatically sets the `ro.boot.vbmeta.digest` property to the SHA-256 hash of the boot partition each time the device boots. This is needed for:
1. Emulate Verified Boot (AVB) behavior
2. Bypassing system integrity checks
3. Compatibility with applications that require vbmeta secure boot parameter  
The module does not use the value from the bootloader. Instead, it calculates the hash directly from the binary contents of the partition:
 1. The module determines the path to the boot partition:  
`/dev/block/by-name/boot
/dev/block/bootdevice/by-name/boot
/dev/block/platform/*/by-name/boot`
 3. Reads the raw partition data byte by byte  
 4. Calculates the SHA-256 hash of the entire contents: `$(sha256sum "$BOOT_PARTITION" | awk '{print $1}')`
<details> 
  
  <summary>Module status</summary>
  
✅ - Active: Hash set  
Success: The module calculated and set the hash  
🔵 - Active: using bootloader value  
The bootloader value is used  
❌ - Error: Boot partition not found   
Critical error: boot partition not found   
❌ - Error: Hash calculation failed  
Error reading partition or calculating hash  
🔄 - intermediate state of script execution  

</details>

## Compatibility

The module is fully compatible with other modules for certification on the device, such as: TrickyStore, PlayIntegrityFIx-Next, SUSFS

## FAQ 

Q: Why does it work?
1. `ro.boot.vbmeta.digest` parameter:
- Not checked by the Android kernel
- Used only by apps/services
- Does not affect the actual boot verification  
  **How apps use**:
In java  
`// An example of checking in an app
String digest = SystemProperties.get("ro.boot.vbmeta.digest");
if (!"expected_hash".equals(digest)) {  
// Actions in case of mismatch
}
  `  
The module substitutes the current hash to pass such checks.

## Screenshots 
<details>
  <summary>Screenshots</summary>
<img src="/Screenshots/ss2.png" alt="Before" width="200">
  
<img src="/Screenshots/ss1.png" alt="After" width="200">
</details>

## Thanks❤️
Big thanks [reveny](https://github.com/reveny/) for [Native Detector](https://github.com/reveny/Android-Native-Root-Detector) and idea for a module

## License 
This project is licensed under the MIT License. See the [LICENSE](https://github.com/LoLToHell/VBMeta-Hash-Fix/blob/Master-branch/LICENSE) file for details.
