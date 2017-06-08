#!/usr/bin/env bash
set -ev

sudo apt-get install -qq liblapack-dev;

# To get wheels when using Ubuntu 14.04, this is necessary; perhaps not otherwise
pip install -qqq --upgrade pip
# TODO: not sure we care about version of setuptools
pip install -qqq --upgrade setuptools
pip install -qqq numpy
pip install -qqq coverage
pip install -qqq nose
pip install -qqq coveralls
