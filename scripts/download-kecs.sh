#!/bin/bash
set -e

VERSION="${1:-latest}"

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $ARCH in
  x86_64) KECS_ARCH="amd64" ;;
  aarch64|arm64) KECS_ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

if [ "$VERSION" = "latest" ]; then
  # Get latest release
  echo "Fetching latest KECS release..."
  VERSION=$(curl -s https://api.github.com/repos/nandemo-ya/kecs/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  if [ -z "$VERSION" ]; then
    echo "Failed to fetch latest version"
    exit 1
  fi
  echo "Latest version: $VERSION"
fi

# Download binary
BINARY_NAME="kecs-${OS}-${KECS_ARCH}"
URL="https://github.com/nandemo-ya/kecs/releases/download/${VERSION}/${BINARY_NAME}"

echo "Downloading KECS ${VERSION} for ${OS}/${KECS_ARCH}..."
echo "URL: ${URL}"

curl -L "$URL" -o /tmp/kecs

if [ ! -f /tmp/kecs ]; then
  echo "Failed to download KECS"
  exit 1
fi

chmod +x /tmp/kecs
sudo mv /tmp/kecs /usr/local/bin/kecs

echo "KECS installed successfully:"
kecs version
