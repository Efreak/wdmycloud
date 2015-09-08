#!/bin/bash
# build-armhf-package.sh <--pagesize=64k or 4k> <package_name> <suite> 
#
# This script will build a package for armhf given <package_name> and <suite>.  
# Currently, <suite> can be either "wheezy" or "jessie".
# This script is intended to run on a x86 PC, with either 64-bit Ubuntu or Debian installed.
#


usage() 
{
	echo "Usage: build-armhf-package.sh <--pagesize=64k or 4k> <suite> <package_name>"
	exit 1
}

if [ $# -ne 3 ]; then
	usage
fi

if [ "$1" == "--pagesize=64k" ]; then
	BUILD_64K="true"
elif [ "$1" != "--pagesize=4k" ]; then
	usage
fi

export package_name=$3
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

sudo chroot $build_dir /bin/bash -x <<EOF
cd /root/binutils
dpkg -i binutils_*.deb
dpkg -i binutils-multiarch_*.deb
EOF

fi

sudo chroot $build_dir /bin/bash -x <<EOF
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LC_ALL=C
export LANGUAGE=C
export LANG=C
export DEB_CFLAGS_APPEND='-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE'
export DEB_BUILD_OPTIONS=nocheck

cd /root
apt-get update
apt-get -y build-dep $package_name
apt-get -y source --compile $package_name

umount /proc
umount /dev/pts
umount /dev

exit
EOF

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo " OUTPUT debs can be found here:        "
find $build_dir/root/ -maxdepth 1 -type f -name "*.deb"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
