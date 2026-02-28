#!/bin/bash

set -euo pipefail

output_dir=$PWD

workdir=$(mktemp --tmpdir --directory)

echo "--Build"
$PYTHON -m venv $workdir/build
source $workdir/build/bin/activate

pip install --progress-bar off setuptools_scm scikit-build-core numpy scipy_openblas32 auditwheel patchelf

pip wheel --progress-bar off --verbose --wheel-dir $workdir/inwheels --no-build-isolation .

OPENBLAS_DIR=$(python -c 'import scipy_openblas32; import os.path; print(scipy_openblas32.get_lib_dir())')

echo "--Repair"
LD_LIBRARY_PATH=$OPENBLAS_DIR auditwheel repair --wheel-dir $workdir/wheelhouse $workdir/inwheels/slycot*.whl

deactivate

echo "--Test"

$PYTHON -m venv $workdir/test
source $workdir/test/bin/activate
pip install --progress-bar off $workdir/wheelhouse/slycot*.whl
pip install --progress-bar off pytest

# cd $workdir
# python -m slycot.test

echo "--Copy"

cp --recursive $workdir/wheelhouse $output_dir
