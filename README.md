# VBMeta-Hash-Fix

A [Magisk](https://github.com/topjohnwu/Magisk)/[KernelSU](https://github.com/tiann/KernelSU)/[Apatch](https://github.com/bmax121/APatch) module to fix VBMeta detections on Android

![License](https://img.shields.io/github/license/LoLToHell/VBMeta-Hash-Fix)
![Release date](https://img.shields.io/github/release-date/LoLToHell/VBMeta-Hash-Fix)
![Downloads](https://img.shields.io/github/downloads/LoLToHell/VBMeta-Hash-Fix/Total)

## Tested 

Android 15, LineageOS 22.1, 6.1.57 Kernel with KernelSU Next (Magic_Mount) via susfs, Poco F6 (Peridot)

Android 15, Matrix 11.6.0, 5.10.236 Kernel via Magisk Poco F5 (Marble)

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

## Compatibility

The module is fully compatible with other modules for certification on the device, such as: TrickyStore, PlayIntegrityFIx-Next, SUSFS

## Thanks❤️
Big thanks [reveny](https://github.com/reveny/) for [Native Detector](https://github.com/reveny/Android-Native-Root-Detector) and idea for a module

## License 
This project is licensed under the MIT License. See the [LICENSE](https://github.com/LoLToHell/VBMeta-Hash-Fix/blob/Master-branch/LICENSE) file for details.
