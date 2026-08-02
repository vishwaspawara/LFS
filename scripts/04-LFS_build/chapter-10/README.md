# Making the LFS bootable



## fstab

1. create a fstab for lfs using `01-fstab.sh`

## Kernel
2. extract kernel source and configure manually, `02-extract-kernel.sh`, this script calls make mrproper, make defconfig and finally make menuconfig

configuration is based on UEFI, NVMe SSD, ext4 fs.
You can search usng `/`, it shows where the module is located.

General setup
    1. `WERROR` - make it `n` 
    2. `PSI` - make it `y` (required by systemd)
    3. `PSI_DEFAULT_DISABLED` - make it `n`
    4. `IKHEADERS` - make it `n`
Control groups
    5. `CGROUPS` - make it `y`
    6. `MEMCG` - make it `y`
    7. `CGROUP_SCHED` - make it `y`
    8. `RT_GROUP_SCHED` - make it `n`
Device Management
    9. `DEVTMPFS` - make it `y`
    10. `DEVTMPFS_MOUNT` make it `y`
Netowrking
    11. `IPV6` - `y`
FileSystem
    12. `TMPFS` - `y`
    13. `TMPFS_POSIX_ACL` - `y`
Storage
    14. `BLK_DEV_NVME` - `y`
Graphics
    15. `DRM` - `y` 
    16. `DRM_SIMPLEDRM` - `y`
    17. `DRM_FBDEV_EMULATION` - `y`
    18. `FRAMEBUFFER_CONSOLE` - `y`

3. build and install kernel with `03-install-kernel.sh`

## UEFI grub

following the BLFS for this
download the dependecies of grub and move to `sources/`

```
Grub
    -> efibootmgr
        -> efivar
        -> popt
```
so installation order is popt -> efivar -> efibootmgr -> grub

install two dependencies of efibootmgr using `04-popt-1.19.sh` and `05-efivar-39.sh`
install bootmgr dependecy for grub UEFI using `06-efibootmgr-18.sh` and finally install the grub itself using `07-grub-2.14.h`
