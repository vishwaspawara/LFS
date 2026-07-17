whoami 

ehco "should be root"

export LFS="/mnt/lfs"
echo 'check $LFS veriable should be /mnt/lfs'

mount /dev/nvme0n1p3 $LFS

mountpoint -q "$LFS" && echo "LFS mounted"

