#!/usr/bin/env bash
set -ev

sudo apt-get install liblapack-dev
pip install --upgrade pip
pip install --upgrade setuptools # TBD: is this necessary?
pip install numpy
pip install coverage
pip install nose
pip install coveralls
