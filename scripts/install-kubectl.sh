#!/bin/bash
set -e

if command -v kubectl &> /dev/null; then
  echo "kubectl already installed: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
  exit 0
fi

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $ARCH in
  x86_64) KUBECTL_ARCH="amd64" ;;
  aarch64|arm64) KUBECTL_ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "Installing kubectl for ${OS}/${KUBECTL_ARCH}..."

# Download and install
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
KUBECTL_URL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${OS}/${KUBECTL_ARCH}/kubectl"

echo "Downloading kubectl ${KUBECTL_VERSION} from ${KUBECTL_URL}"
curl -LO "$KUBECTL_URL"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "kubectl installed successfully:"
kubectl version --client
