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

A version release consists of producing the following artifacts:

1. Tagging a commit with a version string (`vx.y.z`).
2. Uploading the package's wheels and an sdist archive to:
    1. PyPI
    2. GitHub Releases

To create a release, run the following steps:

1. Run `dev/bin/release-new-version-tag`
2. Run the build GitHub action.
3. Fetch the built artifacts and unpack.
4. Run `twine upload pycodec2-$VERSION*`.
5. Run `gh release create v$VERSION pycodec2-$VERSION*`.

## ADRs

### Pipenv vs Poetry

This project uses Pipenv to simplify managing development environment
dependencies. It does not use Poetry, because Poetry does not support building
impure Python wheels (those with Cython), so it would be quite surprising to
have Poetry AND use setuptools directly to build this package.
