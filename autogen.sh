#!/bin/sh
bs_dir="$(dirname $(readlink -f $0))"
rm -rf "${bs_dir}"/autom4te.cache
rm -f "${bs_dir}"/aclocal.m4 "${bs_dir}"/ltmain.sh

echo 'Running autoreconf -if...'
aclocal --force -I m4
libtoolize --install --copy --force
autoheader --force
automake --add-missing --copy --force-missing
autoconf --force

if test -z "$NOCONFIGURE" ; then
	echo 'Configuring...'
	"$bs_dir"/configure "$@"
fi