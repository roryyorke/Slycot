#!/usr/bin/env bash
set -ev

if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
    wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh;
else
    wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
fi

bash miniconda.sh -b -p $HOME/miniconda

export PATH="$HOME/miniconda/bin:$PATH"
hash -r
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda install -q conda-build
conda config --add channels http://conda.binstar.org/python-control
conda info -a
conda create -q -n test-environment python="$TRAVIS_PYTHON_VERSION" pip coverage nose

set +v
source activate test-environment
set -v

pip install -qqq coveralls
