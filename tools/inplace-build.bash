#!/bin/bash

# Demonstrate in-place, editable install
#
#  This re-uses the build directory, including CMake config, and is
#  fastest when doing iterative development.
#
#  The downside is that this is somewhat fragile: although the build
#  tools (scikit-build-core, CMake, and ninja) are pretty good about
#  detecting and handling changes to the source, they're not perfect,
#  and one can end up with apparently impossible results that go away
#  when doing a clean build.

set -euo pipefail

if [ ! -f ./tools/inplace-build.bash ]; then
    echo "Run this from project root"
    exit 1;
fi

echo "--Build"
python -m venv venv-build
source venv-build/bin/activate

pip install --progress-bar off setuptools_scm scikit-build-core numpy scipy_openblas32 auditwheel patchelf pytest scipy

pip install --no-build-isolation --editable . --verbose --config-settings skbuild.build.verbose=true --config-settings skbuild.build-dir=build

pytest --pyargs slycot
