#!/bin/bash
set -e

INSTANCE_NAME="$1"
COLLECT_LOGS="${2:-false}"
LOG_DIR="${3:-.kecs-logs}"

if [ -z "$INSTANCE_NAME" ]; then
  echo "Error: Instance name is required"
  echo "Usage: $0 <instance-name> [collect-logs] [log-dir]"
  exit 1
fi

echo "Cleaning up KECS instance: $INSTANCE_NAME"

# Collect logs if requested
if [ "$COLLECT_LOGS" = "true" ]; then
  echo "Collecting logs to $LOG_DIR..."
  mkdir -p "$LOG_DIR"

  # Get kubectl config
  export KUBECONFIG="/tmp/kecs-${INSTANCE_NAME}.kubeconfig"

  if [ -f "$KUBECONFIG" ]; then
    # Collect KECS system logs
    echo "Collecting KECS system pod logs..."
    kubectl logs -n kecs-system -l app=kecs --tail=1000 > "$LOG_DIR/kecs-controlplane.log" 2>&1 || true
    kubectl logs -n kecs-system -l app=localstack --tail=1000 > "$LOG_DIR/localstack.log" 2>&1 || true
    kubectl logs -n kecs-system -l app.kubernetes.io/name=traefik --tail=1000 > "$LOG_DIR/traefik.log" 2>&1 || true

    # Collect all pod statuses
    echo "Collecting pod statuses..."
    kubectl get pods --all-namespaces -o wide > "$LOG_DIR/pods.txt" 2>&1 || true

    # Collect events
    echo "Collecting cluster events..."
    kubectl get events --all-namespaces --sort-by='.lastTimestamp' > "$LOG_DIR/events.txt" 2>&1 || true

    echo "✅ Logs collected to $LOG_DIR"
  else
    echo "⚠️  Kubeconfig not found at $KUBECONFIG, skipping log collection"
  fi
fi

# Stop the KECS instance
echo "Stopping KECS instance..."
if command -v kecs &> /dev/null; then
  kecs stop --instance "$INSTANCE_NAME" || {
    echo "⚠️  Failed to stop instance cleanly, attempting force cleanup..."
    # Try k3d directly if kecs stop fails
    if command -v k3d &> /dev/null; then
      k3d cluster delete "kecs-$INSTANCE_NAME" || true
    fi
  }
else
  echo "⚠️  KECS CLI not found, skipping instance stop"
fi

# Clean up kubeconfig file
KUBECONFIG_PATH="/tmp/kecs-${INSTANCE_NAME}.kubeconfig"
if [ -f "$KUBECONFIG_PATH" ]; then
  rm -f "$KUBECONFIG_PATH"
  echo "✅ Cleaned up kubeconfig"
fi

echo "✅ Cleanup completed for instance: $INSTANCE_NAME"
