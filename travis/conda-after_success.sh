#!/usr/bin/env bash
set -ev

export PATH="$HOME/miniconda/bin:$PATH"
hash -r

set +v
source activate test-environment
set -v

coveralls
