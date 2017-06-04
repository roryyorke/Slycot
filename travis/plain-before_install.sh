#!/usr/bin/env bash
set -ev

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    sudo apt-get install liblapack-dev;
fi

pip install --upgrade pip
pip install --upgrade setuptools # TBD: is this necessary?
pip install numpy
pip install coverage
pip install nose
pip install coveralls
