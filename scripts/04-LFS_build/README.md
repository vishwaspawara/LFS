# PART IV BUILDING THE LFS SYSTEM

since I had left `chroot` environment need run some scripts for lfs build setup
This build will be executed as `root` user

```bash
# change into root user
su -            

# export LFS variable
export LFS="/mnt/lfs"

bash ../03-build/chapter-07/00.check_env.sh
bash ../03-build/chapter-07/01.chroot_setup/02_vfs.sh
bash ../03-build/chapter-07/01.chroot_setup/03_enter_chroot.sh

```

### compiling packages


1. man-pages using `8.01-man-pages-6.17.sh`
2. protocols and services of network using `8.02-iana-etc-20260202.sh`
3. glibc using `8.05-glibc.sh` - got through the script this includes many configuration which were not needed when complied earlier stages.
