#!/usr/bin/env bash
set -ev

wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
bash miniconda.sh -b -p $HOME/miniconda

export PATH="$HOME/miniconda/bin:$PATH"
hash -r
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda install conda-build
conda info -a
conda create -q -n test-environment python="$TRAVIS_PYTHON_VERSION" pip coverage nose

set +v
source activate test-environment
set -v

pip install coveralls
