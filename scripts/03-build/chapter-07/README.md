# Chapter 7. Entering Chroot and Building Additionall Temporary Tools.

Now that we have buildutils in LFS partition is required location.
next step can be completed using only the kernel of host.
for this `Chroot` will be used.

This step I have performed when working on System replication and Migration project. where instead of compiling each program I was just copying files to target disk/partition.

Kernel operated and reads/writes states to specific file - for proper operation in isolated environment we need to create 'Virtual Kernel File System'

The commands must be performed as `root`, with `LFS` variable set 
after `Chroot` all the commands will be run as `root`

### Chapter 7.2 Changing Ownership

before build confirm
- you are logged in as `root`
- check `echo $LFS` prints proper path (the veriable is set in `root`s env)

Every file is owned by lfs user which only exists on host, if files ownership is kept as it is and some other user is created that user might have same user ID exposing system for exploits.

I am creating `00.chroot_setup/` to store all the scripts you're suppose to run before starting compilation. 
compilation scripts will be stored in this dir with chapterwise naming scheme (will need to update the 6th chapter too)

- `01_owernship_change.sh`
- `02_vfs.sh`
- `03_enter_chroot.sh`

once third script is executed you shoud see something like this
```bash
(lfs chroot) I have no name!:/#
```


all the scripts starting from 02.* shall be executed in after entering `chroot` environment.

All the setup of before starting the compilation is done shall continue...

updated all the startup script with guardrail to mount dir only if not mounted - it has created multiple mounts - it would not have costed anything but cannot take risk at this stage.

### back to compiling the packages -

1. gettext using `23-gettext-1.0.sh`
2. bison using `24-bison-3.2.8.sh`
3. pearl with `25-perl-5.42.0.sh` updated convention of writing scripts

