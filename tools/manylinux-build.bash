#!/bin/bash

if [ ! -f ./tools/manylinux-build.bash ]; then
    echo "Run this from project root"
    exit 1;
fi

docker run -v ~/.cache/pip:/.cache/pip -v .:/example --user $UID --rm --env PYTHON=python3.13 quay.io/pypa/manylinux_2_28_x86_64:latest /bin/bash -c "cd /example && ./tools/build-and-repair.bash"
