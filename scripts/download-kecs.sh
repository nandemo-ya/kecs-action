#!/bin/bash
set -e

VERSION="${1:-latest}"

# Detect OS and architecture
OS=$(uname -s)  # Darwin or Linux
ARCH=$(uname -m)

case $ARCH in
  x86_64) KECS_ARCH="x86_64" ;;
  aarch64|arm64) KECS_ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

if [ "$VERSION" = "latest" ]; then
  # Get latest release (first item from releases list)
  echo "Fetching latest KECS release..."
  VERSION=$(curl -s https://api.github.com/repos/nandemo-ya/kecs/releases | grep -m 1 '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  if [ -z "$VERSION" ]; then
    echo "Failed to fetch latest version"
    exit 1
  fi
  echo "Latest version: $VERSION"
fi

# Remove 'v' prefix from version for archive name
VERSION_NO_V="${VERSION#v}"

# Construct archive name: kecs_VERSION_OS_ARCH.tar.gz
ARCHIVE_NAME="kecs_${VERSION_NO_V}_${OS}_${KECS_ARCH}.tar.gz"
URL="https://github.com/nandemo-ya/kecs/releases/download/${VERSION}/${ARCHIVE_NAME}"

echo "Downloading KECS ${VERSION} for ${OS}/${KECS_ARCH}..."
echo "Archive: ${ARCHIVE_NAME}"
echo "URL: ${URL}"

# Download and extract
curl -L "$URL" -o /tmp/kecs.tar.gz

if [ ! -f /tmp/kecs.tar.gz ]; then
  echo "Failed to download KECS"
  exit 1
fi

# Extract binary
tar -xzf /tmp/kecs.tar.gz -C /tmp

# Find the kecs binary (might be just 'kecs' in the archive)
if [ -f /tmp/kecs ]; then
  chmod +x /tmp/kecs
  sudo mv /tmp/kecs /usr/local/bin/kecs
elif [ -f /tmp/bin/kecs ]; then
  chmod +x /tmp/bin/kecs
  sudo mv /tmp/bin/kecs /usr/local/bin/kecs
else
  echo "Failed to find kecs binary in archive"
  exit 1
fi

# Cleanup
rm -f /tmp/kecs.tar.gz

echo "KECS installed successfully:"
kecs version
