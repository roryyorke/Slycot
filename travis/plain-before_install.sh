#!/usr/bin/env bash
set -ev

python -m venv --clear slycot

source slycot/bin/activate

pip install --upgrade pip
pip install --upgrade setuptools # ?
pip install numpy
pip install coverage
pip install nose
pip install coveralls
