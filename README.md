# LFS!

I always wanted to build Linux From Scratch, so heres the documentation of the same


### structure

```
.
| README.md
| build-progress.md     #build log and notes
| scripts/              #helper scripts used for build 
    | host/
    | setup/
    | chapter-05/
```


### status

#### first attempt

The build follows official Linux From Scratch book Version r13.0-143 systemd

completed :
- Added Binutils Pass 1 build script
- Added GCC Pass 1 build script
- Added Linux API headers installation script
- Recorded Glibc build failure on LFS r13.0-143-systemd

the build failed during temporary Glibc build due to usage of development snapshot of the book


#### second attemp

The build have been restarted using the latest stable linux from sratch 13.0 (systemd) release version.

The compilation of the base LFS system has now been completed successfully. 
The next stage is system configuration - done
Kernel and bootloader setup - done

Test if LFS boots.

- first blank screen
- getting output of `echo`
- kernel panick
- wayaround - compile the kernel using working config of host.
Now I have a bootable LFS.
Shall commit the working config for future experiments `scripts/04-LFS_build/chapter-10/kernel-config-working-6.18.10`
