#!/bin/bash

set -ex

brew install binutils
objcopy_bin=$(brew list binutils|grep objcopy$)

gfortran_bin=$(command -v gfortran-13)
gcc_bin=$(command -v gcc-13)

[ -x "${gfortran_bin}" ] || { echo "Fortran compiler ${gfortran_bin} doesn't exist or not executable"; exit 1; }
[ -x "${gcc_bin}" ] || { echo "C compiler ${gcc_bin} doesn't exist or not executable"; exit 1; }
[ -x "${objcopy_bin}" ] || { echo "objcopy_bin ${objcopy_bin} doesn't exist or not executable"; exit 1; }

sudo ln -sf "${gfortran_bin}" /usr/local/bin/slycot-gfortran
sudo ln -sf "${gcc_bin}" /usr/local/bin/slycot-gcc
sudo ln -sf "${objcopy_bin}" /usr/local/bin/slycot-objcopy
