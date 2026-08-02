# IV. Building LFS System

this part is responsible for actual LFS build using tools available in LFS partition - many will be overwritten.

`chapter-08` this dir contains scripts  for compilation of all the packages, cleanup and backup for completing this stage.

`chapter-09` contains system cofiguration scripts.

`chapter-10` is all about making the system bootable
- fstab creation
- configuring, compiling and installing kernel 
- installing UEFI grub and its dependecies from BLFS


There is possiblitiy of LFS being broken and since last install was LFS, bootorder has been changed. For my sanity I'll keep my host 'debian' as default and add LFS's entry on hosts `grub.cfg`

for this created a script which should be run as root on host (for me debian) `adding-lfs-to-host.sh`

With some work around ie using hosts config for compiling kernel - the system boots.
and WE HAVE working LFS.
