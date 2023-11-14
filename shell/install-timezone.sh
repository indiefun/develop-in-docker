#!/usr/bin/env bash
set -e

TZ=${TZ-"UTC"}
apt-get update
apt-get install -yq tzdata
ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
