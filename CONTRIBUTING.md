# Contributing to KECS Action

Thank you for your interest in contributing to KECS Action! This document provides guidelines and instructions for contributing.

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please be respectful and constructive in your interactions.

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. **Search existing issues** to avoid duplicates
2. **Create a new issue** with a clear title and description
3. **Include reproduction steps** for bugs
4. **Provide use cases** for feature requests

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feat/my-feature`)
3. **Make your changes**
4. **Test your changes** locally using `act` or by running workflows
5. **Commit with clear messages** following conventional commits
6. **Push to your fork**
7. **Open a Pull Request**

### Development Workflow

#### Testing Locally

Use [act](https://github.com/nektos/act) to test GitHub Actions locally:

```bash
# Test the setup workflow
act -W .github/workflows/test-setup.yml -j test-basic-setup

# Test E2E workflows
act -W .github/workflows/test-e2e.yml -j test-task-workflow
```

#### Making Changes

When modifying the action:

1. **Update action.yml** if adding new inputs/outputs
2. **Update scripts/** if changing setup/cleanup logic
3. **Update README.md** with new examples
4. **Add tests** in `.github/workflows/`
5. **Update CHANGELOG.md** with your changes

### Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `test:` Test additions or changes
- `refactor:` Code refactoring
- `chore:` Maintenance tasks

Examples:
```
feat: Add support for custom registry configuration
fix: Resolve port conflict detection issue
docs: Update README with ecspresso example
test: Add E2E test for multi-cluster scenarios
```

### Pull Request Process

1. **Update documentation** if needed
2. **Ensure all tests pass**
3. **Update CHANGELOG.md** under `[Unreleased]`
4. **Request review** from maintainers
5. **Address feedback** promptly

### Testing Requirements

All changes must include appropriate tests:

- **Setup changes**: Add test cases to `test-setup.yml`
- **E2E scenarios**: Add test cases to `test-e2e.yml`
- **Scripts**: Ensure script changes are tested in workflows

### Documentation Standards

- **Clear and concise**: Write for users of all skill levels
- **Include examples**: Show real-world usage
- **Keep it current**: Update docs with code changes
- **Format properly**: Use proper markdown formatting

## Development Setup

### Prerequisites

- Docker
- Git
- Bash
- (Optional) [act](https://github.com/nektos/act) for local testing

### Local Testing

1. Clone your fork:
```bash
git clone https://github.com/YOUR_USERNAME/kecs-action.git
cd kecs-action
```

2. Make changes in a feature branch:
```bash
git checkout -b feat/my-feature
```

3. Test locally:
```bash
# Option 1: Use act
act -W .github/workflows/test-setup.yml

# Option 2: Push to a test branch and check GitHub Actions
git push origin feat/my-feature
```

## Project Structure

```
kecs-action/
├── action.yml              # Main action definition
├── cleanup/
│   └── action.yml          # Cleanup action definition
├── scripts/
│   ├── setup-kecs.sh       # KECS setup script
│   ├── cleanup-kecs.sh     # Cleanup script
│   └── install-k3d.sh      # k3d installation script
├── .github/
│   └── workflows/          # Test workflows
├── README.md               # User documentation
├── CHANGELOG.md            # Version history
└── CONTRIBUTING.md         # This file
```

## Questions?

If you have questions about contributing:

1. Check existing [issues](https://github.com/nandemo-ya/kecs-action/issues)
2. Open a [discussion](https://github.com/nandemo-ya/kecs-action/discussions)
3. Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
