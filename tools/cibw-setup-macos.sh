#!/bin/bash

set -ex

gfortran_bin=$(command -v gfortran-13)
gcc_bin=$(command -v gcc-13)

[ -x "${gfortran_bin}" ] || { echo "Fortran compiler ${gfortran_bin} doesn't exist or not executable"; exit 1; }
[ -x "${gcc_bin}" ] || { echo "C compiler ${gcc_bin} doesn't exist or not executable"; exit 1; }

sudo ln -sf "${gfortran_bin}" /usr/local/bin/slycot-gfortran
sudo ln -sf "${gcc_bin}" /usr/local/bin/slycot-gcc
