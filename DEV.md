# For Developers

## Setting up the development environment

1. Run

```bash
lefthook install
```

## How to Upload to PyPI

1. [Run `build_ext`](https://stackoverflow.com/a/4515279/915552)

   python setup.py build_ext

2. [Build a wheel](https://packaging.python.org/guides/distributing-packages-using-setuptools/#pure-python-wheels)

   python setup.py sdist

3. [Upload](https://packaging.python.org/guides/distributing-packages-using-setuptools/#uploading-your-project-to-pypi)

   twine upload dist/pycodec2.*tar.gz
