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

## Building

This section explains how to build
[a wheel](https://realpython.com/python-wheels/) of this package.

1. Run

```bash
python -m build --wheel
```

This builds a wheel file and saves it in `dist/`.

## How to Upload to PyPI

1. [Run `build_ext`](https://stackoverflow.com/a/4515279/915552)

   python setup.py build_ext

2. [Build a wheel](https://packaging.python.org/guides/distributing-packages-using-setuptools/#pure-python-wheels)

   python setup.py sdist

3. [Upload](https://packaging.python.org/guides/distributing-packages-using-setuptools/#uploading-your-project-to-pypi)

   twine upload dist/pycodec2.*tar.gz

## ADRs

### Pipenv vs Poetry

This project uses Pipenv to simplify managing development environment
dependencies. It does not use Poetry, because Poetry does not support building
impure Python wheels (those with Cython), so it would be quite surprising to
have Poetry AND use setuptools directly to build this package.
