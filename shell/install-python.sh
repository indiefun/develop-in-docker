#!/usr/bin/env bash
set -e

if [ -z "$PYTHON_MAJOR" ]; then
    echo "python install skipped"
    exit 0
fi

apt-get update
apt-get install -y python${PYTHON_MAJOR} python${PYTHON_MAJOR}-pip
pip${PYTHON_MAJOR} install --upgrade pip
