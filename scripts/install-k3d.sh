#!/bin/bash
set -e

# Install k3d if not already installed
if command -v k3d &> /dev/null; then
    echo "k3d is already installed"
    k3d version
    exit 0
fi

echo "Installing k3d..."

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    armv7l)
        ARCH="arm"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Download and install k3d
K3D_VERSION=${K3D_VERSION:-v5.8.3}
DOWNLOAD_URL="https://github.com/k3d-io/k3d/releases/download/${K3D_VERSION}/k3d-${OS}-${ARCH}"

echo "Downloading k3d from $DOWNLOAD_URL"
curl -L -o /tmp/k3d "$DOWNLOAD_URL"
chmod +x /tmp/k3d
sudo mv /tmp/k3d /usr/local/bin/k3d

# Verify installation
k3d version

echo "k3d installed successfully"
