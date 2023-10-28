#!/bin/bash

cd /tmp

LATEST_RELEASE_VERSION=$(curl -s https://api.github.com/repos/magic-wormhole/magic-wormhole.rs/releases/latest | jq -r '.tag_name')

curl -LO "https://github.com/magic-wormhole/magic-wormhole.rs/archive/refs/tags/$LATEST_RELEASE_VERSION.tar.gz"

tar xzf $LATEST_RELEASE_VERSION.tar.gz

cargo install --path=magic-wormhole.rs-$LATEST_RELEASE_VERSION/cli

rm $LATEST_RELEASE_VERSION.tar.gz
rm -rf magic-wormhole.rs-$LATEST_RELEASE_VERSION

mv ~/.cargo/bin/wormhole-rs /usr/local/bin/
