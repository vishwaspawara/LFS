# Cross Compiling Temporary Tools

This chapter shows how to cross-compile basic utilities using the just tools compiled in chapter-05

Instruction while building the toolchain -
- login as 'lfs' user
- check if LFS environment is properly configured (`LFS`, `LFS_TGT`, `PATH`)


General build procedure for each package - 

1. `cd $LFS/sources`
2. `tar -xf <package-name>.tar` extract
3. `cd <package-name>` enter extracted dir
4. follow package specific build procedure
5. `cd $LFS/sources`
6. `rm -rf <package-name>/` remove extracted source tree.


Packages build in this phase -

1. m4 using `06-m4-1.4.21.sh`
2. ncurses using `07-ncurses-6.6.sh`
3. bash using `08-bash-5.3.sh`
4. coreutils using `09-coreutils-9.10.sh`
5. diffutils using `10.diffutils-3.12.sh`
6. file using `11-file-5.46.sh`
7. findutils using `12-findutils-4.10.0.sh` this provide `find` `locate` `xargs` and `updatedb` tools
8. gaws using `13.gawk-5.3.2.sh` gnu inplementation of awk language.
9. grep using `14-grep-3.12.sh`
10. gzip using `15-gzip-1.14.sh`
11. make using `16-make-1.4.4.sh`
12. patch using `17-patch-2.8.sh`
13. sed using `18-sed-4.9.sh`
14. tar using `19-tar-1.35.sh`
15. xz using `20-xz-5.8.2.sh` this is heavily used compression tool (someone even tried to compromise this - almost succeeded)
16. binutils-pass2 using `21-binutils-2.46.0.sh`

The difference between pass1 and pass2 of binutils.

Pass1	
Installed in `$LFS/tools`
Temporary cross-toolchain	
Used to bootstrap Glibc and other temporary tools	
Built before `Glibc`

Pass 2
Installed in `$LFS/usr`
Final LFS toolchain
Used by the completed LFS system
Built after `Glibc` is available

17. gcc using `22-gcc-15.2.sh`

GCC Pass 1 vs Pass 2

Pass 1	
Installed in $LFS/tools	
Cross-compiler used to bootstrap the system	
Built without Glibc headers or libraries	
Minimal runtime support	

Pass 2
Installed in $LFS/usr
Compiler intended for the final LFS system
Built against the target Glibc
Provides the standard C and C++ toolchain for LFS


both pass 2 replaces the temp pass 1 ($LFS/tools). 


With this GCC it completes the Cross Compiling Temporary Tools

```bash

build (debian)
    |
    v
Temporary Toolchain ($LFS/tools)
    |
    v
Programs installation into $LFS/usr

```
