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
18. pkgconf successor to pkg-config compiled and installed using `8.20-pkgconf-2.5.1.sh`

This marks the work of the day shall return soon
Back to compiling packages, today I was able to compile following 10 packages largest of which is GCC

19. binutils using `8.21-binutils-2.46.0.sh`
20. gmp using `8.22-gmp-6.3.0.sh` gmp, mpfr, mpc are maths library
21. mpfr using `8.23-mpfr-4.2.2.sh`
22. mpc using `8.24-mpc-1.3.1.sh`
23. attr using `8.25-attr-2.5.2.sh` file attributes utilities
24. acl using `8.26-acl-2.3.2.sh` fine tuned access management
25. libcap using `8.27-libcap-2.77.sh`
26. libxcrypt using `8.28-libxcrypt-4.5.2.sh` 
27. shadwo for password management and configuration`8.29-shadow-4.19.3.sh` - setup the root password 
28. gcc `8.30-gcc-15.2.0.sh` the test took more than an hour to complete completed the chekcs given in book, all good this is perfect time to stop for the day. shall continue soon.

back at it -
29. nucurse usef to manage tty display `8.31-ncurses-6.6.sh`
30. sed using `8.32-sed-4.9.sh`
31. psmisc using `8.33-psmisc-23.7.sh`
32. gettext using `8.34-gettext-1.0.sh`
33. bison compiler generator using `8.35-bison.3.8.2.sh`
34. grep, fgrep and egrep using `8.36-grep-3.12.sh`
35. bash using `8.37-bash-5.3.sh` also replaced live
36. libtool using `8.38-libtool-2.5.4.sh`
37. GNU database management using `8.39-gdbm-1.26.sh`
38. gperf used to generate hash using `8.40-gperf-3.3.sh`
39. expat using `8.41-expat-2.7.4.sh`
40. inetutils - networking tools using `8.42-inetutils-2.7.sh`
41. less using `8.43-less-692.sh`
42. perl using `8.44-perl-5.42.0.sh`
43. xml parser using `8.45-xml-parser-2.47.sh`
44. automake using `8.48-automake-1.18.1.sh`
45. openssl lib used by openssh and others using`8.49-openssl-3.6.1.sh`
46. only the libelf using `8.50-libelf.sh`
47. libffi used to refer object fils in interpreted languages using`8.51-libffi-3.5.2.sh`
48. sqlite using `8.52-sqlite-3510200.sh`
49. python using `8.53-Python-3.14.3.sh`
50. build core for python packages using`8.54-flit-core-3.12.0.sh` used pip
51. packaging standards using `8.55-packaging-26.0.sh` used pip
52. wheel using `8.56-wheel-0.46.3.sh` used pip
53. classic setuptools using `8.57-setuptools-82.0.0.sh` used pip
54. ninja build tool using `8.58-ninja-1.13.2.sh`
55. meson (fast and simple) using `8.59-meson-1.10.1.sh`
56. tools used to get kernel status using `8.60-kmod-34.2.sh`

dozen more to complete the copiliation part of LFS :)

57. utils needed by every os such as cat, cp, and other utils using `8.61-coreutils-9.10.sh`
58. diff and cmp using `8.62-diffutils-3.12.sh`
59. gawk using `8.63-gawk-5.3.2.sh`
60. find/local using `8.64-findutils-4.10.0.sh`
61. groff using `8.65-groff-1.23.0.sh`

62. `8.66-grub-2.14.sh` - I have skipped this for now - will compile using BLFS, lfs supports legacy by default mine is uefi

63. gzip using `8.67-gzip-1.14.sh`
64. iproute2 using `8.68-iproute2-6.18.0.sh` - bridge, ip, ss and many fundamentals
65. kbd using `8.69-kbd-2.9.0.sh`
66. libpipeline using `8.70-libpipeline-1.5.8.sh` to manage subprocess pipeline
67. make using `8.71-make-4.4.1.sh`
68. patch using `8.72-patch-2.8.sh`
69. tar for archiving utilities using `8.73-tar-1.35.sh` this will overwrite existing binaries
70. textinfo for reading writing and converting info pages using `8.74-texinfo-7.2.sh`
71. my go to editor VIM using `8.75-vim-9.2.0078.sh` also created vimrc
72. python module of markup safe string using `8.76-markupsafe-3.0.3.sh`
73. jinja2 another python modul using `8.77-jinja2-3.1.6.sh`
74. systemd using `8.78-systemd-256.1.sh` highly contested addition replacing the init v
75. dbus communication utility between different application using `8.79-dbus-1.16.2.sh`
76. mandb for finding and viewing man pages using `8.80-man-db-2.13.1.sh`
77. utilities for monitoring processses using `8.81-procps-ng-4.0.6.sh` - ps, top, pkill, etc
78. miscellaneous utility programs covering systems, console, partition and messages using `8.82-util-linux-2.41.3.sh`
79. e2fsprogs to manage ext2 file system using `8.83-e2fsprogs-1.47.3.sh`


now all the packages have been compiled (except grub - shall be compiled from BLFS). 
Most of the programs have been compiled using debugging symbols so if those are removed the size of current LFS should reduce by almost 2GB...
But since strip is destructive operation it's good time to take backup. 

for this exit chroot and execute following `backup_before_strip.sh`

Come back to chroot environment 
Now strip the build using `8.84-strip_and_cleanup.sh`

again leave chroot environment to create another backup after stripping `backup_after_strip.sh`


This marks the end of compilation ...

next task is completing the System Configuration
