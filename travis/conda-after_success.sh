#!/usr/bin/env bash
set -ev

export PATH="$HOME/miniconda/bin:$PATH"
hash -r
source activate test-environment

coveralls
