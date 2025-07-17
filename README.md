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
3. Compatibility with applications that require vbmeta secure boot parameters

## Screenshots 
<details>
  <summary>Screenshots</summary>
<img src="/Screenshots/ss2.png" alt="Before" width="200">
  
<img src="/Screenshots/ss1.png" alt="After" width="200">
</details>

## Thanks❤️
Big thanks [reveny](https://github.com/reveny/)

## License 
This project is licensed under the MIT License. See the [LICENSE](https://github.com/LoLToHell/VBMeta-Hash-Fix/blob/Master-branch/LICENSE) file for details.
