#!/bin/bash

set -euo pipefail
set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "script dir is ${SCRIPT_DIR}"

BUILD_ENV=$(mktemp --tmpdir --directory slycot-build.XXXXXX)

DIST_DIR=$(mktemp --tmpdir --directory slycot-dist.XXXXXX)

python -m venv "${BUILD_ENV}"

source "${BUILD_ENV}/bin/activate"

python -m pip install build

python -m build "${SCRIPT_DIR}/.." "--outdir=${DIST_DIR}"

deactivate

INSTALL_ENV=$(mktemp --tmpdir --directory slycot-install.XXXXXX)

python -m venv "${INSTALL_ENV}"
source "${INSTALL_ENV}/bin/activate"
WHLNAME=$(find "${DIST_DIR}" -iname *.whl)
python -m pip install ${WHLNAME}[test]

pytest --pyargs slycot

deactivate

echo rm -r "${INSTALL_ENV}"
echo rm -r "${DIST_DIR}"
echo rm -r "${BUILD_ENV}"
