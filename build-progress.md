10/07/2026

### Host system configuration

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

