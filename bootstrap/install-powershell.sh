#!/bin/bash

# Get the CPU architecture
ARCH=$(uname -m)

# Check the architecture and echo the result
if [ "$ARCH" = "aarch64" ]; then
    echo "The CPU architecture is aarch64"
elif [ "$ARCH" = "x86_64" ]; then
    echo "The CPU architecture is x86_64"
else
    echo "Unknown CPU architecture: $ARCH"
fi
