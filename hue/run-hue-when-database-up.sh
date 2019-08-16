#!/bin/bash

set -e

echo "Installing essential packages..."
sudo apt-get --assume-yes install python-pip python3-dev \
libmysqlclient-dev \
zlib1g-dev

echo "Install MySQL-python..."
pip install MySQL-python

# echo "Install mysql-connector-"
# pip install mysql-connector-python

# echo "Install pymysql..."
# pip install pymysql

echo "Run connection test..."
python /opt/connection-test.py
