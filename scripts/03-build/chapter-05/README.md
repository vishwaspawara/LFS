# Building the Temporary Toolchain

this chapter builds temporary cross-toolchain that will be used to compile the initial LFS system. these tools are installed in `$LFS/tools`.

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

1. Buildutils (pass 1)   cross assembler, linker, and binary utilities
2. GCC (pass 1)          temp cross c/c++ compiler
3. linux API headers     headers required by Glibc
4. Glibc                 C standard library for the target system
5. Libstdc++             C++ standard library
- 


