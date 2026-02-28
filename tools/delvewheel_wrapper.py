# https://github.com/pypa/cibuildwheel/issues/766
#  run delvewheel with scipy_openblas32 dir at front of path

import sys, subprocess, os

import scipy_openblas32

path_elements = os.environ['PATH'].split(os.pathsep)
os.environ['PATH'] = os.pathsep.join([scipy_openblas32.get_lib_dir()] + path_elements)

subprocess.run(['delvewheel', *sys.argv[1:]], check=True)
