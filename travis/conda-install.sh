#!/usr/bin/env bash
set -ev

export PATH="$HOME/miniconda/bin:$PATH"
hash -r

set +v
source activate test-environment
set -v

# this will also run the unit tests; see ../conda-recipe/meta.yaml
conda build --python "$TRAVIS_PYTHON_VERSION" conda-recipe
