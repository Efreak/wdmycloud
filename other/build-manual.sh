#!/bin/bash
# build-armhf-package.sh <--pagesize=64k or 4k> <package_name> <suite> 
#
# This script will build a package for armhf given <package_name> and <suite>.  
# Currently, <suite> can be either "wheezy" or "jessie".
# This script is intended to run on a x86 PC, with either 64-bit Ubuntu or Debian installed.
#


usage() 
{
	echo "Usage: build-armhf-package.sh <--pagesize=64k or 4k> <suite>"
	exit 1
}

if [ $# -lt 2 ]; then
	usage
fi

if [ "$1" == "--pagesize=64k" ]; then
	BUILD_64K="true"
elif [ "$1" != "--pagesize=4k" ]; then
	usage
fi

suite=$2
build_dir="build"
binutils_tar="binutils/binutils-armhf-64k.tar.gz"

case "$suite" in
    "wheezy" )
	    bootstrap="bootstrap/wheezy-bootstrap_1.24.14_armhf.tar.gz"
	    ;;
    "jessie" )
	    bootstrap="bootstrap/jessie-bootstrap_5.14.14_armhf.tar.gz"
	    ;;
	* ) 
        usage
        ;;
esac

./setup.sh $bootstrap $build_dir

if [ "$BUILD_64K" == "true" ]; then
	mkdir -p $build_dir/root/binutils
	tar xvf $binutils_tar -C $build_dir/root/binutils

sudo chroot $build_dir /bin/bash <<EOF
cd /root/binutils
dpkg -i binutils_*.deb
dpkg -i binutils-multiarch_*.deb
EOF

fi

# setup the chroot for building
sudo chroot $build_dir /bin/bash <<EOF
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LC_ALL=C
export LANGUAGE=C
export LANG=C
export DEB_CFLAGS_APPEND='-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE'
export DEB_BUILD_OPTIONS=nocheck
apt-get update
EOF

# setup vars for text below
for item in ${@};do
if [ ${item} == "--pagesize=4k" ]; then
pagesize=4k
elif [ ${item} == "--pagesize=64k" ]; then
pagesize=64k
elif [ ${item} == "wheezy" ]; then
dist=wheezy
elif [ ${item} == "jessie" ]; then
dist=jessie
fi
done

sudo chroot $build_dir /bin/bash

# clean up/unmount the chroot
sudo chroot $build_dir /bin/bash <<EOF
umount /proc
umount /dev/pts
umount /dev
exit
EOF

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo " Chroot directory is $build_dir. It probably has root-only permissions."
find $build_dir/root/ -maxdepth 1 -type f -name "*.deb"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
