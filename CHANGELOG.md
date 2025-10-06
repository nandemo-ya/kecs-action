# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-10-06

Initial public release of KECS GitHub Action.

### Added
- Automatic KECS installation and cluster setup
- Environment variable configuration (AWS_ENDPOINT_URL, KECS_ENDPOINT, KECS_ADMIN_ENDPOINT, KUBECONFIG, KECS_INSTANCE)
- Multi-platform support (amd64, arm64)
- Cleanup action with optional log collection
- Comprehensive E2E tests for ECS workflows
- Support for additional LocalStack services
- Custom port configuration (api-port, admin-port)
- Debug mode for troubleshooting
- Automatic k3d CLI installation
- Version-specific KECS installation support

### Features
- **Quick Setup**: Get KECS running in just a few lines
- **Auto-configured**: Automatically sets up environment variables and kubeconfig
- **Auto Cleanup**: Companion cleanup action ensures resources are properly deleted
- **No k3d Required**: KECS embeds k3d SDK v5.8.3 internally
- **Log Collection**: Optional collection of KECS, LocalStack, and Traefik logs

### Documentation
- Complete README with usage examples
- E2E workflow examples
- Troubleshooting guide
- Cleanup action documentation
- Contributing guidelines
- Changelog following Keep a Changelog format
