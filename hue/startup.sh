#!/bin/sh


set -e

echo "Installing essential packages..."
sudo apt-get --assume-yes install python-pip zlib1g-dev

echo "Install MySQL-python..."
pip install MySQL-python


echo "Run connection test..."
python /opt/connection-test.py

./build/env/bin/hue syncdb --noinput
./build/env/bin/hue migrate
./build/env/bin/supervisor
