#!/usr/bin/env bash
set -e

if [ ! -z "$PYTHON_MAJOR" ]; then
    apt-get install -y python${PYTHON_MAJOR} python${PYTHON_MAJOR}-pip
    pip${PYTHON_MAJOR} install --upgrade pip
else
    echo "python install skipped"
fi
