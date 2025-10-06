# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of KECS GitHub Action
- Automatic KECS installation and cluster setup
- Environment variable configuration (AWS_ENDPOINT_URL, KECS_ENDPOINT, etc.)
- Multi-platform support (amd64, arm64)
- Cleanup action with optional log collection
- Comprehensive E2E tests for ECS workflows
- Support for additional LocalStack services
- Custom port configuration
- Debug mode for troubleshooting
- Automatic k3d CLI installation

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

## [1.0.0] - TBD

Initial public release.

### Added
- KECS setup action
- Cleanup action
- Comprehensive documentation
- E2E test coverage
