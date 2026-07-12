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
