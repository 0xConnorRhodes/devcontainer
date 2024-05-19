#!/bin/bash

cd /tmp

arch=$(uname -m)
if [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    CPU_ARCHITECTURE="arm64"
elif [ "$arch" = "x86_64" ]; then
    CPU_ARCHITECTURE="x64"
fi

LATEST_RELEASE_VERSION=$(curl -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | jq -r '.tag_name')

curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/$LATEST_RELEASE_VERSION/powershell-$(echo "$LATEST_RELEASE_VERSION" | tr -d "v")-linux-$CPU_ARCHITECTURE.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh