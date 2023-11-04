#!/bin/bash


cd /tmp

LATEST_RELEASE_VERSION=$(curl -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | jq -r '.tag_name')

curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/$LATEST_RELEASE_VERSION/powershell-$(echo "$LATEST_RELEASE_VERSION" | tr -d "v")-linux-arm64.tar.gz

# Create the target folder where powershell will be placed
mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
