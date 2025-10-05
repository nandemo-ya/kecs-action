# KECS Action

GitHub Action for setting up KECS (Kubernetes-based ECS Compatible Service) in your CI/CD workflows.

## Overview

This action simplifies the setup of KECS for testing ECS workflows in GitHub Actions. It handles installation, cluster creation, and environment configuration automatically.

## Features

- 🚀 **Quick Setup**: Get KECS running in just a few lines
- 🔧 **Auto-configured**: Automatically sets up environment variables and kubeconfig
- 🧹 **Auto Cleanup**: Companion cleanup action ensures resources are properly deleted
- 🏗️ **Multi-platform**: Supports both amd64 and arm64 architectures
- 📦 **No k3d Required**: KECS embeds k3d SDK v5.8.3 internally

## Quick Start

### Basic Usage

```yaml
name: ECS Workflow Test

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup KECS
        uses: nandemo-ya/kecs-action@v1
        id: kecs

      - name: Run ECS Tests
        run: |
          # KECS is ready, AWS_ENDPOINT_URL is automatically set
          aws ecs create-cluster --cluster-name test
          aws ecs list-clusters

      - name: Cleanup KECS
        if: always()
        uses: nandemo-ya/kecs-action/cleanup@v1
        with:
          instance-name: ${{ steps.kecs.outputs.instance-name }}
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `kecs-version` | KECS version to install | No | `latest` |
| `instance-name` | KECS instance name | No | Auto-generated |
| `api-port` | AWS API port | No | `5373` |
| `admin-port` | Admin API port | No | `5374` |
| `additional-localstack-services` | Additional LocalStack services (comma-separated) | No | `""` |
| `timeout` | Timeout for cluster creation | No | `10m` |
| `debug` | Enable debug logging | No | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `instance-name` | Actual KECS instance name |
| `endpoint` | KECS API endpoint URL |
| `admin-endpoint` | KECS admin endpoint URL |
| `kubeconfig` | Path to kubeconfig file |

## Environment Variables

The action automatically exports the following environment variables:

- `AWS_ENDPOINT_URL`: KECS API endpoint
- `KECS_ENDPOINT`: KECS API endpoint
- `KECS_ADMIN_ENDPOINT`: KECS admin endpoint
- `KUBECONFIG`: Path to kubeconfig file
- `KECS_INSTANCE`: Instance name

## Advanced Usage

### With Additional LocalStack Services

```yaml
- name: Setup KECS with S3 and DynamoDB
  uses: nandemo-ya/kecs-action@v1
  with:
    additional-localstack-services: s3,dynamodb,sqs
```

### With Custom Instance Name

```yaml
- name: Setup KECS
  uses: nandemo-ya/kecs-action@v1
  with:
    instance-name: my-test-instance
```

### With Port-forward (Optional)

```yaml
- name: Setup KECS
  uses: nandemo-ya/kecs-action@v1
  id: kecs

- name: Setup Port Forward
  run: |
    # Port-forward agent starts automatically
    kecs port-forward start service default/my-service --local-port 8080

- name: Test via Port Forward
  run: |
    curl http://localhost:8080/health
```

## Cleanup Action

Always use the cleanup action to ensure resources are properly deleted:

```yaml
- name: Cleanup KECS
  if: always()
  uses: nandemo-ya/kecs-action/cleanup@v1
  with:
    instance-name: ${{ steps.kecs.outputs.instance-name }}
    collect-logs: true  # Optional, default: true
```

## How It Works

1. **Install Dependencies**: Installs kubectl and downloads KECS CLI
2. **Start KECS**: Creates a k3d cluster with KECS control plane (using embedded k3d SDK)
3. **Verify Setup**: Performs health checks and API tests
4. **Export Environment**: Sets up environment variables for your tests

## Requirements

- Ubuntu runner (ubuntu-latest recommended)
- Docker (pre-installed on GitHub Actions runners)

## Troubleshooting

### KECS fails to start

Check the logs by enabling debug mode:

```yaml
- name: Setup KECS
  uses: nandemo-ya/kecs-action@v1
  with:
    debug: true
```

### Port conflicts

Specify different ports:

```yaml
- name: Setup KECS
  uses: nandemo-ya/kecs-action@v1
  with:
    api-port: 6000
    admin-port: 6001
```

## License

Apache License 2.0

## Related Projects

- [KECS](https://github.com/nandemo-ya/kecs) - Kubernetes-based ECS Compatible Service
