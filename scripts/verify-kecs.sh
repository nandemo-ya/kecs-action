#!/bin/bash
set -e

API_ENDPOINT="$1"
ADMIN_ENDPOINT="$2"

echo "Verifying KECS at $API_ENDPOINT..."

# Health check with retry
for i in {1..30}; do
  if curl -sf "${ADMIN_ENDPOINT}/health" > /dev/null; then
    echo "✅ KECS health check passed"
    break
  fi

  if [ $i -eq 30 ]; then
    echo "❌ KECS health check failed after 30 attempts"
    exit 1
  fi

  echo "Attempt $i: KECS not ready, waiting..."
  sleep 2
done

# Test ECS API
echo "Testing ECS API..."
curl -X POST "${API_ENDPOINT}/" \
  -H "Content-Type: application/x-amz-json-1.1" \
  -H "X-Amz-Target: AmazonEC2ContainerServiceV20141113.ListClusters" \
  -d '{}' || {
    echo "❌ ECS API test failed"
    exit 1
  }

echo "✅ KECS is ready"
