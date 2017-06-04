#!/usr/bin/env bash
set -ev

export PATH="$HOME/miniconda/bin:$PATH"
hash -r

set +v
source activate test-environment
set -v

conda build --python "$TRAVIS_PYTHON_VERSION" conda-recipe
conda install slycot --use-local
