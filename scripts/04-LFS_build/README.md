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

following are compression programs 
4. zlib using `8.06-zlib-1.3.2.sh`
5. bzip using `8.07.bzip-1.0.8.sh`
6. xz using `8.08-xz-5.8.2.sh`
7. lz4 using `8.09-lz4-1.10.0.sh`
8. zstd using `8.10-zstd-1.5.7.sh`

9. file using `8.11-file-5.46.sh` used to determine the type of file
10. readline using `8.12-readline-8.3.sh` library for commandline editing and history
11. pear compatible regular expression 'pxre2' using `8.13-pcre2-10.47.sh`
12. m4 macro processor using `8.14-m4-1.4.21.sh`
13. calculator using `8.15-bc-7.0.3.sh`
14. lex/flex using `8.16-flex-2.6.4.sh`
15. tcl (pronounced tickle) using `8.17-tcl-8.6.17.sh`
16. expect using `8.18.expect5.45.4.sh` this is used to communicate with interactive programms according to a script
17. dejagnu - based on observation this must used for testing, created using `8.19-dejagnu-1.6.3.sh`
