# Host Packages

Install the packages required by the LFS Host System Requirements.

## Verify host

```bash
./scripts/version-check.sh
```

## Required tools

- Bash
- Binutils
- Bison
- Coreutils
- Diffutils
- Findutils
- Gawk
- GCC (C/C++)
- Grep
- Gzip
- M4
- Make
- Patch
- Perl
- Python
- Sed
- Tar
- Texinfo
- Xz
- Git
- Wget

## Verify symbolic links

```bash
readlink -f /usr/bin/sh
readlink -f /usr/bin/awk
readlink -f /usr/bin/yacc
```

Expected:

```text
/usr/bin/bash
/usr/bin/gawk
/usr/bin/bison.yacc
```

If `/bin/sh` points to `dash`:

```bash
sudo ln -sf /bin/bash /bin/sh
```

Re-run:

```bash
./scripts/version-check.sh
```
