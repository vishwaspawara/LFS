10/07/2026

## Host system configuration

installing all the systems required for build and confirming by `./scripts/version-chek.sh`

the solution was to manually change the simlink from `/bin/dash` to /bin/bash` using the command
```bash
sudo ln -sf /bin/bash /bin/sh
```

```bash
OK:    Coreutils 9.7    >= 8.1
OK:    Bash      5.2.37 >= 3.2
OK:    Binutils  2.44   >= 2.13.1
OK:    Bison     3.8.2  >= 2.7
OK:    Diffutils 3.10   >= 2.8.1
OK:    Findutils 4.10.0 >= 4.2.31
OK:    Gawk      5.2.1  >= 4.0.1
OK:    GCC       14.2.0 >= 5.4
OK:    GCC (C++) 14.2.0 >= 5.4
OK:    Grep      3.11   >= 2.5.1a
OK:    Gzip      1.13   >= 1.3.12
OK:    M4        1.4.19 >= 1.4.10
OK:    Make      4.4.1  >= 4.0
OK:    Patch     2.8    >= 2.5.4
OK:    Perl      5.40.1 >= 5.8.8
OK:    Python    3.13.5 >= 3.4
OK:    Sed       4.9    >= 4.1.5
OK:    Tar       1.35   >= 1.22
OK:    Texinfo   7.1.1  >= 5.0
OK:    Xz        5.8.1  >= 5.0.0
OK:    Linux Kernel 6.12.95 >= 5.10
OK:    Linux Kernel supports UNIX 98 PTY
Aliases:
OK:    awk  is GNU
OK:    yacc is Bison
OK:    sh   is Bash
Compiler check:
OK:    g++ works
OK: nproc reports 12 logical cores are available
```

setting up `git`

generating ssh key pair
`ssh-keygen -t ed25519 -C "vishwaspawara07@gmail.com"`
copying the public key to github
`cat ~/.ssh/id_ed25519.pub |copy`
confirm remot key registration
`ssh -T git@github.com`
create global config for email and name
`git config --global user.email "vishwaspawara07@gmail.com"`
`git config --global user.name "vishwaspawara"`
init the repo
`git remote set-url origin git@github.com:vishwaspawara/LFS.git`
first commit
`git commit -m "setting up git and host for lfs"`
push changes
`git push -u origin main`


### creating partition on host

created partition of 50GB
`sudo cfdisk /dev/nvme0n1`
`sudo e2label /dev/nvme0n1p3 lfs13.0+` gave name lfs13.0+
`sudo mkfs.ext4 /dev/nvme0n1p3` format the partition to `ext4`

Setting $LFS variable and Umask
Appending the same to `~/.bashrc` for persistence
`export LFS=/mnt/lfs/`
`sudo mkdir -pv /mnt/lfs`
`umask 022`


Since this is environment setup and I have no idea how long this is going to take I'm creating `scripts/lfs-env.sh` to handle setup.


11/07/2026

lauched the evn setup script and learned about the difference between `source <filename>` and `bash <filename>`, Sourcing alters the current shell while bash creates a child shell and executes and exists.


### Packages and patches

creating a dir to store downloaded packages.


`sudo mkdir -v $LFS/sources`
making created dir writable and sticky
`sudo chmod -v a+wt $LFS/sources/`
`wget --input-file=wget-list-systemd --continue --directory-prefix=$LFS/sources/`
starting the download of packages I will be using provided list `wget-list-systemd`
start - Saturday 11 July 2026 01:11:04 PM IST
end -   Saturday 11 July 2026 01:39:33 PM IST

```bash
total 631520
-rw-r--r-- 1 vishwas vishwas    384828 Jun 29 17:14 acl-2.4.0.tar.xz
-rw-r--r-- 1 vishwas vishwas    506247 Jun 29 17:14 attr-2.6.0.tar.gz
-rw-r--r-- 1 vishwas vishwas   1417428 Mar 21 01:01 autoconf-2.73.tar.xz
-rw-r--r-- 1 vishwas vishwas   1652392 Jun 27  2025 automake-1.18.1.tar.xz
-rw-r--r-- 1 vishwas vishwas  11355854 Jul 30  2025 bash-5.3.tar.gz
-rw-r--r-- 1 vishwas vishwas    474800 Sep 24  2024 bc-7.0.3.tar.xz
-rw-r--r-- 1 vishwas vishwas  28636456 Jun  9 04:18 binutils-2.46.1.tar.xz
-rw-r--r-- 1 vishwas vishwas   2817324 Sep 25  2021 bison-3.8.2.tar.xz
-rw-r--r-- 1 vishwas vishwas      1684 Jul 11 12:38 bzip2-1.0.8-install_docs-1.patch
-rw-r--r-- 1 vishwas vishwas    810029 Jul 13  2019 bzip2-1.0.8.tar.gz
-rw-r--r-- 1 vishwas vishwas     67821 Jul 11 12:38 coreutils-9.11-i18n-1.patch
-rw-r--r-- 1 vishwas vishwas   6562420 Apr 20 19:32 coreutils-9.11.tar.xz
-rw-r--r-- 1 vishwas vishwas   1115644 Feb 27  2025 dbus-1.16.2.tar.xz
-rw-r--r-- 1 vishwas vishwas    622059 Jun 17  2021 dejagnu-1.6.3.tar.gz
-rw-r--r-- 1 vishwas vishwas   1938800 Apr  9  2025 diffutils-3.12.tar.xz
-rw-r--r-- 1 vishwas vishwas  10106395 Mar  7 09:37 e2fsprogs-1.47.4.tar.gz
-rw-r--r-- 1 vishwas vishwas  12032640 Apr 16 04:00 elfutils-0.195.tar.bz2
-rw-r--r-- 1 vishwas vishwas    515504 Jun 25 19:48 expat-2.8.2.tar.xz
-rw-r--r-- 1 vishwas vishwas     12155 Jul 11 12:38 expect-5.45.4-gcc15-1.patch
-rw-r--r-- 1 vishwas vishwas    632363 Feb  4  2018 expect5.45.4.tar.gz
-rw-r--r-- 1 vishwas vishwas   2693209 Jun  8 05:19 file-5.48.tar.gz
-rw-r--r-- 1 vishwas vishwas   2240712 Jun  1  2024 findutils-4.10.0.tar.xz
-rw-r--r-- 1 vishwas vishwas   1419096 Dec  7  2021 flex-2.6.4.tar.gz
-rw-r--r-- 1 vishwas vishwas     53690 Mar 25  2025 flit_core-3.12.0.tar.gz
-rw-r--r-- 1 vishwas vishwas   3803276 Feb 22 20:23 gawk-5.4.0.tar.xz
-rw-r--r-- 1 vishwas vishwas 102456900 Apr 30 14:57 gcc-16.1.0.tar.xz
-rw-r--r-- 1 vishwas vishwas   1226591 Jul 30  2025 gdbm-1.26.tar.gz
-rw-r--r-- 1 vishwas vishwas  10721600 Jan 29 05:44 gettext-1.0.tar.xz
-rw-r--r-- 1 vishwas vishwas  20297012 Jan 24 04:14 glibc-2.43.tar.xz
-rw-r--r-- 1 vishwas vishwas     50118 Jul 11 12:38 glibc-2.43-upstream_fixes-1.patch
-rw-r--r-- 1 vishwas vishwas      2804 Jul 11 12:38 glibc-fhs-1.patch
-rw-r--r-- 1 vishwas vishwas   2094196 Jul 30  2023 gmp-6.3.0.tar.xz
-rw-r--r-- 1 vishwas vishwas   1831294 Apr 20  2025 gperf-3.3.tar.gz
-rw-r--r-- 1 vishwas vishwas   1918448 Apr 10  2025 grep-3.12.tar.xz
-rw-r--r-- 1 vishwas vishwas   9005760 Mar 14 13:31 groff-1.24.1.tar.gz
-rw-r--r-- 1 vishwas vishwas   7725668 Jan 15 02:00 grub-2.14.tar.xz
-rw-r--r-- 1 vishwas vishwas    885748 Apr 10  2025 gzip-1.14.tar.xz
-rw-r--r-- 1 vishwas vishwas    609684 Jun 21 12:49 iana-etc-20260617.tar.gz
-rw-r--r-- 1 vishwas vishwas   2985957 Apr 29 20:19 inetutils-2.8.tar.gz
-rw-r--r-- 1 vishwas vishwas    964700 Jun 16 04:20 iproute2-7.1.0.tar.xz
-rw-r--r-- 1 vishwas vishwas    245115 Mar  6  2025 jinja2-3.1.6.tar.gz
-rw-r--r-- 1 vishwas vishwas     12640 Jul 11 12:38 kbd-2.10.0-backspace-1.patch
-rw-r--r-- 1 vishwas vishwas   1788500 May 25 13:10 kbd-2.10.0.tar.xz
-rw-r--r-- 1 vishwas vishwas    443748 Mar 28  2025 kmod-34.2.tar.xz
-rw-r--r-- 1 vishwas vishwas    996650 Jun  6 23:12 less-704.tar.gz
-rw-r--r-- 1 vishwas vishwas    201040 Apr  6 19:08 libcap-2.78.tar.xz
-rw-r--r-- 1 vishwas vishwas   1475449 Jun 20 19:29 libffi-3.6.0.tar.gz
-rw-r--r-- 1 vishwas vishwas   1056924 Nov 21  2024 libtool-2.5.4.tar.xz
-rw-r--r-- 1 vishwas vishwas    669820 Nov 10  2025 libxcrypt-4.5.2.tar.xz
-rw-r--r-- 1 vishwas vishwas 158323320 Jun 27 16:00 linux-7.1.2.tar.xz
-rw-r--r-- 1 vishwas vishwas    387114 Jul 22  2024 lz4-1.10.0.tar.gz
-rw-r--r-- 1 vishwas vishwas   2080016 Feb  7 01:44 m4-1.4.21.tar.xz
-rw-r--r-- 1 vishwas vishwas   2348200 Feb 27  2023 make-4.4.1.tar.gz
-rw-r--r-- 1 vishwas vishwas   2110328 May  2  2025 man-db-2.13.1.tar.xz
-rw-r--r-- 1 vishwas vishwas   1902724 Apr 23 00:55 man-pages-6.18.tar.xz
-rw-r--r-- 1 vishwas vishwas     80313 Sep 28  2025 markupsafe-3.0.3.tar.gz
-rw-r--r-- 1 vishwas vishwas   5190321 Apr 21 08:47 meson-1.11.1.tar.gz
-rw-r--r-- 1 vishwas vishwas    531992 Apr 16 18:35 mpc-1.4.1.tar.xz
-rw-r--r-- 1 vishwas vishwas   1505596 Mar 20  2025 mpfr-4.2.2.tar.xz
-rw-r--r-- 1 vishwas vishwas   3791150 Dec 31  2025 ncurses-6.6.tar.gz
-rw-r--r-- 1 vishwas vishwas    292385 Jul 11 13:31 ninja-1.13.2.tar.gz
-rw-r--r-- 1 vishwas vishwas  55079428 Jun  9 17:10 openssl-4.0.1.tar.gz
-rw-r--r-- 1 vishwas vishwas    228134 Apr 25 01:45 packaging-26.2.tar.gz
-rw-r--r-- 1 vishwas vishwas    907208 Mar 29  2025 patch-2.8.tar.xz
-rw-r--r-- 1 vishwas vishwas   2145789 Oct 21  2025 pcre2-10.47.tar.bz2
-rw-r--r-- 1 vishwas vishwas  14483976 Mar 29 19:44 perl-5.42.2.tar.xz
-rw-r--r-- 1 vishwas vishwas    328064 Jun 25  2025 pkgconf-2.5.1.tar.xz
-rw-r--r-- 1 vishwas vishwas   1580516 Jan 29 15:45 procps-ng-4.0.6.tar.xz
-rw-r--r-- 1 vishwas vishwas    432208 Mar  5  2024 psmisc-23.7.tar.xz
-rw-r--r-- 1 vishwas vishwas     37417 Jul 11 12:38 Python-3.14.6-consolidated_fixes-1.patch
-rw-r--r-- 1 vishwas vishwas  11003726 Jun 10 16:19 python-3.14.6-docs-html.tar.bz2
-rw-r--r-- 1 vishwas vishwas  23921184 Jun 10 16:19 Python-3.14.6.tar.xz
-rw-r--r-- 1 vishwas vishwas   3419642 Jul  4  2025 readline-8.3.tar.gz
-rw-r--r-- 1 vishwas vishwas   1732800 Apr 22 07:16 sed-4.10.tar.xz
-rw-r--r-- 1 vishwas vishwas   1152316 Mar  9 18:17 setuptools-82.0.1.tar.gz
-rw-r--r-- 1 vishwas vishwas   2332684 Mar  2 19:38 shadow-4.19.4.tar.xz
-rw-r--r-- 1 vishwas vishwas   3282443 Jun 27 02:15 sqlite-autoconf-3530300.tar.gz
-rw-r--r-- 1 vishwas vishwas   6221676 Jun 28 08:11 sqlite-doc-3530300.tar.xz
-rw-r--r-- 1 vishwas vishwas  18405830 Jul 11 13:33 systemd-261.1.tar.gz
-rw-r--r-- 1 vishwas vishwas    820408 Jun 29 02:26 systemd-man-pages-261.1.tar.xz
-rw-r--r-- 1 vishwas vishwas      4333 Jul 11 12:38 tar-1.35-acl_fix-1.patch
-rw-r--r-- 1 vishwas vishwas   2317208 Jul 18  2023 tar-1.35.tar.xz
-rw-r--r-- 1 vishwas vishwas   1197786 May 12 01:51 tcl8.6.18-html.tar.gz
-rw-r--r-- 1 vishwas vishwas  11816279 May 12 01:54 tcl8.6.18-src.tar.gz
-rw-r--r-- 1 vishwas vishwas   6940392 Mar  2 23:17 texinfo-7.3.tar.xz
-rw-r--r-- 1 vishwas vishwas    473703 Apr 23 17:21 tzdata2026b.tar.gz
-rw-r--r-- 1 vishwas vishwas  10658220 Jun 16 17:53 util-linux-2.42.2.tar.xz
-rw-r--r-- 1 vishwas vishwas  19912527 Jul 11 13:36 vim-9.2.0752.tar.gz
-rw-r--r-- 1 root    root         6096 Jul 11 13:05 wget-list-systemd
-rw-r--r-- 1 vishwas vishwas     63854 Apr 22 21:21 wheel-0.47.0.tar.gz
-rw-r--r-- 1 vishwas vishwas   1548064 Mar 31 21:26 xz-5.8.3.tar.xz
-rw-r--r-- 1 vishwas vishwas   1502830 Feb 17 18:17 zlib-1.3.2.tar.gz
-rw-r--r-- 1 vishwas vishwas   2434947 Feb 20  2025 zstd-1.5.7.tar.gz
```
Creating limited dir for LFS and creating the symlinks

`sudo LFS="$LFS" bash scripts/create-limited-dir.sh`

```bash
sudo LFS="$LFS" bash scripts/create-limited-dir.sh 
mkdir: created directory '/mnt/lfs/etc'
mkdir: created directory '/mnt/lfs/var'
mkdir: created directory '/mnt/lfs/usr'
mkdir: created directory '/mnt/lfs/usr/bin'
mkdir: created directory '/mnt/lfs/usr/lib'
mkdir: created directory '/mnt/lfs/usr/sbin'
'/mnt/lfs/bin' -> 'usr/bin'
'/mnt/lfs/lib' -> 'usr/lib'
'/mnt/lfs/sbin' -> 'usr/sbin'
mkdir: created directory '/mnt/lfs/lib64'
mkdir: created directory '/mnt/lfs/tools'
```
now configuring the lfs user
`sudo groupadd lfs`
created group lfs
`sudo useradd -s /bin/bash -g lfs -m -k /dev/net/ lfs`

`-s /bin/bash` default shell for user lfs
`-m` this creates home dir for lfs
`-k /dev/null` prevents skeleton sturcure copying
`lfs` is name of user
`sudo passwd lfs` added password for the user (hint: pucsd convention)

giving ownership of $LFS to lfs user

`chown -v lfs $LFS/{usr/{,/*},var,etc,tools,lib64}`

```bash
changed ownership of '/mnt/lfs/usr' from root to lfs
changed ownership of '/mnt/lfs/usr/bin' from root to lfs
changed ownership of '/mnt/lfs/usr/lib' from root to lfs
changed ownership of '/mnt/lfs/usr/sbin' from root to lfs
changed ownership of '/mnt/lfs/var' from root to lfs
changed ownership of '/mnt/lfs/etc' from root to lfs
changed ownership of '/mnt/lfs/tools' from root to lfs
changed ownership of '/mnt/lfs/lib64' from root to lfs
```
`su - lfs` testing if created user is working

Now since `lsf` user is created build will completed using this user.

### setting up environment for lsf user.

creating minimal `.bash_profile` 

```bash
lfs@vshws:~$ cat > ~/.bash_profile << "EOF"
 exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
 EOF
```

creating minimal `.bashrc`

```bash
lfs@vshws:~$ cat > ~/.bashrc << "EOF"
 set +h
 umask 022
 LFS=/mnt/lfs
 LC_ALL=POSIX
 LFS_TGT=$(uname -m) -lfs-linux-gnu
 PATH=/usr/bin
 
 if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
 
 PATH=$LFS/tools/bin:$PATH
 
 CONFIG_SITE=$LFS/usr/share/config.site
 
 export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
 EOF
```
Meaning of each setting is `.bashrc`
`set +h` this turns of bash hash function - turning this off forces bash to search whole path so newly installed tools are available as soon as they're installed.
`umask 022` write permision
`LFS=/mnt/lfs` variable
`LC_ALL=POSIX` localization of certain program, this ensures everything will work as expetecd in the cross-compilation environment.
`PATH=/usr/bin` since many distros merge `/bin` and `/usr/bin` if not following set `/bin` as PATH
`PATH=$LFS/tools/bin:$PATH` to limit the risk of host compiler is used instead 
the recently installed.
`CONFIG_SITE=$LFS/usr/share/config.site` used by configure scripts default is host but lfs should be used.
`export` makes all the variables visible within any sub-shells.


The following command will be run as root.
`[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE`
syntax explanation - when first condition is false then only second argument will be executed, rename if file does not exist.
this is required as bash reads configuration from `/etc/profile`, `/etc/bash.bashrc`, `/.bash_profile` and `/.bashrc` so when one logs in as lfs it is possible system configuration to mess up lfs build

back to `lfs` user 
adding make flag for cores since my host system has 12 cores i'll execute `make -j12`, adding `export MAKEFLAGS=-j$(nproc)` to `.bashrc` of `lfs` user.



## 3. Building the LFS Cross Toolchain and Temporary Tools.

