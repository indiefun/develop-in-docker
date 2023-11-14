#!/usr/bin/env bash
set -e

if [ -z "$ODOO_VERSION" ]; then
    echo "odoo install skipped"
    exit 0
fi

if [ -z `command -v pip3` ]; then
    echo "SHOULD install python3 first by set build args PYTHON_MAJOR=3"
    exit 1
fi

if [ -z `command -v npm` ]; then
    echo "SHOULD install nodejs first by set build args NODE_MAJOR=20"
    exit 1
fi

apt-get update
apt-get install -y libldap2-dev libpq-dev libsasl2-dev wkhtmltopdf
npm install --global rtlcss
git clone -b ${ODOO_VERSION} --single-branch --depth=1 https://github.com/odoo/odoo.git
pip3 install -r odoo/requirements.txt
chown -R ubuntu:ubuntu odoo
