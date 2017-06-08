#!/usr/bin/env bash
set -ev

(cd slycot/tests && python -m unittest discover)
