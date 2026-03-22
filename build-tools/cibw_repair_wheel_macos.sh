#!/bin/bash

# Wheel repair for macOS
#
#  Usage:
#    bash cibw_repair_wheel_macos.sh <dest-dir> <wheel> <project-root-dir>
#
# See gha_cibw_setup_macos.sh, which creates slycot-gfortran used here

set -ex

dest_dir=$1
wheel=$2
project_root=$3

# copied from Scipy
# See https://github.com/scipy/scipy/issues/20852
lib_loc=$project_root/build-libs

install_name_tool -change @loader_path/../.dylibs/libgfortran.5.dylib @rpath/libgfortran.5.dylib $lib_loc/libsci*
install_name_tool -change @loader_path/../.dylibs/libgcc_s.1.1.dylib @rpath/libgcc_s.1.1.dylib $lib_loc/libsci*
install_name_tool -change @loader_path/../.dylibs/libquadmath.0.dylib @rpath/libquadmath.0.dylib $lib_loc/libsci*

gfortran_libs=$(slycot-gfortran -print-search-dirs|grep "^libraries: ="|sed s/^libraries:\ =//)

if [ ! -z $DYLD_LIBRARY_PATH ]; then
    echo "DYLD_LIBRARY_PATH already set: $DYLD_LIBRARY_PATH";
    exit 1;
fi

export DYLD_LIBRARY_PATH=$lib_loc:$gfortran_libs

delocate-wheel -w $dest_dir $wheel
