#!/usr/bin/env bash
set -ev

export PATH="$HOME/miniconda/bin:$PATH"
hash -r
source activate test-environment

conda build --python "$TRAVIS_PYTHON_VERSION" conda-recipe
conda install slycot --use-local
