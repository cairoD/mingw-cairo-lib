#!/bin/bash

echo "Deleting old result directory"
rm -rf result
mkdir -p result/32/mars
mkdir -p result/32/msvc_mingw
mkdir -p result/64

CAIRO_64_LIB="/mingw64/bin/libcairo-2.dll"
CAIRO_32_LIB="/mingw32/bin/libcairo-2.dll"

CAIRO_64_LIBS="$(python2 mingw64-bundledlls.py $CAIRO_64_LIB) $CAIRO_64_LIB"
CAIRO_32_LIBS="$(python2 mingw32-bundledlls.py $CAIRO_32_LIB) $CAIRO_32_LIB"

echo ""
echo "Installing 32 bit libraries"
for i in $CAIRO_32_LIBS; do
  echo "    => $i"
  cp $i result/32/
  LANG=C pacman -Qi $(pacman -Qo --quiet $i) >> result/32/PACKAGES.info
done
echo "Generating import libraries"
cp /mingw32/lib/libcairo.dll.a result/32/msvc_mingw/cairo.lib
cmd.exe /C "implib /system result\\32\\mars\\cairo.lib $(cygpath -w $CAIRO_32_LIB)"


echo ""
echo "Installing 64 bit libraries"
for i in $CAIRO_64_LIBS; do
  echo "    => $i"
  cp $i result/64/
  LANG=C pacman -Qi $(pacman -Qo --quiet $i) >> result/64/PACKAGES.info
done
echo "Generating import libraries"
cp /mingw64/lib/libcairo.dll.a result/64/cairo.lib

# Copy Readme
cp README_bin.md result/README.md
