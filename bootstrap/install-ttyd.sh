#!/bin/bash

cd /tmp

LATEST_RELEASE_VERSION=$(curl -s https://api.github.com/repos/tsl0922/ttyd/releases/latest | jq -r '.tag_name')

curl -LO "https://github.com/tsl0922/ttyd/archive/refs/tags/$LATEST_RELEASE_VERSION.tar.gz"

tar xzf $LATEST_RELEASE_VERSION.tar.gz
rm $LATEST_RELEASE_VERSION.tar.gz

cd ttyd-$LATEST_RELEASE_VERSION

mkdir build && cd build

cmake ..

make

make install

rm -rf /tmp/ttyd-$LATEST_RELEASE_VERSION
