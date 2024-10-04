# twrp_device_huawei_kiwi

Tree for building TWRP for Huawei Honor 5X.

|                   Basic | Spec Sheet                                                 |
| ----------------------: | :--------------------------------------------------------- |
|                     CPU | Octa-core (4x1.2 GHz Cortex-A53 & 4x1.5 GHz Cortex-A53)    |
|                 Chipset | Qualcomm MSM8939v2 Snapdragon 616                          |
|                     GPU | 550MHz Adreno 405                                          |
|                  Memory | 2GB/3GB RAM (LPDDR3)                                       |
| Shipped Android Version | Android 5.1.1 (Lollipop)                                   |
|    Last Android Version | Android  6.0.1 (Marshmallow)                               |
|                 Storage | 16GB + microSDXC                                           |
|                 Battery | Non-removable Li-Ion 3000 mAh battery                      |
|                 Display | IPS LCD 5.5 inches, 83.4 cm2 (~72.2% screen-to-body ratio) |
|           Camera (Back) | 13 MP, f/2.0, 28mm (wide)                                  |
|          Camera (Front) | 5 MP, f/2.4, 22mm (wide)                                   |

## Device picture

![Huawei Honor 5X picture](https://fdn2.gsmarena.com/vv/pics/huawei/huawei-honor-5x-3.jpg "Huawei Honor 5X colors")


## Kernel

Kernel source:
https://github.com/mohammadsa9/android_kernel_huawei_kiwi

## Compile

1. **Initialize the TWRP 11.0 repository**:
   ```
   mkdir ~/android/twrp-11.0
   cd ~/android/twrp-11.0
   repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11
   ```

2. **Add a local manifest for the device**:
   - If you don't already have the `.repo/local_manifests/` directory, create it:
     ```
     mkdir -p .repo/local_manifests
     ```
   - Then create a new file called `roomservice.xml` inside the directory and add the following content:
     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <manifest>
       <project name="mohammadsa9/twrp_device_huawei_kiwi" path="device/huawei/kiwi" remote="github" revision="android-11" />
     </manifest>
     ```

3. **Sync the source**:
   ```
   repo sync
   ```

4. **Build the recovery image**:
   ```
   . build/envsetup.sh
   lunch twrp_kiwi-eng
   mka recoveryimage
   ```

## Run

1. **Reboot the device into Fastboot mode** using the following command:
   ```
   adb reboot bootloader
   ```

2. **Boot the recovery image temporarily**:
   ```
   fastboot boot $OUT/recovery.img
   ```

3. **Install the recovery image permanently** by running:
   ```
   fastboot flash recovery $OUT/recovery.img
   ```

4. **Finally, reboot the device after the installation is complete** by running:
    ```
   fastboot reboot
   ```

Note: After installation, to boot into TWRP Recovery mode, power off the device. Then press and hold Volume Up + Volume Down + Power. Once the device turns on, release the Power button but continue holding Volume Up + Volume Down until TWRP appears.