# Developer Documentation

This file is meant for developers. It provides instructions on how to
work with the repository.

## Development environment setup

This section explains how to setup your development environment upon cloning
this repository.

1. Run

```bash
lefthook install
pipenv install --dev
```

## Local Build

This section explains how to build
[a wheel](https://realpython.com/python-wheels/) of this package on your local
machine.

1. Run

```bash
python -m build --wheel
```

This builds a wheel file and saves it in `dist/`.

## Build, Release & Publish

This section explains how to create a release (build sdist and wheel files of a
version) and publish to GitHub and PyPI.

1. Run the build GitHub action.
2. Fetch the built artifacts and unpack.
3. Run `twine upload ARTIFACTS`.
4. Run `gh release create VERSION`.

## ADRs

### Pipenv vs Poetry

This project uses Pipenv to simplify managing development environment
dependencies. It does not use Poetry, because Poetry does not support building
impure Python wheels (those with Cython), so it would be quite surprising to
have Poetry AND use setuptools directly to build this package.
