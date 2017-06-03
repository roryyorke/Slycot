#!/usr/bin/env bash
set -ev

source slycot/bin/activate

python runtests.py --coverage
